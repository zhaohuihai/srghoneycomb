function createMH_eigenState(parameter, W, fileName)

%* M((yi,zj),(yj,zi)) = sum{m1,m2,x}_(H(1,1,m1,m2)*A(x,yi,zi,m1)*B(x,yj,zj,m2))

A = W.A ;
B = W.B ;

siteDim = parameter.siteDimension ;
H = reshape(parameter.H, [siteDim, siteDim, siteDim, siteDim]) ;
n = 0 ;

M.subNo = 0 ;
M.quantNo = zeros(4, 0) ;
M.dim = zeros(4, 0) ;
M.tensor2 = cell(0) ;

for m1 = 1 : siteDim
    for m2 = 1 : siteDim
        if parameter.upDownSpin == 1
            h = H(1, 1, m1, m2) ;
        else
            h = H(2, 2, m1, m2) ;
        end
        if h ~= 0
            ANo = A(m1).subNo ;
            for i = 1 : ANo
                AquantNo = A(m1).quantNo(:, i) ;
                j = find(AquantNo(1) == B(m2).quantNo(1, :)) ;
                if ~isempty(j)
                    Adim = A(m1).dim(:, i) ;
                    Atensor = A(m1).tensor3{i} ;
                    Atensor = permute(Atensor, [2, 3, 1]) ; %* (yi,zi,x)
                    Atensor = reshape(Atensor, [Adim(2) * Adim(3), Adim(1)]) ; %* ((yi,zi),x)
                    
                    for k = 1 : length(j)
                        
                        BquantNo = B(m2).quantNo(:, j(k)) ;
                        Bdim = B(m2).dim(:, j(k)) ;
                        
                        Btensor = B(m2).tensor3{j(k)} ; %* (x,yj,zj)
                        
                        Btensor = reshape(Btensor, [Bdim(1), Bdim(2) * Bdim(3)]) ; %* (x,(yj,zj))
                        %* tensor((yi,zi),(yj,zj))
                        tensor = Atensor * Btensor ;
                        %* tensor(yi,zi,yj,zj)
                        tensor = reshape(tensor, [Adim(2), Adim(3), Bdim(2), Bdim(3)]) ;
                        %* tensor(yi,zj,yj,zi)
                        
                        tensor = permute(tensor, [1, 4, 3, 2]) ;
                        %* tensor((yi,zj),(yj,zi))
                        tensor = reshape(tensor, [Adim(2) * Bdim(3), Bdim(2) * Adim(3)]) ;
                        tensor = tensor .* h ;
                        mQN = [AquantNo(2); BquantNo(3); BquantNo(2); AquantNo(3)] ;
                        mDim = [Adim(2), Bdim(3), Bdim(2), Adim(3)] ;
                        
                        equalM = cell(1, 3) ;
                        for m = 1 : 3
                            equalM{m} = (mQN(m) == M.quantNo(m, :)) ;
                        end
                        index = find(equalM{1} & equalM{2} & equalM{3}) ;
                        if isempty(index)
                            n = n + 1 ;
                            M.quantNo(:, n) = mQN ;
                            M.dim(:, n) = mDim ;
                            M.tensor2{n} = tensor ;
                        else
                            M.tensor2{index} = M.tensor2{index} + tensor ;
                        end
                    end
                end
            end
        end
    end
end
M.subNo = n ;

save(fileName, 'M', '-v7.3') ;