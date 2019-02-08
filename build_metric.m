function [d] = build_metric(metric,metric_size)
%BUILD_METRIC - generates a distance metric according to the name metric
% and the metric parameters stored in metric_size


switch metric
    case "grid"
        d = generate_grid(metric_size(1),metric_size(2));
    case "star"
        d = generate_star(metric_size(1));
    otherwise
        d = zeros(1,1);
end

