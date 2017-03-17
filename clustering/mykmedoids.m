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
% the kmeans matlab function directly. That is, you need to comment it out.
% [class, centroid] = kmeans(pixels, K);
     totalrow=size(pixels,1);
     centroid=pixels(randi([1,totalrow],1,K),:);
%      centroid=pixels(1:1:K,:);
%      centroid=pixels(100:1:K+99,:);
%      centroid=pixels(50:1:K+49,:);
     total_diff=1e-6;
     diff=100;
     dist=zeros(totalrow,K);
     
  while diff>total_diff 
     oldcentroid=centroid;  
     %Find the closest centroids 
     for j=1:1:K
            Tcentroid=repmat(centroid(j,:),totalrow,1);
            dist(:,j)=sum((pixels-Tcentroid).^2,2);
     end
     [~,class]=min(dist,[],2);  
     
     %Check if K is too large
     cluster=1:1:K;
     if isempty(setdiff(cluster,class))==0
         K=round(K/2);
         centroid=pixels(randi([1,totalrow],1,K),:);
         dist=zeros(totalrow,K);
         continue;
     end
         
    %Compute centroids  
    for j=1:1:K
         c_j= class==j;
         n=sum(c_j);
         pixels_c_j=pixels(c_j,:);

         kmeans_centroid=repmat((sum(pixels_c_j)./n),n,1);
         dist2=sum((pixels_c_j-kmeans_centroid).^2,2);
         [~,ind]=min(dist2);
         centroid(j,:)=pixels_c_j(ind,:);
     end   
     diff=sum(sum((oldcentroid-centroid).^2));
   end
 
end