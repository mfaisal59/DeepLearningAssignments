function evaluation( gt, predictions )
    
    tp = 0;
    fp = 0;
    tn = 0;
    fn = 0;
    
    classes = unique(gt);
    
    for i = 1 : size(gt,1)
        if(gt(i)==predictions(i) && predictions(i) == classes(1))
            tp = tp + 1;
        elseif(gt(i)==predictions(i) && predictions(i) == classes(2))
            tn = tn + 1;
        elseif(gt(i)~=predictions(i) && predictions(i) == classes(2))
            fp = fp + 1;
        elseif(gt(i)~=predictions(i) && predictions(i) == classes(1))
            fn = fn + 1;
        end
    end
    
    precision = tp/(tp+fp);
    recall = tp/(tp+fn);
    accuracy = (tp+tn)/(tp+tn+fn+fp);
    
    disp(sprintf('\nTrue Positive: %d',tp));
    disp(sprintf('False Positive: %d',fp));
    disp(sprintf('True Negative: %d',tn));
    disp(sprintf('False Negative: %d',fn));
    disp(sprintf('Precision: %2.4f',precision));
    disp(sprintf('Recall: %2.4f',recall));
    disp(sprintf('Accuracy: %2.4f',accuracy));
end

