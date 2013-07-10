function [ accuracy] = analysis(varagin)
%% computes the accuracy and also gives the number of samples classified and missclassifed on the class level

if length(varagin)==2
    
else
    
    output=varagin;
    
    count=0;
    
    for i =1:length(output)
        if output{i}
            count=count+1;
        end
    end
    accuracy = 100-count/length(output(~cellfun('isempty',output)))*100;
end
end