
function output = DynamicTimeWarp(test_data,training_data)
tic
[regions classes versions]= size(test_data);
[gender b] =size(training_data);

output= zeros (regions*classes*versions ,1);
dim=1;
for i =1 : regions
    for j=1 :classes
        current_type = j;
        %using 1 nearest neighbour
        %min=Inf
        %closest_match =0;
        %using 11 nearest neigbours 
        min_dist=ones(11,1)*Inf;
        closest_match =zeros(11,1);
        for k=1 :versions
            seq1= test_data{i,j,k};
           
            for g=1 :gender
                data =training_data{g};
                [regionsT classesT versionsT]=size(data);
                for r=1 : regionsT
                    for q=1 : classesT
                        for v=1 : versionsT
                            seq2= data{r,q,v};
                            
                            if (toc>=600)
                                toc
                                [L,host]= unix('hostname');
                                filename = strcat('output',host,'.mat');
                                save (filename,'output','i','j','k');
                                tic
                            end
                            distortion= log(DTWalgorithm(seq1,seq2)+1);
                           % if distortion <min_dist
                           if distortion<max(min_dist)
                                min_dist(min_dist==max(min_dist))=distortion;
                                closest_match(min_dist==max(min_dist))= q;
                            end
                        end
                    end
                end
            end
            %if current_type==closest_match
            if current_type==mode(closest_match)
                output(dim)=1;
            else
                output(dim)=0;
            end
            dim=dim+1;
        end
    end
end
 [L,host]= unix('hostname');
 filename = strcat('output',host,'.mat');
 save (filename,'output','i','j','k');              


%perform dyanamic timewarping


clearvars seq1 seq2
toc
end

function distortion = DTWalgorithm(seq1,seq2)
% seq1 is r by n matrix and seq2 is an r by m matrix where r denote dimension of each feature vector(frame) 
% and n and m denote the length of the sequences

[r,n]=size(seq1);
[r, m]= size(seq2);



%the following conditional branch is for value-based DTW
if n==1 && m==1
     seq1=seq1';
     seq2=seq2';
     [r,n]=size(seq1);
     [r, m]= size(seq2);

end

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