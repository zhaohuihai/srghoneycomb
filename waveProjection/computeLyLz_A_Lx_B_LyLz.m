function AB = computeLyLz_A_Lx_B_LyLz(parameter, wave)

M = parameter.siteDimension ;

A = wave.A ;
B = wave.B ;
Lambda = wave.Lambda ;
for i = 1 : 3
    A = AtimesLambda(M, A, Lambda(i), i) ;
end
for j = 2 : 3
    B = AtimesLambda(M, B, Lambda(j), j) ;
end

AB = contractA_B(M, A, B, Lambda) ;
