function DATA_ALL= read_data(data_type)
if strcmp(data_type,'tidigits')
        pathname='/group/corpora/public/tidigits/tidigits/train/';
        dir ={'/boy' , '/girl', '/man', '/woman'};
        
         for   i=1 : length(dir) 
              path =strcat(pathname ,dir{i});
              %list the sub directories
              dir_data =ls(path);
              %parse the output
              dir_data=dir_data(find(isletter(dir_data)));
              x=1;
              for c=1:2:length(dir_data)
                  datadir{x}=  [dir_data(c)  dir_data(c+1)];
                   x=x+1;
              end
              dir_data=datadir;
              DATA=cell(length(dir_data),9,2);
             for j=1 : length(dir_data)
                    datapath=[path '/' dir_data{j} ];
                    data ={'1','2','3','4','5','6','7','8','9'};
                    for k=1:length(data)
                        samplepath1= [ datapath '/' data{k} 'a.wav'];
                        samplepath2= [ datapath '/' data{k} 'b.wav'];
                                         DATA{j,k,1}=readnist(samplepath1);
                                         DATA{j,k,2}=readnist(samplepath2);
                    end
               end
               DATA_ALL{i}=DATA;          
          end
end
end
         
 
        
    