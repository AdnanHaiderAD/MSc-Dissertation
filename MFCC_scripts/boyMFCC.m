load MFCCExpTest
boy=MFCC{1};
clear MFCC;
load MFFCTrainingSampled


output =DynamicTimeWarp(boy,MFCC);