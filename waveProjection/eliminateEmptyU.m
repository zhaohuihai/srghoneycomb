function U = eliminateEmptyU(M, keep, U)

for iM = 1 : M
    UsubNo = U(iM).subNo ;
    iUsub = 1 ;
    while iUsub <= UsubNo
        if isempty(U(iM).tensor2{iUsub})

            U(iM).serialNo(:, iUsub) = [] ;
            U(iM).tensor2(iUsub) = [] ;
            UsubNo = UsubNo - 1 ;
        else
            iUsub = iUsub + 1 ;
        end
    end
    U(iM).subNo = UsubNo ;
    for i = 1 : UsubNo
        newSN = find(keep == U(iM).serialNo(3, i)) ;
        U(iM).serialNo(3, i) = newSN ;
    end    
end