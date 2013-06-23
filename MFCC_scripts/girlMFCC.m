load MFCCExpTest
girl=MFCC{2};
clear MFCC;
load MFFCTrainingSampled


output =DynamicTimeWarp(girl,MFCC);