load RawdataCleanedExp
boy=RawdataC{1};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(boy)/4);

output =DynamicTimeWarp(boy(3*i+1:end),RawdataC);