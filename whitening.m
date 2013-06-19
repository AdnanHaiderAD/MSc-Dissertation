function  whitening()
tic

% PACKING ALL The data into one matrix
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


%Perform SVD

[U,S,V] = svd(Data*Data');

%computing the eigenvectors and the mean
Eigenmatrix =S\ U';
mu= mean(Data,2);

%de-correlating the data
load MFCCExpTest
boys=MFCC{1};
girls=MFCC{2};
men= MFCC{3};
women=MFCC{4};
clear MFCC
boys= decorrelate(Eigenmatrix,mu,boys);
girls=decorrelate(Eigenmatrix,mu,girls);
men=decorrelate(Eigenmatrix,mu,men);
women=decorrelate(Eigenmatrix,mu,women);
MFCC{1} =boys;
MFCC{2}=girls;
MFCC{3}=men;
MFCC{4}=women;
save('MFCCExpTestwhiten.mat','MFCC')
clear MFCC

load MFFCTrainingSampled
boys=MFCC{1};
girls=MFCC{2};
men= MFCC{3};
women=MFCC{4};
clear MFFC
boys= decorrelate(Eigenmatrix,mu,boys);
girls=decorrelate(Eigenmatrix,mu,girls);
men=decorrelate(Eigenmatrix,mu,men);
women=decorrelate(Eigenmatrix,mu,women);
MFCC{1} =boys;
MFCC{2}=girls;
MFCC{3}=men;
MFCC{4}=women;
save('MFCCExpTrainingwhiten.mat','MFCC')
clear MFCC

toc
    function decordata = decorrelate(eigenmatrix,mu,data)
        decordata=cell(length(data),1);
        for i =1:length(data)
            entry =data{i};
            [dim num]=size(entry{2});
            entry{2} =  eigenmatrix* (entry{2} - repmat(mu,1,num));
            decordata{i}=entry;
        end
    end


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
