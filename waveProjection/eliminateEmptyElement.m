function [U, S, V] = eliminateEmptyElement(M, U, S, V)

keep = [] ;
SNo = S.subNo ;
for i = 1 : SNo
    if ~isempty(S.tensor1{i})
        %* index is new SN; value is old SN
        keep = [keep, i] ;
    end
end
S.subNo = length(keep) ;
S.quantNo = S.quantNo(keep) ;
S.dim = S.dim(keep) ;
S.tensor1 = S.tensor1(keep) ;

U = eliminateEmptyU(M, keep, U) ;
V = eliminateEmptyU(M, keep, V) ;
