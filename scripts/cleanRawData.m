function RawdataC =cleanRawData(data)
%% passes filterSignal to each time-series data. `data' is cell where each entry contains samples of a specific gender.
boy = data{1};
girl=data{2};
men= data{3};
women=data{4};

CleanDataboy =cleanData(boy);
CleanDatagirl=cleanData(girl);
CleanDatamen = cleanData(men);
CleanDatawomen =cleanData(women);

RawdataC{1}=CleanDataboy;
RawdataC{2}=CleanDatagirl;

RawdataC{3}=CleanDatamen;
RawdataC{4}=CleanDatawomen;

function dataCleaned = cleanData(data)
%% applies the filter to samples of a given category(boy,girl,men,women).
[speakers classes versions] =size(data);
dataCleaned =cell(speakers*classes*versions,1);
count=1;
for s=1:speakers
    for c=1:classes
        for v=1:versions
            %% removes silence and performs subsampling on the result
            %Cleaned=filterSignal(data{s,c,v});
           %% removes silence
            Cleaned =silencefilter(data{s,c,v});
            %%
            entry ={c, Cleaned};
            clear Cleaned
            dataCleaned{count}= entry;
            count=count+1;
        end
    end
end
end
    
end


