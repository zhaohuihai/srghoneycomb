function createMH(parameter, AA, BB, fileName)

siteDim = parameter.siteDimension ;

HBB = computeH_BB(parameter, BB) ;
for m1 = 1 : siteDim
    for m2 = 1 : siteDim
        HBB(m1, m2) = reduceTA(HBB(m1, m2)) ;
    end
end
M = computeAA_HBB(siteDim, AA, HBB) ;
% MH = reduceMH(MH) ;
% MH = partitionMbyBondBond(MH) ;

save(fileName, 'M', '-v7.3') ;