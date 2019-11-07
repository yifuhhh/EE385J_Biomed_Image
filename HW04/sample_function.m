function model = sample_function(params,xdata,TR)



model = params(1)*(exp(-TR/params(2))).*cosd(xdata);

end