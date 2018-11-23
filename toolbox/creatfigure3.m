function creatfigure3(X1, Y1)
%CREATEFIGURE2(X1, Y1)
%  X1:  x 数据的矢量
%  Y1:  y 数据的矢量

%  由 MATLAB 于 06-Dec-2017 15:34:58 自动生成

% 创建 figure
figure1 = figure;

% 创建 axes
axes1 = axes('Parent',figure1);
hold(axes1,'on');

% 创建 plot
plot1 = plot(X1,Y1,'DisplayName','data1','Marker','>','LineStyle','none',...
    'Color',[1 0 0]);

% 获取图中的 xdata
xdata1 = get(plot1, 'xdata');
% 获取图中的 ydata
ydata1 = get(plot1, 'ydata');
% 确保数据为列矢量
xdata1 = xdata1(:);
ydata1 = ydata1(:);


% 删除 NaN 值并发出警告
nanMask1 = isnan(xdata1(:)) | isnan(ydata1(:));
if any(nanMask1)
    warning('GeneratedCode:IgnoringNaNs', ...
        '具有 NaN 坐标的数据点将被忽略。');
    xdata1(nanMask1) = [];
    ydata1(nanMask1) = [];
end

% 求用于基于 xlim 绘制拟合图的 x 值
axesLimits1 = xlim(axes1);
xplot1 = linspace(axesLimits1(1), axesLimits1(2));

% 为“显示方程”系数预分配
coeffs1 = cell(1,1);

% 求多项式的系数(阶 = 1)
fitResults1 = polyfit(xdata1,ydata1,1);
% 计算多项式
yplot1 = polyval(fitResults1,xplot1);

% 保存“显示方程”的拟合类型
fittypesArray1(1) = 2;

% 保存“显示方程”的系数
coeffs1{1} = fitResults1;

% 绘制拟合图
fitLine1 = plot(xplot1,yplot1,'DisplayName','   线性','Tag','linear',...
    'Parent',axes1,...
    'Color',[0 0 0]);

% 将新线条设置为适当位置
setLineOrder(axes1,fitLine1,plot1);

% 已选定“显示方程”
% showEquations(fittypesArray1,coeffs1,3,axes1);

% 创建 xlabel
xlabel('Iterations (No.)','FontSize',25);
title('Linear Equation: y=-0.354*x - 0.272','FontSize',25);
% 创建 ylabel
ylabel('RSE in log-scale','FontSize',25);
% set(axes1,'FontSize',13,'YTickLabel',...
%     {'10^{-12}','10^{-10}','10^{-8}','10^{-6}','10^{-4}','10^{-2}','10^{0}'});

box(axes1,'on');
grid(axes1,'on');
set(gca,'FontSize',14);
%-------------------------------------------------------------------------%
function setLineOrder(axesh1, newLine1, associatedLine1)
%SETLINEORDER(AXESH1,NEWLINE1,ASSOCIATEDLINE1)
%  设置线顺序
%  AXESH1:  坐标轴
%  NEWLINE1:  新线
%  ASSOCIATEDLINE1:  结合线

% 获取坐标轴的子级
hChildren = get(axesh1,'Children');
% 删除新线条
hChildren(hChildren==newLine1) = [];
% 获取结合线的索引
lineIndex = find(hChildren==associatedLine1);
% 对各条线重新排序，以便显示具有关联数据的新线条
hNewChildren = [hChildren(1:lineIndex-1);newLine1;hChildren(lineIndex:end)];
% 设置子级:
set(axesh1,'Children',hNewChildren);

%-------------------------------------------------------------------------%
function showEquations(fittypes1, coeffs1, digits1, axesh1)
%SHOWEQUATIONS(FITTYPES1,COEFFS1,DIGITS1,AXESH1)
%  显示方程
%  FITTYPES1:  拟合类型
%  COEFFS1:  系数
%  DIGITS1:  有效数字位数
%  AXESH1:  坐标轴

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
%  获取“显示方程”文本
%  FITTYPE1:  拟合类型
%  COEFFS1:  系数
%  DIGITS1:  有效数字位数
%  AXESH1:  坐标轴

if isequal(fittype1, 0)
    s1 = '三次样条插值';
elseif isequal(fittype1, 1)
    s1 = '保形插值';
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

