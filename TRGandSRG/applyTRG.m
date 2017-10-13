function coef = applyTRG(parameter)

load coef.mat coef
load TRGstep.mat TRGstep
load coefConvergence.mat coefConvergence
%* (RHx, Ry, Rz);(RHy, Rz, Rx);(RHz, Rx, Ry)
RHindex = [4, 2, 3; 5, 3, 1; 6, 1, 2] ;

systemSuffix = parameter.systemSuffix(1 : 3) ;
while (coefConvergence > parameter.convergenceCriterion_TRG) && (TRGstep < parameter.maxTRGstep) 
    TRGstep = TRGstep + 1 ;
    disp(['TRGstep = ', num2str(TRGstep)])
    coefTH = zeros(1, 6) ;
    %tic
    disp('svd in progress...')
    if parameter.parallelBond == 1
        parfor i = 1 : 6
            [RA(i), RB(i), coefTH(i)] = decomposeM_TRG(parameter, i) ;
        end
    else
        for i = 1 : 6
            [RA(i), RB(i), coefTH(i)] = decomposeM_TRG(parameter, i) ;
        end
    end
    coefT = coefTH(1 : 3) ;
    coefH = coefTH(4 : 6) ;
    
    disp('svd finished.')
    %toc    
    
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
    
    for i = 1 : 3
        index = RHindex(i, :) ;
        THA(i) = contract3RtoT(RA(index(1)), RA(index(2)), RA(index(3))) ;
        THB(i) = contract3RtoT(RB(index(1)), RB(index(2)), RB(index(3))) ;
    end
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
    
    save('intermediateResult/TRGstep.mat', 'TRGstep')
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

if coefConvergence > parameter.convergenceCriterion_TRG
    disp('warning: TRG is not convergent')
end
disp(['total TRG step = ', num2str(TRGstep)]) ;
totalTRGstep = TRGstep ;

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
TRGstepFileName = [pathName, '/totalTRGstep.mat'] ;
save(TRGstepFileName, 'totalTRGstep')