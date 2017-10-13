function [TAx, TBx, MH, coef] = applySRGparallel(parameter, TAx, TBx, MH)

coef = ones(1, 3) ;
i = 0 ;
coefConvergence = 10 ;
TA = struct('subNo', {}, 'quantNo', {}, 'dim', {}, 'tensor3', {}) ;
TB = TA ;
THA = TA ;
THB = TA ;
while coefConvergence > parameter.convergenceCriterion_SRG
    i = i + 1 ;
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
        [RA(j), RB(j), coefT(j), RHA(j), RHB(j), coefH(j)] = computeSRGoneBond(parameter, TA(j), TB(j), MH(j)) ;
    end
    toc
    clear TA TB MH ;
    
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
disp(['total SRG step = ', num2str(i)]) ;
SRGstep = i ;
save SRGstep.mat SRGstep