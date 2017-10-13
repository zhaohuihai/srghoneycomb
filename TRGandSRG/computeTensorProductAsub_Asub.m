function AAtensorP = computeTensorProductAsub_Asub(dimi, AiTensor, dimj, AjTensor)

dim = [] ;
for k = 1 : 3
    dim = [dim, dimi(k), dimj(k)] ;
end
AAtensorP = zeros(dim) ;
for i1 = 1 : dimi(1)
    for i2 = 1 : dimj(1)
        for j1 = 1 : dimi(2)
            for j2 = 1 : dimj(2)
                for k1 = 1 : dimi(3)
                    for k2 = 1 : dimj(3)
                        AAtensorP(i1,i2,j1,j2,k1,k2) = AiTensor(i1,j1,k1) * AjTensor(i2,j2,k2) ;
                    end
                end
            end
        end
    end
end
AAtensorP = reshape(AAtensorP, [dimi(1) * dimj(1), dimi(2) * dimj(2), dimi(3) * dimj(3)]) ;