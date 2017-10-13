function svd_SRG(parameter, id, th)
%* VMU(x1,x2) = sum_{x}(U(x1,x)* S(x) * V(x2,x))

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameVMU = ['VMU', suffix, '.mat'] ;
load(fileNameVMU, 'VMU')

ratio = parameter.svdRatio_SRG ;
svdsOptions = parameter.svdsOptions ;
%* DD: the total retaining dimension
% D = parameter.bondDimension ;
% DD = D^2 ;
DD = parameter.dimSave_RG + 1 ;
VMUno = VMU.subNo ;
decomposingDim = zeros(1, VMUno) ;

U = rmfield(VMU, {'dim',  'tensor2'}) ;
U.dim = zeros(2, VMUno) ;
U.tensor2 = cell(1, VMUno) ;

S = rmfield(VMU, {'dim',  'tensor2'}) ;
S.dim = zeros(1, VMUno) ;
S.tensor1 = cell(1, VMUno) ;

V = rmfield(VMU, {'dim',  'tensor2'}) ;
V.dim = zeros(2, VMUno) ;
V.tensor2 = cell(1, VMUno) ;

for i = 1 : VMUno
    VMUblock = VMU.tensor2{i} ;
    VMU.tensor2{i} = [] ;
    VMUdim = VMU.dim(i) ;
    decomposingDim(i) = VMUdim ;
    %***************************
    %disp(['SRG decomposition dim =', num2str(VMUdim)])
    %***************************
    if (VMUdim * ratio) < DD
        [Ublock, Sblock, Vblock] = svd(VMUblock) ;
        Sblock = diag(Sblock) ;
        if VMUdim > DD
            Ublock = Ublock(:, 1 : DD) ;
            Sblock = Sblock(1 : DD) ;
            Vblock = Vblock(:, 1 : DD) ;
        end
    else
        [Ublock, Sblock, Vblock, convergence] = svds(VMUblock, DD, 'L', svdsOptions) ;
        Sblock = diag(Sblock) ;
        if convergence == 1
            disp('svds is not convergent. Use svd instead') ;
            [Ublock, Sblock, Vblock] = svd(VMUblock) ;
            Sblock = diag(Sblock) ;
            Ublock = Ublock(:, 1 : DD) ;
            Sblock = Sblock(1 : DD) ;
            Vblock = Vblock(:, 1 : DD) ;
        end
    end
    Sdim = length(Sblock) ;
    dim = [VMUdim; Sdim] ;
    U.dim(:, i) = dim ;
    U.tensor2{i} = Ublock ;
    V.dim(:, i) = dim ;
    V.tensor2{i} = Vblock ;
    S.dim(i) = Sdim ;
    S.tensor1{i} = Sblock ;
end
disp(['max SRG decomposition dim = ', num2str(max(decomposingDim)) ]) ;

fileNameUSV = ['USV', suffix, '.mat'] ;
save(fileNameUSV, 'U', 'S', 'V', '-v7.3')