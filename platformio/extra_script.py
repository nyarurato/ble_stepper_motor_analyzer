# NOTE: Make sure this file is listed in platformio.ini under 
# extra_scripts.

Import("env")

# Add a platformio custom task
env.AddCustomTarget(
    name="my_run",
    dependencies=None,
    actions=[
        "pio run --target erase --target upload --target monitor"
    ],
    title="My Run",
    description="My Run"
)