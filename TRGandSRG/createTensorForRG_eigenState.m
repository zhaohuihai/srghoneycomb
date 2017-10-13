function createTensorForRG_eigenState(parameter, wave)

siteDim = parameter.siteDimension ;

systemSuffix = parameter.systemSuffix ;

% Lambda = wave.Lambda ;
%* A(x,y,z,m) = sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))*A0(x,y,z,m)
%* B(x,y,z,m) = sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))*B0(x,y,z,m)
[A, B] = absorbLambda_eigenState(siteDim, wave) ;

if parameter.upDownSpin == 1
    TA(1) = A(1) ;
    TB(1) = B(1) ;
else
    TA(1) = A(2) ;
    TB(1) = B(2) ;
end

TA(2) = rotateT(TA(1)) ;
TB(2) = rotateT(TB(1)) ;
TA(3) = rotateT(TA(2)) ;
TB(3) = rotateT(TB(2)) ;

for i = 1 : 3
    W(i).A = A ;
    W(i).B = B ;
    A = rotateA_eigenState(siteDim, A) ;
    B = rotateA_eigenState(siteDim, B) ;
end

if parameter.parallelBond == 1
    parfor i = 1 : 3
        fileName = ['M', systemSuffix{i}, '.mat'] ;
        contractTA_TB(TA(i), TB(i), fileName) ;
        fileName = ['MH', systemSuffix{i}, '.mat'] ;
        createMH_eigenState(parameter, W(i), fileName) ;        
    end
else
    for i = 1 : 3
        fileName = ['M', systemSuffix{i}, '.mat'] ;
        contractTA_TB(TA(i), TB(i), fileName) ;
        fileName = ['MH', systemSuffix{i}, '.mat'] ;
        createMH_eigenState(parameter, W(i), fileName) ;        
    end
end