function A = AtimesLambda(M, A, Lambda, bondFlag)
%* bondFlag: 1 for x; 2 for y; 3 for z

if bondFlag == 1
    for iM = 1 : M
        for i = 1 : A(iM).subNo
            bondSN = A(iM).serialNo(1, i) ;
            tensor = A(iM).tensor3{i} ;
            L = Lambda.tensor1{bondSN} ;
            for x = 1 : Lambda.dim(bondSN)
                tensor(x, :, :) = L(x) * tensor(x, :, :) ;
            end
            A(iM).tensor3{i} = tensor ;
        end
    end
elseif bondFlag == 2
    for iM = 1 : M
        for i = 1 : A(iM).subNo
            bondSN = A(iM).serialNo(2, i) ;
            tensor = A(iM).tensor3{i} ;
            L = Lambda.tensor1{bondSN} ;
            for y = 1 : Lambda.dim(bondSN)
                tensor(:, y, :) = L(y) * tensor(:, y, :) ;
            end
            A(iM).tensor3{i} = tensor ;
        end
    end
elseif bondFlag == 3
    for iM = 1 : M
        for i = 1 : A(iM).subNo
            bondSN = A(iM).serialNo(3, i) ;
            tensor = A(iM).tensor3{i} ;
            L = Lambda.tensor1{bondSN} ;
            for z = 1 : Lambda.dim(bondSN)
                tensor(:, :, z) = L(z) * tensor(:, :, z) ;
            end
            A(iM).tensor3{i} = tensor ;
        end
    end
else
    'bond not found'
end