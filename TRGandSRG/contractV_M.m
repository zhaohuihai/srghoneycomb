function contractV_M(parameter, id, th)
%* VM(x1, (yj,zi)) = sum_{yi,zj}(Ve((yi,zj),x1)*M((yi,zj),(yj,zi)))

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameVe = ['Ve', suffix, '.mat'] ;
load(fileNameVe, 'Ve') ;
fileNameM = ['M', suffix, '.mat'] ;
load(fileNameM, 'M') ;

n = 0 ;
VM.subNo = 0 ;
VM.quantNo = zeros(3, 0) ;
VM.dim = zeros(3, 0) ;
VM.tensor2 = cell(0) ;
for i = 1 : M.subNo
    mQN = M.quantNo(:, i) ;
    mDim = M.dim(:, i) ;
    mTensor = M.tensor2{i} ; %* ((yi,zj),(yj,zi))
    M.tensor2{i} = [] ;
    equalYi = (mQN(1) == Ve.quantNo(1, :)) ;
    equalZj = (mQN(2) == Ve.quantNo(2, :)) ;
    j = find(equalYi & equalZj) ;
    if ~isempty(j)
        
        vQN = Ve.quantNo(:, j) ;
        vDim = Ve.dim(:, j) ;
        vTensor = Ve.tensor2{j} ; %* ((yi,zj),x1)
        vTensor = vTensor' ; %* (x1,(yi,zj))
        
        tensor = vTensor * mTensor ; %* (x1, (yj,zi))
        tQN = [vQN(3); mQN(3 : 4)] ;
        
        equalT = cell(1, 2) ;
        for m = 1 : 2
            equalT{m} = (tQN(m) == VM.quantNo(m, :)) ;
        end
        index = find(equalT{1} & equalT{2}) ;
        
        if isempty(index)
            n = n + 1 ;
            VM.quantNo(:, n) = tQN ;
            VM.dim(:, n) = [vDim(3); mDim(3 : 4)] ;
            VM.tensor2{n} = tensor ;
        else
            VM.tensor2{index} = VM.tensor2{index} + tensor ;
        end
    end
end
VM.subNo = n ;

fileNameVM = ['VM', suffix, '.mat'] ;
save(fileNameVM, 'VM', '-v7.3')
