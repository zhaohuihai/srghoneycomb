function reduceVMU_SRG(parameter, id, th)
%* field of VMU: subNo(T0), quantNo(T1), dim(T1), tensor2(cell of T2),

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameVMU = ['VMU', suffix, '.mat'] ;
load(fileNameVMU, 'VMU')

subNo = VMU.subNo ;

n = 0 ;
while subNo > 0
    QN = VMU.quantNo(1) ;
    index = find(QN == VMU.quantNo) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + VMU.tensor2{index(i)} ;
    end
    subNo = subNo - indexNo ;
    tensor2{n} = tensor ;
    quantNo(n) = QN ;
    dim(n) = VMU.dim(1) ;
    
    VMU.quantNo(index) = [] ;
    VMU.dim(index) = [] ;
    VMU.tensor2(index) = [] ;
end
VMU.subNo = n ;
VMU.quantNo = quantNo ;
VMU.dim = dim ;
VMU.tensor2 = tensor2 ;

save(fileNameVMU, 'VMU', '-v7.3')