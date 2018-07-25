clear
count = 0;
for A = 1:10
    for sigma_sq = 1:10
        count = count + 1;
        mu1 = 0;
        mu2 = A;
        sigma1 = sigma_sq;
        sigma2 = sigma_sq + A^2;
        dist1 =@(x) exp(-(x-mu1).^2 / (2*sigma1^2)) / sqrt(2*sigma1^2*pi);
        dist2 =@(x) exp(-(x-mu2).^2 / (2*sigma2^2)) / sqrt(2*sigma2^2*pi);
        upper_intersect = fzero(@(x) dist1(x) - dist2(x), rand * (mu1 - mu2) + (mu1 + mu2));
        upper_intersect = abs(upper_intersect);
        
        P_A0 =  2 * normcdf(upper_intersect,0,sigma_sq,'upper');
        p_0A =  normcdf(-upper_intersect,A^2,sigma_sq + A^2,'upper') - normcdf(upper_intersect,A^2,sigma_sq + A^2,'upper');
        C(1,count) = A^2 / sigma_sq;
        C(2,count) = BlahutArimoto([1-P_A0 P_A0; p_0A 1 - p_0A]);
    end
end

[~,idx] = sort(C(1,:)); % sort just the first column
sorted_C = C(:,idx);
plot(sorted_C(1,:),sorted_C(2,:))
        