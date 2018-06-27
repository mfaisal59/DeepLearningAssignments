function [ L ] = classifier( new_test_images, w )

    nTest = size(new_test_images,2);
    L = zeros(nTest,1);
    
    for i = 1:nTest
        sigm = sigmoid(new_test_images(:,i)' * w);
        if sigm > 0.5
            L(i) = 1;
        else
            L(i) = 0;
        end
    end

end