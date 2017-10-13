function AA = rotateAA(M, AA0)

for m1 = 1 : M
    for m2 = 1 : M
        AA(m1, m2).subNo = AA0(m1, m2).subNo ;
        AA(m1, m2).quantNo(1, :) = AA0(m1, m2).quantNo(2, :) ;
        AA(m1, m2).quantNo(2, :) = AA0(m1, m2).quantNo(3, :) ;
        AA(m1, m2).quantNo(3, :) = AA0(m1, m2).quantNo(1, :) ;
        AA(m1, m2).dim(1, :) = AA0(m1, m2).dim(2, :) ;
        AA(m1, m2).dim(2, :) = AA0(m1, m2).dim(3, :) ;
        AA(m1, m2).dim(3, :) = AA0(m1, m2).dim(1, :) ;
        for i = 1 : AA0(m1, m2).subNo
            AA(m1, m2).tensor3{i} = permute(AA0(m1, m2).tensor3{i}, [2, 3, 1]) ;
        end
    end
end
