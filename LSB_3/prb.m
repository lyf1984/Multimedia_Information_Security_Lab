%卡方
function p=prb(img_gray)
count = imhist(img_gray);
length = size(count);
num = floor(length/2);
r=0;%记录卡方统计量
k=0;
for i=1:num
    if(count(2*i-1)+count(2*i))~=0
        r=r+(count(2*i-1)-count(2*i))^2/(2*(count(2*i-1)+count(2*i)));
        k = k+1;
    end
end
p = 1-chi2cdf(r,k-1);
end