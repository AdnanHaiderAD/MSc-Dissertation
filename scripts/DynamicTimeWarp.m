
function output = DynamicTimeWarp(test_data,training_data)
tic
noOftestsamp= length(test_data);
[r genders]=size(training_data);

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
             distortion= log(DTW1(seq,seq2)+1);
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
end

function distortion = DTW1(seq1,seq2)
% seq1 is r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences

[r,n]=size(seq1);
[r, m]= size(seq2);

seq1=[zeros(r,1) seq1];
seq2=[zeros(r,1),seq2];
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
        %using euclidean distance where each frame is a vector
        DTW(i,j)= sum((seq1(:,i)-seq2(:,j)).^2) + min ([DTW(i-1,j),DTW(i-1,j-1),DTW(i,j-1)]);
        %using euclidean metric where each frame is a value.
        %DTW(i,j)= (seq1(i)-seq2(j)).^2 + min ([DTW(i-1,j),DTW(i-1,j-1),DTW(i,j-1)]);
    end
end

distortion=DTW(n+1,m+1)/(n+m);
clearvars DTW seq1 seq2 
end
