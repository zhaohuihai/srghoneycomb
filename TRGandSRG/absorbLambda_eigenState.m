function [A, B] = absorbLambda_eigenState(M, wave)

%* A(x,y,z,m) = A0(x,y,z,m) * sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))

A0 = wave.A ;
B0 = wave.B ;
Lambda = wave.Lambda ;

sqrtLambda = computeSqrtLambda(Lambda) ;
for i = 1 : 3
    A0 = AtimesLambda(M, A0, sqrtLambda(i), i) ;
    B0 = AtimesLambda(M, B0, sqrtLambda(i), i) ;
end

%* field of A0: site, subNo, serialNo, tensor3
%* field of A:  subNo, quantNo, dim, tensor3

for i = 1 : M
    A(i).subNo = A0(i).subNo ;
    B(i).subNo = B0(i).subNo ;
    for j = 1 : 3
        A(i).quantNo(j, :) = Lambda(j).quantNo(A0(i).serialNo(j, :)) ;
        A(i).dim(j, :) = Lambda(j).dim(A0(i).serialNo(j, :)) ;
        
        B(i).quantNo(j, :) = Lambda(j).quantNo(B0(i).serialNo(j, :)) ;
        B(i).dim(j, :) = Lambda(j).dim(B0(i).serialNo(j, :)) ;
    end
    A(i).tensor3 = A0(i).tensor3 ;
    B(i).tensor3 = B0(i).tensor3 ;
end