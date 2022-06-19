% ��� �������� ���������� ������ �� ���������� ������������ ������� ���
% ���������� ���������� �� "�������" ���� � ������ 180 ��������
% (��. Phadke, Fig. 4.3).
% ������ ��� ������������ ��� ��� ��� �����.



function Out = No_angle_jumps(In)

% "In" - ������� ������ (�������� ����� � ��������).
% "Out" - �������� ������ (�������� ����� � ��������).



% ����� ��������� �� ������� �������:
num = numel(In);

% �������� ������ (���� ��� ��� �������� ����� ��������������� ���������
% �������� �������):
Out = In;

for k = 1 : (num - 1)
    
    if abs(In(k+1) - In(k)) > 180 % �� ����� ����, ��� ����� �� ������
                                  % ���-�� ������� 180, � ������� � 360
    
    if In(k+1) < In(k)
        Out((k+1):end) = Out((k+1):end) + 360;
    else
        Out((k+1):end) = Out((k+1):end) - 360;
    end
    
    end
    
end