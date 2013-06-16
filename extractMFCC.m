function MFCC = extractMFCC(DATA)
% extratcs MFCC features. Output data is 1 by 4 cell where each cell represents data corresponding to a gender
MFCC= cell(1,4);
for g=1: length(DATA)
    data= DATA{g};
    [sample_type number version]  = size(data);
    MFCC_data = cell (sample_type ,number,version);
    for i = 1 : sample_type
        for j=1: number
            for k=1:version
                MFCC_data{i,j,k}=melfcc(data{i,j,k});
            end
        end
    end
    
    MFCC{g}= MFCC_data;
end
end