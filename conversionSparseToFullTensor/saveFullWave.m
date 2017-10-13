function saveFullWave ( parameter, waveFull )

fileName = ['result/D = ', num2str(parameter.bondDimension), '/waveFull.mat'] ;
save (fileName, 'waveFull') ;

