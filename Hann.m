%% �������� ������� �������� ���� � ������ ������������ �����������
NN=256*kol_period;
w=0;
ww=0;
%%����
%%for n=1:NN            % ���� �� 1 �� ����� N 
%%    w(n,1)=0.5*(1-cos(2*pi*n/NN))*xt(n);
%%    ww=ww+0.5*(1-cos(2*pi*n/NN));
%%end  

%%������
for n=1:NN            % ���� �� 1 �� ����� N 
    w(n,1)=(0.54-0.46*cos((2*n*pi)/(NN-1)))*xt(n);
    ww=ww+(0.54-0.46*cos((2*n*pi)/(NN-1)));
end  