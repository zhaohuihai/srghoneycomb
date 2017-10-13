function invL = computeInvLambda(Lambda)

subNo = Lambda.subNo ;
invL = rmfield(Lambda, 'tensor1') ;
for i = 1 : subNo
    tensor1 = 1 ./ Lambda.tensor1{i} ;
    invL.tensor1{i} = tensor1 ;
end