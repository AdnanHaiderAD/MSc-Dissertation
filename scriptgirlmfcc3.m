load RawdataCleanedExp
girl=RawdataC{2};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(girl)/4);

output =DynamicTimeWarp(girl(2*i+1:3*i),RawdataC);