function [ Ws, Bs ] = trainSVM(train_images, train_labels)
    
    classes = unique(train_labels);
    num_classes = length(classes);
    
    num_train_images = size(train_images,2);
    dim = size(train_images,1);
    
    Ws = zeros(num_classes, dim);
    Bs = zeros(num_classes, 1);
    
    LAMBDA = 0.001;
    
    
    for ii=1:num_classes
        labels = ones(num_train_images,1).*-1;
        labels(classes(ii) == train_labels) = 1;
        [W, B] = vl_svmtrain(train_images, labels, LAMBDA, 'MaxNumIterations', 10/LAMBDA);
        Ws(ii,:) = W';
        Bs(ii) = B;
    end
end

