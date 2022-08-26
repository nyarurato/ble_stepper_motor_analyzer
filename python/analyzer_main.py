#!python

# A python program to retrieve data from the BLE stepper motor analyzer
# probe and displaying it in realtime on the screen.

from tokenize import String
from turtle import width
from numpy import histogram
from capture_signal import CaptureSignal
from current_histogram import CurrentHistogram
from time_histogram import TimeHistogram
from distance_histogram import DistanceHistogram
from capture_signal_fetcher import CaptureSignalFetcher
from probe import Probe
from probe_state import ProbeState
from filter import Filter
import pyqtgraph as pg
import asyncio
from chart import Chart
import logging
import time
from pyqtgraph import QtGui
import re
import argparse
import signal
import sys

# NOTE: Color names list here https://matplotlib.org/stable/gallery/color/named_colors.html

# Default device address. Use the flag below to override it.
# To find device addresses, run the scanner and look for 
# devices whose name looks like STP-XXXXXXXXXXXX.
# The device address has different format on Windows and 
# on Mac OSX.
DEFAULT_DEVICE_ADDRESS = "F5:DD:EB:97:EA:14"
DEFAULT_DEVICE_NAME = "My Stepper"

# Allows to stop the program by typing ctrl-c.
signal.signal(signal.SIGINT, lambda number, frame: sys.exit())

parser = argparse.ArgumentParser()
parser.add_argument("-i", "--device_address", dest="device_address",
                    default=DEFAULT_DEVICE_ADDRESS, help="The device address")
# The device name is an arbitrary string such as "Extruder 1".
parser.add_argument("-x", "--device_name", dest="device_name",
                    default=DEFAULT_DEVICE_NAME, help="Optional device id such as Stepper X")
args = parser.parse_args()


amps_abs_filter = Filter(0.5)

timer_handler_counter = 0

# NOTE: Initializing pending_reset to True will reset the
# steps on program start but may display an initial spike
# with the notification or two that arrived before the
# reset. In using it, consider send a reset command before
# enabling the notifications.
pending_reset = False
pause_enabled = False

pending_direction_toggle = False
# pending_zero_calibration = True

# Starting with default divider of 5.
capture_divider = 5
last_set_capture_divider = 0

capture_signal_fetcher: CaptureSignalFetcher = None




# TODO: Fix forward reference to update_from_state. The callback_handler is invoked before
# update_from_state is defined which causes an error on startup.


# Receives the state updates from the device.
def callback_handler(probe_state: ProbeState):
    update_from_state(probe_state)


# Co-routing returns Probe or None.
async def connect_to_probe():
    #global PROBE_NAME
    device_address = args.device_address
    print(f"Trying to connect to device {device_address}...", flush=True)
    probe = await Probe.find_by_address(device_address)
    if not probe:
        print(f"Device not found", flush=True)
        return None
    if not await probe.connect():
        print(f"Failed to connect", flush=True)
        return None
    print(f"Connected to probe", flush=True)
    print(f"Model: [{probe.info().model()}]", flush=True)
    print(f"Manufacturer: [{ probe.info().manufacturer()}]", flush=True)
    print(
        f"Current ticks per amp: [{ probe.info().current_ticks_per_amp()}]", flush=True)
    print(
        f"Time ticks per sec: [{ probe.info().time_ticks_per_sec()}]", flush=True)
    print(
        f"Histogram bucket steps/sec: [{ probe.info().histogram_bucket_steps_per_sec()}]", flush=True)
    #
    # TODO, can we avoid it without getting occasional errors? The MTU
    # negotiation can take a few seconds to happen. Is this the cause?
    #print(f"A short delay to stabilize the connection...", flush=True)
    #time.sleep(3)  # was 8

    # NOTE: The notification system keeps a reference to the current event
    # loop which is main_event_loop and uses it to post events.
    # Running the event loop periodically in the timer handler
    # below services these events.
    await probe.state_notifications(callback_handler)
    return probe

logging.basicConfig(level=logging.INFO)

# ----- Initialize graphics

win_width = 1100
win_height = 700

# We set the actual size later. This is a workaround to force an
# early compaction of the buttons row.
win = pg.GraphicsLayoutWidget(show=True, size=[win_width, win_height-1])
title = f"BLE Stepper Motor Analyzer [{args.device_address}]"
if args.device_name:
    title += f" [{args.device_name}]"
win.setWindowTitle(title)
#win.resize(1100, 700)

# Layout class doc: https://doc.qt.io/qt-5/qgraphicsgridlayout.html

win.ci.layout.setColumnPreferredWidth(0, 240)
win.ci.layout.setColumnPreferredWidth(1, 240)
win.ci.layout.setColumnPreferredWidth(2, 240)
win.ci.layout.setColumnPreferredWidth(3, 240)
win.ci.layout.setColumnPreferredWidth(4, 380)


