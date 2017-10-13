function energy = computeEnergyParallel_TRG(parameter, wave)

if parameter.loadIntermediateResult == 1
    disp('load intermediate result')
    copyfile('intermediateResult/TRGstep.mat','TRGstep.mat') ;
    copyfile('intermediateResult/*.mat','../code') ;
else
    createTensorForRG(parameter, wave)
    TRGstep = 0 ;
    save('TRGstep.mat', 'TRGstep')
    coef = ones(1, 3) ;
    save('coef.mat', 'coef')
    coefConvergence = 10 ;
    save('coefConvergence.mat', 'coefConvergence') ;
end

disp('parallel compute by TRG ') ;
[TA, TB, coef] = applyTRGparallel(parameter) ;
deleteIntermediateResult

energyLast6site = zeros(1, 3) ;
energyLast6site(1) = contractLast6site(TA, TB, 1) ;

TA = rotateT(TA) ;
TB = rotateT(TB) ;
energyLast6site(2) = contractLast6site(TA, TB, 2) ;

TA = rotateT(TA) ;
TB = rotateT(TB) ;

energyLast6site(3) = contractLast6site(TA, TB, 3) ;
clear TA TB
%* energy per site
energy = coef .* energyLast6site .* 1.5 ;