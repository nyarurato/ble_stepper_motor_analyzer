#!python

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
from pyqtgraph import QtGui


# NOTE: Color names list here https://matplotlib.org/stable/gallery/color/named_colors.html


#DEVICE_ADDR = "C9:B7:AF:B8:72:D6"
DEVICE_ADDR = "D5:77:38:D3:5A:55"

amps_abs_filter = Filter(0.5)

# ----- Connect to probe

# TODO: Fix forward reference to update_from_state. The callback_handler is invoked before
# update_from_state is defined which causes an error on startup.


def callback_handler(probe_state: ProbeState):
    #print(f"probe state handler called: time: {probe_state.timestamp_secs()}", flush=True)
    update_from_state(probe_state)


# Co-routing returns Probe or None.
async def connect_to_probe():
    global DEVICE_ADDR
    print(f"Trying to connect to device {DEVICE_ADDR}...", flush=True)
    probe = await Probe.find_by_address(DEVICE_ADDR)
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
    # Comment this line if you don't want to start from scratch, viewing histograms
    # with old data, etc.
    # await probe.write_command_reset_data()
    await probe.state_notifications(callback_handler)
    return probe

logging.basicConfig(level=logging.INFO)

# ----- Initialize graphics

win_width = 1100
win_height = 700

# We set the actual size later. This is a workaround to force an
# early compaction of the buttons row.
win = pg.GraphicsLayoutWidget(show=True, size=[win_width, win_height-1])
win.setWindowTitle(f"BLE Stepper Motor Probe Demo [{DEVICE_ADDR}]")
#win.resize(1100, 700)

# Layout class doc: https://doc.qt.io/qt-5/qgraphicsgridlayout.html

win.ci.layout.setColumnPreferredWidth(0, 240)
win.ci.layout.setColumnPreferredWidth(1, 240)
win.ci.layout.setColumnPreferredWidth(2, 240)
win.ci.layout.setColumnPreferredWidth(3, 380)

# win.ci.layout.setColumnMinimumWidth(0, 100)
# win.ci.layout.setColumnMinimumWidth(1, 100)
# win.ci.layout.setColumnMinimumWidth(2, 100)
# win.ci.layout.setColumnMinimumWidth(3, 100)

# win.ci.layout.setColumnMaximumWidth(0, 1000)
# win.ci.layout.setColumnMaximumWidth(1, 1000)
# win.ci.layout.setColumnMaximumWidth(2, 1000)
# win.ci.layout.setColumnMaximumWidth(3, 1000)

win.ci.layout.setColumnStretchFactor(0, 1)
win.ci.layout.setColumnStretchFactor(1, 1)
win.ci.layout.setColumnStretchFactor(2, 1)
win.ci.layout.setColumnStretchFactor(3, 1)

# Note: p1, p2, p3 are of type pyqtgraph.PlotItem

# Graph 1
plot: pg.PlotItem = win.addPlot(name="Plot1", colspan=4)
plot.setLabel('left', 'Distance', 'steps')
plot.setXRange(-10, 0)
plot.showGrid(False, True, 0.7)
plot.setAutoPan(x=True)
graph1 = Chart(plot, pg.mkPen('yellow'))

# Graph 2
win.nextRow()
plot = win.addPlot(name="Plot2", colspan=4)
plot.setLabel('left', 'Speed', 'steps/s')
#plot.setLabel('bottom', 'Time', 's')
plot.setXRange(-10, 0)
plot.showGrid(False, True, 0.7)
plot.setAutoPan(x=True)
plot.setXLink('Plot1')  # synchronize time axis
graph2 = Chart(plot, pg.mkPen('orange'))

# Graph 3
win.nextRow()
plot = win.addPlot(name="Plot3", colspan=4)
plot.setLabel('left', 'Current', 'A')
#plot.setLabel('bottom', 'Time', 's')
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
graph4 = pg.BarGraphItem(x=[], height=[],  width=0.3, brush='yellow')
plot4.addItem(graph4)

# Graph 5
# win.nextRow()
plot5 = win.addPlot(name="Plot5")
plot5.setLabel('left', 'Time', 'Percents')
plot5.setLabel('bottom', 'Speed', 'steps/s')
graph5 = pg.BarGraphItem(x=[], height=[],  width=0.3, brush='salmon')
plot5.addItem(graph5)

# Graph 6
# win.nextRow()
plot6 = win.addPlot(name="Plot6")
plot6.setLabel('left', 'Distance', 'Percents')
plot6.setLabel('bottom', 'Speed', 'steps/s')
graph6 = pg.BarGraphItem(x=[], height=[],  width=0.3, brush='skyblue')
plot6.addItem(graph6)

# Graph 7
# # win.nextRow()
plot7 = win.addPlot(name="Plot7")
plot7.setLabel('left', 'Current', 'A')
plot7.setLabel('bottom', 'Time', 's')


# win.ci.layout.setColumnStretchFactor(0, 1)
# win.ci.layout.setColumnStretchFactor(1, 1)
# win.ci.layout.setColumnStretchFactor(2, 1)
# win.ci.layout.setColumnStretchFactor(3, 1)

# win.ci.nextCol()


# graph7 = Chart(plot, pg.mkPen('green'))
# plot7.addItem(graph6)


# win.centralLayout.setColumnStretchFactor(0, 1)
# win.centralLayout.setColumnStretchFactor(1, 1)
# win.centralLayout.setColumnStretchFactor(2, 1)
# win.centralLayout.setColumnStretchFactor(3, 1)

