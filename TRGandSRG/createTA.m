function TA = createTA(AA)

TA.subNo = AA(1, 1).subNo + AA(2, 2).subNo ;
TA.quantNo = [AA(1, 1).quantNo, AA(2, 2).quantNo] ;
TA.dim = [AA(1, 1).dim, AA(2, 2).dim] ;
TA.tensor3 = [AA(1, 1).tensor3, AA(2, 2).tensor3] ;

% TA = blockTAbyBondBond(AA) ;