win.ci.layout.setColumnStretchFactor(0, 1)
win.ci.layout.setColumnStretchFactor(1, 1)
win.ci.layout.setColumnStretchFactor(2, 1)
win.ci.layout.setColumnStretchFactor(3, 1)
win.ci.layout.setColumnStretchFactor(4, 1)


# Graph 1
plot: pg.PlotItem = win.addPlot(name="Plot1", colspan=5)
plot.setLabel('left', 'Distance', 'steps')
plot.setXRange(-10, 0)
plot.showGrid(False, True, 0.7)
plot.setAutoPan(x=True)
graph1 = Chart(plot, pg.mkPen('yellow'))

# Graph 2
win.nextRow()
plot = win.addPlot(name="Plot2", colspan=5)
plot.setLabel('left', 'Speed', 'steps/s')
plot.setXRange(-10, 0)
plot.showGrid(False, True, 0.7)
plot.setAutoPan(x=True)
plot.setXLink('Plot1')  # synchronize time axis
graph2 = Chart(plot, pg.mkPen('orange'))

# Graph 3
win.nextRow()
plot = win.addPlot(name="Plot3", colspan=5)
plot.setLabel('left', 'Current', 'A')
plot.setXRange(-10, 0)
plot.setYRange(0, 2)
plot.showGrid(False, True, 0.7)
plot.setAutoPan(x=True)
plot.setXLink('Plot1')  # synchronize time axis
graph3 = Chart(plot, pg.mkPen('green'))

# Graph 4
win.nextRow()
plot4 = win.addPlot(name="Plot4")
plot4.setLabel('left', 'Current', 'A')
plot4.setLabel('bottom', 'Speed', 'steps/s')
plot4.setYRange(0, 3)
graph4 = pg.BarGraphItem(x=[], height=[],  width=0.3, brush='yellow')
plot4.addItem(graph4)

# Graph 5
# win.nextRow()
plot5 = win.addPlot(name="Plot5")
plot5.setLabel('left', 'Time', '%')
plot5.setLabel('bottom', 'Speed', 'steps/s')
graph5 = pg.BarGraphItem(x=[], height=[],  width=0.3, brush='salmon')
plot5.addItem(graph5)

# Graph 6
plot6 = win.addPlot(name="Plot6")
plot6.setLabel('left', 'Distance', '%')
plot6.setLabel('bottom', 'Speed', 'steps/s')
graph6 = pg.BarGraphItem(x=[], height=[],  width=0.3, brush='skyblue')
plot6.addItem(graph6)

# TODO: Renumber graphs.

# Graph 8
plot8 = win.addPlot(name="Plot8")
plot8.setLabel('left', 'Coil B', 'A')
plot8.setLabel('bottom', 'Coil A', 'A')
plot8.showGrid(True, True, 0.7)
plot8.setXRange(-3, 3)
plot8.setYRange(-3, 3)

# Graph 7
plot7 = win.addPlot(name="Plot7")
plot7.setLabel('left', 'Current', 'A')
plot7.setLabel('bottom', 'Time', 's')
plot7.setYRange(-3, 3)


win.nextRow()
buttons_layout = win.addLayout(colspan=5)
buttons_layout.setSpacing(20)
buttons_layout.layout.setHorizontalSpacing(30)

# Button1
button1_proxy = QtGui.QGraphicsProxyWidget()
button1 = QtGui.QPushButton('Toggle dir.')
button1_proxy.setWidget(button1)
buttons_layout.addItem(button1_proxy, row=0, col=0)

# Button2
button2_proxy = QtGui.QGraphicsProxyWidget()
button2 = QtGui.QPushButton('Reset Data')
button2_proxy.setWidget(button2)
buttons_layout.addItem(button2_proxy, row=0, col=1)

# Button3
button3_proxy = QtGui.QGraphicsProxyWidget()
button3 = QtGui.QPushButton(f'Time Scale X{capture_divider}')
button3_proxy.setWidget(button3)
buttons_layout.addItem(button3_proxy, row=0, col=2)

# Button4
button4_proxy = QtGui.QGraphicsProxyWidget()
button4 = QtGui.QPushButton('Pause')
button4_proxy.setWidget(button4)
buttons_layout.addItem(button4_proxy, row=0, col=3)


# This is a hack to force the view compacting the buttons
# row ASAP. We created win with similar but slightly different
# size for this to work.
win.resize(win_width, win_height)
# win.show()


last_state = None
points_counter = 0


def update_from_state(state: ProbeState):
    global probe, graph1, graph2, last_state, points_counter, pause_enabled

    if points_counter % 100 == 0:
        print(f"{points_counter:06d}: {state}", flush=True)
    points_counter += 1

    if last_state is None:
        print(f"No last state", flush=True)
        speed = 0
    else:
        delta_t = state.timestamp_secs() - last_state.timestamp_secs()
        # Normal intervals are 0.020. If it's larger, we are missing
        # notification packets.
        if delta_t > 0.025:
            print(f"Data loss: {delta_t*1000:3.0f} ms", flush=True)
        if delta_t <= 0:
            # Notification is too fast, no change in timestamp. We
            # want to avoid divide by zero.
            last_state = state
            return
        speed = (state.steps - last_state.steps) / delta_t

    amps_abs_filter.add(state.amps_abs())

    last_state = state
    if not pause_enabled and not pending_reset:
        graph1.add_point(state.timestamp_secs(), state.steps)
        graph2.add_point(state.timestamp_secs(), speed)
        graph3.add_point(state.timestamp_secs(), amps_abs_filter.value())


