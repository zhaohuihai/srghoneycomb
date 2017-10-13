function env = computeKronTTy_TTz(TTy, TTz)

%* env(yj,zi),(yi,zj)) = TTy(yj,yi)*TTz(zi,zj)
k = 0 ;
for i = 1 : TTy.subNo
    yQN = TTy.quantNo(i) ;
    yDim = TTy.dim(i) ;
    for j = 1 : TTz.subNo
        zQN = TTz.quantNo(j) ;
        zDim = TTz.dim(j) ;
        k = k + 1 ;
        tensor = kron(TTy.tensor2{i}, TTz.tensor2{j}) ; %* ((yj,zi),(yi,zj))
        
        env.quantNo(:, k) = [yQN; zQN; yQN; zQN] ;
        env.dim(:, k) = [yDim; zDim; yDim; zDim] ;
        env.tensor2{k} = tensor ;
    end
end
env.subNo = k ;