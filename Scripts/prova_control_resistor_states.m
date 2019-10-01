% There is a mistake in art1_CMEB: in table 2 the values computed as
% references for the Hydraulic resistors are sometimes of a different order
% of magnitude !!!

convMPa_mmHg = 7.5006e+03;

calcres = @(mu, L, D) 128.* mu.*L./(pi.*D.^4).*convMPa_mmHg .*1e6;

CRA.D = 175; % μm
CRA.mu = 3.0;   % cP
CRA.La = 4.4;   % mm
CRA.Lb = 4.4;   % mm
CRA.Lc = 0.2;   % mm
CRA.Ld = 1.0;   % mm

CRV.D = 238; % μm
CRV.mu = 3.24;   % cP
CRV.La = 1.0;   % mm
CRV.Lb = 0.2;   % mm
CRV.Lc = 4.4;   % mm
CRV.Ld = 4.4;   % mm

R.CRAa = calcres(CRA.mu, CRA.La, CRA.D);
R.CRAb = calcres(CRA.mu, CRA.Lb, CRA.D);
R.CRAc = calcres(CRA.mu, CRA.Lc, CRA.D);
R.CRAd = calcres(CRA.mu, CRA.Ld, CRA.D);
R.CRVa = calcres(CRV.mu, CRV.La, CRV.D);
R.CRVb = calcres(CRV.mu, CRV.Lb, CRV.D);
R.CRVc = calcres(CRV.mu, CRV.Lc, CRV.D);
R.CRVd = calcres(CRV.mu, CRV.Ld, CRV.D);