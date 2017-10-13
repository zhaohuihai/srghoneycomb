function truncateTinyS(parameter, id)

fileNameUSVenv = ['USVenv', parameter.systemSuffix{id}, '.mat'] ;
load(fileNameUSVenv, 'U', 'S', 'V')

[U, S, V] = doTruncationOfTinyS(parameter, U, S, V) ;

[U, S, V] = eliminateEmptyElement_environment(U, S, V) ;

save(fileNameUSVenv, 'U', 'S', 'V', '-v7.3')
