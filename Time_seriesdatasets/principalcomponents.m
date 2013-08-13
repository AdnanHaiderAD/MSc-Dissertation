function eigenvectors = principalcomponents(datamatrix)
%% extracts  eigenvectors correponding to the principal subspace
% datamatrix is D by N where N is the number of samples and D is the
% dimension and D>>N





%% computation of matrix X'X
data =datamatrix'*datamatrix;

[U,S,V]= svd(data);
clear V
%% temporary fix to choosing the appropriate number of eigen vectors:only take the no-zero singular values;

SingularValues= diag(S);
%count = sum(SingularValues~=0);

%%take singular values that explains 95% of the data
for i =1 :length(SingularValues)
    if sum(SingularValues(1:i))/sum(SingularValues) >= 0.95
        count=i;
    end
end


U= U(:,1:count);

singularvalues=SingularValues(1:count);
singValueInv= diag(1./sqrt(singularvalues));




% 1/(srqt(lambda)) * X'*U  
eigenvectors=( datamatrix*U*singValueInv);


end