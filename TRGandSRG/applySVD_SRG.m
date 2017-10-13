function [RA, RB, coefT] = applySVD_SRG(parameter, sqrtSe, id, th)


%* VMU(x1,x2) = sum_{x}(U(x1,x)* S(x) * V(x2,x))

tic
if parameter.parallelSVD == 1
    svdParallel_SRG(parameter, id, th) ;
else
    svd_SRG(parameter, id, th) ;
end
tElapsed = toc ;
disp(['SRG svd time cost: ', num2str(tElapsed, 8), 's'])

coefT = truncate_SRG(parameter, id, th) ;

[RA, RB] = createR_SRG(parameter, sqrtSe, id, th) ;