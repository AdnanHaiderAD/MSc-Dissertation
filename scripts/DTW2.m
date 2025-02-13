function distortion= DTW2(varargin)
tic
%% segments the utterances into frames of 20ms long and applies DTW
% augmented with a polynomial kernel 

if length(varargin)<2
    error('not enough arguments')
end
if length(varargin)==3
    window=varargin{3};
else
    window=50;
end
seq1= varargin{1};
seq2=varargin{2};



%% To achieve perfect segmentation some end points are removed.
[num1 dim]=size(seq1);
noOfseq1frames= fix(length(seq1)/window);
n=noOfseq1frames;
seq1= seq1(1:(n*window),:);


[num2 dim]=size(seq2);
noOfseq2frames= fix(length(seq2)/window);
m=noOfseq2frames;
seq2= seq2(1:(m*window),:);

%% Partitioning the sequences
seq1 =mat2cell(seq1,repmat(window,n,1),dim);
seq2 =mat2cell(seq2,repmat(window,m,1),dim);

%% Initializing The DTW cost matrix
seq1=seq1';
seq2=seq2';
extracell={zeros(1,dim)};

seq1={extracell{:} seq1{:}};
seq2={extracell{:} seq2{:}};
DTW = zeros (n+1,m+1);
for l =2 :m+1
    DTW(1,l)=Inf;
end
for l =2 :n+1
    DTW(l,1)=Inf;
end
DTW(1,1)=0;
for l=2:n+1
    for j=2:m+1
      %using  normal DTW with warping window
      
      sumofvec1=sum(seq1{l});
      sumofvec2=sum(seq2{j});
     
      DTW(l,j)= real(acos((sumofvec1*sumofvec2')/(norm(sumofvec1)*norm(sumofvec2)))) + min ([DTW(l-1,j),DTW(l-1,j-1),DTW(l,j-1)]);
     
     
    end
end
distortion =DTW(n+1,m+1)/(n+m);

toc
end