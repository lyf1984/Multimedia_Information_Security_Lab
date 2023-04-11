function encode_sc=encode(sc,m,n)
rng(2,'twister'); %将种子设定为2，生成器为梅森旋转
rand_m = randi(100,m,n); %创建 1 到 100 之间的随机整数值数组

encode_sc = zeros(m,n);
for i=1:m
    for j=1:n
        %秘密图像与随机矩阵相加模2
        encode_sc(i,j) = mod(sc(i,j)+rand_m(i,j),2);
    end
end
end