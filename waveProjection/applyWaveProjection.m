function wave = applyWaveProjection(parameter, wave)

disp(['apply wavefunction projection in staggered magnetic field: ', num2str(parameter.staggerMagField)]) ;
disp(['wave function bond dimension = ', num2str(parameter.bondDimension)])
dirName = ['result/D = ', num2str(parameter.bondDimension)] ;
mkdir(dirName)

waveFileName = [dirName, '/wavefunction.mat'] ;
parameterFileName = [dirName, '/parameter.mat'] ;

if parameter.loadPreviousWave == 0
    parameter.tau = parameter.tauInitial ;
    wave.polarization = parameter.polarization ;
else
    parameter.tau = wave.tauFinal ;
end

tauChangeFactor = parameter.tauChangeFactor ;
D = parameter.bondDimension ;

if isfield(wave, 'totalProjectionTimes')
    j = wave.totalProjectionTimes ;
else
    j = 0 ;
end
wave.staggerMagField = parameter.staggerMagField ;
%**********************************************************************************
parameter.H = createHamiltonian(parameter) ;
while parameter.tau >= parameter.tauFinal
    disp(['tau = ', num2str(parameter.tau)])
    projectionConvergence = 1 ;
    wave.projectionSingularValue0 = 0 ;
    wave.projectionSingularValue1 = 0 ;
    while projectionConvergence > parameter.convergenceCriterion_projection

        j = j + 1 ;
        if parameter.TrotterOrder == 1
            wave = applyFirstTrotter(parameter, wave) ;
        elseif parameter.TrotterOrder == 2
            wave = applySecondTrotter(parameter, wave) ;
        end
        
        wave.coef = 1 ;
        projectionConvergence = norm(wave.projectionSingularValue0 - wave.projectionSingularValue1) / sqrt(D - 1) ;
        if (j / 100) == floor(j / 100)
            disp(['projection convergence error = ', num2str(projectionConvergence)]) ;
        end
    end
    
    wave.totalProjectionTimes = j ;
    wave.tauFinal = parameter.tau ;
    wave.bondDimension = parameter.bondDimension ;
    
    save (parameterFileName, 'parameter')
    save (waveFileName, 'wave') ;
    
    parameter.tau = tauChangeFactor * parameter.tau ;
end
totalProjectionTimes = j

