function MFCC = extractMFCC(data)
%% extracts MFCC features. 
%data: The raw training/test set
%MFCC: data is 4 by 1 cell where each cell represents data corresponding to a gender
MFCC= cell(4,1);
boy = data{1};
girl=data{2};
men= data{3};
women=data{4};

MFCCDataboy =extract(boy);
MFCCDatagirl=extract(girl);
MFCCDatamen = extract(men);
MFCCDatawomen =extract(women);

MFCC{1} =MFCCDataboy;
MFCC{2} =MFCCDatagirl;
MFCC{3} =MFCCDatamen;
MFCC{4} =MFCCDatawomen;

    function MFCC_data =extract(data)
        %%extracts MFCC vectors from raw samples belonging to the data set
        %of a single category(Eg:boy)
        MFCC_data=cell(length(data),1);
        for i=1 :length(data)
            entry=data{i};
            entry{2} =melfcc(entry{2});
            MFCC_data{i} = entry;
        end
    end
    
   
end
