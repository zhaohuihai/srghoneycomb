function MH = reduceMH(MH)

subNo = MH.subNo ;

n = 0 ;
while subNo > 0
    QN = MH.quantNo(:, 1) ;
    for i = 1 : 4
        equal{i} = (QN(i) == MH.quantNo(i, :)) ;
        
    end
    index = find(equal{1} & equal{2} & equal{3} & equal{4}) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + MH.tensor2{index(i)} ;
    end
    subNo = subNo - indexNo ;
    tensor2{n} = tensor ;
    quantNo(:, n) = QN ;
    dim(:, n) = MH.dim(:, 1) ;
    MH.quantNo(:, index) = [] ;
    MH.dim(:, index) = [] ;
    MH.tensor2(index) = [] ;
end
MH.subNo = n ;
MH.quantNo = quantNo ;
MH.dim = dim ;
MH.tensor2 = tensor2 ;