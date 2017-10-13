function [TA, TB, coef] = applyTRGparallel(parameter)

load coef.mat coef
load TRGstep.mat TRGstep
load coefConvergence.mat coefConvergence
load TA.mat TA
load TB.mat TB
while coefConvergence > parameter.convergenceCriterion_TRG
    TRGstep = TRGstep + 1 ;
    coefT = zeros(1, 3) ;
    coefH = zeros(1, 3) ;
    for j = 1 : 3
        TA(j) = TAx ;
        TB(j) = TBx ;
        TAx = rotateT(TAx) ;
        TBx = rotateT(TBx) ;
    end
    clear TAx TBx
    tic
    parfor j = 1 : 3
        [RA(j), RB(j), coefT(j)] = applySVD_TRG(parameter, TA(j), TB(j)) ;
        [RHA(j), RHB(j), coefH(j)] = decomposeMH_TRG(parameter, MH(j)) ;
    end
    toc
    clear TA TB MH
    
    TAx = contract3RtoT(RA(1), RA(2), RA(3)) ;
    TBx = contract3RtoT(RB(1), RB(2), RB(3)) ;
    parfor j = 1 : 3
        x = j ;
        y = j + 1 ;
        if y > 3
            y = y - 3 ;
        end
        z = j + 2 ;
        if z > 3
            z = z - 3 ;
        end
        THA(j) = contract3RtoT(RHA(x), RA(y), RA(z)) ;
        THB(j) = contract3RtoT(RHB(x), RB(y), RB(z)) ;
    end
    clear RA RB RHA RHB
    parfor j = 1 : 3
        MH(j) = contractTA_TB(THA(j), THB(j)) ;
    end
    clear THA THB
    coef0 = coef ;
    coef = coef .* coefH ./ coefT ;
    %     i
    coefConvergence = max(abs(coef - coef0)) ;
end
disp(['total TRG step = ', num2str(TRGstep)]) ;
save totalTRGstep.mat totalTRGstep