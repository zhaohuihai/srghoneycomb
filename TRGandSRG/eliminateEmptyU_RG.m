function U = eliminateEmptyU_RG(U)

UsubNo = U.subNo ;
iUsub = 1 ;
while iUsub <= UsubNo
    if isempty(U.tensor2{iUsub})
        U.quantNo(:, iUsub) = [] ; %* (y,z,x)
        U.dim(:, iUsub) = [] ;
        U.tensor2(iUsub) = [] ; %* ((y,z),x)
        UsubNo = UsubNo - 1 ;
    else
        iUsub = iUsub + 1 ;
    end
end
U.subNo = UsubNo ;