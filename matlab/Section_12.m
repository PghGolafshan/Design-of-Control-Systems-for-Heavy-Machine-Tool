clc

% Define the plant transfer function
num = [160000];
denum = [1,80,2400,32000,160000];
G_plant = tf(numerator, denominator); % T of sensitivity method

Uncer = 0.1
P = [denum(1)-Uncer*denum(1) , denum(1)+Uncer*denum(1);
    denum(2)-Uncer*denum(2) , denum(2)+Uncer*denum(2);
    denum(3)-Uncer*denum(3) , denum(3)+Uncer*denum(3);
    denum(4)-Uncer*denum(4) , denum(4)+Uncer*denum(4);
    ];

D1 =flip([P(1,1), P(2,1), P(3,2), P(4,2)]);
D2 =flip([P(1,2), P(2,2), P(3,1), P(4,1)]);
D3 =flip([P(1,2), P(2,1), P(3,1), P(4,2)]);
D4 =flip([P(1,1), P(2,2), P(3,2), P(4,1)]);

D = [D1;D2;D3;D4];

for i=1:4
    output = criteria(D(i,:),i);
    flag = output*flag;
end

% if flag==0
%     text = ['System Is Not Robust With K= ',num2str(k(j))];
%     disp(text)
% else
%     text = ['System Is! Robust With K= ',num2str(k(j))];
%     disp(text)
% end


function z = criteria(x,n)
z=1;
l=length(x);
if mod(l,2)==0
m=zeros(l,l/2);
[cols,rows]=size(m);
for i=1:rows
m(1,i)=x(1,(2*i)-1);
m(2,i)=x(1,(2*i));
end
else
m=zeros(l,(l+1)/2);
[cols,rows]=size(m);
for i=1:rows
m(1,i)=x(1,(2*i)-1);
end
for i=1:((l-1)/2)
m(2,i)=x(1,(2*i));
end
end
for j=3:cols
if m(j-1,1)==0
m(j-1,1)=0.001;
end
for i=1:rows-1
m(j,i)=(-1/m(j-1,1))*det([m(j-2,1) m(j-2,i+1);m(j-1,1) m(j-1,i+1)]);
end
end
Temp=sign(m);a=0;
for j=1:cols
a=a+Temp(j,1);
end
text1 = ['---> system ',num2str(n),' is stable <---'];
text2 = ['---> system ',num2str(n),' is not stable <----'];
if a==cols
    disp(text1)
else
    z=0;   
    disp(text2)
end
end
