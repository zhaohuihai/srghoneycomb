function wave = polarizeWave(parameter, wave)

disp('Polarize the wave function') ;
parameter.staggerMagField = parameter.polarField ;
parameter.convergenceCriterion_projection = parameter.convergenceCriterion_polarization ;

wave = applyWaveProjection(parameter, wave) ;
