function ABpro = projectAB(parameter, AB)

M = parameter.siteDimension ;
PO = reshape(parameter.projectionOperator, [M, M, M, M]) ;

%* ABpro(mi,mj,yi,zi,yj,zj) = sum_{ni,nj}(AB(((yi,zi),(yj,zj)),ni,nj)*PO(mi, mj, ni, nj))
i = 1 ;
for mi = 1 : M
    for mj = 1 : M
        for ni = 1 : M
            for nj = 1 : M
                p = PO(mi, mj, ni, nj) ;
                if p ~= 0 && AB(ni, nj).subNo ~= 0
                    subNo = AB(ni, nj).subNo ;
                    
                    j = i + subNo - 1 ;
                    site1(i : j) = AB(mi, mj).site1 ;                  
                    site2(i : j) = AB(mi, mj).site2 ;
                    serialNo(:, i : j) = AB(ni, nj).serialNo ;
                    for iSub = 1 : subNo
                        k = i + iSub - 1 ;
                        tensor2{k} = p .* AB(ni, nj).tensor2{iSub} ;
                    end
                    i = i + subNo ;
                end
            end
        end
    end
end
ABpro.subNo = j ;
ABpro.site1 = site1 ;
ABpro.site2 = site2 ;
ABpro.serialNo = serialNo ;
ABpro.tensor2 = tensor2 ;