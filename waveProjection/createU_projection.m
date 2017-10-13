function [ U ] = createU_projection(M, Ublock, U, T, iT, Lambda, UorV)
%* UorV: 1 for U, 2 for V
s = T.subNo ;
if UorV == 1
    site = T.site1 ;
else
    site = T.site2 ;
end
arr = (2 * UorV - 1) : (2 * UorV) ;
SN = T.serialNo(arr, :) ;

%* 1X2 array
Uno = [U(1).subNo, U(2).subNo] ;

i = 1 ;
while s > 0
    s1 = max(site) ;
    sameSite = find(s1 == site) ; %* index
    m = (M + 1 - s1) / 2 ;
    
    sameSiteNo = length(sameSite) ;
    ss = sameSiteNo ;
    SNsub = SN(:, sameSite) ;
    while ss > 0

        ySN = min(SNsub(1, :)) ;
        sameYSN = find(ySN == SNsub(1, :)) ; %* sub-index
        
        sameYSNno = length(sameYSN) ;
%         index = sameSite(sameYSN) ;
        
        Uno(m) = Uno(m) + 1 ;
        zSN = SNsub(2, sameYSN(1)) ;
        U(m).serialNo(:, Uno(m)) = [ySN; zSN; iT] ;
        yzDim = Lambda(2).dim(ySN) * Lambda(3).dim(zSN) ;
        
        j = i + yzDim - 1 ;
        tensor2 = Ublock(i : j , :) ;
        U(m).tensor2{Uno(m)} = tensor2 ;
        i = j + 1 ;
        
        SNsub(:, sameYSN) = [] ;
        ss = ss - sameYSNno ;
    end
    site(sameSite) = [] ;
    SN(:, sameSite) = [] ;
    s = s - sameSiteNo ;
end

U(1).subNo = Uno(1) ;
U(2).subNo = Uno(2) ;