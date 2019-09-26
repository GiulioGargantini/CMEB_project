function data = define_constants(data)
%This function contains all the constants that are necessary to solve the
%problem.
%
%Set the parameter AR = 1 to study the case with blood flow autoregulation
%                  AR = 0 if autoregulation is absent.
%
%Set the parameter operation = 1 to study the case where the patient has
%                                undergone trabeculectomy
%                  operation = 0 if not.

%% Properties
data.AR = 1;    % set AR = 1 if blood flow autoregulation is active
                % set AR = 0 if it is not
           
data.operation = 1; % set operation = 0 if the patient has not undergone trabeculectomy
                    % set operation = 1 if he has, or if he is healthy

%% Pressures
data.IOP_before = 30;   % [IOP] = mmHg, Internal Ocular Pressure in case of unhealthy patient
data.IOP_after = 15;    % [IOP] = mmHg, Internal Ocular Pressure (or for a healthy individual)
data.MAP = 106.7;   % [MAP] = mmHg, Mean Arterial Pressure
data.RLTp = 7;      % [RLTp] = mmHg, Retro Laminar Tissue pressure
data.LCp = 50;      % [LCp] = mmHg, dummy Pressure in Lamina Cribrosa. It is initialized later in the code


if data.operation == 1
    data.IOP = data.IOP_after;
else
    data.IOP = data.IOP_before;
end

data.OPP = 2/3 * data.MAP - data.IOP;   % [OPP] = mmHg, Ocular Pervasion Pressure

data.Pin = @(t) Pressure_in(t);   % [P] = mmHg, inflow pressure
data.Pout = @(t) 12 + 0.*t;      % [P] = mmHg, outflow pressure
data.convert_MPa_to_mmHg = 1/(133.322e-6);  % = mmHg/MPa 
data.LCp_art = 40.5;   %[P] = mmHg, control pressure in the Lamina Cribrosa

%% Capacitancies at control state
data.C1 = 7.22e-7;  % [C1] = mL/mmHg
data.C2 = 7.53e-7;  % [C2] = mL/mmHg
data.C4 = 1.67e-5;  % [C3] = mL/mmHg
data.C5 = 1.07e-5;  % [C4] = mL/mmHg

data.capacitances = [data.C1;data.C2;data.C4;data.C5];

%% Resistances at control state
data.resistor_control_state.Rin = 2.25e4;   % [R] = mmHg*s/mL
data.resistor_control_state.R1a = 4.3e3;    % [R] = mmHg*s/mL
data.resistor_control_state.R1b = 4.3e3;    % [R] = mmHg*s/mL
data.resistor_control_state.R1c = 1.96e2;   % [R] = mmHg*s/mL
data.resistor_control_state.R1d = 9.78e2;   % [R] = mmHg*s/mL
data.resistor_control_state.R2a = 6.00e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R2b = 6.00e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R3a = 5.68e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R3b = 5.68e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R4a = 3.11e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R4b = 3.11e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R5a = 3.08e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R5b = 6.15e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R5c = 1.35e3;   % [R] = mmHg*s/mL
data.resistor_control_state.R5d = 1.35e3;   % [R] = mmHg*s/mL
data.resistor_control_state.Rout = 5.74e3;  % [R] = mmHg*s/mL

%% CRA constants
data.CRA.D = 175e-3;    % [D] = mm, diameter
data.CRA.L_tot = 10;    % [L] = mm, length
data.CRA.L_a = 4.4;     % [L] = mm, length of segment a
data.CRA.L_b = 4.4;     % [L] = mm, length of segment b
data.CRA.L_c = 0.2;     % [L] = mm, length of segment c
data.CRA.L_d = 1.0;     % [L] = mm, length of segment d
data.CRA.mu = 3.0;      % [mu] = cP = 1e-3*kg/(m*s), blood viscosity
data.CRA.E = 0.3 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
data.CRA.nu = 0.49;     % [nu] = 1, wall poisson ratio
data.CRA.h = 39.7e-3;   % [h] = mm, wall thickness

data.CRA.Aref = pi * data.CRA.D^2 / 4;  % [Aref] = mm^2, reference section
data.CRA.krrho = 8*pi*data.CRA.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
data.CRA.kp = (data.CRA.E*data.CRA.h^3/sqrt(1-data.CRA.nu^2))*...
    (pi/data.CRA.Aref)^(3/2);   % [kp] = mmHg
