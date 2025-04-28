% Temperature and Humidity Control System Simulation with Graphs
clc;
clear;

% Threshold settings
temp_high_threshold = 30; % degrees Celsius
temp_low_threshold = 18;  % degrees Celsius
humidity_low_threshold = 40; % percent
humidity_high_threshold = 80; % percent

% Initialize arrays to store data
temperature_data = [];
humidity_data = [];
fan_status = [];
heater_status = [];
sprayer_status = [];

% Number of cycles
num_cycles = 10;

% Simulate for multiple cycles
for i = 1:num_cycles
    pause(1); % wait for 1 second

    % Simulated sensor readings
    temperature = randi([15, 40]); % random integer between 15 and 40
    humidity = randi([30, 90]);    % random integer between 30 and 90

    % Store readings
    temperature_data(end+1) = temperature;
    humidity_data(end+1) = humidity;

    % Display readings
    fprintf('Cycle %d:\n', i);
    fprintf('Temperature: %d °C\n', temperature);
    fprintf('Humidity: %d %%\n', humidity);

    % Temperature control logic
    if temperature > temp_high_threshold
        fan = 1; % ON
        heater = 0; % OFF
    elseif temperature < temp_low_threshold
        fan = 0; % OFF
        heater = 1; % ON
    else
        fan = 0; % OFF
        heater = 0; % OFF
    end

    % Humidity control logic
    if humidity < humidity_low_threshold
        sprayer = 1; % ON
    else
        sprayer = 0; % OFF
    end

    % Store actuator status
    fan_status(end+1) = fan;
    heater_status(end+1) = heater;
    sprayer_status(end+1) = sprayer;

    % Display device status
    fprintf('Fan: %s\n', onOff(fan));
    fprintf('Heater: %s\n', onOff(heater));
    fprintf('Sprayer: %s\n', onOff(sprayer));
    fprintf('-------------------------\n');
end

% Plotting the results
time = 1:num_cycles;

figure;

subplot(3,1,1);
plot(time, temperature_data, '-o', 'LineWidth', 2);
hold on;
yline(temp_high_threshold, '--r', 'High Threshold');
yline(temp_low_threshold, '--b', 'Low Threshold');
xlabel('Cycle Number');
ylabel('Temperature (°C)');
title('Temperature Variation');
grid on;

subplot(3,1,2);
plot(time, humidity_data, '-s', 'LineWidth', 2, 'Color', [0.1 0.5 0.1]);
hold on;
yline(humidity_low_threshold, '--r', 'Low Humidity Threshold');
xlabel('Cycle Number');
ylabel('Humidity (%)');
title('Humidity Variation');
grid on;

subplot(3,1,3);
stairs(time, fan_status, '-r', 'LineWidth', 2);
hold on;
stairs(time, heater_status, '-b', 'LineWidth', 2);
stairs(time, sprayer_status, '-g', 'LineWidth', 2);
xlabel('Cycle Number');
ylabel('Device Status (1=ON, 0=OFF)');
title('Actuator Status');
legend('Fan', 'Heater', 'Sprayer');
grid on;

% Helper function to convert 1/0 to ON/OFF
function status = onOff(value)
    if value == 1
        status = 'ON';
    else
        status = 'OFF';
    end
end