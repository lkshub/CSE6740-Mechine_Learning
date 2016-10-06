function [ class, centroid ] = mykmedoids( pixels, K )
%
% Your goal of this assignment is implementing your own K-medoids.
% Please refer to the instructions carefully, and we encourage you to
% consult with other resources about this algorithm on the web.
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
% the kmeans matlab function directly. That is, you need to comment it
% out.
    nnorm = 1;
    medoids = randi(size(pixels,1),K,1);
    centroid  = [pixels(medoids,:)];
    class = ones(size(pixels,1),1);
    iter = 0;
%     error = 1000*K;
    cost = zeros(size(pixels,1),1);
    for i=1:size(pixels,1)
            cost(i)=norm(pixels(i,:)-centroid(class(i),:),nnorm);
            for j=1:size(centroid,1)
                if cost(i)>norm(pixels(i,:)-centroid(j,:),nnorm)
                    class(i)=j;
%                     stable =0;
                    cost(i) = norm(pixels(i,:)-centroid(j,:),nnorm);
                end
            end
    end
%     totalCost = sum(cost);
    medoidsChanged = 1;
    newCost = cost;
    newClass = class;
    while medoidsChanged>0
        iter = iter + 1;
        medoidsChanged = 0;

        for i=1:K
         
            j=randi(size(pixels,1));
            while(class(j)~=i)
                j=randi(size(pixels,1));
            end
               
                    for k=1:size(pixels,1)
                        if newCost(k)>norm(pixels(j,:)-pixels(k,:),nnorm)
                            newClass(k)=i;
                            newCost(k) = norm(pixels(j,:)-pixels(k,:),nnorm);
                        end
                    end
                    if sum(newCost)<sum(cost)
                        centroid(i,:)=pixels(j,:);
                        class = newClass;
                        cost = newCost;
                        medoidsChanged = medoidsChanged +1;
                    else
                        newClass=class;
                        newCost = cost;
                    end
                
                
            
        end
        if iter>500
            break;
        end
    end
	%[class, centroid] = kmeans(pixels, K);
end
