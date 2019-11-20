%3.1

mac = imread("maccropped.jpg")
mac = rgb2gray(mac)
imshow(mac)

c1 = [-1 -2 -1; 0 0 0; 1 2 1]
conv_1 = conv2(mac,c1)
imshow(uint8(conv_1))

c2 = [-1 0 1; -2 0 2; -1 0 1]
conv_2 = conv2(mac,c2)
imshow(uint8(conv_2))

squared = conv_1.^2 + conv_2.^2
imshow(squared,[])
%imshow(squared,[])is used to displays the grayscale image, scaling the display based on the range of pixel values in I. This is applied as the result of imshow(squared) is too bright to view the edges

E100 = squared>100  %threshold = 100
imshow(E100,[])
E1000 = squared>1000  %threshold = 1000
imshow(E1000,[])
E10000 = squared>10000  %threshold = 10000
imshow(E10000,[])
E100000 = squared>100000  %threshold = 100000
imshow(E100000,[])

E = edge(mac,'canny',[0.04 0.1],1)
imshow(E)
E = edge(mac,'canny',[0.04 0.1],2)
imshow(E)
E = edge(mac,'canny',[0.04 0.1],3)
imshow(E)
E = edge(mac,'canny',[0.04 0.1],4)
imshow(E)
E = edge(mac,'canny',[0.04 0.1],5)
imshow(E)

E = edge(mac,'canny',[0.01 0.1],3)
imshow(E)
E = edge(mac,'canny',[0.05 0.1],3)
imshow(E)
E = edge(mac,'canny',[0.09 0.1],3)
imshow(E)


%3.2

mac = imread("maccropped.jpg")
mac = rgb2gray(mac)
E = edge(mac,'canny',[0.04 0.1],1)

[H,xp] = radon(E)
imagesc(uint8(H))

[A,B] = pol2cart(104*pi/180,xp(157))
B = -B

% since the value of the E is 290*358 logical, the center of the image is [358/2, 290/2]=[179,145] (observed from graph that 179 is the x value while 145 is the y value)
C = A*(A+179)+B*(B+145)

yl = (C-A*0)/B
yr = (C-A*(358-1))/B

yl = (C-A*0)/B
yr = (C-A*(358-1))/B

%3.3

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

left = imread('corridorl.jpg')
left = rgb2gray(left)
imshow(left)

right = imread('corridorr.jpg')
right = rgb2gray(right)
imshow(right)

