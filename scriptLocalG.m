
%script that extracts local and global features from the entire training time series data set 
load   RawdataTest
DATA=Y;
if exist('iterator.mat','file')==2
    i= real(i)+1;
    if i>4
        break
    end
    data=DATA{i};
    clear DATA
    save('iterator.mat','i')
    localGlobalfeatures =extractLocalGlobalFeat(data);
    [L,host]= unix('hostname');
    filename = strcat('output',host,'.mat');
    save (filename,'localGlobalfeatures');              

else
    i=1;
    data=DATA{i};
    clear DATA
    save('iterator.mat','i')
    localGlobalfeatures =extractLocalGlobalFeat(data);
    [L,host]= unix('hostname');
    filename = strcat('output',host,'.mat');
    save (filename,'localGlobalfeatures');    
end