function data = define_constants(data, IOPval, index)
%This function contains all the constants that are necessary to solve the
%problem.
%
%INPUT: 1) data = []
%       2) IOPval = value of IOP. Not compulsory
%       3) index is used to study all 6 cases of low, medium and high blood
%       pressure and active or inactive autoregulation.
%                
%          ___|_AR_active_|_AR_inactive_|
%      low BP |     1     |      2      |
%   medium BP |     3     |      4      |
%     high BP |     5     |      6      |
%    ------------------------------------
%
%
%If nargin is 1 or 2:
%   Set the parameter AR = 1 to study the case with blood flow autoregulation
%                  AR = 0 if autoregulation is absent.
%
%   Set the parameter operation = 1 to study the case where the patient has
%                                undergone trabeculectomy
%                  operation = 0 if not.

%% Settings
data.plots = 1; % set plots = 1 if you want graphs to be plotted. set it to 0 else.

%% Properties
if nargin <= 2
    data.AR = 0;    % set AR = 1 if blood flow autoregulation is active
                    % set AR = 0 if it is not
           
    data.operation = 0; % set operation = 0 if the patient has not undergone trabeculectomy
                        % set operation = 1 if he has, or if he is healthy
                  
                
    data.blood_pressure = 0;    % set blood_pressure = 0 for low pressure
                                %                    = 1 for medium pressure
                                %                    = 2 for high pressure
else
    [data.AR, data.blood_pressure] = set_AR_BP(index);
end
%% Pressures
data.ratio_maxPin_SP = 0.7683;  % [ratio] = 1, ratio = max(P_in) / Systolic_Pressure
data.ratio_minPin_DP = 0.4945;  % [ratio] = 1, ratio = min(P_in) / Diastolic_Pressure
data.min_fct_Pressure_in = 36.8061; % [min_Pin] = mmHg, minimum of data.Pin
data.max_fct_Pressure_in = 92.3260; % [max_Pin] = mmHg, maximum of data.Pin
data.IOP_before = 30;   % [IOP] = mmHg, Internal Ocular Pressure in case of unhealthy patient
data.IOP_after = 15;    % [IOP] = mmHg, Internal Ocular Pressure (or for a healthy individual)

data.RLTp = 7;      % [RLTp] = mmHg, Retro Laminar Tissue pressure
data.LCp = 50;      % [LCp] = mmHg, dummy Pressure in Lamina Cribrosa. It is initialized later in the code


if nargin >= 2
    data.IOP = IOPval;
elseif data.operation == 1
    data.IOP = data.IOP_after;
else
    data.IOP = data.IOP_before;
end

% Blood pressures: SP = Systolic Pressure, DP = Diastolic Pressure
if data.blood_pressure == 0 % Low pressure
    data.SP = 100;  % [SP] = mmHg
    data.DP = 70;   % [DP] = mmHg
elseif data.blood_pressure == 1 % Medium pressure
    data.SP = 120;  % [SP] = mmHg
    data.DP = 80;   % [DP] = mmHg
else                            % High pressure
    data.SP = 140;  % [SP] = mmHg
    data.DP = 90;   % [DP] = mmHg
end

data.max_Pin = data.SP * data.ratio_maxPin_SP * 2 / 3;  % [max_Pin] = mmHg, maximum value of Pin
data.min_Pin = data.DP * data.ratio_minPin_DP * 2 / 3;  % [max_Pin] = mmHg, minimum value of Pin

data.MAP = (2/3 * data.DP + 1/3 * data.SP);    % [MAP] = mmHg, Mean Arterial Pressure
data.OPP = 2/3 * data.MAP - data.IOP;   % [OPP] = mmHg, Ocular Pervasion Pressure

% Pin(t) = alpha Pressure_in(t) + beta
data.press_coeff_alpha = (data.max_Pin - data.min_Pin) /...
    (data.max_fct_Pressure_in - data.min_fct_Pressure_in);
data.press_coeff_beta = data.max_Pin - data.press_coeff_alpha * data.max_fct_Pressure_in;
data.Pin = @(t) data.press_coeff_alpha .* Pressure_in(t) + data.press_coeff_beta;   % [P] = mmHg, inflow pressure
data.Pout = @(t) 12 + 0.*t;      % [P] = mmHg, outflow pressure
data.convert_MPa_to_mmHg = 1/(133.322e-6);  % = mmHg/MPa 
data.LCp_art = 40.5;   %[P] = mmHg, control pressure in the Lamina Cribrosa

