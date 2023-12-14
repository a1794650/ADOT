
function motor2aircraft(plane, motor_index, motorSpecs)
    plane.motor.power_max = motorSpecs.BatteryPower_W_(motor_index);
    plane.motor.mass = motorSpecs.weight_g_(motor_index)*plane.units.g2kg;
    plane.motor.number = 2;

end