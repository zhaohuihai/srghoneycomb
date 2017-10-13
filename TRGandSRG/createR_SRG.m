function [RA, RB] = createR_SRG(parameter, sqrtSe, id, th)

%* invSqrtSe(x) = 1/sqrtSe(x)
invSqrtSe = computeInvS(sqrtSe) ;

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameUSV = ['USV', suffix, '.mat'] ;
load(fileNameUSV, 'S')
sqrtS = computeSqrtS(S) ;
clear S
%* RA(x,yi,zj) = sum_{x1}(Ve((yi,zj),x1)*invSqrtSe(x1)*U(x1,x)*sqrtS(x))
fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSVenv, 'V')
load(fileNameUSV, 'U')
RA = createRA_SRG(V, invSqrtSe, U, sqrtS) ;
clear U V

%* RB(x,yj,zi) = sum_{x2}(Ue((yj,zi),x2)*invSqrtSe(x2)*V(x2,x)*sqrtS(x))
load(fileNameUSVenv, 'U')
load(fileNameUSV, 'V')
RB = createRA_SRG(U, invSqrtSe, V, sqrtS) ;
clear U V