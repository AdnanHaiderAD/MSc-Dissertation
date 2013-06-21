load RawdataCleanedExp
men=RawdataC{3};
clear RawdataC
load  RawTrainingCleanedSamp
output =DynamicTimeWarp(men,RawdataC);
