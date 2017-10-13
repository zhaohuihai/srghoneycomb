% function test
% a = cell(1, 100) ;
% for i = 1 : 100
%     a{i} = rand(100, 100) ;
% end
% b(1).a = a ;
% b(2).a = a ;
% b(3).a = 1 ;
% b(1).x = 1 ;
% whos('b')
%********************************************
% n = 1000 ;
% retain = 100 ;
% M = rand(n) ;
% tic
% [U1, S1, V1] = svd(M) ;
% toc
% s1 = diag(S1) ;
% % s1 = s1(1 : retain) ;
% s1((retain + 1) : n) = 0 ;
% % M = sparse(M) ;
% tic
% [U2, S2, V2] = svds(M, retain) ;
% toc
% % s2 = diag(S2) ;
% % sum(s1 - s2)
% a = max(max(M - U1 * diag(s1) * V1')) ;
% b = max(max(M - U2 * S2 * V2')) ;
% a - b
%**************************************************
% clear
% load TA1
% load TA2
% % load TB3
% for i = 1 : TA1.subNo
%     %* (x,y,z)
%     QN1 = TA1.quantNo(:, i) ;
%     %* (y,z,x)
%     QN2 = zeros(3, 1) ;
%     QN2(1) = QN1(2) ;
%     QN2(2) = QN1(3) ;
%     QN2(3) = QN1(1) ;
%
%     c = cell(1, 3) ;
%     for j = 1 : 3
%         c{j} = (QN2(j) == TA2.quantNo(j, :)) ;
%     end
%     index = find(c{1} & c{2} & c{3}) ;
%     a1 = permute(TA1.tensor3{i}, [2, 3, 1]) ;
%     a2 = TA2.tensor3{index} ;
% %     a1 - a2
% end
%******************************************************
% load TA1
% load TA2
% for i = 1 : TA1.subNo
%     %* (x,y,z)
%     a1 = TA1.tensor3{i} ;
%     a2 = TA2.tensor3{i} ;
%     a1 - a2
% end
%*********************************
% d = 10 : 10 : 1000 ;
% dno = length(d) ;
% tE = zeros(1, dno) ;
% for i = 1 : dno

%     M = rand(d(i)) ;
%
%     tStart = tic ;
%     [U, S] = eig(M) ;
%     tE(i) = toc(tStart) ;
% end
% logd = log(d) ;
% logtE = log(tE) ;
%******************************************
% D = 40 ;
% DD = D^2 ;
% retain = DD * 0.15 ;
% M = rand(DD) ;
% tic
% [U1, S1, V1] = svd(M) ;
% t1 = toc ;
% tic
% [U2, S2, V2, flag] = svds(M, retain) ;
% t2 = toc ;
% 
% timeRatio = t1 / t2 ;
% save timeRatio.mat timeRatio
%*********************************
% folderName = 'testSub' ;
% mkdir('test')
% a = 1 ;
% b = 2 ;
% save('test/test1.mat', 'a')
% save('test/test2.mat', 'b')
% % load(fn, 'a', 'b')
% copyfile('test/test1.mat', 'test.mat')
% delete(fn)
%************************************************
% d1 = 1 : 21 ;
% d2 = 20 : -1 : 1 ;
% dfactor = 40 ;
% d = [d1, d2] ;
% dim = dfactor .* d(1, :) ;
% for i = 1 : 41
%     S(i).matrix = rand(dim(i)) ;
% end
% Ublock = cell(1, 41) ;
% Sblock = cell(1, 41) ;
% Vblock = cell(1, 41) ;
% 
% tic
% for i = 1 : 41
%     disp(['i = ',num2str(i)]) ;
%     disp(['dim = ', num2str(dim(i))])
%     [U1, S1, V1] = svd(S(i).matrix) ;
%     Ublock{i} = U1 ;
%     Vblock{i} = V1 ;
%     Sblock{i} = diag(S1) ;
% end
% toc
% 
% matlabpool open 4
% tic
% parfor i = 1 : 41
%     disp(['i = ',num2str(i)]) ;
%     disp(['dim = ', num2str(dim(i))])
%     [U1, S1, V1] = svd(S(i).matrix) ;
%     Ublock{i} = U1 ;
%     Vblock{i} = V1 ;
%     Sblock{i} = diag(S1) ;
% end
% toc
% 
% [dOrder, dIndex] = sort(d, 'ascend') ;
% dimOrder = dfactor .* dOrder ;
% S= S(dIndex) ;
% tic
% parfor i = 1 : 41
%     disp(['i = ',num2str(i)]) ;
%     disp(['dim = ', num2str(dimOrder(i))])
%     [U1, S1, V1] = svd(S(i).matrix) ;
%     Ublock{i} = U1 ;
%     Vblock{i} = V1 ;
%     Sblock{i} = diag(S1) ;
% end
% toc
% 
% matlabpool close

%*************************************************
% A = [20, 30, 10, 40]
% [A, index] = sort(A)
% % B(index)
% % for i = 1 : 4
%     A(index) = A
% % end
% % C
%**************************
% % id{1} = 'Mx' 
% % id{2} = 'My'
% matlabpool open 2
% parfor i = 1 : 4
%     a = i ;
%     if i == 2
%         testSave(a)
%     end
% end
% 
% 
% matlabpool close
% % id = {'Mx', 'My'}
%*************************
copyfile('intermediateResult/*.mat','./') ;