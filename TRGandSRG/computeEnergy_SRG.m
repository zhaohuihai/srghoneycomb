function energy = computeEnergy_SRG(parameter, waveLeft, waveRight)

if parameter.loadIntermediateResult == 1
    disp('load intermediate result')
    copyfile('intermediateResult/SRGstep.mat','SRGstep.mat') ;
    copyfile('intermediateResult/*.mat','./') ;
else
    if parameter.eigenStateMethod == 1
        createTensorForRG_eigenState(parameter, waveRight)
    else
        createTensorForRG(parameter, waveLeft, waveRight)
    end
    SRGstep = 0 ;
    save('SRGstep.mat', 'SRGstep')
    coef = ones(1, 3) ;
    save('coef.mat', 'coef')
    coefConvergence = 10 ;
    save('coefConvergence.mat', 'coefConvergence') ;
    copyfile('*.mat', './intermediateResult') ;
end

disp('compute by SRG') ;
coef = applySRG(parameter) ;
% deleteIntermediateResult
disp('SRG finished. Trace out last 6 site...') ;

energyLast6site = zeros(1, 3) ;
if parameter.parallelBond == 1
    parfor i = 1 : 3
        energyLast6site(i) = contractLast6site(parameter, i) ;
    end
else
    for i = 1 : 3
        energyLast6site(i) = contractLast6site(parameter, i) ;
    end
end

%* energy per site
energy = coef .* energyLast6site .* 1.5 ;

