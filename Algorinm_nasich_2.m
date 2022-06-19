function [ otvet ] = Algorinm_nasich_2( xtTT,xtPR,Nper,f )
%# otvet - ������� 2�2 ������ ������� ����������� ���������, ������ - ���������� ���������������
%# ������ ������� - ����� �� ������ ��������, ������ - ��������� ��� ���
%# 1 - ��, 0 - ���.
otvet = [0 0; 0 0];

%# ���������� ��������� ����������� �����
N=fix(Nper*1000/f*256/20);

%# ����� �������������� �������� �����, � ������������ � ���������
%��������������. ����� ���������, ��� ������ ��� ��������������, ������ �
%��������� �� ������������ ��� ����������
%xtTT=xtTT_signal(1:N);
%xtPR=xtPR_signal(1:N);

%# ���������� ������� � ��
Fft_TT=abs(fft(xtTT(1:N))*2/N);
Fft_TT(1)=Fft_TT(1)/2;

%# ������� ������� � % �� ������ ��������� (2 - 7)
spectrtrTT(1)=100;
for i=2:1:7
    spectrtrTT(i)= Fft_TT(1+Nper*i)/Fft_TT(1+Nper)*100;
end

%# ���������� ������� � ��
Fft_PR=abs(fft(xtPR(1:N))*2/N);
Fft_PR(1)=Fft_PR(1)/2;

%# ������� ������� � % �� ������ ��������� (2 - 7)
spectrtrPR(1)=100;
for i=2:1:7
    spectrtrPR(i)= Fft_PR(1+Nper*i)/Fft_PR(1+Nper)*100;
end

%# ������������� ��� � ��
for i=2:1:7
    spectrtrPR(i)=spectrtrPR(i)/i;
end


%# �������� ������ �� ������ �������� (�� ���������� ���������������)
if     (spectrtrTT(2)>0.986 && spectrtrTT(4)>0.85) || (spectrtrTT(2)>0.986 && spectrtrTT(6)>0.795) || (spectrtrTT(4)>0.85 && spectrtrTT(6)>0.795)
    if (spectrtrPR(2)>0.986 && spectrtrPR(4)>0.85) || (spectrtrPR(2)>0.986 && spectrtrPR(6)>0.795) || (spectrtrPR(4)>0.85 && spectrtrPR(6)>0.795)
    else
        otvet = [0 1; 0 1];
    end
%# �������� ������ �� ������ �������� (�� ������������� ���������)
elseif (spectrtrTT(3)>1.062 && spectrtrTT(5)>0.98) || (spectrtrTT(3)>1.062 && spectrtrTT(7)>0.959) || (spectrtrTT(5)>0.98 && spectrtrTT(7)>0.959)
    if (spectrtrPR(3)>1.062 && spectrtrPR(5)>0.98) || (spectrtrPR(3)>1.062 && spectrtrPR(7)>0.959) || (spectrtrPR(5)>0.98 && spectrtrPR(7)>0.959)
    else
        otvet = [1 0; 1 0];
    end
%# �������� �� ��������� (�� ���������� ���������������)
elseif spectrtrTT(2)>0.2
    if spectrtrPR(2)>0.2
    else
        otvet = [0 0; 0 1];
    end
%# �������� �� ��������� (�� ���������� ���������������)
elseif spectrtrTT(3)>0.4
    if spectrtrPR(3)>0.4
    else
        otvet = [0 0; 1 0];
    end
end

end