function T = partitionABbySiteBondBond(parameter, AB, Lambda)

M = parameter.siteDimension ;

%* T((mi,yi,zi),(mj,yj,zj)) = AB(((yi,zi),(yj,zj)),(mi,mj))
i = 0 ;
for mi = 1 : M
    for mj = 1 : M
        subNo = AB(mi, mj).subNo ;        
        for iSub = 1 : subNo
            i = i + 1 ;           
            site1(i) = AB(mi, mj).site1 ;
            site2(i) = AB(mi, mj).site2 ;
            SN(:, i) = AB(mi, mj).serialNo(:, iSub) ;
            tensor2{i} = AB(mi, mj).tensor2{iSub} ;
        end
    end
end
for i = 1 : 2
    QN = Lambda(i + 1).quantNo ;
    bond(i, :) = QN(SN(i, :)) ;
end
siteBondBond = site1 - bond(1, :) - bond(2, :) ;

iT = 0 ;
t = length(siteBondBond) ;
while t > 0
    maxSiteBondBond = max(siteBondBond) ;
    index = find(siteBondBond == maxSiteBondBond) ;
    indexNo = length(index) ;
    
    iT = iT + 1 ;
    T(iT).siteBondBond = maxSiteBondBond ;
    T(iT).subNo = indexNo ;
    T(iT).site1 = site1(index) ;
    T(iT).site2 = site2(index) ;
    T(iT).serialNo = SN(:, index) ;
    T(iT).tensor2 = tensor2(index) ;
    
    siteBondBond(index) = siteBondBond(index) - 1e9 ;
    t = t - indexNo ;
end