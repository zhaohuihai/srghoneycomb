function computeMagnetization(parameter, waveLeft, waveRight)

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
TRGmagnetizationFileName = [pathName, '/magnetization_TRG_dimSave', num2str(dimSave), '.mat'] ;
SRGmagnetizationFileName = [pathName, '/magnetization_SRG_dimSave', num2str(dimSave), '.mat'] ;

disp('apply magnetization computation') ;
if (parameter.parallelSVD == 1 || parameter.parallelBond == 1)
    disp('  apply parallel computation')
    matlabpool ('open', 'local', parameter.poolSize)
end

if parameter.TRG == 1
    magnetizationX = computeEnergy_TRG(parameter, waveLeft, waveRight) ;
    magnetization_TRG = mean(magnetizationX) ;
    disp([dirName, ', dimSave = ', num2str(dimSave),' TRG magnetization: ', num2str(magnetization_TRG, 15)])
    save (TRGmagnetizationFileName, 'magnetizationX', 'magnetization_TRG', 'parameter')
end
if parameter.SRG == 1
    magnetizationX = computeEnergy_SRG(parameter, waveLeft, waveRight) ;
    magnetization_SRG = mean(magnetizationX) ;
    disp([dirName, ', dimSave = ', num2str(dimSave),' SRG magnetization: ', num2str(magnetization_SRG, 15)])
    save (SRGmagnetizationFileName, 'magnetizationX', 'magnetization_SRG', 'parameter')
end

if (parameter.parallelSVD == 1 || parameter.parallelBond == 1)
    matlabpool close
end