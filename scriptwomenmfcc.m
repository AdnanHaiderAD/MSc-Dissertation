load MFCCExpTestwhiten
women=MFCC{4};
clear MFCC
load MFCCExpTrainingwhiten
output =DynamicTimeWarp(women(69:end),MFCC);
