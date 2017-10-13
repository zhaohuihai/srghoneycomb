function debugTRG(TA, TB, MH)

MAB = contractTA_TB(TA, TB) ;
MAB = partitionMbyBondBond(MAB) ;

for i = 1 : length(MAB)
    sum(MAB(i).yiZjBondBond - MH(i).yiZjBondBond)
    sum(MAB(i).yiBond - MH(i).yiBond)
    sum(MAB(i).yiDim - MH(i).yiDim)
    sum(MAB(i).zjBond - MH(i).zjBond)
    sum(MAB(i).zjDim - MH(i).zjDim)
    sum(MAB(i).yjBond - MH(i).yjBond)
    sum(MAB(i).yjDim - MH(i).yjDim)
    sum(MAB(i).ziBond - MH(i).ziBond)
    sum(MAB(i).ziDim - MH(i).ziDim)
    
end