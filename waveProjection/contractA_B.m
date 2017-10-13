function AB = contractA_B(M, A, B, Lambda)

for mi = 1 : M
    site1 = A(mi).site ;
    AsubNo = A(mi).subNo ;
    for mj = 1 : M
        site2 = B(mj).site ;
        
        iSub = 0 ;
        ABsn = [] ;
        tensor2 = cell(0) ;
        AB(mi, mj).site1 = site1 ;
        AB(mi, mj).site2 = site2 ;
        
        for i = 1 : AsubNo
            AbondSN = A(mi).serialNo(:, i) ;
            Adim = zeros(1, 3) ;
            for id = 1 : 3
                Adim(id) = Lambda(id).dim(AbondSN(id)) ;
            end
            
            if B(mj).subNo == 0
                break
            end
            
            j = find(AbondSN(1) == B(mj).serialNo(1, :)) ;
            if ~isempty(j)
                
                Asub = A(mi).tensor3{i} ;
                Asub = permute(Asub, [2, 3, 1]) ; %* Asub(yi,zi,x)
                Asub = reshape(Asub, [Adim(2) * Adim(3), Adim(1)]) ; %* Asub((yi,zi),x)
                
                for k = 1 : length(j)
                    iSub = iSub + 1 ;
                    BbondSN = B(mj).serialNo(:, j(k)) ;
                    Bdim = zeros(1, 3) ;
                    for jd = 1 : 3
                        Bdim(jd) = Lambda(jd).dim(BbondSN(jd)) ;
                    end
                    Bsub = B(mj).tensor3{j(k)} ;
                    
                    %* ABsub(yi,zi,yj,zj) = sum{x}_(Asub(x,yi,zi)*Bsub(x,yj,zj))
                    Bsub = reshape(Bsub, [Bdim(1), Bdim(2) * Bdim(3)]) ; %* Bsub(x, (yj,zj))
                    ABsub = Asub * Bsub ; %* ABsub((yi,zi),(yj,zj))
                    
                    ABsn(:, iSub) = [AbondSN(2 : 3); BbondSN(2 : 3)] ;
                    tensor2{iSub} = ABsub ;
                end
            end
        end
        AB(mi, mj).subNo = iSub ;
        AB(mi, mj).serialNo = ABsn ; %* (yi,zi,yj,zj)
        AB(mi, mj).tensor2 = tensor2 ;
    end
end