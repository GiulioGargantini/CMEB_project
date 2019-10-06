% Simulation of circuit (1) of Art1_CMEB

%% Loading data
clear all
close all

% Resistors global variable
global resistors data
resistors = initialize_resistors();


data = [];
data = define_constants(data);
res = data.resistor_control_state;

% Dummy initial condition
P1245 = zeros(4,1);

% Time vector
tspan = [0, 1];



%% Call to the ODE solver

P1245 = solve_circuit_1245(data, res, 0);
opt = odeset('Refine',3);
[ttout, PP1245] = ode15s(@time_deriv_P1245, tspan, P1245,opt);

%% Postprocessing 
% Ordering data
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

% Computation of the total arterial flow, [flow] = μL / min
tot_Q = trapz(resistors.time, resistors.flow_CRA) * data.convert_mL_s_to_muL_min;

fprintf('IOP = %3.2f, tot_Q = %2.4f\n', data.IOP, tot_Q)

%% Plots
if data.plots == 1
    figure
    hold on
    plot(ttout,data.Pin(ttout),'r-',ttout,data.Pout(ttout),'k-')
    plot(ttout,PP1245(:,1),ttout,PP1245(:,2),ttout,PP1245(:,3),ttout,PP1245(:,4))
    legend('P_{in}', 'P_{out}', 'P_1', 'P_2', 'P_4', 'P_5')
    title('Pressures')
    xlabel('time [s]')
    ylabel('Pressure [mmHg]')
    ylim([10 100])


    figure
    hold on
    plot(resistors.time ,resistors.R1c,resistors.time ,resistors.R1d)
    legend('R1c', 'R1d')
    title('CRA')
    xlabel('time [s]')
    ylabel('Resistance [mmHg*s/mL]')
    ylim([100 1100])

    figure
    hold on
    plot(resistors.time ,resistors.R2a,resistors.time ,resistors.R2b)
%     plot(resistors.time ,data.resistor_control_state.R2a*ones(size(resistors.time)),'b--',...
%          resistors.time ,data.resistor_control_state.R2b*ones(size(resistors.time)),'r--')
    legend('R2a', 'R2b');%,'R2a control', 'R2b control')
    title('Arterioles')
    xlabel('time [s]')
    ylabel('Resistance [mmHg*s/mL]')

    figure
    hold on
    plot(resistors.time ,resistors.R4a,resistors.time ,resistors.R4b)
    plot(resistors.time ,data.resistor_control_state.R4a*ones(size(resistors.time)),'b--',...
         resistors.time ,data.resistor_control_state.R4b*ones(size(resistors.time)),'r--')
    legend('R4a', 'R4b','R4a control', 'R4b control')
    title('Venules')
    xlabel('time [s]')
    ylabel('Resistance [mmHg*s/mL]')
    ylim([0 2e4])

    figure
    hold on
    plot(resistors.time ,resistors.R5a,resistors.time ,resistors.R5b)
    plot(resistors.time ,data.resistor_control_state.R5a*ones(size(resistors.time)),'b--',...
         resistors.time ,data.resistor_control_state.R5b*ones(size(resistors.time)),'r--')
    legend('R5a', 'R5b','R5a control', 'R5b control')
    title('CRV')
    xlabel('time [s]')
    ylabel('Resistance [mmHg*s/mL]')
    ylim([0 4000])
    

    % Blood flow
    figure
    hold on
    plot(resistors.time ,resistors.flow_CRA,resistors.time ,resistors.flow_CRV)
    legend('blood flow in CRA', 'blood flow in CRV')
    title('Blood flows')
    xlabel('time [s]')
    ylabel('Flow [mL / s]')
    ylim([0 1.5e-3])

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

end