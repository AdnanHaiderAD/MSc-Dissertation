function [accuracy]=  analysis(data)
%%  gives the accuracy 

count=0; 
for i=1:length(data)
    entry=data{i};
    count=count+entry{1};
end

%% misclassification rate
accuracy= 100-count/length(data)*100;



end
