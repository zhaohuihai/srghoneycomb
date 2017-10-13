function sqrtS = computeSqrtS(S)

sqrtS = rmfield(S, 'tensor1') ;

for i = 1 : S.subNo
    sqrtS.tensor1{i} = sqrt(S.tensor1{i}) ;
end