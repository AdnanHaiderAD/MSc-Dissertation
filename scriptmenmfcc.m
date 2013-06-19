load MFCCExpTest
men=MFFC{3};
clear MFCC
load MFFCTrainingSampled
output =DynamicTimeWarp(men,MFCC);
