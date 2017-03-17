function [ class ] = mycluster( bow, K )
%
% Your goal of this assignment is implementing your own text clustering algo.
%
% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment. 400*100
%
%     K: the number of desired topics/clusters. 
%
% Output:
%     class: the assignment of each topic. The
%     assignment should be 1, 2, 3, etc. 
%
% For submission, you need to code your own implementation without using
% any existing libraries

% YOUR IMPLEMENTATION SHOULD START HERE!


% Initialize the probability parameter mu_j, pi_c
   [nd,nw]=size(bow);
   mu=[];
   pi=ones(K,1) .*(1/K);    
   for c=1:K
       mu(:,c)=0.25+(0.75-0.25)*rand(nw,1);
       mu(:,c)=mu(:,c)/sum(mu(:,c));
    end

    error=10;
    limit=1e-10;
   while error>limit
    % Expectation step
        gamma=zeros(nd,K);
        for i=1:nd
            normalize=0;
            for c=1:K
                gamma(i,c)=pi(c)*prod(mu(:,c)'.^(bow(i,:)));
                normalize=normalize+gamma(i,c);
            end
            gamma(i,:)=gamma(i,:)/normalize;
        end
      [value class]=max(gamma,[],2);
      oldmu=mu;
      oldpi=pi;
    % Maximization step
        for c=1:K
            pi(c)=1/nd *sum(gamma(:,c));
            for j=1:nw
                mu(j,c)=sum(gamma(:,c).*bow(:,j))/sum(gamma(:,c).*sum(bow,2));
            end
        end
        error=sum(sum((oldmu-mu).^2))+sum((oldpi-pi).^2);
    end
end

