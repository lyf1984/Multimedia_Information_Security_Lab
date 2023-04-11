%随机选取最低位

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
secret_img = imread("secret.png");
secret_gray = rgb2gray(secret_img);%转为灰度图
secret_binary = imbinarize(secret_gray,0.8);%转为二值图
subplot(242),imshow(secret_binary);title("隐写信息")
%灰度图矩阵大小
[m,n] = size(secret_gray);

%插入隐写信息
rng(1,'twister'); %将种子设定为1，生成器为梅森旋转
max = int16((x*y)/(m*n));%获取最大步长
rd = randi(max,m,n); %创建 1 到 10 之间的随机整数值数组
pos = 0;%初始位置
for i = 1:m;
    for j = 1:n;
        pos = pos + rd(i,j);
        a = ceil(pos/x);%获取行数
        b = int16(mod(pos,y));%获取列数
        %最后一列
        if b == 0
            b = y;
            a = a-1;
        end
        %减去最低位
        low = mod(img_gray(a,b),2);
        img_gray(a,b) = img_gray(a,b) - low;
        %最低位替换为隐写信息
        img_gray(a,b) = img_gray(a,b) + uint8(secret_binary(i,j));
    end
end
%显示隐写后图像
subplot(243),imshow(img_gray);title("隐写后")

%提取隐写信息
decode = zeros(m,n);
pos = 0;
for i = 1:m;
    for j = 1:n;
        pos = pos + rd(i,j);
        a = ceil(pos/x);%获取行数
        b = int16(mod(pos,y));%获取列数
        %最后一列
        if b == 0
            b = y;
            a = a-1;
        end
        decode(i,j) = mod(img_gray(a,b),2);
    end
end
%显示提取的信息
subplot(244),imshow(decode);title("提取的信息");

%展示隐写后局部直方图
count = imhist(img_gray); %得到直方图计数
subplot(224); stem(0:20,count(1:21));title("隐写后");
