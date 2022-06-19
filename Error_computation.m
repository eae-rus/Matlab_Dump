% ������� ���������� ������������ ������� �������������, ������� � ��������
% ��������� �������

function [ TVE, df, df_dt ] = ...
Error_computation ( Ph_true, Ph_c, f_true, f_c, deriv_true, deriv_c )

% ������� ���������:
%
% 1) Ph_true - "��������" �����������;
% 2) Ph_c - ������������ �����������;
% 3) f_true - "��������" �������� �������;
% 4) f_c - ������������ �������� �������;
% 5) deriv_true - "��������" �������� �������� ��������� �������;
% 6) deriv_c - ������������ �������� �������� ��������� �������.

% �������� ���������:
%
% 1) TVE - Total Vector Error (������ ��������� �����������) � ���������;
% 2) df - ���������� ������� �� "��������", ��;
% 3) df_dt - ���������� �������� ��������� ������� �� "��������", ��/�.

% ����������.
% ��� ������� �������� ����� ���� ��� ���������, ��� � ���������.



% ��� ���������� �������������� � ������������ �� ���������� IEEE
% C37.118.1-2011.

TVE = 100 * abs(Ph_c - Ph_true) ./ abs(Ph_true);
df = f_true - f_c;
df_dt = deriv_true - deriv_c;
