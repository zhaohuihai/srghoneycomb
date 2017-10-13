function partitionEnvByBondBond(parameter, id)

fileNameEnv = ['env', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameEnv, 'env') ;

quantNo = env.quantNo ;
dim = env.dim ;
% tensor2 = env.tensor2 ;
yiZj = quantNo(1, :) - quantNo(2, :) ;
i = 0 ;
t = env.subNo ;
while t > 0
    maxYiZj = max(yiZj) ;
    index = find(yiZj == maxYiZj) ;
    indexNo = length(index) ;
    
    i = i + 1 ;
    Tenv(i).yiZjBondBond = maxYiZj ;
    
    Tenv(i).subNo = indexNo ;
    Tenv(i).quantNo = quantNo(:, index) ;
    Tenv(i).dim = dim(:, index) ;
    Tenv(i).tensor2 = env.tensor2(index) ;
    
    quantNo(:, index) = [] ;
    dim(:, index) = [] ;
    env.tensor2(index) = [] ;
    yiZj(index) = [] ;
    
    t = t - indexNo ;
end
fileNameTenv = ['Tenv', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameTenv, 'Tenv', '-v7.3') ;