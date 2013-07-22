function data = createdatamatrix(data)

%% takes the raw data that is partioned into categories and classes  and creates a data matrix.
% output : datamatrix where the first column holds information about the
% classes

[categories, classes, production] =size(data);

labels= zeros(categories*classes,1);

%%  1st task: make al sequences of the same length
maximum_length=-Inf;
for c=1 : categories
    for  i=1 : classes
        labels((c-1)*classes +i) =i;
        seqlen= length(data{c,i,1});
        if seqlen>maximum_length
            maximum_length= seqlen;
        end
    end
end
data= zeros ( categories*classes, maximum_length+1);
data(:,1)= labels;
 for c=1:categories 
     for i=1:classes
         sample=data{c,i,1};
         data((c-1)*classes+i,2:end)= resample(sample,maximum_length,length(sample));
     end
 end
end
