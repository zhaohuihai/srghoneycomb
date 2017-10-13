function reduceVM_SRG(parameter, id, th)

%* VM(x1, (yj,zi))

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameVM = ['VM', suffix, '.mat'] ;
load(fileNameVM, 'VM')

subNo = VM.subNo ;

n = 0 ;
while subNo > 0
    QN = VM.quantNo(:, 1) ;
    equalX1 = (QN(1) == VM.quantNo(1, :)) ;
    equalYj = (QN(2) == VM.quantNo(2, :)) ;
    index = find(equalX1 & equalYj) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + VM.tensor2{index(i)} ;
    end
    
    subNo = subNo - indexNo ;
    tensor2{n} = tensor ;
    quantNo(:, n) = QN ;
    dim(:, n) = VM.dim(:, 1) ;
    
    VM.quantNo(:, index) = [] ;
    VM.dim(:, index) = [] ;
    VM.tensor2(index) = [] ;
end
VM.subNo = n ;
VM.quantNo = quantNo ;
VM.dim = dim ;
VM.tensor2 = tensor2 ;

save(fileNameVM, 'VM', '-v7.3')