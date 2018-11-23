function creatfigure3(X1, Y1)
%CREATEFIGURE2(X1, Y1)
%  X1:  x ���ݵ�ʸ��
%  Y1:  y ���ݵ�ʸ��

%  �� MATLAB �� 06-Dec-2017 15:34:58 �Զ�����

% ���� figure
figure1 = figure;

% ���� axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% ���� plot
plot1 = plot(X1,Y1,'DisplayName','data1','Marker','>','LineStyle','none',...
    'Color',[1 0 0]);

% ��ȡͼ�е� xdata
xdata1 = get(plot1, 'xdata');
% ��ȡͼ�е� ydata
ydata1 = get(plot1, 'ydata');
% ȷ������Ϊ��ʸ��
xdata1 = xdata1(:);
ydata1 = ydata1(:);


% ɾ�� NaN ֵ����������
nanMask1 = isnan(xdata1(:)) | isnan(ydata1(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        '���� NaN ��������ݵ㽫�����ԡ�');
    xdata1(nanMask1) = [];
    ydata1(nanMask1) = [];
end

% �����ڻ��� xlim �������ͼ�� x ֵ
axesLimits1 = xlim(axes1);
xplot1 = linspace(axesLimits1(1), axesLimits1(2));

% Ϊ����ʾ���̡�ϵ��Ԥ����
coeffs1 = cell(1,1);

% �����ʽ��ϵ��(�� = 1)
fitResults1 = polyfit(xdata1,ydata1,1);
% �������ʽ
yplot1 = polyval(fitResults1,xplot1);

% ���桰��ʾ���̡����������
fittypesArray1(1) = 2;

% ���桰��ʾ���̡���ϵ��
coeffs1{1} = fitResults1;

% �������ͼ
fitLine1 = plot(xplot1,yplot1,'DisplayName','   ����','Tag','linear',...
    'Parent',axes1,...
    'Color',[0 0 0]);

% ������������Ϊ�ʵ�λ��
setLineOrder(axes1,fitLine1,plot1);

% ��ѡ������ʾ���̡�
% showEquations(fittypesArray1,coeffs1,3,axes1);

% ���� xlabel
xlabel('Iterations (No.)','FontSize',25);
title('Linear Equation: y=-0.354*x - 0.272','FontSize',25);
% ���� ylabel
ylabel('RSE in log-scale','FontSize',25);
% set(axes1,'FontSize',13,'YTickLabel',...
%     {'10^{-12}','10^{-10}','10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}'});

box(axes1,'on');
grid(axes1,'on');
set(gca,'FontSize',14);
%-------------------------------------------------------------------------%
function setLineOrder(axesh1, newLine1, associatedLine1)
%SETLINEORDER(AXESH1,NEWLINE1,ASSOCIATEDLINE1)
%  ������˳��
%  AXESH1:  ������
%  NEWLINE1:  ����
%  ASSOCIATEDLINE1:  �����

% ��ȡ��������Ӽ�
hChildren = get(axesh1,'Children');
% ɾ��������
hChildren(hChildren==newLine1) = [];
% ��ȡ����ߵ�����
lineIndex = find(hChildren==associatedLine1);
% �Ը��������������Ա���ʾ���й������ݵ�������
hNewChildren = [hChildren(1:lineIndex-1);newLine1;hChildren(lineIndex:end)];
% �����Ӽ�:
set(axesh1,'Children',hNewChildren);

%-------------------------------------------------------------------------%
function showEquations(fittypes1, coeffs1, digits1, axesh1)
%SHOWEQUATIONS(FITTYPES1,COEFFS1,DIGITS1,AXESH1)
%  ��ʾ����
%  FITTYPES1:  �������
%  COEFFS1:  ϵ��
%  DIGITS1:  ��Ч����λ��
%  AXESH1:  ������

n = length(fittypes1);
txt = cell(length(n + 1) ,1);
txt{1,:} = ' ';
for i = 1:n
    txt{i + 1,:} = getEquationString(fittypes1(i),coeffs1{i},digits1,axesh1);
end
text(.05,.95,txt,'parent',axesh1, ...
    'verticalalignment','top','units','normalized');

%-------------------------------------------------------------------------%
function [s1] = getEquationString(fittype1, coeffs1, digits1, axesh1)
%GETEQUATIONSTRING(FITTYPE1,COEFFS1,DIGITS1,AXESH1)
%  ��ȡ����ʾ���̡��ı�
%  FITTYPE1:  �������
%  COEFFS1:  ϵ��
%  DIGITS1:  ��Ч����λ��
%  AXESH1:  ������

if isequal(fittype1, 0)
    s1 = '����������ֵ';
elseif isequal(fittype1, 1)
    s1 = '���β�ֵ';
else
    op = '+-';
    format1 = ['%s %0.',num2str(digits1),'g*x^{%s} %s'];
    format2 = ['%s %0.',num2str(digits1),'g'];
    xl = get(axesh1, 'xlim');
    fit =  fittype1 - 1;
    s1 = sprintf('y =');
    th = text(xl*[.95;.05],1,s1,'parent',axesh1, 'vis','off');
    if abs(coeffs1(1) < 0)
        s1 = [s1 ' -'];
    end
    for i = 1:fit
        sl = length(s1);
        if ~isequal(coeffs1(i),0) % if exactly zero, skip it
            s1 = sprintf(format1,s1,abs(coeffs1(i)),num2str(fit+1-i), op((coeffs1(i+1)<0)+1));
        end
        if (i==fit) && ~isequal(coeffs1(i),0)
            s1(end-5:end-2) = []; % change x^1 to x.
        end
        set(th,'string',s1);
        et = get(th,'extent');
        if et(1)+et(3) > xl(2)
            s1 = [s1(1:sl) sprintf('\n     ') s1(sl+1:end)];
        end
    end
    if ~isequal(coeffs1(fit+1),0)
        sl = length(s1);
        s1 = sprintf(format2,s1,abs(coeffs1(fit+1)));
        set(th,'string',s1);
        et = get(th,'extent');
        if et(1)+et(3) > xl(2)
            s1 = [s1(1:sl) sprintf('\n     ') s1(sl+1:end)];
        end
    end
    delete(th);
    % Delete last "+"
    if isequal(s1(end),'+')
        s1(end-1:end) = []; % There is always a space before the +.
    end
    if length(s1) == 3
        s1 = sprintf(format2,s1,0);
    end
end

