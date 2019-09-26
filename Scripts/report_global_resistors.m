function resistors = report_global_resistors(t, res, resistors, flows)
% Updates the value of the global variable resistors, that cumulates the
% values of the variable resistors throughout the solution of the ODE.

% Initialization
if isempty(resistors.time)
    resistors.time = t;
    resistors.R1c = res.R1c;
    resistors.R1d = res.R1d;
    resistors.R2a = res.R2a;
    resistors.R2b = res.R2b;
    resistors.R4a = res.R4a;
    resistors.R4b = res.R4b;
    resistors.R5a = res.R5a;
    resistors.R5b = res.R5b;
    resistors.flow_CRA = flows(1);
    resistors.flow_CRV = flows(2);

% Replacement
elseif (resistors.time(end) == t)
    resistors.time(end) = t;
    resistors.R1c(end) = res.R1c;
    resistors.R1d(end) = res.R1d;
    resistors.R2a(end) = res.R2a;
    resistors.R2b(end) = res.R2b;
    resistors.R4a(end) = res.R4a;
    resistors.R4b(end) = res.R4b;
    resistors.R5a(end) = res.R5a;
    resistors.R5b(end) = res.R5b;
    resistors.flow_CRA(end) = flows(1);
    resistors.flow_CRV(end) = flows(2);
% Addition
else
    resistors.time = [resistors.time t];
    resistors.R1c = [resistors.R1c res.R1c];
    resistors.R1d = [resistors.R1d res.R1d];
    resistors.R2a = [resistors.R2a res.R2a];
    resistors.R2b = [resistors.R2b res.R2b];
    resistors.R4a = [resistors.R4a res.R4a];
    resistors.R4b = [resistors.R4b res.R4b];
    resistors.R5a = [resistors.R5a res.R5a];
    resistors.R5b = [resistors.R5b res.R5b];
    resistors.flow_CRA = [resistors.flow_CRA flows(1)];
    resistors.flow_CRV = [resistors.flow_CRV flows(2)];
end

end