function [U, S, V] = eliminateEmptyElement_SRG(U, S, V)


SNo = S.subNo ;
iS = 1 ;
while iS <= SNo
    if isempty(S.tensor1{iS})
        S.quantNo(iS) = [] ;
        S.dim(iS) = [] ;
        S.tensor1(iS) = [] ;
        
        U.quantNo(iS) = [] ;
        U.dim(:, iS) = [] ;
        U.tensor2(iS) = [] ;
        
        V.quantNo(iS) = [] ;
        V.dim(:, iS) = [] ;
        V.tensor2(iS) = [] ;
        
        SNo = SNo - 1 ;
    else
        iS = iS + 1 ;
    end
end
S.subNo = SNo ;
U.subNo = SNo ;
V.subNo = SNo ;
