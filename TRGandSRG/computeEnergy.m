function computeEnergy(parameter, waveLeft, waveRight)

format long
dimSave = parameter.dimSave_RG ;

if parameter.imbalanceWave == 0
    D = parameter.bondDimension ;
    dirName = ['D = ', num2str(D)] ;
else
    Dleft = parameter.leftBondDimension ;
    Dright = parameter.rightBondDimension ;
    dirName = ['D', num2str(Dleft), 'D', num2str(Dright)] ;
end
pathName = ['result/', dirName] ;
mkdir(pathName) ;

if parameter.eigenStateMethod == 1
    disp('apply energy computation by eigen state method') ;
    TRGenergyFileName = [pathName, '/energy_TRG_dimSave', num2str(dimSave), '_eigenMethod', '.mat'] ;
    SRGenergyFileName = [pathName, '/energy_SRG_dimSave', num2str(dimSave), '_eigenMethod', '.mat'] ;
else
    disp('apply energy computation by inner product method') ;
    TRGenergyFileName = [pathName, '/energy_TRG_dimSave', num2str(dimSave), '.mat'] ;
    SRGenergyFileName = [pathName, '/energy_SRG_dimSave', num2str(dimSave), '.mat'] ;
end

if (parameter.parallelSVD == 1 || parameter.parallelBond == 1)
    disp('  apply parallel computation')
    matlabpool ('open', 'local', parameter.poolSize)
end

if parameter.TRG == 1
    energyX = computeEnergy_TRG(parameter, waveLeft, waveRight) ;
    energy_TRG = mean(energyX) ;
    disp([dirName, ', dimSave = ', num2str(dimSave), ' TRG energy: ', num2str(energy_TRG, 15)])
    save (TRGenergyFileName, 'energyX', 'energy_TRG', 'parameter')
end
if parameter.SRG == 1
    energyX = computeEnergy_SRG(parameter, waveLeft, waveRight) ;
    energy_SRG = mean(energyX) ;
    disp([dirName, ', dimSave = ', num2str(dimSave),' SRG energy: ', num2str(energy_SRG, 15)])
    save (SRGenergyFileName, 'energyX', 'energy_SRG', 'parameter')
end

if (parameter.parallelSVD == 1 || parameter.parallelBond == 1)
    matlabpool close
end

% deleteTempData

