function disparity_map = map(left,right,d1,d2)
    half_d1 = floor(d1/2);
    half_d2 = floor(d2/2);
    
    [x1,y1]=size(left);
    [x2,y2]=size(right);
    
    for i = 1+half_d1:x1-half_d1
        for j = 1+half_d2:y1-half_d2
            cur_r = left(i-half_d1:i+half_d1, j-half_d2:j+half_d2);
            cur_l = rot90(cur_r,2);
            min_coor = j;
            min_diff = inf;
            
            for k =max(1+half_d2,j-14):j
                T = right(i-half_d1:i+half_d1,k-half_d2:k+half_d2);
                cur_r = rot90(T,2)
                
                conv_1 = conv2(T,cur_r);
                conv_2 = conv2(T,cur_l);
                
                ssd = conv_1(d1,d2)-2*conv_2(d1,d2);
                if ssd<min_diff
                    min_diff = ssd;
                    min_coor =k;
                end
            end
            
            disparity(i-half_d1,j-half_d2) = j-min_coor;
            
        end
    end
end
