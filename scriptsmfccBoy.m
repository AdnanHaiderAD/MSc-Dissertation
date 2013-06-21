load MFCCExpTestwhiten
boy=MFCC{1};
clear MFCC
load MFCCExpTrainingwhiten
output =DynamicTimeWarp(boy(61:end),MFCC);
