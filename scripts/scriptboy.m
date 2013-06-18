load ('orignalTestMFCCExp')
T1=MFCC{1};
if exist('iterator1.mat','file')==2
    load iterator1
    j=real(i)+1;
    i=i+5;
    i=real(i);
    if i>9
        i=9
    end
    save('iterator1.mat','i')
    part=T1(j:i,:,:);
    clear T1 MFCC
    load MFCCTraining
    output = DynamicTimeWarp(part,MFCC);
    
    
else
    i =5
    save('iterator1.mat','i');
    part=T1(1:i,:,:);
    clear T1 MFCC
    load MFCCTraining
    output = DynamicTimeWarp(part,MFCC);
end