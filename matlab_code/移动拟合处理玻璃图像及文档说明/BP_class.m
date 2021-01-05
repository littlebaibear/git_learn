% 超参数定义
numberOfTrain = a;
numberOfVal = a;
numberOfTest = a;
nemberofHiddenNeure = a;
inputDim = a;
outDim = a;

% 训练集
factor_1 = b;
factor_2 = b;
factor_a = b;
% 真实标签
gt_label = gt;

rand('state',sum(100*clock))
input = [factor_1,factor_2,factor_a];
