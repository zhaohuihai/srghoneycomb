function svdAllParallel_SRG(parameter, id)

fileNameMenv = ['Menv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameMenv, 'Menv') ;
Menv = Menv ;
Mno = length(Menv) ;
decomposingDim = zeros(1, Mno) ;
S.subNo = Mno ;

U.subNo = 0 ;
V = U ;
Ublock = cell(1, Mno) ;
Sblock = cell(1, Mno) ;
Vblock = cell(1, Mno) ;

parfor i = 1 : Mno
    Mblock = combineMsub(Menv(i)) ;
    Menv(i).tensor2 = [] ;
    Mdim = length(Mblock) ;
    decomposingDim(i) = Mdim ;
    %***************************
    %disp(['environment decomposition dim =', num2str(Mdim)])
    %***************************
    [U1, S1, V1] = svd(Mblock) ;
    S1 = diag(S1) ;
    
    Ublock{i} = U1 ;
    Sblock{i} = S1 ;
    Vblock{i} = V1 ;
end

for i = 1 : Mno    
    Sdim = length(Sblock{i}) ;
    U = createU_RG(Ublock{i}, U, Menv(i), Sdim, 1) ;
    V = createU_RG(Vblock{i}, V, Menv(i), Sdim, 2) ;
    S = createS_RG(Sblock{i}, S, Menv(i), i) ;
    Ublock{i} = [] ;
    Vblock{i} = [] ;
    Sblock{i} = [] ;
end
disp(['max environment decomposition dim = ', num2str(max(decomposingDim)) ]) ;

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameUSVenv, 'U', 'S', 'V', '-v7.3')