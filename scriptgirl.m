load ('orignalTestExp')
T1=Y{2};
if exist('iterator2.mat','file')==2
    j=real(i)+1;
    i=i+5;
    i=real(i);
    if i>9
        i=9;
    end
    save('iterator2.mat','i')
    part=T1(j:i,:,:);
    clear T1 Y
    load ('MFCCtraining.mat')
    output = DynamicTimeWarp(part,MFCC);
    
    
else
    i =5;
    save('iterator2.mat','i');
    part=T1(1:i,:,:);
    clear T1 MFCC
    load ('MFCCtraining.mat')
    output = DynamicTimeWarp(part,MFCC);
end