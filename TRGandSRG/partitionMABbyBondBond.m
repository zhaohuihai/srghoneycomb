function partitionMABbyBondBond

load MAB.mat MAB
quantNo = MAB.quantNo ;
dim = MAB.dim ;
tensor2 = MAB.tensor2 ;
yiZj = quantNo(1, :) - quantNo(2, :) ;
iM = 0 ;
t = MAB.subNo ;
while t > 0
    maxYiZj = max(yiZj) ;
    index = find(yiZj == maxYiZj) ;
    indexNo = length(index) ;
    
    iM = iM + 1 ;
    M(iM).yiZjBondBond = maxYiZj ;
    
    M(iM).subNo = indexNo ;
    M(iM).quantNo = quantNo(:, index) ;
    M(iM).dim = dim(:, index) ;
    M(iM).tensor2 = tensor2(index) ;
    
    yiZj(index) = yiZj(index) - 1e9 ;
    t = t - indexNo ;
end
save ('M.mat', 'M', '-v7.3')
clear MAB