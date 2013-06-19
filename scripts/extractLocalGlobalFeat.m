function LocGlob =extractLocalGlobalFeat(data)
% alternative to MFCC, extracts local +global features from the tim-series
% data.

tic

LocGlob= cell(1,4);
boy = data{1};
girl=data{2};
men= data{3};
women=data{4};

LocGLoDataboy =extractLG(boy);
LocGLoDatagirl=extractLG(girl);
LocGLoDatamen = extractLG(men);
LocGLoDatawomen =extractLG(women);

LocGlob{1} =LocGLoDataboy;
LocGlob{2} =LocGLoDatagirl;
LocGlob{3} =LocGLoDatamen;
LocGlob{4} =LocGLoDatawomen;

function  localGLo =extractLG(data)

localGLo=cell(length(data),1);
for i=1:length(data)
    entry =data{i};
    class=entry{1};
    dataPoint = entry{2};
    localFeat = zeros(2,length(dataPoint)-2);
    globalFeat = zeros(2,length(dataPoint)-2);
    for j=2:length(dataPoint)-1
        globalFeat(:,j-1)= [(dataPoint(j)-sum(dataPoint(1:j-1))) (dataPoint(j)-sum(dataPoint(j+1:end)))];
        localFeat(:,j-1) =[ (dataPoint(j) -dataPoint(j-1))  (dataPoint(j)- dataPoint(j+1))];
    end
    new_data =cell(2,1);
    new_data{1}=localFeat;
    new_data{2}=globalFeat;
    clear entry dataPoint
    entry = cell(2,1);
    entry{1} =class;
    entry{2} = new_data;
    localGLo{i} =entry;
    
    if toc>300
       toc
       tic
    end
end
end
end
    
        
    




                