load RawdataCleanedExp
men=RawdataC{3};
clear RawdataC
load ReducedCleanedRawTrain
i=fix(length(men)/4);

output =DynamicTimeWarp(men(2*i+1:3*i),RawdataC);