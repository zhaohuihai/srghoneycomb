function coef = truncate_RG(parameter, id)

fileNameUSV = ['USV', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSV, 'U', 'S', 'V')
[U, S, V, coef] = doTruncation_RG(parameter, U, S, V) ;

[U, S, V] = eliminateEmptyElement_RG(U, S, V) ;
save(fileNameUSV, 'U', 'S', 'V', '-v7.3')
