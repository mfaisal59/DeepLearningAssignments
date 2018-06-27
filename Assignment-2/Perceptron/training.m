function [ w ] = training( new_train_images, new_train_labels )
    
    totImages = size(new_train_images,2);
    imgSize = size(new_train_images,1);
    
    w = rand(imgSize,1)/10;
    
    classes = unique(new_train_labels);
    ind = find(new_train_labels == classes(1));
    new_train_labels(ind) = -1;
    ind = find(new_train_labels == classes(2));
    new_train_labels(ind) = 1;
    
    lb = zeros(totImages,1);
    lr = 0.001;
    
    avgErr = 0;
    minTrErr = 1;
    
    for it = 1 : 100
        
        up = 0;
        
        for i=1:totImages
            lb(i) = hardLimitFun(new_train_images(:,i), w);
            up = up + lr*0.5*(new_train_labels(i) - lb(i))*new_train_images(:,i);
        end
       
        w = w + up;
        
        er = numel(find(new_train_labels ~= lb))/numel(new_train_labels);
        disp(sprintf('%03d) Training Error: %02.3f',it, er));
        if er <= 0
            break;
        end
        
        if minTrErr>er
            minTrErr = er;
        end
        
        avgErr = avgErr + er;
    end
    
    disp(sprintf('\nMinimum Training Error: %02.3f', minTrErr));
    disp(sprintf('Average Training Error: %02.3f', avgErr/it));
end

