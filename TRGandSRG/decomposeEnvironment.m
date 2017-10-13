function decomposeEnvironment(parameter, id)

%* env((yj,zi),(yi,zj))
computeEnvironment(parameter, id) ;
partitionEnvByBondBond(parameter, id) ;

%* no truncation!
tic
if parameter.parallelSVD == 1
    svdAllParallel_SRG(parameter, id) ;
else
    svdAll_SRG(parameter, id) ;
end
tElapsed = toc ;
disp(['environment svd time cost: ', num2str(tElapsed, 8), 's'])

normalizeS_SRG(parameter, id) ;

%* cut the tiny singular value
truncateTinyS(parameter, id) ;

%***************************
%* for test only
% S = USVenv.S ;
% SNo = S.subNo ;
% allS = [] ;
% for iS = 1 : SNo
%     allS = [allS; S.tensor1{iS}] ;
% end
% allS = sort(allS, 'descend') ;
% allS = allS' ;
