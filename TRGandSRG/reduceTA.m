function TA = reduceTA(TA)

subNo = TA.subNo ;
% s = 1 ;
n = 0 ;
if TA.subNo == 0
    return
end
while subNo > 0
    QN = TA.quantNo(:, 1) ; 
    equalX = (QN(1) == TA.quantNo(1, :)) ;
    equalY = (QN(2) == TA.quantNo(2, :)) ;
    equalZ = (QN(3) == TA.quantNo(3, :)) ;
    index = find(equalX & equalY & equalZ) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + TA.tensor3{index(i)} ;
    end
    subNo = subNo - indexNo ;
    tensor3{n} = tensor ;
    quantNo(:, n) = QN ;
    dim(:, n) = TA.dim(:, 1) ;
    TA.quantNo(:, index) = [] ;
    TA.dim(:, index) = [] ;
    TA.tensor3(index) = [] ;
end
TA.subNo = n ;
TA.quantNo = quantNo ;
TA.dim = dim ;
TA.tensor3 = tensor3 ;
