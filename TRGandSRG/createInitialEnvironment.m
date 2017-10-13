function createInitialEnvironment(parameter, id)
%* env((yj,zi),(yi,zj)) = sum_{x1,z1,x2,y2}(TA(x1,yj,z1)*TB(x1,yi,z1)*TA(x2,y2,zj)*TB(x2,y2,zi))

load('TAenv.mat', 'TAenv')
load('TBenv.mat', 'TBenv')
for i = 1 : (id - 1)
    TAenv = rotateT(TAenv) ;
    TBenv = rotateT(TBenv) ;
end

%* TTy(yj,yi) = sum_{x1,z1}(TA(x1,yj,z1)*TB(x1,yi,z1))
TTy = contractXZofTA_TB(TAenv, TBenv) ;
% TTy = reduceTT_SRG(TTy) ;

TAenv = rotateT(TAenv) ;
TBenv = rotateT(TBenv) ;
%* TTz(zi,zj) = sum_{x2,y2}(TB(y2,zi,x2)*TA(y2,zj,x2))
TTz = contractXZofTA_TB(TBenv, TAenv) ;
% TTz = reduceTT_SRG(TTz) ;

%* env((yj,zi),(yi,zj)) = TTy(yj,yi)*TTz(zi,zj)
env = computeKronTTy_TTz(TTy, TTz) ;

fileNameEnv = ['env', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameEnv, 'env', '-v7.3') ;