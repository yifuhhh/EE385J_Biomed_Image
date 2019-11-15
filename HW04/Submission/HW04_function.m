function model = HW04_function(params, TR)

    model = params(1) * (1 - exp(-TR / params(2)));

end