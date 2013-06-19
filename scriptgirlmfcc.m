load MFCCExpTest
girl=MFFC{2};
clear MFCC
load MFFCTrainingSampled
output =DynamicTimeWarp(girl,MFCC);