data.CRA.kL = 12 * data.CRA.Aref/(pi * data.CRA.h^2);   % [kL] = 1


%% Arterioles constants
data.art.cL = 2.50e-3;  % [cL] = 1, lower bound for variation in resistance
data.art.cU = 1.5;      % [cU] = 1, upper bound for variation in resistance
data.art.K = 6.91e4;    % [K] = s/mL, resistance sensitivity to variations in OPP
data.art.c_hat = log(data.art.cU - 1) - log(1 - data.art.cL);   % [c_hat] = 1
                                            % normalization constant

%% CRV constants
data.CRV.D = 238e-3;    % [D] = mm, diameter
data.CRV.L_tot = 10;    % [L] = mm, length
data.CRV.L_a = 1.0;     % [L] = mm, length of segment a
data.CRV.L_b = 0.2;     % [L] = mm, length of segment b
data.CRV.L_c = 4.4;     % [L] = mm, length of segment c
data.CRV.L_d = 4.4;     % [L] = mm, length of segment d
data.CRV.mu = 3.24;      % [mu] = cP = 1e-3*kg/(m*s), blood viscosity
data.CRV.E = 0.6 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
data.CRV.nu = 0.49;     % [nu] = 1, wall poisson ratio
data.CRV.h = 10.7e-3;   % [h] = mm, wall thickness

data.CRV.Aref = pi * data.CRV.D^2 / 4;  % [Aref] = mm^2, reference section
data.CRV.krrho = 8*pi*data.CRV.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
data.CRV.kp = (data.CRV.E*data.CRV.h^3/sqrt(1-data.CRV.nu^2))*...
    (pi/data.CRV.Aref)^(3/2);   % [kp] = mmHg
data.CRV.kL = 12 * data.CRV.Aref/(pi * data.CRV.h^2);   % [kL] = 1

%% Venules constants
data.ven.D = 230e-3;    % [D] = mm, diameter !!!FOUND IN art2_CMEB (altri dicono 150e-3)
data.ven.volume = 6.12 * 1e3; % [volume] = mm^3
data.ven.Aref = pi * data.ven.D^2 / 4;  % [Aref] = mm^2, reference section
data.ven.L_tot = data.ven.volume/ data.ven.Aref;    % [L] = mm, length
data.ven.L_a = data.ven.L_tot/2;     % [L] = mm, length of segment a
data.ven.L_b = data.ven.L_a;     % [L] = mm, length of segment b
data.ven.mu = data.CRV.mu;      % [mu] = cP = 1e-3 Pa * s, blood viscosity
data.ven.E = 0.066 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
data.ven.nu = 0.49;     % [nu] = 1, wall poisson ratio
data.ven.wtlr = 0.05;   % [wtlr] = 1, wall to Lumen ratio
data.ven.h = data.ven.wtlr * data.ven.D / 2;    % [h] = mm, wall thickness

data.ven.krrho = 8*pi*data.ven.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
data.ven.kp = (data.ven.E*data.ven.h^3/sqrt(1-data.ven.nu^2))*...
    (pi/data.ven.Aref)^(3/2);   % [kp] = mmHg
data.ven.kL = 12 * data.ven.Aref/(pi * data.ven.h^2);   % [kl] = 1

%% Lamina Cribrosa constants
% see art3_CMEB.pdf
data.LC.L = 1.5;    % [L] = mm
data.LC.zlc = data.LC.L - 0.75; % [zlc] = mm
data.LC.zlc_minus_hl = data.LC.zlc - data.CRA.L_c;  % [zlc] = mm
data.LCp = mean_LC_pressure(data);


%% Total flow
data.Q_bar = 6.8178e-4; % [Q_bar] = mL/s, physiological bloodflow through 
                        % the retinal vessels
            
% formatspec = 'CRV Area = %3.5f ; venules Area = %3.5f; \n';
% fprintf(formatspec, data.CRV.Aref, data.ven.Aref);
data.convert_mL_mm2s_to_cm_s = 1e2;    % Converts mL/(s * mm^2) to cm/s
               
%% Cycle while in time_deriv_P1245
data.tdev.tol = 1e-5;    % relative tolerance for the convergence
data.tdev.upper_bound = 1e8;    % if the norm reaches this value, stop everything
end