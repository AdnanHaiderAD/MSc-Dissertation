load RawdataCleanedExp
boy=RawdataC{1};
clear RawdataC
load RawTrainingCleanedSamp
output =DynamicTimeWarp(boy,RawdataC);
