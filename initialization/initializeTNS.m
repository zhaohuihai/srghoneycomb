function wave = initializeTNS(parameter, mapping)

if parameter.sameInitialTensor == 1
    A = initializeTensor(parameter, mapping) ;
    L = initializeLambda(mapping) ;
    wave.A = A ;
    wave.B = A ;
    wave.Lambda(1) = L ;
    wave.Lambda(2) = L ;
    wave.Lambda(3) = L ;
else %* == 0
    wave.A = initializeTensor(parameter, mapping) ;
    wave.B = initializeTensor(parameter, mapping) ;
    wave.Lambda(1) = initializeLambda(mapping) ;
    wave.Lambda(2) = initializeLambda(mapping) ;
    wave.Lambda(3) = initializeLambda(mapping) ;
end

wave.coef = 1 ;
wave.ABsingularValue = 1 ;




