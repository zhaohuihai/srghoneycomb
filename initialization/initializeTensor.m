function A = initializeTensor(parameter, mapping)

M = parameter.siteDimension ;

quantNo = mapping.quantNo ;
dim = mapping.dim ;

mapNo = length(quantNo) ;
Adim = zeros(1, 3) ;
for iM = 1 : M
    site = M + 1 - 2 * iM ;
    A(iM).site = site ;
    i = 0 ;
    
    for iMap = 1 : mapNo
        Adim(1) = dim(iMap) ;
        for jMap = 1 : mapNo
            Adim(2) = dim(jMap) ;
            for kMap = 1 : mapNo
                Adim(3) = dim(kMap) ;
                if (quantNo(iMap) + quantNo(jMap) + quantNo(kMap)) == site
                    i = i + 1 ;
                    A(iM).serialNo(:, i) = [iMap; jMap; kMap] ;
                    A(iM).tensor3{i} = rand(Adim) ;
                    
                end
            end
        end
    end
    A(iM).subNo = i ;
end