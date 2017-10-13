function tr = computeTrace(fileNameM)
%* tr = sum_{y1,z2}(M((y1,z2),(y1,z2)))

load(fileNameM, 'M') ;
tr = 0 ;
for i = 1 : M.subNo
    mQN = M.quantNo(:, i) ;
    c1 = (mQN(1) == mQN(3)) ;
    c2 = (mQN(2) == mQN(4)) ;
    if c1 && c2
        tr = tr + trace(M.tensor2{i}) ;
    end
    
end