function RRAyz = contractRy_Rz(RAy, RAz)

%* RRAyz((yi,zi),(y,z)) = sum_{xi}(RAy(y,zi,xi)*RAz(z,xi,yi))

RAyNo = RAy.subNo ;
n = 0 ;
for i = 1 : RAyNo
    RyQN = RAy.quantNo(:, i) ;
    j = find(RyQN(3) == RAz.quantNo(2, :)) ;
    if ~isempty(j)
        RyDim = RAy.dim(:, i) ;
        RAyTensor = RAy.tensor3{i} ; %* (y,zi,xi)
        RAy.tensor3{i} = [] ;
        RAyTensor = reshape(RAyTensor, [RyDim(1) * RyDim(2), RyDim(3)]) ; %* ((y,zi),xi)
        
        for k = 1 : length(j)
            n = n + 1 ;
            
            RzQN = RAz.quantNo(:, j(k)) ;
            RzDim = RAz.dim(:, j(k)) ;
            RAzTensor = RAz.tensor3{j(k)} ; %* (z,xi,yi)
            RAzTensor = permute(RAzTensor, [2, 3, 1]) ; %* (xi,yi,z)
            RAzTensor = reshape(RAzTensor, [RzDim(2), RzDim(3) * RzDim(1)]) ;
            %* tensor((y,zi),(yi,z))
            tensor = RAyTensor * RAzTensor ;
            %* tensor(y,zi,yi,z)
            tensor = reshape(tensor, [RyDim(1), RyDim(2), RzDim(3), RzDim(1)]) ;
            %* tensor(yi,zi,y,z)
            tensor = permute(tensor, [3, 2, 1, 4]) ;
            %* tensor((yi,zi),(y,z))
            tensor = reshape(tensor, [RzDim(3) * RyDim(2), RyDim(1) * RzDim(1)]) ;
            
            RRAyz.quantNo(:, n) = [RzQN(3); RyQN(2); RyQN(1); RzQN(1)] ;
            RRAyz.dim(:, n) = [RzDim(3); RyDim(2); RyDim(1); RzDim(1)] ;
            RRAyz.tensor2{n} = tensor ;
        end
    end
end
RRAyz.subNo = n ;

