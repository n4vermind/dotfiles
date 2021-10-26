-- This uses UPowerGlib.Device (https://lazka.github.io/pgi-docs/UPowerGlib-1.0/classes/Device.html)
-- Provides:
-- stat::battery
--    percentage
--    state
local upower_widget = require("lib.battery_widget")

local batt_listener = upower_widget {
    device_path = '/org/freedesktop/UPower/devices/battery_BAT0',
    instant_update = true
}

batt_listener:connect_signal("upower::update", function (_, device)
    awesome.emit_signal("stat::battery", device.percentage, device.state)
end)
