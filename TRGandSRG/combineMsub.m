function Mblock = combineMsub(M)

yiQuantNo = M.quantNo(1, :) ;
iDim = M.dim(1, :) .* M.dim(2, :) ;
yjQuantNo = M.quantNo(3, :) ;
jDim = M.dim(3, :) .* M.dim(4, :) ;
 
tensor2 = M.tensor2 ;

dim = zeros(1, 2) ;
[yiMap, dim(1)] = createMapping(yiQuantNo, iDim) ;
[yjMap, dim(2)] = createMapping(yjQuantNo, jDim) ;

Mblock = zeros(dim) ;

subNo = M.subNo ;

for i = 1 : subNo
    yiIndex = find(yiMap(1, :) == yiQuantNo(i)) ;
    yjIndex = find(yjMap(1, :) == yjQuantNo(i)) ;
    
    yi = yiMap(2, yiIndex) : (yiMap(2, yiIndex) + iDim(i) - 1) ;
    yj = yjMap(2, yjIndex) : (yjMap(2, yjIndex) + jDim(i) - 1) ;

    Mblock(yi, yj) = Mblock(yi, yj) + tensor2{i} ;
end