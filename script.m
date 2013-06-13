load ('MFCCtest.mat')
T1=MFCC{4};
if exist('iterator.mat','file')==2
    j=i+1;
    i=i+5;
    i=real(i);
    save('iterator.mat','i')
    part=T1(j:i,:,:);
    clear T1 MFCC
    load ('MFCCtraining.mat')
    output = DynamicTimeWarp(part,MFCC);
    
    
else
    i =5;
    save('iterator.mat','i');
    part=T1(1:i,:,:);
    clear T1 MFCC
    load ('MFCCtraining.mat')
    output = DynamicTimeWarp(part,MFCC);
end