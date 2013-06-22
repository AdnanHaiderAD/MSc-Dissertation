load RawdataCleanedExp
women=RawdataC{4};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(women)/4);

output =DynamicTimeWarp(women(i+1:2*i),RawdataC);