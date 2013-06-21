function distortion = DTWalgorithm(sq1,sq2)
%DTW algorithm for Local+Global features
tic

%for local +global features
seq1= sq1{1};
seq2 =sq2{1};

seq3= sq1{2};
seq4=sq2{2};


% seq1 now is a r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences

[r,n]=size(seq1);
[r, m]= size(seq2);


%adding a warping window to speed up computation


w = max(fix (0.1*n),abs(n-m));

seq1=[zeros(r,1) seq1];
seq2=[zeros(r,1) seq2];
seq3=[zeros(r,1) seq1];
seq4=[zeros(r,1) seq2];
%Initialize the DTW cost matrix
DTW = zeros (n+1,m+1);
for i =2 :m+1
    DTW(1,i)=Inf;
end
for i =2 :n+1
    DTW(i,1)=Inf;
end
DTW(1,1)=0;

for i=2:n+1
    for j=max(2,i-w) :min(m+1,i+w+1)
     
        %using (local + global distance) / normal DTW
        DTW(i,j)= sum((seq1(:,i)-seq2(:,j)).^2) +sum((seq3(:,i)-seq4(:,j)).^2) + min ([DTW(i-1,j),DTW(i-1,j-1),DTW(i,j-1)]);
        %DTW(i,j)= sum((seq1(:,i)-seq2(:,j)).^2) + min ([DTW(i-1,j),DTW(i-1,j-1),DTW(i,j-1)]);
    end
end

distortion=DTW(n+1,m+1)/(n+m);

clearvars DTW seq1 seq2 
toc
end