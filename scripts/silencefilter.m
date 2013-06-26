function outputSignal=silencefilter(signal)
%%detects and removes segments of silence
threshold=0;

if max(signal)>4000
    threshold=60;
end
    
if threshold==0 && max(signal)>3000
    threshold = 50;
end
    
if threshold==0 && max(signal)>2000
    threshold=40;
end

if threshold==0
    threshold=30;
    
end
    outputSignal=signal(abs(signal)>threshold) ;
end