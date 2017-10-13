function [AAblock, AAblockDim] = combineAAsub(AA, index, mapping)

% xQuantNo = AA.quantNo(1, indexX) ;
% xDim = AA.dim(1, indexX) ;
% yQuantNo = AA.quantNo(3, indexY) ;
% yDim = AA.dim(2, indexY) ;
% zQuantNo = AA.quantNo(5, indexZ) ;
% zDim = AA.dim(3, indexZ) ;

AAblockDim = zeros(3, 1) ;
for i = 1 : 3
    AAblockDim(i) = mapping(i).totDim ;
end
% [xMap, dim(1)] = createMapping(xQuantNo, xDim) ;
% [yMap, dim(2)] = createMapping(yQuantNo, yDim) ;
% [zMap, dim(3)] = createMapping(zQuantNo, zDim) ;

subNo = length(index) ;
for n = 1 : 3
    n1 = 2 * n - 1 ;
    quantNo(n, :) = AA.quantNo(n1, index) ;
end
dim = AA.dim(:, index) ;
% yQuantNo = AA.quantNo(3, index) ;
% yDim = AA.dim(2, index) ;
% zQuantNo = AA.quantNo(5, index) ;
% zDim = AA.dim(3, index) ;
tensor3 = AA.tensor3(index) ;
AAblock = zeros(AAblockDim') ;

for i = 1 : subNo
    m = zeros(1, 3) ;
    for j = 1 : 3
        m(j) = find(mapping(j).map(1, :) == quantNo(j, i)) ;
    end
%     ix = find(xMap(1, :) == xQuantNo(i)) ;
%     iy = find(yMap(1, :) == yQuantNo(i)) ;
%     iz = find(zMap(1, :) == zQuantNo(i)) ;
    k = cell(1, 3) ;
    for j = 1 : 3
        position = mapping(j).map(2, m(j)) ;
        k{j} = position : (position + dim(j, i) - 1) ;
    end
%     x = xMap(2, ix) : (xMap(2, ix) + xDim(i) - 1) ;
%     y = yMap(2, iy) : (yMap(2, iy) + yDim(i) - 1) ;
%     z = zMap(2, iz) : (zMap(2, iz) + zDim(i) - 1) ;
    AAblock(k{1}, k{2}, k{3}) = AAblock(k{1}, k{2}, k{3}) + tensor3{i} ;
end

