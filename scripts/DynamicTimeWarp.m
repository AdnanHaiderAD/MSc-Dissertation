
function output = DynamicTimeWarp(test_data,training_data)
tic
noOftestsamp= length(test_data);
[r, genders]=size(training_data);

output=cell(1,noOftestsamp);

for samp=1:noOftestsamp
     testSamp=test_data{samp};
     %extract class and the data seperately 
     class=testSamp{1};
     seq= testSamp{2};
     
     %keeping record of K nearest neighbours
     min_dist=ones(11,1)*Inf;
     closest_match =zeros(11,1);
     
    for g=1 :genders
        data=training_data{g};
        for i=1:length(data)
            trainSamp=data{i};
            trainClass =trainSamp{1};
            seq2= trainSamp{2};
            if (toc>=300)
                toc
                [L,host]= unix('hostname');
                filename = strcat('output',host,'.mat');
                save (filename,'output','samp');
                tic
            end
             %distortion= log(DTW1(seq,seq2)+1); for MFCC features 
             distortion= log(DTW2(seq',seq2')+1);%if applying base-line DTW
             %distortion= log(DTW3(seq,seq2)+1); %if using local +global features
             if distortion<max(min_dist)
                min_dist(min_dist==max(min_dist))=distortion;
                closest_match(min_dist==max(min_dist))= trainClass;
             end
        end
    end
    if closest_match(min_dist==min(min_dist))==class
        entry{1}=0;
    else
        entry{1}=1;
    end
    entry{2}=closest_match;
    output{samp}=entry;
    clear closest_match entry min_dist
end

 [L,host]= unix('hostname');
 filename = strcat('output',host,'.mat');
 save (filename,'output','samp');              


%perform dyanamic timewarping


clearvars seq1 seq2
toc


function distortion = DTW1(seq1,seq2)
% seq1 is r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences
[r1,n]=size(seq1);
[r1, m]= size(seq2);
seq1=[zeros(r1,1) seq1];
seq2=[zeros(r1,1),seq2];
%Initialize the DTW cost matrix
DTW = zeros (n+1,m+1);
for k =2 :m+1
    DTW(1,k)=Inf;
end
for k =2 :n+1
    DTW(k,1)=Inf;
end
DTW(1,1)=0;
for k=2:n+1
    for j=2:m+1
        %using euclidean distance where each frame is a vector and no
        %warping window is used
        DTW(k,j)= sum((seq1(:,k)-seq2(:,j)).^2) + min ([DTW(k-1,j),DTW(k-1,j-1),DTW(k,j-1)]);
    end
end
distortion=DTW(n+1,m+1)/(n+m);
clearvars DTW seq1 seq2 
end



function distortion = DTW2(seq1,seq2)
%DTW algorithm for Local+Global features

% seq1 now is a r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences
[r2,n]=size(seq1);
[r2, m]= size(seq2);
%adding a warping window to speed up computation
w = max(fix (0.1*n),abs(n-m));

seq1=[zeros(r2,1) seq1];
seq2=[zeros(r2,1) seq2];
%Initialize the DTW cost matrix
DTW = zeros (n+1,m+1);
for l =2 :m+1
    DTW(1,l)=Inf;
end
for l =2 :n+1
    DTW(l,1)=Inf;
end
DTW(1,1)=0;
for l=2:n+1
    for j=max(2,l-w) :min(m+1,l+w+1)
     %using  normal DTW with warping window
      DTW(l,j)= sum((seq1(:,l)-seq2(:,j)).^2) + min ([DTW(l-1,j),DTW(l-1,j-1),DTW(l,j-1)]);
    end
end
distortion=DTW(n+1,m+1)/(n+m);
clearvars DTW seq1 seq2 

end



function distortion = DTW3(sq1,sq2)
%DTW algorithm for Local+Global features

%for local +global features
seq1= sq1{1};
seqs2 =sq2{1};
seq3= sq1{2};
seq4=sq2{2};
% seq1 and sq3 are now a 'r' by 'n' matrix and seqs2 and seq4 are now a r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences
[r3,n]=size(seq1);
[r3, m]= size(seqs2);
%adding a warping window to speed up computation
w = max(fix (0.1*n),abs(n-m));

seq1=[zeros(r3,1) seq1];
seqs2=[zeros(r3,1) seqs2];
seq3=[zeros(r3,1) seq1];
seq4=[zeros(r3,1) seqs2];
%Initialize the DTW cost matrix
DTW = zeros (n+1,m+1);
for s =2 :m+1
    DTW(1,s)=Inf;
end
for s =2 :n+1
    DTW(s,1)=Inf;
end
DTW(1,1)=0;
for s=2:n+1
    for j=max(2,s-w) :min(m+1,s+w+1)
        %using (local + global distance) + warping window
        DTW(s,j)= sum((seq1(:,s)-seqs2(:,j)).^2) +sum((seq3(:,s)-seq4(:,j)).^2) + min ([DTW(s-1,j),DTW(s-1,j-1),DTW(s,j-1)]);
        
    end
end

distortion=DTW(n+1,m+1)/(n+m);

clearvars DTW seq1 seq2 

end
end
