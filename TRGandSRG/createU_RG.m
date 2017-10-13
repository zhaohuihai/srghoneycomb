function U = createU_RG(Ublock, U, M, Sdim, UorV)

yzBondBond = M.yiZjBondBond ;
s = M.subNo ;
i = 1 ;
k = [2 * UorV - 1, 2 * UorV ] ; 
quantNo = M.quantNo ;
yQuantNo = M.quantNo(k(1), :) ;
dim = M.dim ;
while s > 0
    maxY = max(yQuantNo) ;
    sameY = find(maxY == yQuantNo) ;
    sameYNo = length(sameY) ;
    index = sameY(1) ;
    
    U.subNo = U.subNo + 1 ;
    %* (yi,zj,x)
    U.quantNo(:, U.subNo) = [quantNo(k, index); yzBondBond] ;
    yDim = dim(k(1), index) ;
    zDim = dim(k(2), index) ;
    U.dim(:, U.subNo) = [yDim; zDim; Sdim] ;
    yzDim = yDim * zDim ;
    j = i + yzDim - 1 ;
    U.tensor2{U.subNo} = Ublock(i : j, :) ; %* ((y,z),x)
    i = j + 1 ;
    
    yQuantNo(sameY) = yQuantNo(sameY) - 1e9 ;
    s = s - sameYNo ;
end