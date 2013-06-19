function  createtestSubset()
load RawTestCleaned
boys =RawdataC{1};
girls=RawdataC{2};
men=RawdataC{3};
women=RawdataC{4};
clear RawdataC

[indicesboys boysEx] =extract(boys,162);
[indicesgirls girlsEx] =extract(girls,162);
[indicesmen menEx] =extract(men,326);
[indiceswomen womenEx] =extract(women,326);
RawdataC =cell(4,1);
RawdataC{1}=boysEx;
RawdataC{2}=girlsEx;
RawdataC{3}=menEx;
RawdataC{4}= womenEx;

% keeping a record of which samples were gathered using the information
% from indices
save('RawdataTestExp.mat','RawdataC','indicesboys','indicesgirls','indicesmen','indiceswomen')
clear

function [indices dataExtracted] = extract(data,sampleSize)
 indices= zeros(sampleSize,1);
 dataExtracted = cell(sampleSize,1);
 rand('seed',12345)
 count=1;
 %to prevent looping forever to get unique number
 loop=1;
 dataSize=length(data);
 while count<=sampleSize
     num=floor(rand*dataSize);
     if num==0
         num=1;
     end;
     if sum(indices==num)~=0
         loop=loop+1;
         if(loop>5)
             %if unique number not found after 5 iterations try this
             if (sum(indices==(num+1))==0 &&num~=dataSize)|| (sum(indices==(num-1))==0&&num~=1)
                 
                 loop=1;
                 indices(count)=num;
                 dataExtracted{count} =data{indices(count)};
                 count=count+1;
             end
         end
     
         continue;
         
             
     end
    loop=1;
    
    indices(count)=num;
    dataExtracted{count} =data{indices(count)};
    count=count+1;
 end
end
end