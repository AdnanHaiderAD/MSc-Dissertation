function [MisClassCount ,Counter,Accuracy]=  analysis(data,refdata)
%%  gives the accuracy along with the misscalssification and accuracy in the class breakdown 
count=0;
MisClassCount =zeros(9,1);
Counter=zeros(9,1);
length(refdata)
for i=1:length(refdata)
    entry =refdata{i};
    class =entry{1};
    if isempty(data{i})
        continue;
    else
     
        outentry=data{i};
        Counter(class)=Counter(class)+1;
        
        if outentry{1}
            count=count+1;
            %%records the number of misclassifications seen for the class so
            %far
            
            MisClassCount(class)=MisClassCount(class)+1;
        end
    end
end

%% misclassification rate
Accuracy= 100-count/sum(Counter)*100;
Counter=Counter-MisClassCount;



end
