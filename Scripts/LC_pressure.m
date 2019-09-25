function P = LC_pressure(x, IOP, RLTp)
%Computes the value of the external pressure exerced by the Lamina Cribrosa
%on the CRA at each point x.
%The function is deduced by fig_9 of art3_CMEB, using the interpolation
%function. The point have been retrieved thanks to http://www.graphreader.com

x_IOP_40 = [-0.1 0.012 0.016 0.02 0.065 0.068 0.072 0.076 0.1];
y_IOP_40 = [903.226 141.129 100.806 -4.032 -56.452 -64.516 -64.516 -209.677 -379.032];

x_IOP_30 = [-0.1 0.008 0.012 0.08 0.084 0.088 0.1];
y_IOP_30 = [661.29 104.839 -4.032 -60.484 -60.484 -217.742 -282.258];

x_IOP_20 = [-0.1 0 0.004 0.1];
y_IOP_20 = [403.226 100.806 4.032 -44.355];

IOP_ind = sign(IOP - 30);

if IOP_ind == 0
    P0 = -interp1(x_IOP_30, y_IOP_30, x);
elseif IOP == -1
    coeff = (IOP - 20)/10;
    P1 = -interp1(x_IOP_20, y_IOP_20, x);
    P2 = -interp1(x_IOP_30, y_IOP_30, x);
    P0 = (1 - coeff) * P1 + coeff * P2; 
else
    coeff = (IOP - 30)/10;
    P1 = -interp1(x_IOP_30, y_IOP_30, x);
    P2 = -interp1(x_IOP_40, y_IOP_40, x);
    P0 = (1 - coeff) * P1 + coeff * P2;  
end
M = [P0; RLTp*ones(size(P0))];
P = max(M);
end