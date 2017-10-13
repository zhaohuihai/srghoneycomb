function TA = blockTAbyBondBond(AA)

AANo = AA.subNo ;
for i = 1 : 3
    bondBond(i, :) = AA.quantNo((2 * i - 1), :) - AA.quantNo((2 * i), :) ;
end
xBondBond = bondBond(1, :) ;
yBondBond = bondBond(2, :) ;

sx = AANo ;
i = 0 ;
while sx > 0
    maxXBondBond = max(xBondBond) ;
    sameXBondBond = find(maxXBondBond == xBondBond) ; %* index
    sameXBondBondNo = length(sameXBondBond) ;
    sy = sameXBondBondNo ;
    while sy > 0
        i = i + 1 ;
        maxYBondBond = max(yBondBond(sameXBondBond)) ;
        %* sub-index
        sameYBondBond = find(maxYBondBond == yBondBond(sameXBondBond)) ; 
        sameYBondBondNo = length(sameYBondBond) ;
        
        index = sameXBondBond(sameYBondBond) ;
        
        zbb = 0 - maxXBondBond - maxYBondBond ;
        
        indexX = find(maxXBondBond == bondBond(1, :)) ;
        indexY = find(maxYBondBond == bondBond(2, :)) ;
        indexZ = find(zbb == bondBond(3, :)) ;
        
        [TAblock, TAblockDim] = combineAAsub(AA, index, indexX, indexY, indexZ) ;
        
        quantNo(:, i) = [maxXBondBond; maxYBondBond; zbb] ;
        dim(:, i) = TAblockDim ;
        tensor3{i} = TAblock ;
        
        yBondBond(index) = yBondBond(index) - 1e9 ;
        sy = sy - sameYBondBondNo ;
    end
    xBondBond(sameXBondBond) = xBondBond(sameXBondBond) - 1e9 ;
    sx = sx - sameXBondBondNo ;
end
TA.subNo = i ;
TA.quantNo = quantNo ;
TA.dim = dim ;
TA.tensor3 = tensor3 ;