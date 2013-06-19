load MFCCExpTest
women=MFFC{4};
clear MFCC
load MFFCTrainingSampled
output =DynamicTimeWarp(women,MFCC);
