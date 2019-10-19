%Q2.1 code:


Pc = imread('mrt-train.jpg');
whos Pc

P = rgb2gray(Pc);
whos P

imshow(P)
min(P(:)),max(P(:))

P_sub = imsubtract(P(:,:),13);
min(P_sub(:)),max(P_sub(:))

P_scaled = immultiply(P_sub(:,:),255/191);
min(P_scaled(:)),max(P_scaled(:))

imshow(P_scaled)


%Q2.2 code:

imhist(P,10)
imhist(P,256)

P3 = histeq(P,255);

imhist(P3,10)
imhist(P3,256)

P4 = histeq(P3,255);

imhist(P4,10)
imhist(P4,256)

%Q2.3 code

a1 = fspecial('gaussian',[5,5],1);
figure,mesh(a1)
a2 = fspecial('gaussian',[5,5],2);
figure,mesh(a2)

ntugn = imread('ntugn.jpg');
imshow(ntugn)

c1 = conv2(ntugn,a1);
imshow(uint8(c1))

c2 = conv2(ntugn,a2);
imshow(uint8(c2))

ntusp = imread('ntusp.jpg');
imshow(ntusp)

e1 = conv2(ntusp,a1);
imshow(uint8(e1))

e2 = conv2(ntusp,a2);
imshow(uint8(e2))


%Q2.4 code

a1 = fspecial('gaussian',[5,5],1);
figure,mesh(a1)

a2 = fspecial('gaussian',[5,5],2);
figure,mesh(a2)

ntugn = imread('ntugn.jpg');
imshow(ntugn)

c1 = medfilt2(ntugn,[3,3]);
imshow(c1)

c2 = medfilt2(ntugn,[5,5]);
imshow(c2)

ntusp = imread('ntusp.jpg');
imshow(ntusp)

e1 = medfilt2(ntusp,[3,3]);
imshow(e1)

e2 = medfilt2(ntusp,[5,5]);
imshow(e2)


%Q2.5 code

pckint = imread('pckint.jpg');
F = fft2(pckint);
S= abs(F);
imagesc(S.^0.1)
colormap('default')
F(239:243,7:11)=0;
F(15:19,247:251)=0;
S= abs(F);
imagesc(fftshift(S.^0.1))
colormap('default')

e5 = uint8(ifft2(F));
imshow(e5)

fence = imread('primatecaged.jpg');
fence = rgb2gray(fence);
imshow(fence)
F = fft2(fence);
S = abs(F);
imagesc(S.^0000.1)
colormap('default')

F(250:254,9:13)=0;
F(7:11,236:240)=0;
F(19:23,246:250)=0;
F(4:8,246:250)=0;
F(246:250,20:24)=0;

S=abs(F);
imagesc(S.^0.1)
colormap('default')

removed = uint8(ifft2(F));
imshow(removed)


%Q2.6 code:

book = imread('book.jpg')
imshow(book);

[x,y] = ginput(4);

x_desired = [0,210,210,0];
y_desired = [0,0,297,297];


A =[[x(1),y(1),1,0,0,0,-x_desired(1)*x(1),-x_desired(1)*y(1)];
    [0,0,0,x(1),y(1),1,-y_desired(1)*x(1),-y_desired(1)*y(1)];
    [x(2),y(2),1,0,0,0,-x_desired(2)*x(2),-x_desired(2)*y(2)];
    [0,0,0,x(2),y(2),1,-y_desired(2)*x(2),-y_desired(2)*y(2)];
    [x(3),y(3),1,0,0,0,-x_desired(3)*x(3),-x_desired(3)*y(3)];
    [0,0,0,x(3),y(3),1,-y_desired(3)*x(3),-y_desired(3)*y(3)];
    [x(4),y(4),1,0,0,0,-x_desired(4)*x(4),-x_desired(4)*y(4)];
    [0,0,0,x(4),y(4),1,-y_desired(4)*x(4),-y_desired(4)*y(4)];];

v = [x_desired(1);y_desired(1);x_desired(2);y_desired(2);x_desired(3);y_desired(3);x_desired(4);y_desired(4)];
u =A\v;

U =reshape([u;1],3,3)';

w = U*[x'; y'; ones(1,4)];
w = w ./ (ones(3,1) * w(3,:)) ;

T = maketform('projective', U');
book2 = imtransform(book, T, 'XData', [0 210], 'YData', [0 297]); 

imshow(book2)






