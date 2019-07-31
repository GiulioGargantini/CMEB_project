function R = starling_resistor(krrho, L, Aref, delP,kp, kL)
if delP >= 0
    R = krrho * L /Aref^2 * (1+ delP/(kp * kL))^(-4);
else
    R = krrho * L /Aref^2 * (1- delP/kp)^(4/3);
end
end