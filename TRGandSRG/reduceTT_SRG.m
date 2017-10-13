function TT = reduceTT_SRG(TT)
%* field of TT: subNo(T0), quantNo(T1), dim(T1), tensor2(cell of T2),
subNo = TT.subNo ;

n = 0 ;
while subNo > 0
    QN = TT.quantNo(1) ;
    index = find(QN == TT.quantNo) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + TT.tensor2{index(i)} ;
    end
    subNo = subNo - indexNo ;
    tensor2{n} = tensor ;
    quantNo(n) = QN ;
    dim(n) = TT.dim(1) ;
    
    TT.quantNo(index) = [] ;
    TT.dim(index) = [] ;
    TT.tensor2(index) = [] ;
end
TT.subNo = n ;
TT.quantNo = quantNo ;
TT.dim = dim ;
TT.tensor2 = tensor2 ;