win.nextRow()
buttons_layout = win.addLayout(colspan=2)
buttons_layout.setSpacing(20)
buttons_layout.layout.setHorizontalSpacing(30)

# Button1
button1_proxy = QtGui.QGraphicsProxyWidget()
button1 = QtGui.QPushButton('Reset')
button1_proxy.setWidget(button1)
buttons_layout.addItem(button1_proxy, row=0, col=0)


# Button2
button2_proxy = QtGui.QGraphicsProxyWidget()
button2 = QtGui.QPushButton('Pause')
button2_proxy.setWidget(button2)
buttons_layout.addItem(button2_proxy, row=0, col=1)

# This is a hack to force the view compacting the buttons
# row ASAP. We created win with similar but slightly different
# size for this to work.
win.resize(win_width, win_height)
# win.show()

# Steps text label
# steps_label = pg.LabelItem()
# steps_label.setText("Steps: ???")
# buttons_layout.addItem(steps_label)

last_state = None
points_counter = 0


def update_from_state(state: ProbeState):
    # global p3,  current_chunk_data, points_counter, curves, startTime
    global probe, graph1, graph2, last_state, points_counter, pause_enabled

    # Read probe
    # state = asyncio.get_event_loop().run_until_complete(probe.read_state())

    if points_counter % 100 == 0:
        print(f"{points_counter:06d}: {state}", flush=True)
    points_counter += 1

    if last_state is None:
        speed = 0
    else:
        delta_t = state.timestamp_secs() - last_state.timestamp_secs()
        if delta_t <= 0:
            # Notification is too fast, no change in timestamp.
            return
        speed = (state.steps - last_state.steps) / delta_t

    amps_abs_filter.add(state.amps_abs())

    last_state = state
    if not pause_enabled and not pending_reset:
        graph1.add_point(state.timestamp_secs(), state.steps)
        graph2.add_point(state.timestamp_secs(), speed)
        graph3.add_point(state.timestamp_secs(), amps_abs_filter.value())

    # graph4.add_point(state.timestamp_secs(), state.watts_per_ohm())

# This is a hack. By reading the probe from the QT timer we can have
# both display updates and async notifications from the device. Should
# have a simpler way, but don't really understand how asyncio and
# QT exec co exist.


timer_handler_counter = 0
# slot_cycle = 0

pending_reset = True
pause_enabled = False

capture_signal_fetcher: CaptureSignalFetcher = None


def on_reset_button():
    global pending_reset
    pending_reset = True


def on_pause_button():
    global pause_enabled, button2
    if pause_enabled:
        button2.setText("Pause")
        pause_enabled = False
    else:
        button2.setText("Continue")
        pause_enabled = True


def timer_handler():
    global probe, timer_handler_counter, slot_cycle, graph1, graph2, graph3, graph4, graph5, graph6, plot7, capture_signal_fetcher, buttons_layout, pending_reset, pause_enabled

    if pending_reset:
        asyncio.get_event_loop().run_until_complete(probe.write_command_reset_data())
        graph1.clear()
        graph2.clear()
        graph3.clear()

        graph4.setOpts(x=[], height=[])
        graph5.setOpts(x=[], height=[])
        graph6.setOpts(x=[], height=[])

        plot7.clear()
        capture_signal_fetcher.reset()

        pending_reset = False

    updates_enabled = not pause_enabled

    slot = timer_handler_counter % 25
    # if slot == 0:
    #     slot_cycle += 1

    # Once in a while update the histograms.
    if updates_enabled and slot == 14:
        # print(f"*** {type(buttons_layout)}", flush=True)
        histogram: CurrentHistogram = asyncio.get_event_loop(
        ).run_until_complete(probe.read_current_histogram())
        graph4.setOpts(x=histogram.centers(), height=histogram.heights(
        ), width=0.75*histogram.bucket_width())
    elif updates_enabled and slot == 5:
        histogram: TimeHistogram = asyncio.get_event_loop(
        ).run_until_complete(probe.read_time_histogram())
        graph5.setOpts(x=histogram.centers(), height=histogram.heights(
        ), width=0.75*histogram.bucket_width())
    elif updates_enabled and slot == 10:
        histogram: DistanceHistogram = asyncio.get_event_loop(
        ).run_until_complete(probe.read_distance_histogram())
        graph6.setOpts(x=histogram.centers(), height=histogram.heights(
        ), width=0.75*histogram.bucket_width())
    elif updates_enabled and slot in [16,  18, 20, 22, 24]:
        capture_signal: CaptureSignal = asyncio.get_event_loop(
        ).run_until_complete(capture_signal_fetcher.loop())
        if capture_signal:
            plot7.clear()
            plot7.plot(capture_signal.times_sec(),
                       capture_signal.amps_a(), pen='yellow')
            plot7.plot(capture_signal.times_sec(),
                       capture_signal.amps_b(), pen='skyblue')
    else:
        state = asyncio.get_event_loop().run_until_complete(probe.read_state())

    timer_handler_counter += 1


probe = asyncio.get_event_loop().run_until_complete(connect_to_probe())
capture_signal_fetcher = CaptureSignalFetcher(probe)

button1.clicked.connect(lambda: on_reset_button())
button2.clicked.connect(lambda: on_pause_button())

timer = pg.QtCore.QTimer()
timer.timeout.connect(timer_handler)
timer.start(25)

if __name__ == '__main__':
    pg.exec()
