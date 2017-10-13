function contractSystem_Environment(parameter, sqrtSe, id, th)
%* VMU(x1,x2) = sum_{yi,zj,yj,zi}(sqrtSe(x1)*Ve((yi,zj),x1)*M((yi,zj),(yj,zi))*Ue((yj,zi),x2)*sqrtSe(x2))

%* Ve((yi,zj),x1) = sqrtSe(x1)*Ve((yi,zj),x1)
VeTimesSqrtSe(parameter, sqrtSe, id, th) ;

%* VM(x1, (yj,zi)) = sum_{yi,zj}(Ve((yi,zj),x1)*M((yi,zj),(yj,zi)))
contractV_M(parameter, id, th) ;
% reduceVM_SRG(parameter, id, th) ;

%* Ue((yj,zi),x2) = sqrtSe(x2)*Ue((yj,zi),x2)
UeTimesSqrtSe(parameter, sqrtSe, id, th) ;
clear sqrtSe

%* VMU(x1, x2) = sum_{yj,zi}(VM(x1, (yj,zi)) * Ue((yj,zi),x2))
contractVM_U(parameter, id, th) ;
% reduceVMU_SRG(parameter, id, th) ;