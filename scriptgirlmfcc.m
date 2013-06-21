load MFCCExpTestwhiten
girl=MFCC{2};
clear MFCC
load MFCCExpTrainingwhiten
output =DynamicTimeWarp(girl(98:end),MFCC);
