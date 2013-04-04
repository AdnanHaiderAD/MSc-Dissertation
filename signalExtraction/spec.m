function [H,W]=spec(x,varargin)
% SPEC  Compute or plot the frequency spectrum
%    [H,W] = SPEC(X) computes the frequency spectrum H of the input
%    signal X. W is a vector of frequency sampling points and has units
%    of radians/sample. 
%
%    [H,W] = SPEC(X,Fs,N) specifies the sampling frequency Fs and 
%    the number of frequency sampling points N. If a sampling frequency
%    is specified, the vector of frequency sampling points W will be in 
%    units of Hz.
% 
%    SPEC(X,...) without output arguments plots the spectrum of X. 
% 
%    In addition to the parameters specified above, SPEC accepts the 
%    following flags to control its behaviour:
%      'lin'     plot the spectrum on a linear scale (default)
%      'db'      plot the spectrum on a dB-scale
%      'dbrel'   plot the spectrum on a relative dB-scale (max = 0 dB)
%      'full'    plot/return the two-sided spectrum (default for complex X)
%      'half'    plot/return the positive spectrum (default for real X)
%    Additional PLOT parameters may be specified after these flags, see
%    PLOT for details.

% set default options
full = 0;
db   = 0;
nfft = length(x);
norm = 1; 
fs   = 2;
plotopt = cell(0);

numarg = 0;

% process optional arguments
for i = 1:length(varargin),
    if isnumeric(varargin{i}),
        numarg = numarg+1;
        if ~isempty(varargin{i}),
            switch numarg
                case 1
                    fs = varargin{i};
                    norm = 0;
                case 2
                    nfft = varargin{i};
            end;
        end;
    elseif strcmp(varargin{i},'dbrel'),
        db = 2;
    elseif strcmp(varargin{i},'db'),
        db = 1;
    elseif strcmp(varargin{i},'lin'),
        db = 0;
    elseif strcmp(varargin{i},'full'),
        full = 1;
    elseif strcmp(varargin{i},'half'),
        full = 0;
    else
        plotopt = varargin(i:end);
        break;
    end;
end;

% take DFT
if nfft<length(x),
    X = fft(x(1:nfft),nfft);
else
	X = fft(x,nfft);
end;

% prepare output parameters
if isreal(x),
    if full,
        H = fftshift(X);
        W = linspace(-fs/2,fs/2,nfft+1);
        W = W(1:end-1);
    else
        H = X(1:floor(length(X)/2)+1);
        W = linspace(0,fs,nfft+1);
        W = W(1:floor(nfft/2)+1);
    end;
else
    H = fftshift(X);
    W = linspace(-fs/2,fs/2,nfft+1);
    W = W(1:end-1);
end;
size(H)
% plot if no output variables specified
if nargout==0,
    if db==0,
        plot(W,abs(H),plotopt{:});
        ylabel('Magnitude');
    elseif db==1,
        plot(W,20*log10(abs(H)),plotopt{:});
        ylabel('Magnitude (dB)');
    else
        D = 20*log10(abs(H));
        D = D - max(D);
        plot(W,D,plotopt{:});
        ylabel('Magnitude (dB)');
    end;
    
    if ~norm,
        xlabel('Frequency (Hz)');
    else
        xlabel('Normalized Frequency (\times\pi rad/sample)');
    end;
    clear H W;
end;
