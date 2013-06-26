function [Rawdata, indicesboys,indicesgirls,indicesmen,indiceswomen]= createtestSubset(RawdataC)
%% subsamples the test set using a random generator, The algorithm is 
%designed to ensure we have enough sufficient samples from all classes.

boys =RawdataC{1};
girls=RawdataC{2};
men=RawdataC{3};
women=RawdataC{4};
clear RawdataC

[indicesboys boysEx] =extract(boys,162);
[indicesgirls girlsEx] =extract(girls,162);
[indicesmen menEx] =extract(men,326);
[indiceswomen womenEx] =extract(women,326);

%%subsampled data
Rawdata=cell(4,1);
Rawdata{1}=boysEx;
Rawdata{2}=girlsEx;
Rawdata{3}=menEx;
Rawdata{4}= womenEx;



function [indices dataExtracted] = extract(data,sampleSize)
    %% indices: keeping a record of which samples were gathered using the information
    % dataExtracted: sampled data
 indices= zeros(sampleSize,1);
 dataExtracted = cell(sampleSize,1);
 rand('twister',5489)
 count=1;
 loop=1; 
 dataSize=length(data);
 

 while count<=sampleSize
     %% Picks a random sample 
     num=floor(rand*dataSize);
     if num==0
         num=1;
     end;
     %%check to see whether this samples has already been included
     if sum(indices==num)~=0 
         loop=loop+1;
        %% if no unique samples have been after 5 iterations
         if(loop>5)
            %% Possible fix
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
