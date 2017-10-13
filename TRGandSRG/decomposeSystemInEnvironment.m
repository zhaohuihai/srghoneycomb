function [RA, RB, coefT] = decomposeSystemInEnvironment(parameter, id, th)

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSVenv, 'S')
sqrtSe = computeSqrtS(S) ;
%* VMU(x1,x2) = sum_{yi,zj,yj,zi}(sqrtSe(x1)*Ve((yi,zj),x1)*M((yi,zj),(yj,zi))*Ue((yj,zi),x2)*sqrtSe(x2))
contractSystem_Environment(parameter, sqrtSe, id, th) ;


[RA, RB, coefT] = applySVD_SRG(parameter, sqrtSe, id, th) ;

