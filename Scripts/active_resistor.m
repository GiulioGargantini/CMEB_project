function R = active_resistor(OPP)
%Computes the resistance of the arterioles with an active mechanism of
%autoregulation according to figure (A2) of art1_CMEB.
%INPUT: OPP = Optical Perfusion Pressure, constant throughout the
%           simulation. MAP is the Mean Arterial Pressure in the brachial artery
%           and IOP the Internal Ocular Pressure.
%               OPP = 2/3 MAP - IOP  (see pg 4107 of art1_CMEB).
%               MAP = 2/3 DP + 1/3 SP.
%               IOP is a parameter found in data
%
%OUTPUT R = value of the resistance.
%
%Data have been read thanks to http://www.graphreader.com/
    
x_OPP =[30.0 31.58 38.993 41.262 43.125 45.231 47.176 49.201 51.227 53.414 60.99 65.0];
y_R = [90.0 91.463 73.171 164.634 493.902 2176.829 5981.707 8268.293 8798.78 8926.829 8926.829 8926.829];

R = interp1(x_OPP, y_R, OPP);
    
end

