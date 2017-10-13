function RA = createRA(U, S)

UNo = U.subNo ;
% RA = rmfield(U, 'tensor2') ;
for i = 1 : UNo
    %* tensor((y,z),x)
    tensor = U.tensor2{i} ;
    
    quantNo = U.quantNo(3, i) ;
    dim = U.dim(:, i) ;
    %* tensor(y,z,x)
    tensor = reshape(tensor, dim') ;
    
    %* tensor(x,y,z)
    tensor = permute(tensor, [3, 1, 2]) ;
    
    iLx = find(quantNo == S.quantNo) ;
    Lx = S.tensor1{iLx} ;
    
    for x = 1 : dim(3)
        tensor(x, :, :) = sqrt(Lx(x)) .* tensor(x, :, :) ;
    end
    tensor3{i} = tensor ;
end
RA.subNo = UNo ;
RA.quantNo(1, :) = U.quantNo(3, :) ;
RA.quantNo(2, :) = U.quantNo(1, :) ;
RA.quantNo(3, :) = U.quantNo(2, :) ;
RA.dim(1, :) = U.dim(3, :) ;
RA.dim(2, :) = U.dim(1, :) ;
RA.dim(3, :) = U.dim(2, :) ;
RA.tensor3 = tensor3 ;