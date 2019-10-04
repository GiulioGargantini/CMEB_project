% In this script we plot the value of the active resistance R_2a computed
% with the formula (4) of Art1_CMEB with the ones found in figure 2A of the
% same paper. The objective is to show that both methods give the same
% result.

data = [];
data = define_constants(data);

OPPs = linspace(25,65,100);

R_comp = zeros(size(OPPs));
R_mark = R_comp;

for ii = 1:numel(OPPs)
    R_comp(ii) = active_resistor_variante( data.resistor_control_state.R2a, data.art.cL, ...
        data.art.cU, data.art.K, OPPs(ii), data.Q_bar, data.art.c_hat);
    R_mark(ii) = active_resistor(OPPs(ii));
end

figure
hold on
plot(OPPs, R_comp, OPPs, R_mark);
title('Computation of the active resistance')
xlabel('OPP [mmHg]')
ylabel('R_2a [mmHg * s / mL');
legend('Computed using formula (4)','Retraced from fig. 2A')