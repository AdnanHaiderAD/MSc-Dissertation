function MFCC = extractMFCC(data)
% extratcs MFCC features. Output data is 1 by 4 cell where each cell represents data corresponding to a gender
MFCC= cell(1,4);
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
        [speakers classes versions]  = size(data);
        MFCC_data = cell (speakers*classes*versions,1);
        count=1;
        for s = 1 : speakers
            for c=1: classes
               for v=1:versions
                        mfcc=melfcc(data{s,c,v});
                        entry ={c, mfcc};
                        clear mfcc
                        MFCC_data{count}=entry;
                        count=count+1;
               end
                
            end
        end
    end
    
   
end
