function data = set_IOP(data, IOP)
% Function used in main2 to update all parameters in data when the IOP
% changes

data.IOP = IOP;
data.MAP = 2/3 * data.DP + 1/3 * data.SP;    % [MAP] = mmHg, Mean Arterial Pressure
data.OPP = 2/3 * data.MAP - data.IOP;   % [OPP] = mmHg, Ocular Pervasion Pressure
data.LCp = mean_LC_pressure(data);
end