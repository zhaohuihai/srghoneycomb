function coef = truncate_SRG(parameter, id, th)

id6 = id + 3 * (th - 1) ;
suffix = parameter.systemSuffix{id6} ;
fileNameUSV = ['USV', suffix, '.mat'] ;
load(fileNameUSV, 'U', 'S', 'V')

[U, S, V, coef] = doTruncation_SRG(parameter, U, S, V) ;

[U, S, V] = eliminateEmptyElement_SRG(U, S, V) ;

save(fileNameUSV, 'U', 'S', 'V', '-v7.3')
