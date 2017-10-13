function contractRRA_env(parameter, id)
%* RRe((yi1,zj1),(yj2,zj2)) = sum_{yi2,zi2}(RRAyz((yi1,zj1),(yi2,zi2))*env((yj2,zi2),(yi2,zj2)))

fileNameRRA = ['RRAyz_', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameRRA, 'RRAyz') ;

fileNameEnv = ['env', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameEnv, 'env') ;

n = 0 ;

RRe.subNo = 0 ;
RRe.quantNo = zeros(4, 0) ;
RRe.dim = zeros(4, 0) ;
RRe.tensor2 = cell(0) ;

for i = 1 : RRAyz.subNo
    rQN = RRAyz.quantNo(:, i) ;
    rDim = RRAyz.dim(:, i) ;
    rTensor = RRAyz.tensor2{i} ; %* ((yi1,zj1),(yi2,zi2))
    RRAyz.tensor2{i} = [] ;
    equalYi2 = (rQN(3) == env.quantNo(3, :)) ;
    equalZi2 = (rQN(4) == env.quantNo(2, :)) ;
    j = find(equalYi2 & equalZi2) ;
    if ~isempty(j)                
        for k = 1 : length(j)           
            eQN = env.quantNo(:, j(k)) ;
            eDim = env.dim(:, j(k)) ;
            eTensor = env.tensor2{j(k)} ; %* ((yj2,zi2),(yi2,zj2))
            
            eTensor = reshape(eTensor, eDim') ; %* (yj2,zi2,yi2,zj2)
            eTensor = permute(eTensor, [3, 2, 1, 4]) ; %* (yi2,zi2,yj2,zj2)
            eTensor = reshape(eTensor,[eDim(3) * eDim(2), eDim(1) * eDim(4)]) ; %* ((yi2,zi2),(yj2,zj2))
            
            tensor = rTensor * eTensor ; %* ((yi1,zj1),(yj2,zj2))
            
            tQN = [rQN(1 : 2); eQN(1); eQN(4)] ;
            
            equalT = cell(1, 3) ;
            for m = 1 : 3
                equalT{m} = (tQN(m) == RRe.quantNo(m, :)) ;
            end
            index = find(equalT{1} & equalT{2} & equalT{3}) ;
            
            if isempty(index)
                n = n + 1 ;
                RRe.quantNo(:, n) = tQN ;
                RRe.dim(:, n) = [rDim(1 : 2); eDim(1); eDim(4)] ;
                RRe.tensor2{n} = tensor ;
            else
                RRe.tensor2{index} = RRe.tensor2{index} + tensor ;
            end
        end
    end
end
RRe.subNo = n ;

fileNameRRe = ['RRe', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameRRe, 'RRe', '-v7.3')