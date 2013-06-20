load MFCCExpTest
men=MFCC{3};
clear MFCC
load MFFCTrainingSampled
output =DynamicTimeWarp(men(183:184),MFCC);
