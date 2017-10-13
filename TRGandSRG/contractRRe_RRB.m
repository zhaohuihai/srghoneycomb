function contractRRe_RRB(parameter, id)
%* env1((yj1,zi1),(yi1,zj1)) = sum_{yj2,zj2}(RRe((yi1,zj1),(yj2,zj2))*RRByz((yj1,zi1),(yj2,zj2)))

fileNameRRe = ['RRe', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameRRe, 'RRe')
fileNameRRB = ['RRByz_', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameRRB, 'RRByz') ;

n = 0 ;

env.subNo = 0 ;
env.quantNo = zeros(4, 0) ;
env.dim = zeros(4, 0) ;
env.tensor2 = cell(0) ;

for i = 1 : RRe.subNo
    eQN = RRe.quantNo(:, i) ;
    eDim = RRe.dim(:, i) ;
    eTensor = RRe.tensor2{i} ; %* ((yi1,zj1),(yj2,zj2))
    RRe.tensor2{i} = [] ;
    eTensor = eTensor' ; %* ((yj2,zj2),(yi1,zj1))
    equalYj2 = (eQN(3) == RRByz.quantNo(3, :)) ;
    equalZj2 = (eQN(4) == RRByz.quantNo(4, :)) ;
    j = find(equalYj2 & equalZj2) ;
    if ~isempty(j)       
        for k = 1 : length(j)           
            rQN = RRByz.quantNo(:, j(k)) ;
            rDim = RRByz.dim(:, j(k)) ;
            rTensor = RRByz.tensor2{j(k)} ; %* ((yj1,zi1),(yj2,zj2))            
            
            tensor = rTensor * eTensor ; %* ((yj1,zi1),(yi1,zj1))
            tQN = [rQN(1 : 2); eQN(1 : 2)] ;
            
            equalT = cell(1, 3) ;
            for m = 1 : 3
                equalT{m} = (tQN(m) == env.quantNo(m, :)) ;
            end
            index = find(equalT{1} & equalT{2} & equalT{3}) ;
            
            if isempty(index)
                n = n + 1 ;
                env.quantNo(:, n) = tQN ;
                env.dim(:, n) = [rDim(1 : 2); eDim(1 : 2)] ;
                env.tensor2{n} = tensor ;
            else
                env.tensor2{index} = env.tensor2{index} + tensor ;
            end
        end
    end
end
env.subNo = n ;

fileNameEnv = ['env', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameEnv, 'env', '-v7.3') ;