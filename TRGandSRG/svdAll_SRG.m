function svdAll_SRG(parameter, id)

fileNameTenv = ['Tenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameTenv, 'Tenv') ;
Mno = length(Tenv) ;
decomposingDim = zeros(1, Mno) ;
S.subNo = Mno ;

U.subNo = 0 ;
V = U ;
for i = 1 : Mno
    Mblock = combineMsub(Tenv(i)) ;
    Tenv(i).tensor2 = [] ;
    Mdim = length(Mblock) ;
    decomposingDim(i) = Mdim ;
    %***************************
%     disp(['environment decomposition dim =', num2str(Mdim)])
    %***************************
    [Ublock, Sblock, Vblock] = svd(Mblock) ;
    Sblock = diag(Sblock) ;
    
    Sdim = length(Sblock) ;
    U = createU_RG(Ublock, U, Tenv(i), Sdim, 1) ;
    V = createU_RG(Vblock, V, Tenv(i), Sdim, 2) ;
    S = createS_RG(Sblock, S, Tenv(i), i) ;
    
end
disp(['max environment decomposition dim = ', num2str(max(decomposingDim)) ]) ;

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameUSVenv, 'U', 'S', 'V', '-v7.3')

%**************************
%* for test only
% SNo = S.subNo ;
% allS = [] ;
% for iS = 1 : SNo
%     allS = [allS; S.tensor1{iS}] ;
% end
% allS = sort(allS, 'descend')' ;