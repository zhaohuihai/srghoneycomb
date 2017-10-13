function coef = applySRG(parameter)

load coef.mat coef
load SRGstep.mat SRGstep
load coefConvergence.mat coefConvergence

systemSuffix = parameter.systemSuffix(1 : 3) ;
while (coefConvergence > parameter.convergenceCriterion_SRG) && (SRGstep < parameter.maxSRGstep)
    SRGstep = SRGstep + 1 ;
    disp(['SRGstep = ', num2str(SRGstep)])
    coefT = zeros(1, 3) ;
    coefH = zeros(1, 3) ;
    disp('svd in progress...')
    %* TAenv TBenv RA RB 
    recordTRGhistory(parameter) ;
    
    copyfile('intermediateResult/M*.mat','../code') ;    
    if parameter.parallelBond == 1
        parfor i = 1 : 3
            [RA(i), RB(i), coefT(i), RHA(i), RHB(i), coefH(i)] = computeSRGoneBond(parameter, i) ;
        end
    else
        for i = 1 : 3
            [RA(i), RB(i), coefT(i), RHA(i), RHB(i), coefH(i)] = computeSRGoneBond(parameter, i) ;
        end
    end
    disp('svd finished.')
    
    
    
    TA(1) = contract3RtoT(RA(1), RA(2), RA(3)) ;
    TB(1) = contract3RtoT(RB(1), RB(2), RB(3)) ;
    TA(2) = rotateT(TA(1)) ;
    TB(2) = rotateT(TB(1)) ;
    TA(3) = rotateT(TA(2)) ;
    TB(3) = rotateT(TB(2)) ;
    if parameter.parallelBond == 1
        parfor i = 1 : 3
            fileName = ['M', systemSuffix{i}, '.mat'] ;
            contractTA_TB(TA(i), TB(i), fileName) ;
        end
    else
        for i = 1 : 3
            fileName = ['M', systemSuffix{i}, '.mat'] ;
            contractTA_TB(TA(i), TB(i), fileName) ;
        end
    end
    clear TA TB
    
    THA(1) = contract3RtoT(RHA(1), RA(2), RA(3)) ;
    THB(1) = contract3RtoT(RHB(1), RB(2), RB(3)) ;
    THA(2) = contract3RtoT(RHA(2), RA(3), RA(1)) ;
    THB(2) = contract3RtoT(RHB(2), RB(3), RB(1)) ;
    THA(3) = contract3RtoT(RHA(3), RA(1), RA(2)) ;
    THB(3) = contract3RtoT(RHB(3), RB(1), RB(2)) ;
    clear RA RB
    
    if parameter.parallelBond == 1
        parfor i = 1 : 3
            fileName = ['MH', systemSuffix{i}, '.mat'] ;
            contractTA_TB(THA(i), THB(i), fileName) ;
        end
    else
        for i = 1 : 3
            fileName = ['MH', systemSuffix{i}, '.mat'] ;
            contractTA_TB(THA(i), THB(i), fileName) ;
        end
    end
    clear THA THB
    
    copyfile('intermediateResult/*.mat', './intermediateResultBack') ;
    
    save('intermediateResult/SRGstep.mat', 'SRGstep')
    copyfile('M*.mat', './intermediateResult') ;
    coef0 = coef ;
    coef = coef .* coefH ./ coefT ;
    disp(['coef = ', num2str(coef, 15)]) ;
    save('intermediateResult/coef.mat', 'coef')
    coefConvergence = max(abs(coef - coef0)) ;
    disp(['coef convergence error = ', num2str(coefConvergence)]) ;
    energyEstimate = - mean(coef) * 1.5 ;
    disp(['estimate energy = ', num2str(energyEstimate, 15)]) ;
    save('intermediateResult/coefConvergence.mat', 'coefConvergence')
end

if coefConvergence > parameter.convergenceCriterion_SRG
    disp('warning: SRG is not convergent')
end
disp(['total SRG step = ', num2str(SRGstep)]) ;
totalSRGstep = SRGstep ;

if parameter.imbalanceWave == 0
    D = parameter.bondDimension ;
    dirName = ['D = ', num2str(D)] ;
else
    Dleft = parameter.leftBondDimension ;
    Dright = parameter.rightBondDimension ;
    dirName = ['D', num2str(Dleft), 'D', num2str(Dright)] ;
end
pathName = ['result/', dirName] ;
mkdir(pathName)
SRGstepFileName = [pathName, '/totalSRGstep.mat'] ;
save (SRGstepFileName, 'totalSRGstep')