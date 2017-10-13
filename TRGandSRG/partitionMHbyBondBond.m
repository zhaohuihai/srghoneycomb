function partitionMHbyBondBond(ID)

if ID == 1
    load MHx.mat M    
elseif ID == 2
    load MHy.mat M
elseif ID == 3
    load MHz.mat M
end
MH = M ;
clear M

quantNo = MH.quantNo ;
dim = MH.dim ;
tensor2 = MH.tensor2 ;
yiZj = quantNo(1, :) - quantNo(2, :) ;
iM = 0 ;
t = MH.subNo ;
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
clear MH