%% Parameters for main2 about IOP
data.IOP_min = 15;  % [IOP] = mmHg
data.IOP_max = 50;  % [IOP] = mmHg
data.n_of_simul = 10;   % number of simulations with differents IOPs

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
data.resistor_control_state.R5a = 3.08e2;   % [R] = mmHg*s/mL there is a mistake in art1_CMEB !!!
data.resistor_control_state.R5b = 6.15e1;   % [R] = mmHg*s/mL there is a mistake in art1_CMEB !!!
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
data.CRV.mu = 3.24;     % [mu] = cP = 1e-3*kg/(m*s), blood viscosity
data.CRV.E = 0.6 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
data.CRV.nu = 0.49;     % [nu] = 1, wall poisson ratio
data.CRV.h = 10.7e-3;   % [h] = mm, wall thickness

data.CRV.Aref = pi * data.CRV.D^2 / 4;  % [Aref] = mm^2, reference section
data.CRV.krrho = 8*pi*data.CRV.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
data.CRV.kp = (data.CRV.E*data.CRV.h^3/sqrt(1-data.CRV.nu^2))*...
    (pi/data.CRV.Aref)^(3/2);   % [kp] = mmHg
data.CRV.kL = 12 * data.CRV.Aref/(pi * data.CRV.h^2);   % [kL] = 1

%% Venules constants

% data.ven.mu = 2.44;                 % [mu] = cP P 1e-3 kg/(m*s), Dynamical viscosity of blood
% data.ven.Dist = 8*34.12e-4;         % [Dist] = mmHg ^ -1, Distensibility of the vessel (kp * kL)
% data.ven.L = ((data.C4^2 * data.resistor_control_state.R4a)/...
%     (data.ven.Dist^2 * 8 * pi * data.ven.mu * data.convert_MPa_to_mmHg))...
%     ^(1/3) * 1e4;                   % [L] = mm, Length of the vessel
% data.ven.Aref = ((8 * pi * data.ven.mu * data.C4)/(data.ven.Dist * ...
%     data.resistor_control_state.R4a) * data.convert_MPa_to_mmHg * 1e-3)^(1/3); % [Aref] = mm^2, reference section
% data.ven.D = sqrt(data.ven.Aref * 4 / pi);      % [D] = mm, diameter
data.ven.wtlr = 0.05;            % [wtlr] = 1, wall to Lumen ratio = h / radius
data.ven.E = 0.66 * data.convert_MPa_to_mmHg;   % [E] = mmHg, Young modulus off walls
data.ven.nu = 0.49;                 % [nu] = 1, wall poisson ratio
% data.ven.krrho = 8*pi*data.ven.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
data.ven.kp = (data.ven.E*data.ven.wtlr^3/sqrt(1-data.ven.nu^2)) * 8;   % [kp] = mmHg
data.ven.kL = 12 /(data.ven.wtlr^2);   % [kL] = 1


% % Small Venulus vessel (SV)
% data.ven.SV.L = 0.52 * 1e1;             % [L] = mm, Length of the SV vessel
% data.ven.SV.mu = 2.09;                  % [mu] = cP = 1e-3 kg/(m*s), Dynamical viscosity of blood in SV 
% data.ven.SV.n = 40;                     % [n] = 1, equivalent number of small venulas
% data.ven.SV.D = 68.5*1e-3;              % [D] = mm, SV diameter
% data.ven.SV.Dist= 8*34.12e-4;           % [Dist] = mmHg ^ -1, Distensibility of the SV vessel (kp * kL)
% data.ven.SV.Aref = pi * data.ven.SV.D^2 / 4; % [Aref] = mm^2, reference section
% data.ven.SV.res_const = 128 * data.ven.SV.mu * data.ven.SV.L / ...
%     (data.ven.SV.D.^4 * pi) * data.convert_MPa_to_mmHg * 1e-6 / data.ven.SV.n; % [res] = mmHg * s / mL, reference for the resistance
% data.ven.SV.wtlr = 0.05;                % [wtlr] = 1, wall to Lumen ratio = h / radius
% data.ven.SV.E = 0.66 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
% data.ven.SV.nu = 0.49;                   % [nu] = 1, wall poisson ratio
% data.ven.SV.h = data.ven.SV.wtlr * data.ven.SV.D ;    % [h] = mm, wall thickness
% data.ven.SV.krrho = 8*pi*data.ven.SV.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
% data.ven.SV.kp = (data.ven.SV.E*data.ven.SV.h^3/sqrt(1-data.ven.SV.nu^2))*...
%     (pi/data.ven.SV.Aref)^(3/2);   % [kp] = mmHg
% data.ven.SV.kL = 12 * data.ven.SV.Aref/(pi * data.ven.SV.h^2);   % [kL] = 1