def on_reset_button():
    global pending_reset
    pending_reset = True


def on_pause_button():
    global pause_enabled, button4
    if pause_enabled:
        button4.setText("Pause")
        pause_enabled = False
    else:
        button4.setText("Continue")
        pause_enabled = True


def on_scale_button():
    global capture_divider, last_set_capture_divider
    if capture_divider == 1:
        capture_divider = 2
    elif capture_divider == 2:
        capture_divider = 5
    elif capture_divider == 5:
        capture_divider = 10
    elif capture_divider == 10:
        capture_divider = 20
    else:
        capture_divider = 1
    button3.setText(f"Time Scale X{capture_divider}")


def on_direction_button():
    global pending_direction_toggle
    pending_direction_toggle = True


main_event_loop = asyncio.new_event_loop()

async def do_nothing():
    None

def timer_handler():
    global probe, timer_handler_counter, slot_cycle, graph1, graph2, graph3, graph4, graph5, graph6, plot7
    global capture_signal_fetcher, buttons_layout, pending_reset, pause_enabled
    global capture_divider, last_set_capture_divider, pending_zero_calibration, pending_direction_toggle
    global main_event_loop

    if pending_reset:
        # asyncio.run(probe.write_command_reset_data())
        main_event_loop.run_until_complete(probe.write_command_reset_data())
        last_state = None
        graph1.clear()
        graph2.clear()
        graph3.clear()

        graph4.setOpts(x=[], height=[])
        graph5.setOpts(x=[], height=[])
        graph6.setOpts(x=[], height=[])

        plot7.clear()
        capture_signal_fetcher.reset()

        pending_reset = False

    if pending_direction_toggle:
        # asyncio.run(
        #     probe.write_toggle_direction_command())
        main_event_loop.run_until_complete(probe.write_toggle_direction_command())
        pending_direction_toggle = False

    if capture_divider != last_set_capture_divider:
        # asyncio.run(
        #     probe.write_command_set_capture_divider(capture_divider))
        main_event_loop.run_until_complete( probe.write_command_set_capture_divider(capture_divider))
        last_set_capture_divider = capture_divider
        print(f"Capture divider set to {last_set_capture_divider}", flush=True)

    updates_enabled = not pause_enabled

    slot = timer_handler_counter % 25

    # Once in a while update the histograms.
    if updates_enabled and slot == 14:
        histogram: CurrentHistogram = main_event_loop.run_until_complete(
            probe.read_current_histogram())
        graph4.setOpts(x=histogram.centers(), height=histogram.heights(
        ), width=0.75*histogram.bucket_width())
    elif updates_enabled and slot == 5:
        histogram: TimeHistogram = main_event_loop.run_until_complete(
            probe.read_time_histogram())
        graph5.setOpts(x=histogram.centers(), height=histogram.heights(
        ), width=0.75*histogram.bucket_width())
    elif updates_enabled and slot == 10:
        histogram: DistanceHistogram = main_event_loop.run_until_complete(
            probe.read_distance_histogram())
        graph6.setOpts(x=histogram.centers(), height=histogram.heights(
        ), width=0.75*histogram.bucket_width())
    elif updates_enabled and slot in [16,  18, 20, 22, 24]:
        capture_signal: CaptureSignal = main_event_loop.run_until_complete(
            capture_signal_fetcher.loop())
        if capture_signal:
            plot7.clear()
            plot7.plot(capture_signal.times_sec(),
                       capture_signal.amps_a(), pen='yellow')
            plot7.plot(capture_signal.times_sec(),
                       capture_signal.amps_b(), pen='skyblue')

            plot8.clear()
            plot8.plot(capture_signal.amps_a(),
                       capture_signal.amps_b(), pen='greenyellow')
    else:
        # state = asyncio.run(probe.read_state())
        main_event_loop.run_until_complete(probe.read_state())

    timer_handler_counter += 1


probe = main_event_loop.run_until_complete(connect_to_probe())
# probe = asyncio.run(connect_to_probe())
capture_signal_fetcher = CaptureSignalFetcher(probe)

button1.clicked.connect(lambda: on_direction_button())
button2.clicked.connect(lambda: on_reset_button())
button3.clicked.connect(lambda: on_scale_button())
button4.clicked.connect(lambda: on_pause_button())


timer = pg.QtCore.QTimer()
timer.timeout.connect(timer_handler)
# Interval in ms.
# timer.start(25)
timer.start(20)

if __name__ == '__main__':
    pg.exec()
