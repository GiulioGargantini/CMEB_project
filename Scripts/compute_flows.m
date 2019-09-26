function flows = compute_flows(data, res, P1245, t)
% Computes the blood flow in CRA and CRV.
% flow = Q = dP/R
%       dP = pressure drop across the resistor
%       R = total value of the resistor (sum of all components)
%
%OUTPUT = [flow_CRA flow_CRV]

%% Pressure drops
dP_CRA = data.Pin(t) - P1245(1);
dP_CRV = P1245(4) - data.Pout(t);

%% Resistors
R_CRA = data.resistor_control_state.R1a + data.resistor_control_state.R1b +...
    res.R1c + res.R1d;

R_CRV = res.R1a + res.R1b + ...
    data.resistor_control_state.R5c + data.resistor_control_state.R5d;

%% Flows
flow_CRA = dP_CRA / R_CRA;
flow_CRV = dP_CRV / R_CRV;

flows = [flow_CRA flow_CRV];
    
end