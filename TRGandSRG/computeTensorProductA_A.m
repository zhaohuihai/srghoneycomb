function AA = computeTensorProductA_A(M, A, Lambda)
%* AA(x1,x2,y1,y2,z1,z2;m1,m2) = A(x1,y1,z1,m1) * A(x2,y2,z2,m2)

for m1 = 1 : M
    A1no = A(m1).subNo ;
    for m2 = 1 : M
        A2no = A(m2).subNo ;
        k = 0 ;
        for i = 1 : A1no
            SNi = A(m1).serialNo(:, i) ;
            for j = 1 : A2no
                SNj = A(m2).serialNo(:, j) ;
                k = k + 1 ;
                for n = 1 : 3
                    quantNo((2 * n - 1), k) = Lambda(n).quantNo(SNi(n)) ;
                    quantNo((2 * n), k) = Lambda(n).quantNo(SNj(n)) ;
                    
                    dimi(n) = Lambda(n).dim(SNi(n)) ;
                    dimj(n) = Lambda(n).dim(SNj(n)) ;
                    dim(n, k) = dimi(n) * dimj(n) ;
                end
                %* AA.tensor3{k}((x1,x2),(y1,y2),(z1,z2))
                %* =A(iM).tensor3{i}(x1,y1,z1)*A(iM).tensor3{j}(x2,y2,z2)
                AiTensor = A(m1).tensor3{i} ;
                AjTensor = A(m2).tensor3{j} ;
                AAtensor = computeTensorProductAsub_Asub(dimi, AiTensor, dimj, AjTensor) ;

                tensor3{k} = AAtensor ;
            end
        end
        AA(m1, m2).subNo = k ;
        AA(m1, m2).quantNo = quantNo ;
        AA(m1, m2).dim = dim ;
        AA(m1, m2).tensor3 = tensor3 ;
        clear quantNo dim tensor3
    end
end


