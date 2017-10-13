function AA = createAA(M, A, Lambda)

AA0 = computeTensorProductA_A(M, A, Lambda) ;

quantNo = [] ;
dim = [] ;
% tensor3 = cell(0) ;
for m1 = 1 : M
    for m2 = 1 : M
        quantNo = [quantNo, AA0(m1, m2).quantNo] ;
        dim = [dim, AA0(m1, m2).dim] ;
%         tensor3 = [tensor3, AA0(m1, m2).tensor3] ;
    end
end
for n = 1 : 3
    n1 = 2 * n - 1 ;
    n2 = n1 + 1 ;
    allTwoQN = quantNo(n1, :) - quantNo(n2, :) ;
    mapping(n) = createTotMapping(allTwoQN, quantNo(n1, :), dim(n, :)) ;
end

for m1 = 1 : M
    for m2 = 1 : M        
        AA(m1, m2) = blockAAby2bond(AA0(m1, m2), mapping) ;
    end
end