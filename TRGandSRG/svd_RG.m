function svd_RG(parameter, id)

fileNameM = ['M', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameM, 'M') ;

ratio = parameter.svdRatio_TRG ;
svdsOptions = parameter.svdsOptions ;

% D = parameter.bondDimension ;
%* DD: the total retaining dimension
% DD = D^2 ;
DD = parameter.dimSave_RG + 1 ;
Mno = length(M) ;
decomposingDim = zeros(1, Mno) ;
S.subNo = Mno ;

U.subNo = 0 ;
V = U ;
for i = 1 : Mno
    Mblock = combineMsub(M(i)) ;
    M(i).tensor2 = [] ;
    Mdim = length(Mblock) ;
    decomposingDim(i) = Mdim ;
    %***************************
    %     disp(['TRG decomposition dim =', num2str(Mdim)])
    %***************************
    if (Mdim * ratio) < DD
        [Ublock, Sblock, Vblock] = svd(Mblock) ;
        Sblock = diag(Sblock) ;
        if Mdim > DD
            Ublock = Ublock(:, 1 : DD) ;
            Sblock = Sblock(1 : DD) ;
            Vblock = Vblock(:, 1 : DD) ;
        end
    else
        [Ublock, Sblock, Vblock, convergence] = svds(Mblock, DD, 'L', svdsOptions) ;
        Sblock = diag(Sblock) ;
        if convergence == 1
            disp('svds is not convergent. Use svd instead') ;
            [Ublock, Sblock, Vblock] = svd(Mblock) ;
            Sblock = diag(Sblock) ;
            Ublock = Ublock(:, 1 : DD) ;
            Sblock = Sblock(1 : DD) ;
            Vblock = Vblock(:, 1 : DD) ;
        end
    end
    Sdim = length(Sblock) ;
    U = createU_RG(Ublock, U, M(i), Sdim, 1) ;
    V = createU_RG(Vblock, V, M(i), Sdim, 2) ;
    S = createS_RG(Sblock, S, M(i), i) ;    
end
disp(['max TRG decomposition dim = ', num2str(max(decomposingDim)) ]) ;


fileNameUSV = ['USV', parameter.systemSuffix{id}, '.mat'] ;
save(fileNameUSV, 'U', 'S', 'V', '-v7.3') ;