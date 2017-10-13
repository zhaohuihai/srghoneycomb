function ABAB = computeAB_H_AB(parameter, AB, Lambda)
%* MH((yi,zj),(yj,zi))

M = parameter.siteDimension ;
H = reshape(parameter.H, [M, M, M, M]) ;

k = 0 ;
for mi = 1 : M
    for mj = 1 : M
        for ni = 1 : M
            for nj = 1 : M
                h = H(mi, mj, ni, nj) ;
                if h ~= 0
                    ABNo1 = AB(mi, mj).subNo ;
                    for i = 1 : ABNo1
                        ABNo2 = AB(ni, nj).subNo ;
                        for j = 1 : ABNo2
                            k = k + 1 ;
                            
                            SN1 = AB(mi, mj).serialNo(1, i) ;
                            SN2 = AB(ni, nj).serialNo(1, j) ;
                            quantNo(1, k) = Lambda(2).quantNo(SN1) ; %* yi1
                            quantNo(2, k) = Lambda(2).quantNo(SN2) ; %* yi2
                            yi1D = Lambda(2).dim(SN1) ;
                            yi2D = Lambda(2).dim(SN2) ;
                            dim(1, k) = yi1D * yi2D ;
                            
                            SN1 = AB(mi, mj).serialNo(4, i) ;
                            SN2 = AB(ni, nj).serialNo(4, j) ;
                            quantNo(3, k) = Lambda(3).quantNo(SN1) ; %* zj1
                            quantNo(4, k) = Lambda(3).quantNo(SN2) ; %* zj2
                            zj1D = Lambda(3).dim(SN1) ;
                            zj2D = Lambda(3).dim(SN2) ;
                            dim(2, k) = zj1D * zj2D ;
                            
                            SN1 = AB(mi, mj).serialNo(3, i) ;
                            SN2 = AB(ni, nj).serialNo(3, j) ;
                            quantNo(5, k) = Lambda(2).quantNo(SN1) ; %* yj1
                            quantNo(6, k) = Lambda(2).quantNo(SN2) ; %* yj2
                            yj1D = Lambda(2).dim(SN1) ;
                            yj2D = Lambda(2).dim(SN2) ;
                            dim(3, k) = yj1D * yj2D ;
                            
                            SN1 = AB(mi, mj).serialNo(2, i) ;
                            SN2 = AB(ni, nj).serialNo(2, j) ;
                            quantNo(7, k) = Lambda(3).quantNo(SN1) ; %* zi1
                            quantNo(8, k) = Lambda(3).quantNo(SN2) ; %* zi2
                            zi1D = Lambda(3).dim(SN1) ;
                            zi2D = Lambda(3).dim(SN2) ;
                            dim(4, k) = zi1D * zi2D ;
                            
                            %* tensor((yi1,zi1,yi2,zi2),(yj1,zj1,yj2,zj2))
                            tensor = kron(AB(mi, mj).tensor2{i}, AB(ni, nj).tensor2{j}) ;
                            tensor = tensor .* h ;
                            
                            %* tensor(yi1,zi1,yi2,zi2,yj1,zj1,yj2,zj2)
                            tensor = reshape(tensor, [yi1D, zi1D, yi2D, zi2D, yj1D, zj1D, yj2D, zj2D]) ;
                            
                            %* tensor(yi1,yi2,zj1,zj2,yj1,yj2,zi1,zi2)
                            tensor = permute(tensor, [1, 3, 6, 8, 5, 7, 2, 4]) ;
                            
                            tensor = reshape(tensor, dim(:, k)') ;
                            
                            tensor4{k} = tensor ;
                        end
                    end
                end
            end
        end
    end
end
ABAB.subNo = k ;
ABAB.quantNo = quantNo ;
ABAB.dim = dim ;
ABAB.tensor4 = tensor4 ;
