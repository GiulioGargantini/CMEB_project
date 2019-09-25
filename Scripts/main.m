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

% Initialise external pressure at Lamina Cribrosa

%% Call to the ODE solver

P1245 = solve_circuit_1245(data, res, 0);
%opt = odeset('Refine',2);
[ttout, PP1245] = ode15s(@time_deriv_P1245, tspan, P1245);

%% Plots
figure
hold on
plot(ttout,data.Pin(ttout),'r-',ttout,data.Pout(ttout),'k-')
plot(ttout,PP1245(:,1),ttout,PP1245(:,2),ttout,PP1245(:,3),ttout,PP1245(:,4))
legend('P_{in}', 'P_{out}', 'P_1', 'P_2', 'P_4', 'P_5')