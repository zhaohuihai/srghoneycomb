function invS = computeInvS(S)

invS = rmfield(S, 'tensor1') ;

for i = 1 : S.subNo
    invS.tensor1{i} = 1 ./ S.tensor1{i} ;
end

