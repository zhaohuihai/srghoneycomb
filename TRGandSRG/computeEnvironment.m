function computeEnvironment(parameter, id)


%* env((yj,zi),(yi,zj)) = sum_{x1,z1,x2,y2}(TA(x1,yj,z1)*TB(x1,yi,z1)*TA(x2,y2,zj)*TB(x2,y2,zi))
createInitialEnvironment(parameter, id) ;

n = parameter.environmentSize ;
while n > 0
    %* env1((yj1,zi1),(yi1,zj1)) = sum_{yi2,zi2,yj2,zj2,x1,x2}(env2(yj2,zi2,yi2,zj2)*
    %* RAy(yi2,zj1,x1)*RAz(zi2,x1,yi1)*RBy(yj2,zi1,x2)*RBz(zj2,x2,yj1))
    contractEnvironment(parameter, n, id) ;
    n = n - 1 ;
end