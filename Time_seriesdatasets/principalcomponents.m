function eigenvectors = principalcomponents(datamatrix)
%% extracts  eigenvectors correponding to the principal subspace
% datamatrix is N by D where N is the number of samples and D is the
% dimension and D>>N





%% computation of matrix XX'
data =datamatrix*datamatrix';

[U,S,V]= svd(data);
clear V
%% temporary fix to choosing the appropriate number of eigen vectors:only take the no-zero singular values;

SingularValues= diag(S);
count = sum(SingularValues~=0);


U= U(:,1:count);

singularvalues=SingularValues(1:count);
singValueInv= 1./sqrt(singularvalues);




% 1/(srqt(lambda)) * X'*U  
eigenvectors=abs( datamatrix'*U*singValueInv);


end