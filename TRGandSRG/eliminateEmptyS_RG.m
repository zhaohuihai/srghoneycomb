function S = eliminateEmptyS_RG(S)

SNo = S.subNo ;
iS = 1 ;
while iS <= SNo
    if isempty(S.tensor1{iS})
        S.quantNo(iS) = [] ;
        S.dim(iS) = [] ;
        S.tensor1(iS) = [] ;
        SNo = SNo - 1 ;
    else
        iS = iS + 1 ;
    end
end
S.subNo = SNo ;