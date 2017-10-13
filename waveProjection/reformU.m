function U = reformU(M, Lambda, U0)
%* U(m)((y,z),x) --> U(x,y,z)
U = rmfield(U0, 'tensor2') ;
for i = 1 : M
    subNo = U(i).subNo ;
    U(i).serialNo(1, :) = U0(i).serialNo(3, :) ;
    U(i).serialNo(2, :) = U0(i).serialNo(1, :) ;
    U(i).serialNo(3, :) = U0(i).serialNo(2, :) ;
    for j = 1 : subNo
        dim = zeros(1, 3) ;
        SN = U(i).serialNo(:, j) ;
        for k = 1 : 3
            dim(k) = Lambda(k).dim(SN(k)) ; 
        end
        
        tensor = reshape(U0(i).tensor2{j}, [dim(2), dim(3), dim(1)]) ;
        tensor = permute(tensor, [3, 1, 2]) ;
        U(i).tensor3{j} = tensor ; 
        
        
    end
end