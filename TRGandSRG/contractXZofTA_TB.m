function TTy = contractXZofTA_TB(TA, TB)
%* field of TTy: subNo quantNo dim tensor2
%* TTy(yj,yi) = sum_{x1,z1}(TA(x1,yj,z1)*TB(x1,yi,z1))

TAno = TA.subNo ;
n = 0 ;

TTy.subNo = 0 ;
TTy.quantNo = zeros(1, 0) ;
TTy.dim = zeros(1, 0) ;
TTy.tensor2 = cell(0) ;
for i = 1 : TAno
    AquantNo = TA.quantNo(:, i) ;
    TAtensor = TA.tensor3{i} ; %* (x1,yi,z1)
    TA.tensor3{i} = [] ;
    equalX = (AquantNo(1) == TB.quantNo(1, :)) ;
    equalZ = (AquantNo(3) == TB.quantNo(3, :)) ;
    j = find(equalX & equalZ) ;
    if ~isempty(j)
        Adim = TA.dim(:, i) ;
        
        TAtensor = permute(TAtensor, [2, 1, 3]) ; %* (yi,x1,z1)
        TAtensor = reshape(TAtensor, [Adim(2), Adim(1) * Adim(3)]) ; %* (yi,(x1,z1))
        
%         BquantNo = TB.quantNo(:, j) ;
        Bdim = TB.dim(:, j) ;
        TBtensor = TB.tensor3{j} ; %* (x1,yj,z1)
        TBtensor = permute(TBtensor, [1, 3, 2]) ; %* (x1,z1,yj)
        TBtensor = reshape(TBtensor, [Bdim(1) * Bdim(3), Bdim(2)]) ; %* ((x1,z1),yj)
        %* tensor(yi, yj)
        tensor = TAtensor * TBtensor ;
        
        tDim = Adim(2) ;
        tQN = AquantNo(2) ;
        
        index = find(TTy.dim == tDim) ;
        if isempty(index)
            n = n + 1 ;
            TTy.quantNo(n) = tQN ;
            TTy.dim(n) = tDim ;
            TTy.tensor2{n} = tensor ;
        else
            TTy.tensor2{index} = TTy.tensor2{index} + tensor ;
        end
    end
end

TTy.subNo = n ;