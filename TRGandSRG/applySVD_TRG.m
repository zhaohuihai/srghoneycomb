function [RA, RB, coefT] = applySVD_TRG(parameter, TA, TB)

MAB = contractTA_TB(TA, TB) ;
clear TA TB
save ('MAB.mat', 'MAB', '-v7.3')

clear MAB
partitionMABbyBondBond ;
tic
if parameter.parallelSVD == 1
    svdParallel_RG(parameter) ;
else
    svd_RG(parameter) ;
end
toc
coefT = truncate_RG(parameter) ;

[RA, RB] = createR ;