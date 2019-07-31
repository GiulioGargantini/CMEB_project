function R = compliant_resistor(krrho, L, Aref, delP,kp, kL)
    R = krrho * L /Aref^2 * (1+ delP/(kp * kL))^(-4);
end
