function value =polynomialKernel(InputA,InputB ,M)
%%computes a particular weighted sum of all possible products of M time
%in the first slice with M time in the second slice.



%%Assume InputA and InputB are of the same dimensions
[n r]= size(InputA);


%%if each time point is presented by a feature vector
if r>1
    %% this ensures the sum of all possible products of M time points in the
    %first image with M time points in the 2nd image.
    dotprod= dot(InputA,InputB);
    value  =  log(sum(dotprod)) *M;
else
    value = (dot(InputA,InputB))^M;
end
%value indicates similarity thus converting it to cost
value=real(1/value);
end

