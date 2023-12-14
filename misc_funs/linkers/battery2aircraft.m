

function battery2aircraft(plane, battery_index, batterySpecs)
    plane.battery.capacity = batterySpecs.batteryCapacity_mAh_(battery_index);
    plane.battery.width    = batterySpecs.Bw_mm_(battery_index)*plane.units.mm2m;
    plane.battery.height   = batterySpecs.Bh(battery_index)*plane.units.mm2m;
    plane.battery.length   = batterySpecs.Bl(battery_index)*plane.units.mm2m;
    plane.battery.mass     = batterySpecs.weight_g_(battery_index)*plane.units.g2kg;
    plane.battery.voltage  = 22.2; %change this???
end