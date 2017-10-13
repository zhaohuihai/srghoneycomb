function svdParallel_SRG(parameter, id, th)
%* VMU(x1,x2) = sum_{x}(U(x1,x)* S(x) * V(x2,x))

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameVMU = ['VMU', suffix, '.mat'] ;
load(fileNameVMU, 'VMU')
VMU = VMU ;
ratio = parameter.svdRatio_SRG ;
svdsOptions = parameter.svdsOptions ;
%* DD: the total retaining dimension
D = parameter.bondDimension ;
% DD = D^2 ;
DD = parameter.dimSave_RG + 1 ;
VMUno = VMU.subNo ;
% decomposingDim = zeros(1, VMUno) ;

U = rmfield(VMU, {'dim',  'tensor2'}) ;
Udim = zeros(2, VMUno) ;
Utensor2 = cell(1, VMUno) ;

S = rmfield(VMU, {'dim',  'tensor2'}) ;
Sdim = zeros(1, VMUno) ;
Stensor1 = cell(1, VMUno) ;

V = rmfield(VMU, {'dim',  'tensor2'}) ;
Vdim = zeros(2, VMUno) ;
Vtensor2 = cell(1, VMUno) ;

VMUtensor2 = VMU.tensor2 ;
VMU = rmfield(VMU, {'tensor2'}) ;
VMUdim = VMU.dim ;

parfor i = 1 : VMUno
    VMUblock = VMUtensor2{i} ;
    VMUtensor2{i} = [] ;
    
    %***************************
    %disp(['SRG decomposition dim =', num2str(VMUdim(i))])
    %***************************
    if (VMUdim(i) * ratio) < DD
        [Ublock, Sblock, Vblock] = svd(VMUblock) ;
        Sblock = diag(Sblock) ;
        if VMUdim(i) > DD
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
%     Sdim = length(Sblock) ;
    dim = [VMUdim(i); length(Sblock)] ;
    Udim(:, i) = dim ;
    Utensor2{i} = Ublock ;
    Vdim(:, i) = dim ;
    Vtensor2{i} = Vblock ;
    Sdim(i) = length(Sblock) ;
    Stensor1{i} = Sblock ;
end

U.dim = Udim ;
U.tensor2 = Utensor2 ;
clear Utensor2 ;
V.dim = Vdim ;
V.tensor2 = Vtensor2 ;
clear Vtensor2
S.dim = Sdim ;
S.tensor1 = Stensor1 ;
clear Stensor1
disp(['max SRG decomposition dim = ', num2str(max(VMUdim))]) ;

fileNameUSV = ['USV', suffix, '.mat'] ;
save(fileNameUSV, 'U', 'S', 'V', '-v7.3')