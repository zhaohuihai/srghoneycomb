function convertSparseToFullWave(parameter, wave)

M = parameter.siteDimension ;
D = parameter.bondDimension ;

Lambda = wave.Lambda ;
L = cell(1, 3) ;
for i = 1 : 3
    for j = 1 : Lambda(i).subNo
        L{i} = [L{i}; Lambda(i).tensor1{j}] ;
    end
end
waveFull.A = convertSparseToFullA(M, D, wave.A, Lambda) ;
waveFull.B = convertSparseToFullA(M, D, wave.B, Lambda) ;

waveFull.Lx = L{1} ;
waveFull.Ly = L{2} ;
waveFull.Lz = L{3} ;

saveFullWave ( parameter, waveFull )