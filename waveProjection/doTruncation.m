function [U, S, V, coef, allS] = doTruncation(parameter, U, S, V)

D = parameter.bondDimension ;
M = parameter.siteDimension ;
SNo = S.subNo ;
allS = [] ;
for iS = 1 : SNo
    allS = [allS; S.tensor1{iS}] ;
end
allS = sort(allS, 'descend') ;
coef = allS(1) ;
SminRetain = allS(D) * parameter.maxDiffRatio ;

%* truncation
for iS = 1 : SNo
    cut = find(S.tensor1{iS} < SminRetain) ;
    cutNo = length(cut) ;
    % normalization
    S.tensor1{iS} = S.tensor1{iS} / coef ;
    
    if ~isempty(cut)
        S.tensor1{iS}(cut) = [] ;
        S.dim(iS) = S.dim(iS) - cutNo ;
    end
end
for iM = 1 : M
    for i = 1 : U(iM).subNo
        dimKeep = 1 : S.dim(U(iM).serialNo(3, i)) ;
        U(iM).tensor2{i} = U(iM).tensor2{i}(:, dimKeep) ;
    end

    for j = 1 : V(iM).subNo
        dimKeep = 1 : S.dim(V(iM).serialNo(3, j)) ;
        V(iM).tensor2{j} = V(iM).tensor2{j}(:, dimKeep) ;
    end
end
allS = allS ./ coef ;
allS = allS(1 : D) ;