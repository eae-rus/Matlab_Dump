%Программа подготовки данных для моделирования гистерезиса в Simulink
%Параметры трансформатора
w1=1; %Количество витков первичной обмотки
w2=10; %Количество витков вторичной обмотки
d1=0.065; %Внешний диаметр магнитопровода
d2=0.05; %Внутренний диаметр магнитопровода
h=0.025; %Высота магнитопровода

%Перерасчет кривой намагничивания
B=BH_s01(:,1);
H=BH_s01(:,2);
I=H*2*pi*((d1+d2)/4)/w1;
S=h*(d1-d2)/2;
Psi=B*S*w2;

%Вычисление параметров петли гистерезиса

sizeI=length(I);
for i=2:sizeI
   if (I(i-1)<0)&&(I(i)>0)
      a=(Psi(i)-Psi(i-1))/(I(i)-I(i-1)); 
      b=Psi(i)-a*I(i);
      break;
   end   
end

Fr=abs(b); %Remsnent flux
Fs2=max(Psi); %Saturation flux
Fs1=1.66e-3;
Is2=max(I); %Saturation current
Is1=0.5;

sizePsi=length(Psi);
for i=2:sizePsi
   if (Psi(i-1)<0)&&(Psi(i)>0)
      a=(I(i)-I(i-1))/(Psi(i)-Psi(i-1)); 
      b=I(i)-a*Psi(i);
      break;
   end   
end

Ic=b; %Coercive current
dFdI=(Psi(i-1)-Psi(i))/(I(i-1)-I(i)); %dF/dI at coercive current

%Построение области насыщения
X1=Is1;
Y1=Fs1;
X2=Is2;
Y2=Fs2;
X3=[0.8 1e15];
a=(Y2-Y1)/(X2-X1);
b=Y1-a*X1;
Y3=a*X3+b;






