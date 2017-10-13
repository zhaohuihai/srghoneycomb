function reduceEnv(parameter, id)

fileNameEnv = ['env', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameEnv, 'env') ;
subNo = env.subNo ;

n = 0 ;
while subNo > 0
    QN = env.quantNo(:, 1) ;
    for i = 1 : 4
        equal{i} = (QN(i) == env.quantNo(i, :)) ;
        
    end
    index = find(equal{1} & equal{2} & equal{3} & equal{4}) ;
    indexNo = length(index) ;
    n = n + 1 ;
    tensor = 0 ;
    for i = 1 : indexNo
        tensor = tensor + env.tensor2{index(i)} ;
    end
    subNo = subNo - indexNo ;
    tensor2{n} = tensor ;
    quantNo(:, n) = QN ;
    dim(:, n) = env.dim(:, 1) ;
    env.quantNo(:, index) = [] ;
    env.dim(:, index) = [] ;
    env.tensor2(index) = [] ;
end
env.subNo = n ;
env.quantNo = quantNo ;
env.dim = dim ;
env.tensor2 = tensor2 ;

save(fileNameEnv, 'env', '-v7.3') ;