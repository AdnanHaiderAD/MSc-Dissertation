load RawdataCleanedExp
men=RawdataC{3};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(men)/4);

output =DynamicTimeWarp(men(i+1:2*i),RawdataC);