load MFCCExpTest
boy=MFFC{1};
clear MFCC
load MFFCTrainingSampled
output =DynamicTimeWarp(boy,MFCC);
