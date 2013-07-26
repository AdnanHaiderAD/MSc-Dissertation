function output = patternmatch(test,train)

%% performs 1 nearest neighbour match after mapping the istance to principal subspace
tic

test_labels=test(:,1);
testData=test(:,2:end);

train_labels=train(:,1);

%% the data is now N by D matrix
trainData=train(:,2:end);

fingerprintSpace = principalcomponents(trainData);


%% projection to principal subspace
trainDataR= (fingerprintSpace'* trainData')';
testDataR= (fingerprintSpace'* testData')';
output=zeros(1,length(test_labels));


%%perform 1 nearest neighbour
for i=1 :length(test_labels)
    match =nearest_neighbours(testDataR(i,:),trainDataR,train_labels);
    if match ==test_labels(i)
        output(i)=1;
    end
    
end


function match= nearest_neighbours(sample,data,train_labels)
%% conducts 1 nearest neigbour search.
    [samp, dim]= size(data);
    nearestN=NaN;
    min_dist=Inf;
    for j=1 :samp
        dist= sum ((sample-data(j,:)).^2);
        if dist<min_dist
            nearestN = train_labels(j);
            min_dist=dist;
        end
    end
    match =nearestN;
end
toc
end
    
    
    
  

