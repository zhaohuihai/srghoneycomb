function [U, S, V, coef] = doTruncation_SRG(parameter, U, S, V)
%* U(x1,x); S(x); V(x2,x) 

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
        
        U.tensor2{iS}(:, cut) = [] ;
        U.dim(2, iS) = U.dim(2, iS) - cutNo ;
        
        V.tensor2{iS}(:, cut) = [] ;
        V.dim(2, iS) = V.dim(2, iS) - cutNo ;
    end
end
