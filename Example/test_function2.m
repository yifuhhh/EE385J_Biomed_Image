function [mask] = test_function2(data)
    imagesc(data)
    mask = roipoly();
end