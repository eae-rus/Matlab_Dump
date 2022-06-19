% �������� � 4 ��� ������ ������� � �������� ��������� �������: ������
% ������� � �������� ��������� ������� ��� ����������� �������� ����.
%
% ��������: IEEE Std C37.118.1a-2014 �IEEE Standard for Synchrophasor
% Measurements for Power Systems�, Amendment 1: Modification of Selected
% Performance Requirements.
%
% !!! ������ ����������.
%
% ����� ������������ ����������� ���������, � ������ - �������������
% "����������" ������� ���� ������������� � ������� ������� �����������
% �������� ������ "N/2-1" ��� "N/2" (��. ����).



function [ F, DF ] = Algorithm_4_UPDATE ( Sig, N, dt )

% ������� ����������:
%
% 1) "Sig" - ������ ��������������� ����������� �������������;
% 2) "N" - ����� ������� �� ������ ��� ������������� �������� �����������
% �������;
% 3) "dt" - �������� ������� ����� ��������� ��������������; ���� ��������
% ������ ��������������� "dt = 1 / (N * 50)", �� ����� ��� ����, ����� ��
% ������� ��� �������������� ������� ��� ����������� ���������� ��������
% ����, � ������� ������ ��� �������.

% �������� ����������:
%
% 1) "F" - ������ ������������ �������� ������� ������� (� ��). �����
% ������� ����� ����� ������� ������������� "Sig";
% 2) "DF" - ������ ������������ �������� �������� ��������� ������� �������
% (� ��/�). ����� ������� ����� ����� ����� ������� ������������� "Sig".

% !!! ������ ����������.
%
% ����� ������� �� ������ "N" ������ ���� ������.

% !!! ������ ����������.
%
% ������ �������� ������� ���� �� �������� �����������. ���������� ������
% ��������, �������� ����������� �������� ("Three_point_filter" - ��.
% ����) � �������������� ������ "round(N/6)", � ����� ��������, ��������
% �������� ����������� �������� ("Moving_average" - ��. ����) �
% �������������� ������ "((N/2-1)-1)/2" ��� "((N/2)-1)/2" (��. ���������� �
% ������� ����). �� �� ����� �������� � ��������� �������� �������. ���
% ������ � ��������� �������� �������� ��������� ������� - ����������.

% !!! ������ ����������.
%
% ��������, ��� ����� ������� "Sig" ������ ���������� ��� �����������
% ���������������� ���������, ������� ���������� ��������� ���� ����
% ("�����������" ������) �� �����.

% !!! ������ ����������.
%
% ������ � ��������� �������� ������� "F" (����� ��� � "DF") ����� �����
% ����, ��������� - � ������������ � ������������ ���������� - ��������
% ���� ��������� ���������� ����������.



% ���������� ������ ����� ������� ����������� �������� ("Moving_average"),
% ������� ����� ������������:
filter_length = 2 * floor((N/2-1)/2) + 1;
%
% ���������� 1. ���� � ���, ��� ���� ��� ������� "Moving_average" ������
% ��������� �������� ���������� ��������. �� ������� ������� �������� "N" -
% ����� ������, ������ ��� ������� ��������, ��� ������ ����� � "N/2".
% �������:
%
% 1. N = 48 (������� �� 4).
%
% ����� ������� ����������� ��������:
% N = 48;
% [ 2 * floor((N/2-1)/2) + 1,   N/2-1 ]
% ans =
%     23    23
%
% �������� �������� ��������:
% [ (ans(1)-1)/2, ((N/2-1)-1)/2 ]
% ans =
%     11    11
%
% 2. N = 50 (�� ������� ������ �� 4).
%
% ����� ������� ����������� ��������:
% N = 50;
% [ 2 * floor((N/2-1)/2) + 1,   N/2 ]
% ans =
%     25    25
%
% �������� �������� ��������:
% [ (ans(1)-1)/2, ((N/2)-1)/2 ]
% ans =
%     12    12
%
% ���������� 2. ��� ����������� ���������� ������ ������� (��������
% ���������������� PMU) ���������� "filter_length" ����� �� ���������
% ������� � ���������� � ��� ������� ��� ������� ��������, ����� ���������
% �������������� �������.

% ��������� ������� ���� ��� �������� ������� �������������:
Ang = angle(Sig) * 180/pi;   % � ��������

% ��������� ����������� ������:
Ang = Three_point_filter(Ang, N, false);

% ����������� �� ��������� "�������" ���� � ������ 180 ��������:
Ang = No_angle_jumps(Ang);

% ��������� ���� � �������:
Ang = Ang * pi/180;

% ��������� �������������� "�����������" ������� �����:
Ang = Moving_average(Ang, filter_length);

% ���������� ����������� �������� ����������:
num_of_elem = numel(Sig);   % ���������� ������������� � ������� �������
F = zeros(1, num_of_elem);
DF = zeros(1, num_of_elem);

% �������, ��� ��������� ���������� �������� ��������� ������������ ������
% ������� ����� ������������� "(i-1)" � "(i+1)", �.�. "��������" �
% "��������", ������� �������� �������� "F" � "DF" ����� ����� ����,
% ��������� ��������������� �������� ��������� ���������� ����������.

% ��������� ������� �������� ������ ������� � �������� ��������� �������:
a1 = (4*pi*dt);   % ��������������� ���������� 1
a2 = (2*pi*dt^2);   % ��������������� ���������� 2
for k = 2 : (num_of_elem-1)
    F(k) = 50 + ( Ang(k+1) - Ang(k-1) ) / a1;
    DF(k) = ( Ang(k+1) + Ang(k-1) - 2 * Ang(k) ) / a2;
end