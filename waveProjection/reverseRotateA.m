function A = reverseRotateA(M, A0)

for iM = 1 : M
    A(iM).site = A0(iM).site ;
    A(iM).subNo = A0(iM).subNo ;
    A(iM).serialNo(1, :) = A0(iM).serialNo(3, :) ;
    A(iM).serialNo(2, :) = A0(iM).serialNo(1, :) ;
    A(iM).serialNo(3, :) = A0(iM).serialNo(2, :) ;
    for i = 1 : A(iM).subNo
        A(iM).tensor3{i} = permute(A0(iM).tensor3{i}, [3, 1, 2]) ;
    end
end