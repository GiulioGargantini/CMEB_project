%=======================================================================
% MICRORETINA MODEL parameters PARAMETERS IN AGREEMENT WITH ARCIERO this
% implementation gives the same results 
%=======================================================================
Convfac = 133.3224e3 ;                  % conversion factor from mmHg to mPa
% Non-Vasoactive vessel
% Capillaries vessel (C)
l_c = 0.067;                            % Length of the C vessel [cm]
m_c = 10.01 /Convfac ;                  % Dynamical viscosity of C [cP=mPa*s] will be converted 
                                        % in [mmHg*s] by the factor Convfac^-1
n_c = 187890;                           % equivalent number of Capillaries
d_c = 6.0*1e-4;                         % C diameter [mum] will be converted in [cm] by the factor 1e-4
RCAP = 128*l_c*m_c/(pi*n_c*d_c^4);      % Hydraulic Resistance of C  [mmHg*s/cm^3]
% Small Venulus vessel (SV)
l_sv = 0.52;                            % Length of the SV vessel [cm]
m_sv = 2.09 /Convfac;                   % Dynamical viscosity of SV [cP=mPa*s] will be converted in [mmHg*s] 
                                        % by the factor Convfac^-1
n_sv = 40;                              % equivalent number of small venulus
d_sv = 68.5*1e-4;                       % SV diameter [mum] will be converted in [cm] by the factor 1e-4
RSV = 128*l_sv*m_sv/(pi*n_sv*d_sv^4);   % Hydraulic Resistance of SV [mmHg*s/cm^3]
VolSV = (pi*n_sv*(d_sv/2)^2*l_sv)  ;    % Equivalent volume of SV [cm^3]
DistSV = 8*34.12e-4;                    % Distensibility of the SV vessel [mmHg^-1]
% Large Venulus vessel (LV)
l_lv = 0.73;                            % Length of the LV vessel [cm]
m_lv = 2.44 /Convfac;                   % Dynamical viscosity of LV [cP=mPa*s] will be converted in [mmHg*s] 
                                        % by the factor Convfac^-1 
n_lv = 4;                               % equivalent number of Large venulus
d_lv = 154.9*1e-4;                      % LV diameter [mum] will be converted in [cm] by the factor 1e-4
RLV = 128*l_lv*m_lv/(pi*n_lv*d_lv^4) ;  % Hydraulic Resistance of LV  [mmHg*s/cm^3]
VolLV = (pi*n_lv*(d_lv/2)^2*l_lv)  ;    % Equivalent volume of LV [cm^3]
DistLV = 8*34.12e-4;                    % Distensibility of the LV vessel [mmHg^-1]

% Vasoactive vessels
% Small Artioles (SA)
l_sa = 0.52;                            % Length of the SA vessel [cm]
m_sa = 2.06 /Convfac;                   % Dynamical viscosity of SA [cP=mPa*s] will be converted in [mmHg*s] 
                                        % by the factor Convfac^-1 
n_sa = 40;                              % equivalent number of Small Arterioles
d_sa = 47.2*1e-4;                       % SA diameter [mum] will be converted in [cm] by the factor 1e-4
RSA =  128*l_sa*m_sa/(pi*n_sa*d_sa^4);  % Hydraulic Resistance of SA  [mmHg*s/cm^3]
VolSA = (pi*n_sa*(d_sa/2)^2*l_sa)  ;    % Equivalent volume of SA [cm^3]
DistSA = 34.12e-4 ;                     % Distensibility of the SA vessel [mmHg^-1]
% Large Artiroles (LA)
l_la = 0.73;                            % Length of the LA vessel [cm]
m_la = 2.28 /Convfac;                   % Dynamical viscosity of LA [cP=mPa*s] will be converted in [mmHg*s] 
                                        % by the factor Convfac^-1
n_la = 4;                               % equivalent number of Large arterioles
d_la = 105*1e-4;                        % LA diameter [mum] will be converted in [cm] by the factor 1e-4
RLA =  128*l_la*m_la/(pi*n_la*d_la^4);  % Hydraulic Resistance of LA  [mmHg*s/cm^3]
VolLA = (pi*n_la*(d_la/2)^2*l_la)  ;    % Equivalent volume of LA [cm^3]
DistLA = 34.12e-4 ;                     % Distensibility of the LA vessel [mmHg^-1]
