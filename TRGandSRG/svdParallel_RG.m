function svdParallel_RG(parameter, id)

fileNameM = ['M', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameM, 'M') ;
M = M ;

ratio = parameter.svdRatio_TRG ;
svdsOptions = parameter.svdsOptions ;

D = parameter.bondDimension ;
%* DD: the total retaining dimension
% DD = D^2 ;
DD = parameter.dimSave_RG + 1 ;
Mno = length(M) ;
decomposingDim = zeros(1, Mno) ;
S.subNo = Mno ;

U.subNo = 0 ;
V = U ;

Ublock = cell(1, Mno) ;
Sblock = cell(1, Mno) ;
Vblock = cell(1, Mno) ;
Mblock = cell(1, Mno) ;
% Mdim = zeros(1, Mno) ;

parfor i = 1 : Mno
    Mblock{i} = combineMsub(M(i)) ;
    M(i).tensor2 = [] ;
    decomposingDim(i) = length(Mblock{i}) ;
end
M = rmfield(M, 'tensor2') ;

%* sort sub matrix ascendingly
[decomposingDim, index] = sort(decomposingDim) ;
Mblock = Mblock(index) ;
%*********

parfor i = 1 : Mno
    Mdim = decomposingDim(i) ;
    %***************************
    %disp(['TRG decomposition dim =', num2str(Mdim(i))])
    %***************************
    if (Mdim * ratio) < DD
        [U1, S1, V1] = svd(Mblock{i}) ;
        S1 = diag(S1) ;
        if Mdim > DD
            U1 = U1(:, 1 : DD) ;
            S1 = S1(1 : DD) ;
            V1 = V1(:, 1 : DD) ;
        end
    else
        [U1, S1, V1, convergence] = svds(Mblock{i}, DD, 'L', svdsOptions) ;
        S1 = diag(S1) ;
        if convergence == 1
            disp('svds is not convergent. Use svd instead') ;
            [U1, S1, V1] = svd(Mblock{i}) ;
            S1 = diag(S1) ;            
            U1 = U1(:, 1 : DD) ;
            S1 = S1(1 : DD) ;
            V1 = V1(:, 1 : DD) ;            
        end
    end
    Ublock{i} = U1 ;
    Sblock{i} = S1 ;
    Vblock{i} = V1 ;
end
%* recover order
Ublock(index) = Ublock ;
Sblock(index) = Sblock ;
Vblock(index) = Vblock ;
%***************************

for i = 1 : Mno    
    Sdim = length(Sblock{i}) ;
    U = createU_RG(Ublock{i}, U, M(i), Sdim, 1) ;
    Ublock{i} = [] ;
    V = createU_RG(Vblock{i}, V, M(i), Sdim, 2) ;
    Vblock{i} = [] ;
    S = createS_RG(Sblock{i}, S, M(i), i) ;    
    Sblock{i} = [] ;
end
disp(['max TRG decomposition dim = ', num2str(max(decomposingDim)) ]) ;

fileNameUSV = ['USV', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameUSV, 'U', 'S', 'V', '-v7.3') ;