function v = hardLimitFun(x, w)
    
    v = x'*w;
    ind = find(v>0);
    v(ind) = 1;
    ind = find(v<=0);
    v(ind) = -1;

end