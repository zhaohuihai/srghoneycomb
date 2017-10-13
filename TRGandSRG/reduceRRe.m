function reduceRRe(parameter, id)

fileNameRRe = ['RRe', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameRRe, 'RRe')
subNo = RRe.subNo ;

n = 0 ;
while subNo > 0
    QN = RRe.quantNo(:, 1) ;
    for i = 1 : 4
        equal{i} = (QN(i) == RRe.quantNo(i, :)) ;
        
    end
    index = find(equal{1} & equal{2} & equal{3} & equal{4}) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + RRe.tensor2{index(i)} ;
    end
    subNo = subNo - indexNo ;
    tensor2{n} = tensor ;
    quantNo(:, n) = QN ;
    dim(:, n) = RRe.dim(:, 1) ;
    RRe.quantNo(:, index) = [] ;
    RRe.dim(:, index) = [] ;
    RRe.tensor2(index) = [] ;
end
RRe.subNo = n ;
RRe.quantNo = quantNo ;
RRe.dim = dim ;
RRe.tensor2 = tensor2 ;

save(fileNameRRe, 'RRe', '-v7.3')