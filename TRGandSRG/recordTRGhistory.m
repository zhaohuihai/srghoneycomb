function recordTRGhistory(parameter)

systemSuffix = parameter.systemSuffix(1 : 3) ;
envSize = 0 ;
while envSize < parameter.environmentSize
    envSize = envSize + 1 ;
%     RA = [] ;
%     RB = [] ;
    if parameter.parallelBond == 1
        parfor i = 1 : 3
            [RA(i), RB(i)] = decomposeM_TRG(parameter, i) ;
        end
    else
        for i = 1 : 3
            [RA(i), RB(i)] = decomposeM_TRG(parameter, i) ;
        end
    end
    
    TAenv = contract3RtoT(RA(1), RA(2), RA(3)) ;
    TBenv = contract3RtoT(RB(1), RB(2), RB(3)) ;
    
    if envSize ~= parameter.environmentSize
        TA(1) = TAenv ;
        TB(1) = TBenv ;
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
    end
    
    fileName = ['TRGhistory', num2str(envSize), '.mat'] ;
    save(fileName, 'RA', 'RB', '-v7.3')
end

save('TAenv.mat', 'TAenv', '-v7.3')
save('TBenv.mat', 'TBenv', '-v7.3')