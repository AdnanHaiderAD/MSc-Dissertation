
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
             distortion= log(DTW(seq,seq2)+1); %for MFCC features 
             %distortion= log(DTW2(seq',seq2')+1);%if applying base-line DTW
             
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






function distortion = DTW(seq1,seq2)
%DTW algorithm for MFCC + baseline featues

% seq1 now is a r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences
[r2,n]=size(seq1);
[r2, m]= size(seq2);
%adding a warping window to speed up computation
w = min(fix (0.1*max(m,n)),abs(n-m));

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
%Making more adjustments to reduce time complexity
DTW=DTW(2:end,2:end);
distortion =DTW(find(DTW,1,'last'))/(n+m);
%distortion=DTW(n+1,m+1)/(n+m);


clearvars DTW seq1 seq2 

end



end
