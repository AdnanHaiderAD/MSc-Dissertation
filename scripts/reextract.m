function Data =reextract(data)
%%only keep samples from one production
boy =data{1};
girl= data{2};
men =data{3};
women=data{4};
clear data
boy= boy(2:2:end);
girl =girl(2:2:end);
men= men(2:2:end);
women=women(2:2:end);
Data=cell(1,4);
Data{1}=boy;
Data{2}=girl;
Data{3}=men;
Data{4}=women;
end
