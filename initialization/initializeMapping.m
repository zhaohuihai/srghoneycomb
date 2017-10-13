function mapping = initializeMapping(parameter)

% initialize the mapping of virtual spin and bond number
% make as small blocks as possible
S = parameter.virtualSpin ;

subNo = 2 * S + 1 ;
quantNo = zeros(1, subNo) ;
dim = zeros(1, subNo) ;
for iS = 1 : (2 * S + 1)
    quantNo(iS) = S + 1 - iS ;
end

iS = 0 ;
iBond = parameter.bondDimension ;
while iBond >= 2
    if iS == S+1
        iS = iS-(S+1) ;
    end
    m = S + 1 - iS ;
    dim(m) = dim(m) + 1 ;
    iBond = iBond - 1 ;
    if iS ~= 0
        n = S + 1 + iS ;
        dim(n) = dim(n) + 1 ;
        iBond = iBond - 1 ;
    end
    iS = iS + 1 ;
    
end

if iBond ~= 0
    n = S + 1 - iS ;
    dim(n) = dim(n) + iBond ;
end

noneZeroIndex = find(dim ~= 0) ;
mapping.quantNo = quantNo(noneZeroIndex) ;
mapping.dim = dim(noneZeroIndex) ;
%**************