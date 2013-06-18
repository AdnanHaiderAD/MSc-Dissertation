function distortion = DTWalgorithmLG(seq1G,seq2G, seq1L,seq2L)
%DTW algorithm for Local+Global features
seq1G=seq1G';
seq2G=seq2G';
seq1L=seq1L';
seq2L=seq2L';


%The global and local feature of a sequence are of the same length, r
%denotes the dimension of each feature vector
[r,n]=size(seq1G);
[r, m]= size(seq2G);





%constructing a n+1 by m+1 matrix
seq1L=[zeros(r,1) seq1L];
seq2L=[zeros(r,1),seq2L];
seq1G=[zeros(r,1) seq1G];
seq2G=[zeros(r,1),seq2G];
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
    for j=2:m+1
        %using local + global distance
        DTW(i,j)= sum((seq1G(:,i)-seq2G(:,j)).^2)+sum((seq1L(:,i)-seq2L(:,j)).^2) + min ([DTW(i-1,j),DTW(i-1,j-1),DTW(i,j-1)]);
        %using euclidean metric where each frame is a value.
        %DTW(i,j)= (seq1(i)-seq2(j)).^2 + min ([DTW(i-1,j),DTW(i-1,j-1),DTW(i,j-1)]);
    end
end

distortion=DTW(n+1,m+1)/(n+m);
clearvars DTW seq1 seq2 
end