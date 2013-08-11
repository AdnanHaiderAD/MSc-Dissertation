function kappa= compute_curvature(x,y)
%s=spline(x,y);
 s= csaps(x,y,0.2);
% first derivative, pp form
s1 = s;
s1.order = s.order-1; 
s1.coefs = bsxfun(@times, s.coefs(:,1:end-1), s1.order:-1:1);

% second derivative, pp form
s2 = s1;
s2.order = s1.order-1; 
s2.coefs = bsxfun(@times, s1.coefs(:,1:end-1), s2.order:-1:1);

% Evaluate the curvature
% 100 points cover the same interval 
%x = linspace(x(1),x(end));
A1 = ppval(s1,x); % first derivative at x
A2 = ppval(s2,x); % second derivative at x
% curvature
kappa = A2./(1 + A1.^2).^(3/2);



 %Graphic check
% figure(5)
subplot(1,2,1)
plot(x,ppval(x,s),'b');
%kappa=ppval(x,s);
%kappa=s;
subplot(1,2,2)
plot(x,kappa,'r');

