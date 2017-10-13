function contractEnvironment(parameter, n, id)
%* env1((yj1,zi1),(yi1,zj1)) = sum_{yi2,zi2,yj2,zj2,x1,x2}(env2(yj2,zi2,yi2,zj2)*
%* RAy(yi2,zj1,x1)*RAz(zi2,x1,yi1)*RBy(yj2,zi1,x2)*RBz(zj2,x2,yj1))

fileName = ['TRGhistory', num2str(n), '.mat'] ;

load(fileName, 'RA')
%* RRAyz((yi1,zj1),(yi2,zi2)) = sum_{x1}(RAy(yi2,zj1,x1)*RAz(zi2,x1,yi1))
if id == 1
    RRAyz = contractRy_Rz(RA(2), RA(3)) ;
elseif id == 2
    RRAyz = contractRy_Rz(RA(3), RA(1)) ;
elseif id == 3
    RRAyz = contractRy_Rz(RA(1), RA(2)) ;
end
clear RA
fileNameRRA = ['RRAyz_', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameRRA, 'RRAyz', '-v7.3') ;
clear RRAyz

load(fileName, 'RB')
%* RRByz((yj1,zi1),(yj2,zj2)) = sum_{x2}(RBy(yj2,zi1,x2)*RBz(zj2,x2,yj1))
if id == 1
    RRByz = contractRy_Rz(RB(2), RB(3)) ;
elseif id == 2
    RRByz = contractRy_Rz(RB(3), RB(1)) ;
elseif id == 3
    RRByz = contractRy_Rz(RB(1), RB(2)) ;
end
clear RB
fileNameRRB = ['RRByz_', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameRRB, 'RRByz', '-v7.3') ;
clear RRByz

%* RRe((yi1,zj1),(yj2,zj2)) = sum_{yi2,zi2}(RRAyz((yi1,zj1),(yi2,zi2))*env2((yj2,zi2),(yi2,zj2)))
contractRRA_env(parameter, id) ;
% reduceRRe(parameter, id) ;

%* env1((yj1,zi1),(yi1,zj1)) = sum_{yj2,zj2}(RRe((yi1,zj1),(yj2,zj2))*RRByz((yj1,zi1),(yj2,zj2)))
contractRRe_RRB(parameter, id) ;
% reduceEnv(parameter, id) ;