% Simulation of circuit (1) of Art1_CMEB

%% Loading data
clear all
close all

data = [];
data = define_constants(data);
res = data.resistor_control_state;

% Dummy initial condition
P1245 = zeros(4,1);

% Time vector
tspan = [0, 1];

% Resistors global variable
global resistors
resistors = initialize_resistors();


%% Call to the ODE solver

P1245 = solve_circuit_1245(data, res, 0);
%opt = odeset('Refine',2);
[ttout, PP1245] = ode15s(@time_deriv_P1245, tspan, P1245);

%% Postprocessing (ordering the data)
[resistors.time, I] = sort(resistors.time);
resistors.R1c = resistors.R1c(I);
resistors.R1d = resistors.R1d(I);
resistors.R2a = resistors.R2a(I);
resistors.R2b = resistors.R2b(I);
resistors.R4a = resistors.R4a(I);
resistors.R4b = resistors.R4b(I);
resistors.R5a = resistors.R5a(I);
resistors.R5b = resistors.R5b(I);
resistors.flow_CRA = resistors.flow_CRA(I);
resistors.flow_CRV = resistors.flow_CRV(I);

%% Plots
figure
hold on
plot(ttout,data.Pin(ttout),'r-',ttout,data.Pout(ttout),'k-')
plot(ttout,PP1245(:,1),ttout,PP1245(:,2),ttout,PP1245(:,3),ttout,PP1245(:,4))
legend('P_{in}', 'P_{out}', 'P_1', 'P_2', 'P_4', 'P_5')
title('Pressures')
xlabel('time [s]')
ylabel('Pressure [mmHg]')


figure
hold on
plot(resistors.time ,resistors.R1c,resistors.time ,resistors.R1d)
legend('R1c', 'R1d')
title('CRA')
xlabel('time [s]')
ylabel('Resistance [mmHg*s/mL]')

figure
hold on
plot(resistors.time ,resistors.R2a,resistors.time ,resistors.R2b)
legend('R2a', 'R2b')
title('Arterioles')
xlabel('time [s]')
ylabel('Resistance [mmHg*s/mL]')

figure
hold on
plot(resistors.time ,resistors.R4a,resistors.time ,resistors.R4b)
legend('R4a', 'R4b')
title('Venules')
xlabel('time [s]')
ylabel('Resistance [mmHg*s/mL]')

figure
hold on
plot(resistors.time ,resistors.R5a,resistors.time ,resistors.R5b)
legend('R5a', 'R5b')
title('CRV')
xlabel('time [s]')
ylabel('Resistance [mmHg*s/mL]')

% Blood flow
figure
hold on
plot(resistors.time ,resistors.flow_CRA,resistors.time ,resistors.flow_CRV)
legend('blood flow in CRA', 'blood flow in CRV')
title('Blood flows')
xlabel('time [s]')
ylabel('Flow [mL / s]')

% Velocity
% V = (8*Q(t))/(pi * D^2)
figure
hold on
plot(resistors.time ,(8.*resistors.flow_CRA)./(pi * data.CRA.D^2) * data.convert_mL_mm2s_to_cm_s,...
    resistors.time ,-(8.*resistors.flow_CRV)./(pi * data.CRV.D^2) * data.convert_mL_mm2s_to_cm_s)
legend('blood velocity in CRA', 'blood velocity in CRV')
title('Velocities')
xlabel('time [s]')
ylabel('Velocity [cm / s]')