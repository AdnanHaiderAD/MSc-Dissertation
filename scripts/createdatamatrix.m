function data = createdatamatrix(data)

%% takes the raw  training data set that is partioned into categories and classes  and creates a data matrix.
% output : datamatrix where the first column holds information about the
% classes




%%  extracts data of each category
boy =data{1};
girl=data{2};
men=data{3};
women=data{4};



%% find the maximum length of the sequences.

total_length=0;


%% counter keeps track of the total size of the training set
  count=1;
 labels={};

 
 %% changes made : normalization and removing silence: translation invariance
 
function cg_data= findmaxlength(cg_data)
%% records the maximum length of the sequence seen in the data so far
% output : is now the same data where sequences are translted and
% normalised

    [samples] =length(cg_data);
    for s=1:samples
        entry= cg_data{s};
        sample=entry{2};
        labels{count}= entry{1};
        count=count+1;
        sample= sample(sample~=0); % translation
        %sample=1/norm(sample)*sample;
         seqlen= length(sample);
         total_length=total_length+seqlen;
     end
   
end
tic
boy=findmaxlength(boy);
toc
tic
girl=findmaxlength(girl);
toc
tic
men=findmaxlength(men);
toc
tic

women=findmaxlength(women);
toc
optimum_length= fix((total_length)/(count-1));
%% creates the data matrix
data= zeros ( count-1, optimum_length+1);
data(:,1)= cell2mat(labels);% 1st column contains label information

counter=1;


function fillmatrix(cg_data)
  
%% fills in the matrix after resampling     
    [samples] =length(cg_data);
    for s=1:samples 
       entry=cg_data{s};  
        sample=entry{2};
             %sampleLen=length(sample);
             %data(counter,2:sampleLen+1)=sample; 
        data(counter,2:end) = resample(sample,optimum_length,length(sample));
         counter=counter+1;
    end
    
end
tic
fillmatrix(boy);
toc
tic
toc
fillmatrix(girl);
tic
fillmatrix(men);
toc
tic
fillmatrix(women);
end
