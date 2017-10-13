function TA = convertSparseToFullTA(TAs)


%* mapping: 1X3 structure array
%* field of mapping: quantNo(1D array), position(cell of 1D arrays)
mapping = createMapping2fullTA(TAs) ;
TA = zeros(mapping(1).totDim, mapping(2).totDim, mapping(3).totDim) ;
for i = 1 : TAs.subNo
    QN = TAs.quantNo(:, i) ;
    p = cell(1, 3) ;
    for j = 1 : 3
        k = find(QN(j) == mapping(j).quantNo) ;
        p{j} = mapping(j).position{k} ;        
    end
    TA(p{1}, p{2}, p{3}) = TA(p{1}, p{2}, p{3}) + TAs.tensor3{i} ;
end