load ('orignalTestMFCCExp')
T1=MFCC{3};
if exist('iterator3.mat','file')==2
    load iterator3
    j=real(i)+1;
    i=i+5;
    i=real(i);
    if i>19
        i=19;
    end
    save('iterator3.mat','i')
    part=T1(j:i,:,:);
    clear T1 MFCC
    load ('MFCCtraining.mat')
    output = DynamicTimeWarp(part,MFCC);
    
    
else
    i =5;
    save('iterator3.mat','i');
    part=T1(1:i,:,:);
    clear T1 MFCC
    load ('MFCCtraining.mat')
    output = DynamicTimeWarp(part,MFCC);
end