function [xMap, dim] = createMapping(xBond, xDim)

s = length(xBond) ;
mapNo = 0 ;
dim = 0 ;
while s > 0
    maxXBond = max(xBond) ;
    sameXBond = find(maxXBond == xBond) ; %* index
    
    sameXBondNo = length(sameXBond) ;
    subDim = xDim(sameXBond(1)) ;
    
    mapNo = mapNo + 1 ;
    xMap(1, mapNo) = maxXBond ;
    xMap(2, mapNo) = dim + 1 ;
    dim = dim + subDim ;
    
    xBond(sameXBond) = xBond(sameXBond) - 1e9 ;
    s = s - sameXBondNo ;
end