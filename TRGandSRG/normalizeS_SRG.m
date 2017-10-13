function normalizeS_SRG(parameter, id)

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSVenv, 'S')

SNo = S.subNo ;
allS = [] ;
for iS = 1 : SNo
    allS = [allS; S.tensor1{iS}] ;
end
Smax = max(allS) ;

for iS = 1 : SNo
    S.tensor1{iS} = S.tensor1{iS} ./ Smax ;
end

save(fileNameUSVenv, 'S', '-append', '-v7.3')