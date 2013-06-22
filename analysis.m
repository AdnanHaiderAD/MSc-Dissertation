function accuracy = analysis(data)

boysR=data{1};
girlsR =data{2};
menR=data{3};
womenR=data{4};

resultb=extract(boysR);
sum(resultb)
resultg=extract(girlsR);
sum(resultg)
resultm=extract(menR);
sum(resultm)
resultwom=extract(womenR);
sum(resultwom)
accuracy= (sum(resultb) +sum(resultg)+sum(resultm)+sum(resultwom))/(length(resultb)+length(resultg)+length(resultm)+length(resultwom)) *100;

    function result =extract(dat)
        result=zeros(length(dat),1);
        for i=1 :length(dat)
            entry=dat{i};
            if entry{1}~=0 && entry{1}~=1
                entry{1}
            end
            result(i)=entry{1};
        end
    end
end