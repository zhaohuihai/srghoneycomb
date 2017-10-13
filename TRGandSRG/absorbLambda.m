function [A, B] = absorbLambda(M, wave)

%* A(x,y,z,m) = A0(x,y,z,m) * sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))

A = wave.A ;
B = wave.B ;
Lambda = wave.Lambda ;

sqrtLambda = computeSqrtLambda(Lambda) ;
for i = 1 : 3
    A = AtimesLambda(M, A, sqrtLambda(i), i) ;
    B = AtimesLambda(M, B, sqrtLambda(i), i) ;
end
