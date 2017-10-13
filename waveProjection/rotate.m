function wave = rotate(parameter, wave0)
%* (x, y, z) --> (y, z, x)
M = parameter.siteDimension ;

A0 = wave0.A ;
B0 = wave0.B ;
A = rotateA(M, A0) ;
B = rotateA(M, B0) ;

wave.A = A ;
wave.B = B ;
wave.Lambda(1) = wave0.Lambda(2) ;
wave.Lambda(2) = wave0.Lambda(3) ;
wave.Lambda(3) = wave0.Lambda(1) ;

wave.ABsingularValue = wave0.ABsingularValue ;
wave.coef = wave0.coef ;
