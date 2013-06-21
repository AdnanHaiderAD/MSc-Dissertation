load RawdataCleanedExp
women=RawdataC{4};
clear RawdataC
load RawTrainingCleanedSamp
output =DynamicTimeWarp(women,RawdataC);
