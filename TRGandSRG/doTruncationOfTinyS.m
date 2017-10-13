function [U, S, V] = doTruncationOfTinyS(parameter, U, S, V)

SNo = S.subNo ;

SminRetain = parameter.smallestSingularValue ;
%* truncation
for iS = 1 : SNo
    %* keep the degenerate element
    cut = find(S.tensor1{iS} < SminRetain) ;
    cutNo = length(cut) ;
    
    if ~isempty(cut)
%         warning(['some singular values of environment are smaller than ', num2str(SminRetain), ', so they are eliminated']) ;
        S.tensor1{iS}(cut) = [] ;
        S.dim(iS) = S.dim(iS) - cutNo ;
        quantNo = S.quantNo(iS) ;
        
        Uindex = find(U.quantNo(3, :) == quantNo) ;
        for i = 1 : length(Uindex)
            U.dim(3, Uindex(i)) = U.dim(3, Uindex(i)) - cutNo ;
            U.tensor2{Uindex(i)}(:, cut) = [] ;
        end
        Vindex = find(V.quantNo(3, :) == quantNo) ;
        for j = 1 : length(Vindex)
            V.dim(3, Vindex(j)) = V.dim(3, Vindex(j)) - cutNo ;
            V.tensor2{Vindex(j)}(:, cut) = [] ;
        end
    end
end
