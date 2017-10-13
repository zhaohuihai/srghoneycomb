function wave = applySecondTrotter(parameter, wave)

projectionSingularValue0 = wave.projectionSingularValue1 ;
tauSaved = parameter.tau ;

parameter.tau = tauSaved / 2 ;
%* exp(- (tau / 2) * Hx)
[wave, projectionSingularValue] = projectBy1operator(parameter, wave) ;
wave = rotate(parameter, wave) ;

%* exp(- (tau / 2) * Hy)
wave = projectBy1operator(parameter, wave) ;
wave = rotate(parameter, wave) ;

%* exp(- tau * Hz)
parameter.tau = tauSaved ;
wave = projectBy1operator(parameter, wave) ;
wave = reverseRotate(parameter, wave) ;

%* exp(- (tau / 2) * Hy)
parameter.tau = tauSaved / 2 ;
wave = projectBy1operator(parameter, wave) ;
wave = reverseRotate(parameter, wave) ;

%* exp(- (tau / 2) * Hx)
wave = projectBy1operator(parameter, wave) ;


wave.projectionSingularValue0 = projectionSingularValue0 ;
wave.projectionSingularValue1 = projectionSingularValue ;