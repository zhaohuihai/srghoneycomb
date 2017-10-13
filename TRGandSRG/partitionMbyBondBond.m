function M = partitionMbyBondBond(M0)

quantNo = M0.quantNo ;
dim = M0.dim ;
% tensor2 = MH.tensor2 ;
yiZj = quantNo(1, :) - quantNo(2, :) ;
i = 0 ;
t = M0.subNo ;
while t > 0
    maxYiZj = max(yiZj) ;
    index = find(yiZj == maxYiZj) ;
    indexNo = length(index) ;
    
    i = i + 1 ;
    M(i).yiZjBondBond = maxYiZj ;
    
    M(i).subNo = indexNo ;
    M(i).quantNo = quantNo(:, index) ;
    M(i).dim = dim(:, index) ;
    M(i).tensor2 = M0.tensor2(index) ;
    
    quantNo(:, index) = [] ;
    dim(:, index) = [] ;
    M0.tensor2(index) = [] ;
    
    yiZj(index) = [] ;
    t = t - indexNo ;
end
