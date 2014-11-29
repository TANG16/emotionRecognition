function predictions = nFoldCrossValidationNN(examples, answers, n, net)
%CROSSVALIDATION takes in data and perfoms nfold validation, generates
%predictions and returns them with expected values
  predictions = cell(n, 2);

  for i = 1:n
    [~, ~, ~, ~, tI1, tI2] = partition(size(answers, 1), i, n);
    
    predictions(i, 1) = {testANN(net, examples(tI1:tI2, :)')};
    predictions(i, 2) = {answers(tI1:tI2, :)};
  end

end

function [egI1, egI2, egI3, egI4, tI1, tI2] = partition(numEgs, i, n)
  ds  = numEgs/n;
  i1 = round((i - 1) * ds);
  i2 = round(i * ds);
  
  egI1 = 1;
  egI2 = i1 - 1;
  egI3 = i2 + 1;
  egI4 = numEgs;
  tI1 = i1;
  tI2 = i2;
  
  if i == 1
    egI1 = egI3;
    egI2 = egI3;
    tI1  = 1;
  elseif i == n
    egI3 = egI2;
    egI4 = egI2;
    tI2  = numEgs;
  end
  
end

function [predictions] = testANN(net, x2)
  result = sim(net, x2);
  predictions = NNout2labels(result);
end

function y = NNout2labels(x)

[v I] = max(x);
y = I';
end
