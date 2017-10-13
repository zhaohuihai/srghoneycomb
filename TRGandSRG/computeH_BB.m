function HBB = computeH_BB(parameter, BB)
%* HBB(mi, ni)(x,y,z) = sum_{mj, nj}(H(mi,mj,ni,nj)*BB(mj,nj)(x,y,z))
M = parameter.siteDimension ;
H = reshape(parameter.H, [M, M, M, M]) ;
for mi = 1 : M
    for ni = 1 : M
        k = 0 ;
        for mj = 1 : M
            for nj = 1 : M
                h = H(mi, mj, ni, nj) ;
                if h ~= 0
                    BBno = BB(mj, nj).subNo ;
                    for i = 1 : BBno
                        k = k + 1 ;
                        HBB(mi, ni).quantNo(:, k) = BB(mj, nj).quantNo(:, i) ;
                        HBB(mi, ni).dim(:, k) = BB(mj, nj).dim(:, i) ;
                        HBB(mi, ni).tensor3{k} = h .* BB(mj, nj).tensor3{i} ; 
                        
                    end
                end
            end
        end
        HBB(mi, ni).subNo = k ;
    end
end
