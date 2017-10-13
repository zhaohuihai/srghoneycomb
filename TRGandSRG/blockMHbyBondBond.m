function T = blockMHbyBondBond(ABAB)

for n = 1 : 4
    n1 = 2 * n - 1 ;
    n2 = 2 * n ;
    bondBond(n, :) = ABAB.quantNo(n1, :) - ABAB.quantNo(n2, :) ;
end
yiBondBond = bondBond(1, :) ;
zjBondBond = bondBond(2, :) ;
yjBondBond = bondBond(3, :) ;

ABABNo = ABAB.subNo ;
syi = ABABNo ;
i = 0 ;
while syi > 0
    maxYi = max(yiBondBond) ;    
    %* index
    sameYi = find(maxYi == yiBondBond) ;
    
    sameYiNo = length(sameYi) ;
    szj = sameYiNo ;
    while szj > 0
        maxZj = max(zjBondBond(sameYi)) ;        
        %* sub-index
        sameZj = find(maxZj == zjBondBond(sameYi)) ;
        
        sameZjNo = length(sameZj) ;
        syj = sameZjNo ;
        while syj > 0
            i = i + 1 ;
            maxYj = max(yjBondBond(sameYi(sameZj))) ;            
            %* sub-sub-index
            sameYj = find(maxYj == yjBondBond(sameYi(sameZj))) ;
            
            sameYjNo = length(sameYj) ;
            index = sameYi(sameZj(sameYj)) ;
            
            Zi = maxYj - maxYi + maxZj ;            
            indexYi = find(maxYi == bondBond(1, :)) ;
            indexZj = find(maxZj == bondBond(2, :)) ;
            indexYj = find(maxYj == bondBond(3, :)) ;
            indexZi = find(Zi == bondBond(4, :)) ;
            %* tensor order: 4; dim: 4X1
            [Tblock, Tdim] = combineABABsub(ABAB, index, indexYi, indexZj, indexYj, indexZi) ; 
            
            quantNo(:, i) = [maxYi; maxZj; maxYj; Zi] ;
            dim(:, i) = Tdim ;
            tensor2{i} = reshape(Tblock, [Tdim(1) * Tdim(2), Tdim(3) * Tdim(4)]) ;
            
            yjBondBond(index) = yjBondBond(index) - 1e9 ;
            syj = syj - sameYjNo ;
        end
        zjBondBond(sameYi(sameZj)) = zjBondBond(sameYi(sameZj)) - 1e9 ;
        szj = szj - sameZjNo ;
    end
    yiBondBond(sameYi) = yiBondBond(sameYi) - 1e9 ;
    syi = syi - sameYiNo ;
end
T.subNo = i ;
T.quantNo = quantNo ;
T.dim = dim ;
T.tensor2 = tensor2 ;


