function wave = truncateWave(parameter, wave)

D = parameter.bondDimension ;
dimSave = parameter.dimSave_RG ;

parameter.H = createHamiltonian(parameter) ;
if ceil(sqrt(dimSave)) < D
    disp('wavefunction is truncated before RG process')
    parameter.bondDimension = ceil(sqrt(dimSave)) ;
    parameter.tau = 0 ;
    
    for i = 1 : 3
        wave = projectBy1operator(parameter, wave) ;
        wave = rotate(parameter, wave) ;
    end
end