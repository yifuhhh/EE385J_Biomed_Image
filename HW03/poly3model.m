function model = poly3model(params,time)

model = params(1)*time.^3+params(2)*time.^2+params(3)*time+params(4);

end