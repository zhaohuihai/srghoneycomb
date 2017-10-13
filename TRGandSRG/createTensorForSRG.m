function createTensorForSRG(parameter, wave)

siteDim = parameter.siteDimension ;

systemSuffix = parameter.systemSuffix ;

Lambda = wave.Lambda ;
%* A(x,y,z,m) = sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))*A0(x,y,z,m)
%* B(x,y,z,m) = sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))*B0(x,y,z,m)
[A, B] = absorbLambda(siteDim, wave) ;
clear wave
%* TA((x1,x2),(y1,y2),(z1,z2))=sum{m}_(A(x1,y1,z1,m)*A(x2,y2,z2,m))
%* TA((x1,x2),(y1,y2),(z1,z2))~TA(x,y,z)
As(1).AA = createAA(siteDim, A, Lambda) ;
clear A
TA(1) = createTA(As(1).AA) ;
TA(1) = reduceTA(TA(1)) ;


Bs(1).BB = createAA(siteDim, B, Lambda) ;
clear B
TB(1) = createTA(Bs(1).BB) ;
TB(1) = reduceTA(TB(1)) ;

TA(2) = rotateT(TA(1)) ;
TB(2) = rotateT(TB(1)) ;
TA(3) = rotateT(TA(2)) ;
TB(3) = rotateT(TB(2)) ;

As(2).AA = rotateAA(siteDim, As(1).AA) ;
Bs(2).BB = rotateAA(siteDim, Bs(1).BB) ;
As(3).AA = rotateAA(siteDim, As(2).AA) ;
Bs(3).BB = rotateAA(siteDim, Bs(2).BB) ;

if parameter.parallelBond == 1
    parfor i = 1 : 3
        fileName = ['M', systemSuffix{i}, '.mat'] ;
        contractTA_TB(TA(i), TB(i), fileName) ;
        fileName = ['MH', systemSuffix{i}, '.mat'] ;
        createMH(parameter, As(i).AA, Bs(i).BB, fileName) ;        
    end
else
    for i = 1 : 3
        fileName = ['M', systemSuffix{i}, '.mat'] ;
        contractTA_TB(TA(i), TB(i), fileName) ;
        fileName = ['MH', systemSuffix{i}, '.mat'] ;
        createMH(parameter, As(i).AA, Bs(i).BB, fileName) ;        
    end
end
