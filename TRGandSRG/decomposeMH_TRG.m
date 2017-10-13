function [RHA, RHB, coefH] = decomposeMH_TRG(parameter, ID)

partitionMHbyBondBond(ID) ;

if parameter.parallel == 1
    svdParallel_RG(parameter) ;
else
    svd_RG(parameter) ;
end

coefH = truncate_RG(parameter) ;
[RHA, RHB] = createR ;