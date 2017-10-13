function Tblock = combineTsub(T, Lambda)
%* siteBondBond is same in each substructure
subNo = T.subNo ;

site1 = T.site1 ;
yiSN = T.serialNo(1, :) ;
ziSN = T.serialNo(2, :) ;

yDim = Lambda(2).dim ;
zDim = Lambda(3).dim ;
TblockDim = 0 ;
s = subNo ;
mapNo = 0 ;
while s > 0
    maxSite1 = max(site1) ;
    sameSite1 = find(maxSite1 == site1) ; %* index
    sameSite1No = length(sameSite1) ;
    ss = sameSite1No ;
    while ss > 0
        minYiSN = min(yiSN(sameSite1)) ;
        sameYiSN = find(minYiSN == yiSN(sameSite1)) ; %* sub-index
        index = sameSite1(sameYiSN) ;
        
        subDim = yDim(minYiSN) * zDim(ziSN(index(1))) ;
        TblockDim = TblockDim + subDim ;
        
        mapNo = mapNo + 1 ;
        %* determine the location of the submatrix
        map(1, mapNo) = maxSite1 ;
        map(2, mapNo) = minYiSN ;
        %******************************************
        map(3, mapNo) = TblockDim - subDim + 1 ;
        
        yiSN(index) = yiSN(index) + 1e9 ;
        ss = ss - length(sameYiSN) ;
    end
    site1(sameSite1) = site1(sameSite1) - 1e9 ;
    s = s - sameSite1No ;
end

Tblock = createTblock_projection(map, T, TblockDim, yDim, zDim) ;

