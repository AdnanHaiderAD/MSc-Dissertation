load RawdataCleanedExp
girl=RawdataC{2};
clear RawdataC
load RawTrainingCleanedSamp
output =DynamicTimeWarp(girl,RawdataC);
