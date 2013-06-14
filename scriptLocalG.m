load   Rawdata
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
else
    i=1;
    data=DATA{i};
    clear DATA
    save('iterator.mat','i')
    localGlobalfeatures =extractLocalGlobalFeat(data);
end