function [tensor, dim] = combineABABsub(ABAB, index, indexYi, indexZj, indexYj, indexZi)

yiQuantNo = ABAB.quantNo(1, indexYi) ;
yiDim = ABAB.dim(1, indexYi) ;
zjQuantNo = ABAB.quantNo(3, indexZj) ;
zjDim = ABAB.dim(2, indexZj) ;

yjQuantNo = ABAB.quantNo(5, indexYj) ;
yjDim = ABAB.dim(3, indexYj) ;
ziQuantNo = ABAB.quantNo(7, indexZi) ;
ziDim = ABAB.dim(4, indexZi) ;

dim = zeros(4, 1) ;
[yiMap, dim(1)] = createMapping(yiQuantNo, yiDim) ;
[zjMap, dim(2)] = createMapping(zjQuantNo, zjDim) ;
[yjMap, dim(3)] = createMapping(yjQuantNo, yjDim) ;
[ziMap, dim(4)] = createMapping(ziQuantNo, ziDim) ;

yiQuantNo = ABAB.quantNo(1, index) ;
yiDim = ABAB.dim(1, index) ;
zjQuantNo = ABAB.quantNo(3, index) ;
zjDim = ABAB.dim(2, index) ;

yjQuantNo = ABAB.quantNo(5, index) ;
yjDim = ABAB.dim(3, index) ;
ziQuantNo = ABAB.quantNo(7, index) ;
ziDim = ABAB.dim(4, index) ;

tensor4 = ABAB.tensor4(index) ;

tensor = zeros(dim') ;
subNo = length(index) ;
for i = 1 : subNo
    yiIndex = find(yiMap(1, :) == yiQuantNo(i)) ;
    zjIndex = find(zjMap(1, :) == zjQuantNo(i)) ;
    yjIndex = find(yjMap(1, :) == yjQuantNo(i)) ;
    ziIndex = find(ziMap(1, :) == ziQuantNo(i)) ;
    
    yi = yiMap(2, yiIndex) : (yiMap(2, yiIndex) + yiDim(i) - 1) ;
    zj = zjMap(2, zjIndex) : (zjMap(2, zjIndex) + zjDim(i) - 1) ;
    yj = yjMap(2, yjIndex) : (yjMap(2, yjIndex) + yjDim(i) - 1) ;
    zi = ziMap(2, ziIndex) : (ziMap(2, ziIndex) + ziDim(i) - 1) ;
    
    tensor(yi, zj, yj, zi) = tensor(yi, zj, yj, zi) + tensor4{i} ;
end