load MFCCExpTestwhiten
men=MFCC{3};
clear MFCC
load MFCCExpTrainingwhiten
output =DynamicTimeWarp(men(95:end),MFCC);
