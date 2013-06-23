load RawdataCleanedExp
girl=RawdataC{2};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(girl)/4);

output =DynamicTimeWarp(girl(148:end),RawdataC);