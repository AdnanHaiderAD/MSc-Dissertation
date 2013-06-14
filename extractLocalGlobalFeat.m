function localGlobalfeatures =extractLocalGlobalFeat(data)
[regions classes versions] = size(data);
localGlobalfeatures =cell(regions,classes,versions,2);

for r=1 :regions
    for c=1 : classes
        for v=1:versions
            seq=data{r,c,v};
            len =length(seq);
            globalFeatures =zeros(len-2,2);
            localFeatures = zeros(len-2,2);
            for l=2:len-1
                globalFeatures(l-1,1)=seq(l)-sum(seq(1:l));
                globalFeatures(l-1,2)=seq(l)-sum(seq(l+1:end));
                localFeatures(l-1,1) =seq(l)-seq(l-1);
                localFeatures(l-1,2) =seq(l)-seq(l+1);
            end
            localGlobalfeatures{r,c,v,1}=globalFeatures;
            localGlobalfeatures{r,c,v,2}=localFeatures;
        end
    end
end
                