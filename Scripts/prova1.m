 data = [];
 data = define_constants(data);
 
 delps = linspace(-20, 20, 21);
 ii = 1;
 res = zeros(size(delps));
 for dp = delps
     res(ii) = starling_resistor(data.ven.krrho, data.ven.L, data.ven.Aref,...
        dp, data.ven.kp, data.ven.kL);
     ii = ii + 1;
 end
 
 plot(delps, res, '.')