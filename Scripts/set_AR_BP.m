function [AR, BP] = set_AR_BP(index)
%Used to set the parameters autoregulation and blood_pression in
%define_constants. In particular, in implements this table:
%                  ___|_AR_active_(AR_=_1)_|_AR_inactive_(AR_=_0)|
%      low BP (BP = 0)|          1         |          2          |
%   medium BP (BP = 1)|          3         |          4          |
%     high BP (BP = 2)|          5         |          6          |
%    -------------------------------------------------------------
if index > 6 || index < 1
    error('Insert as index an integer between 1 and 6 \n');
end
AR = mod(index, 2);
BP = floor((index - 1)/2);
end