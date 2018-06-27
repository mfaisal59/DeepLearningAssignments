function a = computeCost1( im, l, w )
    a = 0;
        h = sigmoid(im' * w);
        if l == 1
            a = a + log(h);
        else
            a = a + log(1 - h);
        end


end