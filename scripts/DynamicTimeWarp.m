
function output = DynamicTimeWarp(varargin)
%% Runs two versions of DTW algorithm augmented with different  kernel metric to perform K nearest neighbours classification for each test sample in the test set.
% using the training data.
% Input : test data, training data , window parameter size;
%  Output : the 1 vs rest classification output for each test instance.
tic 
time=0;
%%checks for the number of arguments
if length(varargin)<2
    error('No enough arguments')
end
%if window is not specified then
if length(varargin)==2
    w=nan;

else
    w=varargin{3};
end

test_data=varargin{1};
training_data=varargin{2};
data_b=training_data{1};
data_g=training_data{2};
data_m=training_data{3};
data_w= training_data{4};
data(1:length(data_b)) = data_b(1:end);
data(length(data_b)+1:length(data_b)+length(data_g)) = data_g(1:end);
data(length(data_b)+length(data_g)+1:length(data_b)+length(data_g)+length(data_m)) = data_m(1:end);
data(length(data_b)+length(data_g)+length(data_m)+1:length(data_b)+length(data_g)+length(data_m)+length(data_w)) = data_w(1:end);



noOftestsamp= length(test_data);
[r, categories]=size(training_data);

%% each entry of the output contain a vector of K nearest neighbours and value of 0 or 1 where 1 denote misclassication
output=cell(noOftestsamp,1);




for samp=1:noOftestsamp
     testSamp=test_data{samp};
     %%extract class and the data seperately 
     class=testSamp{1};
     seq= testSamp{2};
     
     %%keeping record of K nearest neighbours and their distances
     min_dist=ones(11,1)*Inf;
     closest_match =zeros(11,1);
     
     %% Comparing the test sample with the entire training set
    
        for i=1:length(data)
            %extraction of class and sample separately
            trainSamp=data{i};
            trainClass =trainSamp{1};
            seq2= trainSamp{2};
            if (toc>=300)
                %save output at regular interval
                time=time+toc
                [L,host]= unix('hostname');
                filename = strcat('output',host,'.mat');
                save (filename,'output','samp');
                tic
            end
            %% applying DTW+(baseline or MFCC) +euclidean metric
             %distortion= log(DTW(seq,seq2,w)+1); 
             %% applying DTW using local and global features and the proposed kernel. 
              distortion=DTW2(seq',seq2');
              %% keeping a record of K nearest matches
            if distortion<max(min_dist)
                min_dist(min_dist==max(min_dist))=distortion;
                closest_match(min_dist==max(min_dist))= trainClass;
            end
        end
    
    %% The classifier is a 1 vs rest classifier where correct classifiaction denotes 0
    % and misclassifaction denotes 1
    
   
    % if closest_match(min_dist==min(min_dist))==class
   %% k nearest neighbour
   if mode(closest_match)==class
      entry{1}=0;
    else
        entry{1}=1;
    end
    entry{2}=closest_match;
    output{samp}=entry;
    clear closest_match entry min_dist
end
  time=time+toc;

 [L,host]= unix('hostname');
 filename = strcat('output',host,'.mat');
 save (filename,'output','samp','time'); 
 time




clearvars seq seq2






function distortion = DTW(seq1,seq2,w)
%% DTW algorithm for MFCC + baseline featues
% seq1 now is a r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences

[r2,n]=size(seq1);
[r2, m]= size(seq2);

if n==1 && m==1
    seq1=seq1';
    seq2=seq2';
    [r2,n]=size(seq1);
    [r2, m]= size(seq2);
end

if ~isnan(w)
w = max(fix(w*max(n,m)),abs(n-m));
end

%% Initializing The DTW cost matrix
seq1=[zeros(r2,1) seq1];
seq2=[zeros(r2,1) seq2];
DTW = zeros (n+1,m+1);
for l =2 :m+1
    DTW(1,l)=Inf;
end
for l =2 :n+1
    DTW(l,1)=Inf;
end
DTW(1,1)=0;

%% if no window constraints are specified
if (isnan(w))
  
for l=2:n+1
    for j=2:m+1
     %using  normal DTW with warping window
      DTW(l,j)= sum((seq1(:,l)-seq2(:,j)).^2) + min ([DTW(l-1,j),DTW(l-1,j-1),DTW(l,j-1)]);
    end
end
distortion =DTW(n+1,m+1)/(n+m);

%% if window constraints are specified
else
   
  for l=2:n+1
    for j=max(2,l-w) :min(m+1,l+w+1)
     %using  normal DTW with warping window
      DTW(l,j)= sum((seq1(:,l)-seq2(:,j)).^2) + min ([DTW(l-1,j),DTW(l-1,j-1),DTW(l,j-1)]);
    end
  end  
DTW=DTW(2:end,2:end);
distortion =DTW(find(DTW,1,'last'))/(n+m);
end

clearvars DTW seq1 seq2 

end

function distortion= DTW2(varargin)

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
seq3=varargin{2};

%% To achieve perfect segmentation some end points are removed.
[num1 dim]=size(seq1);
noOfseq1frames= fix(length(seq1)/window);
n=noOfseq1frames;
seq1= seq1(1:(n*window),:);


[num2 dim]=size(seq3);
noOfseq2frames= fix(length(seq3)/window);
m=noOfseq2frames;
seq3= seq3(1:(m*window),:);

%% Partitioning the sequences
seq1 =mat2cell(seq1,repmat(window,n,1),dim);
seq3 =mat2cell(seq3,repmat(window,m,1),dim);

%% Initializing The DTW cost matrix
seq1=seq1';
seq3=seq3';
extracell={zeros(1,dim)};

seq1={extracell{:} seq1{:}};
seq3={extracell{:} seq3{:}};
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
      %% using my own proposed kernel
      sumofvec1=sum(seq1{l});
      sumofvec2=sum(seq3{j});
      DTW(l,j)= real(acos((sumofvec1*sumofvec2')/(norm(sumofvec1)*norm(sumofvec2)))) + min ([DTW(l-1,j),DTW(l-1,j-1),DTW(l,j-1)]);
    end
end
distortion =DTW(n+1,m+1)/(n+m);


end

end
