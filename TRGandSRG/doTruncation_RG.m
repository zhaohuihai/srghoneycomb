function [U, S, V, coef] = doTruncation_RG(parameter, U, S, V)

% D = parameter.bondDimension ;
DD = parameter.dimSave_RG ;

SNo = S.subNo ;
allS = [] ;
for iS = 1 : SNo
    allS = [allS; S.tensor1{iS}] ;
end
allS = sort(allS, 'descend') ;
coef = allS(1) ;

retainDim = min(length(allS), DD) ;
SminRetain = allS(retainDim) * parameter.maxDiffRatio ;
%* truncation
for iS = 1 : SNo
    %* keep the degenerate element
    cut = find(S.tensor1{iS} < SminRetain) ;
    cutNo = length(cut) ;
    % normalization
    S.tensor1{iS} = S.tensor1{iS} ./ coef ;
    
    if ~isempty(cut)
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