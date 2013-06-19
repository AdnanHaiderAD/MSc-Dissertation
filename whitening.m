function [Eigenmatrix mu]= whitening()
load MFCCExpTest
boys=MFCC{1};
girls=MFCC{2};
men= MFCC{3};
women=MFCC{4};
%for MFCCs ,data has dim 13
clear MFCC
Data= pack(boys);
Data = [Data pack(girls)];
Data =[Data pack(men)];
Data =[Data pack(women)];

load  MFFCTrainingSampled
boys=MFCC{1};
girls=MFCC{2};
men= MFCC{3};
women=MFCC{4};
clear MFCC
%for MFCCs ,data has dim 13
Data= [Data pack(boys)];
Data = [Data pack(girls)];
Data =[Data pack(men)];
Data =[Data pack(women)];

[U,S,V] = svd(Data*Data');

Eigenmatrix =U';
size(Data)
mu= mean(Data');



    function Data = pack(data)
        entr =data{1};
        Data = entr{2};
        for i=2 :length(data)
            entry =data{i};
            vectors =entry{2};
            Data =[Data vectors];
        end
    end
            
end           
