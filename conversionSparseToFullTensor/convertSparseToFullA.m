function A = convertSparseToFullA(M, D, As, Lambda)

A = zeros(D, D, D, M) ;
for m = 1 : M
    for i = 1 : As(m).subNo
        SN = As(m).serialNo(:, i) ;
        p = cell(1, 3) ;
        for j = 1 : 3
            p{j} = findPosition(SN(j), Lambda(j)) ;
        end
        A(p{1}, p{2}, p{3}, m) = A(p{1}, p{2}, p{3}, m) + As(m).tensor3{i} ;
    end
end