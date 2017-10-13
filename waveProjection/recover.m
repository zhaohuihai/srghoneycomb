function wave = recover(parameter, wave0, USV)

M = parameter.siteDimension ;

U = USV.U ;
V = USV.V ;
S = USV.S ;
Lambda = wave0.Lambda ;
Lambda(1) = S ;

U = reformU(M, Lambda, U) ;
V = reformU(M, Lambda, V) ;

invLy = computeInvLambda(Lambda(2)) ;
invLz = computeInvLambda(Lambda(3)) ;

A0 = AtimesLambda(M, U, invLy, 2) ;
A = AtimesLambda(M, A0, invLz, 3) ;

B0 = AtimesLambda(M, V, invLy, 2) ;
B = AtimesLambda(M, B0, invLz, 3) ;


wave.Lambda = Lambda ;
wave.A = A ;
wave.B = B ;
wave.ABsingularValue = wave0.ABsingularValue ;
wave.coef = wave0.coef * USV.coef ;