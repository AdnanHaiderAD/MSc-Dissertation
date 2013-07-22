function eigenvectors = principalcomponents(datamatrix)
%% extracts  eigenvectors correponding to the principal subspace
% datamatrix is D by N where N is the number of samples and D is the
% dimension and D>>N


datamatrix=datamatrix';%X is now a N by D matrix


[samp dim]= size(datamatrix);
%% computation of matrix XX'
data =datamatrix*datamatrix';
[U,S,V]= svd(data)
clear V
%% temporary fix to choosing the appropriate number of eigen vectors
count=1;
SingularValues= diag(S);
for i=2:length(SingularValues)
    if (sum(SingularValues(1:i))/sum(SingularValues))<0.95
        count=count+1;
    else
        break;
    end
end


U= U(:,1:count);

singularvalues=SingularValues(1:count);
singValueInv= 1./sqrt(singularvalues);

% 1/(srqt(lambda)) * X'*U  
eigenvectors=abs( datamatrix'*U*singValueInv);

end