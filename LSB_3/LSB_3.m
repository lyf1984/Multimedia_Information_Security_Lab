%加密隐写信息，替换所有最低位

clc%清除窗口

%载体图像
origin_img = imread("img.jpg");
img_gray = rgb2gray(origin_img);%转为灰度图
subplot(241),imshow((img_gray));title("原图")%显示原灰度图
%获取灰度图矩阵大小
[x,y] = size(img_gray);
%展示隐写前直方图
count = imhist(img_gray); %得到直方图计数
subplot(223); stem(0:20,count(1:21));title("隐写前");

%隐写图像
secret_img = imread("SC.png");
secret_gray = rgb2gray(secret_img);
%裁剪隐写图像尺寸
secret_gray = imresize(secret_gray,[x,y]);
%转换为二值
secret_binary = imbinarize(secret_gray,0.8);
%展示隐写图像
subplot(242),imshow(secret_binary);title("隐写信息")
%灰度图矩阵大小
[m,n] = size(secret_gray);

%加密隐写图像
secret_binary = encode(secret_binary,m,n);

%插入隐写信息
for i = 1:x;
    for j = 1:y;
        %减去最低位
        low = mod(img_gray(i,j),2);
        img_gray(i,j) = img_gray(i,j) - low;
        %最低位替换为隐写信息
        img_gray(i,j) = img_gray(i,j) + uint8(secret_binary(i,j));
    end
end
%显示隐写后图像
subplot(243),imshow(img_gray);title("隐写后")

%提取隐写信息
secret_binary = zeros(m,n);
pos = 0;
for i = 1:x
    for j = 1:y
        secret_binary(i,j) = mod(img_gray(i,j),2);
    end
end

%解密提取的信息
secret_binary = decode(secret_binary,m,n);
%显示提取的信息
subplot(244),imshow(secret_binary);title("提取的信息");

%展示隐写后局部直方图
count = imhist(img_gray); %得到直方图计数
subplot(224); stem(0:20,count(1:21));title("隐写后");

%计算隐写可能性
p = prb(img_gray);
if(p>0.8)
    disp("图像被隐写");
else
    disp("没有被隐写");
end


