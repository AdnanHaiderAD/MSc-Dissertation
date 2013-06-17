function [yout,x,t] = impulse(a,b,c,d,iu,t)
%IMPULSE  Impulse response of dynamic systems.
%
%   IMPULSE(SYS) plots the impulse response of the dynamic system SYS. For systems  
%   with more than one input, independent impulse commands are applied to each 
%   input channel. The time range and number of points are chosen automatically.
%   For continuous-time systems with direct feedthrough, the infinite pulse at 
%   t=0 is ignored.
%
%   IMPULSE(SYS,TFINAL) simulates the impulse response from t=0 to the final time 
%   t=TFINAL (expressed in the time units specified in SYS.TimeUnit). For 
%   discrete-time models with unspecified sampling time, TFINAL is interpreted 
%   as the number of samples.
%
%   IMPULSE(SYS,T) uses the time vector T for simulation (expressed in the 
%   time units of SYS). For discrete-time models, T should be of the form 
%   Ti:Ts:Tf where Ts is the sampling time. For continuous-time models, T 
%   should be of the form Ti:dt:Tf where dt is the sampling period for the 
%   discrete approximation of SYS. The impulse is always assumed to arise at 
%   t=0 (regardless of Ti).
%
%   IMPULSE(SYS1,SYS2,...,T) plots the impulse response of several systems
%   SYS1,SYS2,... on a single plot. The time vector T is optional. You can 
%   also specify a color, line style, and marker for each system, for 
%   example:
%      impulse(sys1,'r',sys2,'y--',sys3,'gx').
%
%   When invoked with left-hand arguments,
%      [Y,T] = IMPULSE(SYS) 
%   returns the output response Y and the time vector T used for simulation. 
%   No plot is drawn on the screen. If SYS has NY outputs and NU inputs, 
%   and LT=length(T), Y is an array of size [LT NY NU] where Y(:,:,j) gives 
%   the impulse response of the j-th input channel. The time vector T is 
%   expressed in the time units of SYS. 
%
%   For state-space models, 
%      [Y,T,X] = IMPULSE(SYS, ...) 
%   also returns the state trajectory X which is an LT-by-NX-by-NU array if 
%   SYS has NX states.
%
%   See IMPULSEPLOT for additional options for impulse response plots.
%
%   See also IMPULSEPLOT, STEP, INITIAL, LSIM, LTIVIEW, DYNAMICSYSTEM.

% Old help
%warning(['This calling syntax for ' mfilename ' will not be supported in the future.'])
%IMPULSE Impulse response of continuous-time linear systems.
%	 IMPULSE(A,B,C,D,IU)  plots the time response of the linear system
%		.
%		x = Ax + Bu
%		y = Cx + Du
%	to an impulse applied to the inputs IU.  The time vector is
%	automatically determined.  
%
%	IMPULSE(NUM,DEN) plots the impulse response of the polynomial 
%	transfer function  G(s) = NUM(s)/DEN(s)  where NUM and DEN contain
%	the polynomial coefficients in descending powers of s.
%
%	IMPULSE(A,B,C,D,IU,T) or IMPULSE(NUM,DEN,T) uses the user-supplied
%	time vector T which must be regularly spaced.  When invoked with
%	left hand arguments,
%		[Y,X,T] = IMPULSE(A,B,C,D,...)
%		[Y,X,T] = IMPULSE(NUM,DEN,...)
%	returns the output and state time history in the matrices Y and X.
%	No plot is drawn on the screen.  Y has as many columns as there 
%	are outputs and length(T) rows.  X has as many columns as there 
%	are states.
%
%	See also: STEP,INITIAL,LSIM and DIMPULSE.

%	J.N. Little 4-21-85
%	Revised: 8-1-90  Clay M. Thompson, 2-20-92 ACWG, 10-1-94 
%	Revised: A. Potvin 10-1-94, P. Gahinet, 4-24-96
%	Copyright 1986-2003 The MathWorks, Inc.
%	$Revision: 1.1.8.4 $  $Date: 2010/11/08 02:16:07 $

ni = nargin;
no = nargout;
if ni==0, 
   eval('exresp(''impulse'')')
   return
end
error(nargchk(2,6,ni))

% Determine which syntax is being used
switch ni
case 2
   if size(a,1)>1,
      % SIMO syntax
      a = num2cell(a,2);
      den = b;
      b = cell(size(a,1),1);
      b(:) = {den};
   end
   sys = tf(a,b);
   t = [];

case 3
   % Transfer function form with time vector
   if size(a,1)>1,
      % SIMO syntax
      a = num2cell(a,2);
      den = b;
      b = cell(size(a,1),1);
      b(:) = {den};
   end
   sys = tf(a,b);
   t = c;

case 4
   % State space system without iu or time vector
   sys = ss(a,b,c,d);
   t = [];

otherwise
   % State space system with iu 
   if min(size(iu))>1,
      error('IU must be a vector.');
   elseif isempty(iu),
      iu = 1:size(d,2);
   end
   sys = ss(a,b(:,iu),c,d(:,iu));
   if ni<6, 
      t = [];
   end
end


if no==1,
   yout = impulse(sys,t);
   yout = yout(:,:);
elseif no>1,
   [yout,t,x] = impulse(sys,t);
   yout = yout(:,:);
   x = x(:,:);
   t = t';
else
   impulse(sys,t)
end

% end impulse
