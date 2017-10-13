function AA = blockAAby2bond(AA0, totMapping)

subNo = AA0.subNo ;
for i = 1 : 3
    twoQuantNo(i, :) = AA0.quantNo((2 * i - 1), :) - AA0.quantNo((2 * i), :) ;
end
% AA = AA0 ;
% allTwoQN = twoQuantNo ;
n = 0 ;
while subNo > 0
    QN = twoQuantNo(:, 1) ;
    for i = 1 : 3
        equal{i} = (QN(i) == twoQuantNo(i, :)) ;
        mapIndex = find(QN(i) == totMapping(i).twoQuantNo) ;
        mapping(i).map = totMapping(i).map{mapIndex} ;
        mapping(i).totDim = totMapping(i).totDim(mapIndex) ;
    end
    
    index = find(equal{1} & equal{2} & equal{3}) ;
    indexNo = length(index) ;
    n = n + 1 ;
    [AAblock, AAblockDim] = combineAAsub(AA0, index, mapping) ;
    
    AA0.quantNo(:, index) = [] ;
    AA0.dim(:, index) = [] ;
    AA0.tensor3(index) = [] ;
    twoQuantNo(:, index) = [] ;
    
    tensor3{n} = AAblock ;
    quantNo(:, n) = QN ;
    dim(:, n) = AAblockDim ;
    
    subNo = subNo - indexNo ;
end
AA.subNo = n ;
AA.quantNo = quantNo ;
AA.dim = dim ;
AA.tensor3 = tensor3 ;