% Calculates and manipulates a poynominial Kernel of parameters c1, c2 and d.
% Where K(i,j) = (c1 + c2 xi'xj)^d.


function [PolynomialKernel] = calculatePolynomialKernel(Inputs,c1,c2,d)
tic
global NumberOfPoints

%% Calculates the Linear Kernel
Kernel = zeros(NumberOfPoints,NumberOfPoints);

for i = 1:NumberOfPoints
    for j = 1:NumberOfPoints
        Kernel(i,j) = (c1 + c2*(Inputs(:,i)'*Inputs(:,j)))^d;
    end
end

% Normalisation
N = trace(Kernel);
Kernel = Kernel/N;

%% Does an SVD and returns the US^0.5 matrix.

[U,S] = svd(Kernel);
PolynomialKernel = U*(S^0.5);
disp('Polynomial Kernel SVD finished')
toc