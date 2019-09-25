function R = active_resistor_variante(R2_avg, cL, cU, K, OPP, Q_bar, c_hat)
%Computes the resistance of the arterioles with an active mechanism of
%autoregulation according to the formula (4) of art1_CMEB.
%INPUT: 1) R2_avg = average value for R2a and R2b, found in data
%       2) cL = lower bound for the variation in resistance, found in data
%       3) cU = upper bound for the variation in resistance, found in data
%       4) K = sensitivity of the resistance to changes in OPP, found in data
%       5) OPP = Optical Perfusion Pressure, constant throughout the
%       simulation. MAP is the Mean Arterial Pressure in the brachial artery
%       and IOP the Internal Ocular Pressure.
%           OPP = 2/3 MAP - IOP  (see pg 4107 of art1_CMEB).
%           MAP = 2/3 DP + 1/3 SP.
%           IOP is a parameter found in data
%       6) Q_bar = physiological value of the bloodflow in the retinal
%           vessels. It can be found in data.
%       7) c_hat = normalization parameter (see pg 4116 of art1_CMEB)
%           c_hat = log(cU - 1) - log(1 - cL)
%           This parameter is computed once and is found in data.
%
%OUTPUT R = value of the resistance.
    
    Q_noAR_OPP = Q_noAR(OPP, Q_bar);
    val_exp = exp(-K .* (Q_noAR_OPP - Q_bar) - c_hat);
    R = R2_avg * (cL + cU .* val_exp )./(1 + val_exp);
    
end