function RA = createRA_SRG(Ve, invSqrtSe, U, sqrtS)
%* RA(x,yi,zj) = sum_{x1}(Ve((yi,zj),x1)*invSqrtSe(x1)*U(x1,x)*sqrtS(x))

%* VS((yi,zj),x1) = Ve((yi,zj),x1)*invSqrtSe(x1)
VS = UeTimesInvSqrtSe(Ve, invSqrtSe) ;

%* US(x1,x) = U(x1,x)*sqrtS(x)
US = UtimesS_SRG(U, sqrtS) ;

%* RA(x,yi,zj) = sum_{x1}(VS((yi,zj),x1)*US(x1,x))
RA = VStimesUS_SRG(VS, US) ;
