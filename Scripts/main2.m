% Simulation of fig 5 in art1_CMEB

%% Loading data
clear all
close all

global resistors data

data = [];
data = define_constants(data);
data.plots = 0;

IOPs = linspace(data.IOP_min, data.IOP_max, data.n_of_simul);
Qs = zeros(6,numel(IOPs)); % total blood flow for each IOP

for ind = 1:6
    for ii = 1:numel(IOPs)
        data = [];
        data = define_constants(data,IOPs(ii),ind);
        res = data.resistor_control_state;
        P1245 = zeros(4,1);
        tspan = [0, 1];
        resistors = [];
        resistors = initialize_resistors();

        P1245 = solve_circuit_1245(data, res, 0);
        %opt = odeset('Refine',2);
        [ttout, PP1245] = ode15s(@time_deriv_P1245, tspan, P1245);

        [resistors.time, I] = sort(resistors.time);
        resistors.flow_CRA = resistors.flow_CRA(I);

        Qs(ind,ii) = trapz(resistors.time, resistors.flow_CRA) * data.convert_mL_s_to_muL_min;
        fprintf('data.IOP = %3.4f, Q = %2.4f \n',data.IOP, Qs(ii))
    end
end

%% Plot
figure
hold on
plot(IOPs, Qs(1,:),'b-', IOPs, Qs(2,:), 'b--')
plot(IOPs, Qs(3,:),'g-', IOPs, Qs(4,:), 'g--')
plot(IOPs, Qs(5,:),'r-', IOPs, Qs(6,:), 'r--')
legend('low BP, AR','low BP, wAR','medium BP, AR','medium BP, wAR','high BP, AR','high BP, wAR');
title('Blood flows')
xlabel('IOP [mmHg]')
ylabel('Blood flow [mL / s]')
ylim([20, 60])
