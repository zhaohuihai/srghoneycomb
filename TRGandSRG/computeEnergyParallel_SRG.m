function energy = computeEnergyParallel_SRG(parameter, wave)
M = parameter.siteDimension ;

Lambda = wave.Lambda ;
%* A(x,y,z,m) = sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))*A0(x,y,z,m)
%* B(x,y,z,m) = sqrt(LambdaX(x)*LambdaY(y)*LambdaZ(z))*B0(x,y,z,m)
[A, B] = absorbLambda(M, wave) ;
clear wave
%* TA((x1,x2),(y1,y2),(z1,z2))=sum{m}_(A(x1,y1,z1,m)*A(x2,y2,z2,m))
%* TA((x1,x2),(y1,y2),(z1,z2))~TA(x,y,z)
AA = createAA(M, A, Lambda) ;
TAx = createTA(AA) ;
TAx = reduceTA(TAx) ;
% TAfull = convertSparseToFullTA(parameter, TA) ;
clear A
BB = createAA(M, B, Lambda) ;
TBx = createTA(BB) ;
TBx = reduceTA(TBx) ;
clear B

MH = struct('subNo', {}, 'quantNo', {}, 'dim', {}, 'tensor2', {}) ;
for i = 1 : 3
    MH(i) = createMH(parameter, AA, BB) ;
    AA = rotateAA(M, AA) ;
    BB = rotateAA(M, BB) ;
end
clear AA BB


disp('compute by SRG') ;
[TAx, TBx, MH, coef] = applySRGparallel(parameter, TAx, TBx, MH) ;

for i = 1 : 3
    TA(i) = TAx ;
    TB(i) = TBx ;
    TAx = rotateT(TAx) ;
    TBx = rotateT(TBx) ;
end
clear TAx TBx

energyLast6site = zeros(1, 3) ;
parfor i = 1 : 3
    energyLast6site(i) = contractLast6site(TA(i), TB(i), MH(i)) ;
end
clear TA TB MH
%* energy per site
energy = coef .* energyLast6site .* 1.5 ;

