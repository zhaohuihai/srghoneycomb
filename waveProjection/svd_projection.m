function USV = svd_projection(parameter, T, Lambda)
ratio = parameter.svdRatio_projection ;
M = parameter.siteDimension ;
D = parameter.bondDimension ;
TNo = length(T) ;
for iM = 1 : M
    site = M + 1 - 2 * iM ;
    U(iM).site = site ;
    U(iM).subNo = 0 ;
end
V = U ;
S.subNo = TNo ;
for iT = 1 : TNo
%     tic
    Tblock = combineTsub(T(iT), Lambda) ;
%     toc
    Tdim = length(Tblock) ;
    %***************************
%         disp(['decomposition dim =', num2str(Tdim)])
    %***************************
%     tic
    if (Tdim * ratio) < D
        [Ublock, Sblock, Vblock] = svd(Tblock) ;
        if Tdim > D
            Ublock = Ublock(:, 1 : D) ;
            Sblock = Sblock(1 : D, 1 : D) ;
            Vblock = Vblock(:, 1 : D) ;
        end
    else
        [Ublock, Sblock, Vblock] = svds(Tblock, D) ;
    end

    [ U ] = createU_projection(M, Ublock, U, T(iT), iT, Lambda, 1) ;
%     toc
%     tic
    [ V ] = createU_projection(M, Vblock, V, T(iT), iT, Lambda, 2) ;
%     toc

    S = createS_projection(Sblock, S, T(iT), iT) ;
%     pause
end

USV.U = U ;
USV.S = S ;
USV.V = V ;