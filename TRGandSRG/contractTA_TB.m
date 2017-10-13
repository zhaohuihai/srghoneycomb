function contractTA_TB(TA, TB, fileName)
%* field of TA: subNo, quantNo, dim, tensor3
%* M((yi,zj),(yj,zi)) = sum{x}_(TA(x,yi,zi)*TB(x,yj,zj))

TANo = TA.subNo ;
n = 0 ;
for i = 1 : TANo
    AquantNo = TA.quantNo(:, i) ;
    j = find(AquantNo(1) == TB.quantNo(1, :)) ;
    if ~isempty(j)
        Adim = TA.dim(:, i) ;
        TAtensor = TA.tensor3{i} ;
        TAtensor = permute(TAtensor, [2, 3, 1]) ; %* (yi,zi,x)
        TAtensor = reshape(TAtensor, [Adim(2) * Adim(3), Adim(1)]) ; %* ((yi,zi),x)
        
        for k = 1 : length(j)
            n = n + 1 ;
            BquantNo = TB.quantNo(:, j(k)) ;
            Bdim = TB.dim(:, j(k)) ;
            
            TBtensor = TB.tensor3{j(k)} ; %* (x,yj,zj)

            TBtensor = reshape(TBtensor, [Bdim(1), Bdim(2) * Bdim(3)]) ; %* (x,(yj,zj))
            %* tensor((yi,zi),(yj,zj))
            tensor = TAtensor * TBtensor ;
            %* tensor(yi,zi,yj,zj)
            tensor = reshape(tensor, [Adim(2), Adim(3), Bdim(2), Bdim(3)]) ;
            %* tensor(yi,zj,yj,zi)
            
            tensor = permute(tensor, [1, 4, 3, 2]) ;
            %* tensor((yi,zj),(yj,zi))
            tensor = reshape(tensor, [Adim(2) * Bdim(3), Bdim(2) * Adim(3)]) ;
            
            M.quantNo(:, n) = [AquantNo(2); BquantNo(3); BquantNo(2); AquantNo(3)] ;
            M.dim(:, n) = [Adim(2), Bdim(3), Bdim(2), Adim(3)] ;
            M.tensor2{n} = tensor ;
        end
    end
end
M.subNo = n ;

save(fileName, 'M', '-v7.3') ;
% save(fileName, 'M') ;