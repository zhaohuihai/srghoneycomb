function mapping = createMapping2fullTA(TA)
%* mapping: 1X3 structure array
%* field of mapping: quantNo(1D array), position(cell of 1D arrays)
subNo = TA.subNo ;

for i = 1 : 3
    QN = TA.quantNo(i, :) ;
    dim = TA.dim(i, :) ;
    sn = subNo ;
    a = 0 ;
    n = 0 ;
    while sn > 0
        n = n + 1 ;
        maxQN = max(QN) ;
        index = find(maxQN == QN) ;
        indexNo = length(index) ;
        b = a + dim(index(1)) ;
        
        mapping(i).quantNo(n) = maxQN ;
        mapping(i).position{n} = (a + 1) : b ;
        a = a + dim(index(1)) ;
        
        QN(index) = QN(index) - 1e9 ;
        sn = sn - indexNo ;
    end
    mapping(i).totDim = a ;
end