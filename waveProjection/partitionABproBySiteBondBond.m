function T = partitionABproBySiteBondBond(ABpro, Lambda)

site1 = ABpro.site1 ;
site2 = ABpro.site2 ;
tensor2 = ABpro.tensor2 ;
SN = ABpro.serialNo ;
for i = 1 : 2
    QN = Lambda(i + 1).quantNo ;
    bond(i, :) = QN(SN(i, :)) ;
end

siteBondBond = site1 - bond(1, :) - bond(2, :) ;

iT = 0 ;
t = ABpro.subNo ;
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