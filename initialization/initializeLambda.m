function Lambda = initializeLambda(mapping)

quantNo = mapping.quantNo ;
dim = mapping.dim ;

mapNo = length(quantNo) ;

tensor1 = cell(1, mapNo) ;

for iMap = 1 : mapNo
    tensor1{iMap} = rand(dim(iMap), 1) ;
    
end
Lambda.subNo = mapNo ;
Lambda.quantNo = quantNo ;
Lambda.dim = dim ;
Lambda.tensor1 = tensor1 ;