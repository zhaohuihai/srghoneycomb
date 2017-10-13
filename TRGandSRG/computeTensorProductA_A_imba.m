function AA = computeTensorProductA_A_imba(M, Aleft, LambdaLeft, Aright, LambdaRight)

%* AA(x1,x2,y1,y2,z1,z2;m1,m2) = Aleft(x1,y1,z1,m1) * Aright(x2,y2,z2,m2)

for m1 = 1 : M
    A1no = Aleft(m1).subNo ;
    for m2 = 1 : M
        A2no = Aright(m2).subNo ;
        k = 0 ;
        for i = 1 : A1no
            SNi = Aleft(m1).serialNo(:, i) ;
            for j = 1 : A2no
                SNj = Aright(m2).serialNo(:, j) ;
                k = k + 1 ;
                for n = 1 : 3
                    quantNo((2 * n - 1), k) = LambdaLeft(n).quantNo(SNi(n)) ;
                    quantNo((2 * n), k) = LambdaRight(n).quantNo(SNj(n)) ;
                    
                    dimi(n) = LambdaLeft(n).dim(SNi(n)) ;
                    dimj(n) = LambdaRight(n).dim(SNj(n)) ;
                    dim(n, k) = dimi(n) * dimj(n) ;
                end
                %* AA.tensor3{k}((x1,x2),(y1,y2),(z1,z2))
                %* =A(iM).tensor3{i}(x1,y1,z1)*A(iM).tensor3{j}(x2,y2,z2)
                AiTensor = Aleft(m1).tensor3{i} ;
                AjTensor = Aright(m2).tensor3{j} ;
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
