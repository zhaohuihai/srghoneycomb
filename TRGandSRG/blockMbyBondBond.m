function M = blockMbyBondBond(M0)

Mno = length(M0) ;
M.subNo = Mno ; 
for i = 1 : Mno
    Mblock = combineMsub(M0(i)) ;
    
    M.quantNo(i) = M0(i).yiZjBondBond ;
    M.dim(i) = length(Mblock) ;
    M.tensor2{i} = Mblock ;
end