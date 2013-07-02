function LocGLo =extractLocalGlobalFeat(data)

%% extracts Local and Global features. 
%data: The raw training/test set
%LocGLo: data is 4 by 1 cell where each cell represents data corresponding to
%extracted local+global features from a particular category.
boy = data{1};
girl=data{2};
men= data{3};
women=data{4};

LocGLoDataboy =extract(boy);
LocGLoDatagirl=extract(girl);
LocGLoDatamen = extract(men);
LocGLoDatawomen =extract(women);

LocGLo{1} =LocGLoDataboy;
LocGLo{2} =LocGLoDatagirl;
LocGLo{3} =LocGLoDatamen;
LocGLo{4} =LocGLoDatawomen;

function  locGLo =extract(data)
 %% extracts local+global features
locGLo=cell(length(data),1);
for i=1:length(data)
    entry =data{i};
    class=entry{1};
    dataPoint = entry{2};
    localFeat = zeros(length(dataPoint)-2,2);
    globalFeat = zeros(length(dataPoint)-2,2);
    
    %% extracting local and global features seperately
    for j=2:length(dataPoint)-1
        % computing global feature
        offsetL=(sum(dataPoint(1:j-1)))/(j-1);
        offsetR= (sum(dataPoint(j+1:end)))/(length(dataPoint)-j);
        globalFeat(j-1,:)= [(dataPoint(j)-offsetL) (dataPoint(j)-offsetR)];
        %computing the local feature
        localFeat(j-1,:) =[ (dataPoint(j) -dataPoint(j-1))  (dataPoint(j)- dataPoint(j+1))];
    end
    featMatrix =[localFeat globalFeat];
    clear entry dataPoint
   
    entry{1} =class;
    entry{2} = featMatrix;
    locGLo{i} =entry;
    
end

end
end
    
        
    




                