% Large Venulus vessel (LV)

% data.ven.LV.L = 0.73 * 1e1;             % [L] = mm, Length of the LV vessel
% data.ven.LV.mu = 2.44;                  % [mu] = cP P 1e-3 kg/(m*s), Dynamical viscosity of blood in SV 
% data.ven.LV.n = 4;                      % [n] = 1, equivalent number of small venulas
% data.ven.LV.D = 154.9*1e-3;             % [D] = mm, SV diameter
% data.ven.LV.Dist= 8*34.12e-4;           % [Dist] = mmHg ^ -1, Distensibility of the SV vessel (kp * kL)
% data.ven.LV.Aref = pi * data.ven.LV.D^2 / 4; % [Aref] = mm^2, reference section
% data.ven.LV.res_const = 128 * data.ven.LV.mu * data.ven.LV.L / ...
%     (data.ven.LV.D.^4 * pi) * data.convert_MPa_to_mmHg * 1e-6 / data.ven.LV.n; % [res] = mmHg * s / mL, reference for the resistance
% data.ven.LV.wtlr = 0.05;                % [wtlr] = 1, wall to Lumen ratio = h / radius
% data.ven.LV.E = 0.66 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
% data.ven.LV.nu = 0.49;                   % [nu] = 1, wall poisson ratio
% data.ven.LV.h = data.ven.SV.wtlr * data.ven.LV.D ;    % [h] = mm, wall thickness
% data.ven.LV.krrho = 8*pi*data.ven.LV.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
% data.ven.LV.kp = (data.ven.LV.E*data.ven.LV.h^3/sqrt(1-data.ven.LV.nu^2))*...
%     (pi/data.ven.LV.Aref)^(3/2);   % [kp] = mmHg
% data.ven.LV.kL = 12 * data.ven.LV.Aref/(pi * data.ven.LV.h^2);   % [kL] = 1
% 
% 
% data.resistor_control_state.R4a = data.ven.SV.res_const;   % [R] = mmHg*s/mL, redefinition
% data.resistor_control_state.R4b = data.ven.LV.res_const;   % [R] = mmHg*s/mL, redefinition
% OLD VENULES PARAMETERS
% data.ven.D = 230e-3;    % [D] = mm, diameter !!!FOUND IN art2_CMEB (altri dicono 150e-3)
% data.ven.volume = 6.12 * 1e3; % [volume] = mm^3
% data.ven.Aref = pi * data.ven.D^2 / 4;  % [Aref] = mm^2, reference section
% data.ven.L_tot = data.ven.volume/ data.ven.Aref;    % [L] = mm, length
% data.ven.L_a = data.ven.L_tot/2;     % [L] = mm, length of segment a
% data.ven.L_b = data.ven.L_a;     % [L] = mm, length of segment b
% data.ven.mu = data.CRV.mu;      % [mu] = cP = 1e-3 Pa * s, blood viscosity
% data.ven.E = 0.066 * data.convert_MPa_to_mmHg; % [E] = mmHg, Young modulus off walls
% data.ven.nu = 0.49;     % [nu] = 1, wall poisson ratio
% data.ven.wtlr = 0.05;   % [wtlr] = 1, wall to Lumen ratio
% data.ven.h = data.ven.wtlr * data.ven.D / 2;    % [h] = mm, wall thickness
% 
% data.ven.krrho = 8*pi*data.ven.mu * 1e-6 * data.convert_MPa_to_mmHg ;%  [krrho] = 1e-3 s * mmHg, kr*rho
% data.ven.kp = (data.ven.E*data.ven.h^3/sqrt(1-data.ven.nu^2))*...
%     (pi/data.ven.Aref)^(3/2);   % [kp] = mmHg
% data.ven.kL = 12 * data.ven.Aref/(pi * data.ven.h^2);   % [kl] = 1

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
data.convert_mL_s_to_muL_min = 1e3 * 60;    % Converts mL/s to μL/min
               
%% Cycle while in time_deriv_P1245
data.tdev.tol = 1e-8;    % relative tolerance for the convergence
data.tdev.upper_bound = 1e8;    % if the norm reaches this value, stop everything

end