function sqrtLambda = computeSqrtLambda(Lambda)

sqrtLambda = rmfield(Lambda, 'tensor1') ;
for i = 1 : 3
    subNo = Lambda(i).subNo ;
    
    for j = 1 : subNo
        tensor1 = Lambda(i).tensor1{j} ;
        sqrtLambda(i).tensor1{j} = sqrt(tensor1) ;
    end
end