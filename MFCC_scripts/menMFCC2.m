load MFCCExpTest
men=MFCC{3};
clear MFCC;
load MFFCTrainingSampled


output =DynamicTimeWarp(men(66:169),MFCC);