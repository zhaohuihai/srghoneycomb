function [wave, projectionSingularValue] = projectBy1operator(parameter, wave)

parameter.projectionOperator = createProjectionOperator(parameter) ;
% tic
AB = computeLyLz_A_Lx_B_LyLz(parameter, wave) ;
% toc
% tic
T = computeProjection(parameter, AB, wave.Lambda) ;
% T = reduceT_projection(T) ;
% toc
% tic
USV = svd_projection(parameter, T, wave.Lambda) ;
% toc
% tic
[USV, projectionSingularValue] = truncate(parameter, USV) ;
% toc
% tic
wave = recover(parameter, wave, USV) ;
% toc
% pause