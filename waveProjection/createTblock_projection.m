function Tblock = createTblock_projection(map, T, TblockDim, yDim, zDim)

Tblock = zeros(TblockDim) ;
subNo = T.subNo ;
SN = T.serialNo ;

for i = 1 : subNo
    SNi = SN(:, i)' ;
    %* mi yi
    j = find(map(1, :) == T.site1(i)) ;
    x = find(map(2, j) == SNi(1)) ;
    %* mj yj
    k = find(map(1, :) == T.site2(i)) ;
    y = find(map(2, k) == SNi(3)) ;
    
    subDim = [yDim(SNi(1)) * zDim(SNi(2)), yDim(SNi(3)) * zDim(SNi(4))] ;
    
    arr = map(3, j(x)) : (map(3, j(x)) + subDim(1) - 1) ;
    col = map(3, k(y)) : (map(3, k(y)) + subDim(2) - 1) ;
    Tblock(arr, col) = Tblock(arr, col) + T.tensor2{i} ;
end
