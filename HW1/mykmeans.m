function [ class, centroid ] = mykmeans( pixels, K )
%
% Your goal of this assignment is implementing your own K-means.
%
% Input:
%     pixels: data set. Each row contains one data point. For image
%     dataset, it contains 3 columns, each column corresponding to Red,
%     Green, and Blue component.
%
%     K: the number of desired clusters. Too high value of K may result in
%     empty cluster error. Then, you need to reduce it.
%
% Output:
%     class: the class assignment of each data point in pixels. The
%     assignment should be 1, 2, 3, etc. For K = 5, for example, each cell
%     of class should be either 1, 2, 3, 4, or 5. The output should be a
%     column vector with size(pixels, 1) elements.
%
%     centroid: the location of K centroids in your result. With images,
%     each centroid corresponds to the representative color of each
%     cluster. The output should be a matrix with size(pixels, 1) rows and
%     3 columns. The range of values should be [0, 255].
%     
%
% You may run the following line, then you can see what should be done.
% For submission, you need to code your own implementation without using
% the kmeans matlab f9unction directly. That is, you need to comment it out.
    centroid  = randi(256,K,3)-1;
    class = ones(size(pixels,1),1);
    iter = 0;
    error = 1000*K;
    while error/K >1
        iter = iter + 1;  
        stable = 1;
        for i=1:size(pixels,1)
            dis=norm(pixels(i,:)-centroid(class(i),:));
            for j=1:size(centroid,1)
                if dis>norm(pixels(i,:)-centroid(j,:))
                    class(i)=j;
                    stable =0;
                    dis = norm(pixels(i,:)-centroid(j,:));
                end
            end
        end
        if stable ==0
            newCentroid = zeros(K,3);
            num = zeros(K,1);
            for i = 1:size(pixels,1)
                newCentroid(class(i),:) =newCentroid(class(i),:)+ pixels(i,:);
                num(class(i)) = num(class(i))+ 1;
            end
            error = 0;
            for i=1:K
                if num(i)>0
                    newCentroid(i,:) = newCentroid(i,:) / num(i);
                else
                     newCentroid(i,:) = centroid(i,:);
                end
                error = error + norm(newCentroid(i,:)-centroid(i,:));
            end
        end
        if iter>100
            break;
        end
        centroid = newCentroid;
    end
	%[class, centroid] = kmeans(pixels, K);
end

