function [RA, RB, coefH] = decomposeM_TRG(parameter, id)

fileNameM = ['M', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameM, 'M') ; 
M = partitionMbyBondBond(M) ;
save(fileNameM, 'M', '-v7.3') ;
clear M

tic
if parameter.parallelSVD == 1
    svdParallel_RG(parameter, id) ;
else
    svd_RG(parameter, id) ;
end
tElapsed = toc ;
disp(['TRG svd time cost: ', num2str(tElapsed, 8), 's'])

coefH = truncate_RG(parameter, id) ;
[RA, RB] = createR(parameter, id) ;