function result = createdatamatrix2(data,max_length)
%% takes the raw  test data set that is partioned into categories creates a data matrix.
% output : datamatrix where the first column holds information about the
% classes

boy=data{1};
girl=data{2};
men=data{3};
women=data{4};

labels= zeros(length(boy)+length(girl)+length(men)+length(women),1);
datacell= cell (length(labels),1);
count=1;

function separatedata(cg_data)
%% separate lables and put all samples in one list
    for i =1 :length(cg_data)
         entry=cg_data{i};
        labels{count}= entry{1};
        datacell{count}=entry{2};
        count=count+1;
    end
end


separatedata(boy);
separatedata(girl);
separatedata(men);
separatedata(women);

%% intialise data matrix
result=zeros(length(labels),max_length+1);
result(:,1)=labels;

%% fill in matrix after recaling each sequence
for i=1 : length(datacell)
    sample=datacell{i};
    result(i,2:end) = resample(sample,max_length,length(sample));
end
end