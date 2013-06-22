load RawdataCleanedExp
women=RawdataC{4};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(women)/4);

output =DynamicTimeWarp(women(2*i+1:3*i),RawdataC);