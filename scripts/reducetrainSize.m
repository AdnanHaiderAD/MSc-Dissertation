function data= reducetrainSize(trainData)
%% resamples the training set to get a smaller data sets that contains sufficient examples of labels
% input : training set :1 by 4 cell where each cell contains examples of
% each category

boy=trainData{1};
girl=trainData{2};
men=trainData{3};
women=trainData{4};


%% number of speakers in each category
numOfBoyspeakers = length(boy)/9;
numOfGirlspeakers = length(girl)/9;
numOfMenspeakers = length(men)/9;
numOfWomenspeakers = length(women)/9;


bindice= randomspeakers(numOfBoyspeakers,6);
gindices= randomspeakers(numOfGirlspeakers,6);
mindices=randomspeakers(numOfMenspeakers,11);
winidces= randomspeakers(numOfWomenspeakers,11);


data{1}=resample(boy,bindice);
data{2}=resample(girl,gindices);
data{3}=resample(men,mindices);
data{4}= resample(women,winidces);


function indices = randomspeakers(numSize,numR)
    %% randomly chooses numR speakers from numSize speakers
indices = zeros(1,numR);
count=0;
while count < numR
    rng('shuffle');
    num= fix(rand() * numSize);
    if sum(indices==num)==0
        count=count+1;
        indices(count)=num;
    end
end
end

    function  dataN= resample(data,indices)
        %% resample the data by limiting the number of speakers
        count=1;
        for i=1 :length(indices)
            index=indices(i);
            dataN(count:count+8) = data(index:index+8);
            count=count+9;
        end
    end
end
        
  
