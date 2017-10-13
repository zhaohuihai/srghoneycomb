function mapping = createTotMapping(allTwoQN, quantNo, dim)

subNo = length(allTwoQN) ;

n = 0 ;
while subNo > 0
    twoQN = max(allTwoQN) ;
    index = find(twoQN == allTwoQN) ;
    indexNo = length(index) ;
    n = n + 1 ;
    
    [map, totDim] = createMapping(quantNo(index), dim(index)) ;
    mapping.twoQuantNo(n) = twoQN ;
    mapping.map{n} = map ;
    mapping.totDim(n) = totDim ;
    allTwoQN(index) = allTwoQN(index) - 1e9 ;
    subNo = subNo - indexNo ;
end