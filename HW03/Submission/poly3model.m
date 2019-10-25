function model = poly3model(params, t)

    model = params(1) * (1 - exp(-params(2) * t));

end