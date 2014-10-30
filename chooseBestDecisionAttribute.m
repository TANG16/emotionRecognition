function [bestAttribute] = chooseBestDecisionAttribute(examples, attributes, binary_targets)
  gain = intmin;
  curBest = 1;
  while (attributes(curBest) == -1)
    curBest = curBest + 1;
  end
  for (a = 1 : length(attributes))
    flag = 0;
    while (attributes(a) == -1)
      a = a + 1;
      if (a > length(attributes))
        flag = 1;
        break;
      end
    end
    
    if (flag == 1)
      break;
    end

    p = countMember(1, a, examples);
    n = countMember(0, a, examples);

    p0 = getNumExamples(1, 0, a, examples, binary_targets);
    p1 = getNumExamples(1, 1, a, examples, binary_targets);
    n0 = getNumExamples(0, 0, a, examples, binary_targets);
    n1 = getNumExamples(0, 1, a, examples, binary_targets);

    temp1 = ((p0 + n0) / (p + n)) * calcI(p0, n0);
    temp2 = ((p1 + n1) / (p + n)) * calcI(p1, n1);

    remainder = temp1 + temp2;

    thisGain = calcI(p, n) - remainder;

    if (thisGain > gain)
      gain = thisGain;
      curBest = attributes(a);
    end    
  end
  bestAttribute = curBest;