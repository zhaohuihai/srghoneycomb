function MH = computeAA_HBB(M, AA, HBB)
%* MH((yi,zj),(yj,zi))=sum_{x,m1,m2}(AA(m1,m2)(x,yi,zi)*HBB(m1,m2)(x,yj,zj))
n = 0 ;

MH.subNo = 0 ;
MH.quantNo = zeros(4, 0) ;
MH.dim = zeros(4, 0) ;
MH.tensor2 = cell(0) ;

for m1 = 1 : M
    for m2 = 1 : M
        AAno = AA(m1, m2).subNo ;
        if HBB(m1, m2).subNo == 0
            continue
        end
        for i = 1 : AAno
            AquantNo = AA(m1, m2).quantNo(:, i) ;
            j = find(AquantNo(1) == HBB(m1, m2).quantNo(1, :)) ;
            Adim = AA(m1, m2).dim(:, i) ;
            Atensor = AA(m1, m2).tensor3{i} ;
            Atensor = permute(Atensor, [2, 3, 1]) ; %* (yi,zi,x)
            Atensor = reshape(Atensor, [Adim(2) * Adim(3), Adim(1)]) ; %* ((yi,zi),x)
            for k = 1 : length(j)
                BquantNo = HBB(m1, m2).quantNo(:, j(k)) ;
                Bdim = HBB(m1, m2).dim(:, j(k)) ;
                
                Btensor = HBB(m1, m2).tensor3{j(k)} ; %* (x,yj,zj)
                
                Btensor = reshape(Btensor, [Bdim(1), Bdim(2) * Bdim(3)]) ; %* (x,(yj,zj))
                %* tensor((yi,zi),(yj,zj))
                tensor = Atensor * Btensor ;
                %* tensor(yi,zi,yj,zj)
                tensor = reshape(tensor, [Adim(2), Adim(3), Bdim(2), Bdim(3)]) ;
                %* tensor(yi,zj,yj,zi)
                
                tensor = permute(tensor, [1, 4, 3, 2]) ;
                                
                %* tensor((yi,zj),(yj,zi))
                tensor = reshape(tensor, [Adim(2) * Bdim(3), Bdim(2) * Adim(3)]) ;
                tQN = [AquantNo(2); BquantNo(3); BquantNo(2); AquantNo(3)] ;
                
                equalT = cell(1, 3) ;
                for m = 1 : 3
                    equalT{m} = (tQN(m) == MH.quantNo(m, :)) ;
                end
                index = find(equalT{1} & equalT{2} & equalT{3}) ;
                
                if isempty(index)
                    n = n + 1 ;
%                     MH.subNo = n ;
                    MH.quantNo(:, n) = tQN ;
                    MH.dim(:, n) = [Adim(2), Bdim(3), Bdim(2), Adim(3)] ;
                    MH.tensor2{n} = tensor ;
                else
                    MH.tensor2{index} = MH.tensor2{index} + tensor ;
                end
            end
        end
    end
end
MH.subNo = n ;