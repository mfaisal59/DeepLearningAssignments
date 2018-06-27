function [ L ] = testing( w, new_test_images )
    
    totImages = size(new_test_images,2);
    L = zeros(totImages,1);
    
    for i = 1 : totImages
        L(i) = hardLimitFun(new_test_images(:,i), w);
    end
end