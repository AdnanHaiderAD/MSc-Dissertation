function output  = feature_extract(input)
%% extracts local and global features from the  UCR time series
%   the input is a matrix with each row denoting a time series 
[num dim]= size(input);
output= cell(num,1);

for i=1 : num
    localFeat = zeros(dim-2,2);
    globalFeat = zeros(dim-2,2);
    for j=2:dim-1
        %% computing global features
        offsetL=(sum(input(i,1:j-1)))/(j-1);
        offsetR=(sum(input(i,j+1:end)))/(dim-j) ;
        globalFeat(j-1,:)= [(input(i,j)-offsetL) (input(i,j)-offsetR)];
        %% computing the local feature
        localFeat(j-1,:) =[ (input(i,j) -input(i,j-1))  (input(i,j)- input(i,j+1))];
        
    end
    output{i}= [localFeat globalFeat];
end
end

