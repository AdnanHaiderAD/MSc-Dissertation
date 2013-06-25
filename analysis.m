function [indVaccuracy,accuracy]=  analysis(data,refdata)
%%plot an histogram  and a grapgh
%the histogram corresponds to the number of in-correct 
% classifications performed by the algorithm for each class
%The graph correpsponds to the accuracy
count=0;
MisClassCount =zeros(9,1);
Counter=zeros(9,1);

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
            histogram(count)=class;
            MisClassCount(class)=MisClassCount(class)+1;
        end
    end
end

%% misclassification rate
figure(1)

hist(histogram,[1:9]);
h = findobj(gca,'Type','patch');
set(h,'FaceColor',[1 0.5 0],'EdgeColor','w')
xlabel('Classes'); 
ylabel('Number of Mis-Classifications'); 
 title('Results for the women category');

%%accuracy
output= MisClassCount./Counter*100;
indVaccuracy = 100*ones(9,1) -output;
accuracy =100-count/sum(Counter) *100;

end
