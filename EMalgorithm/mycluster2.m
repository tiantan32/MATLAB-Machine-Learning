function [ Pwz,Pdz,Pz ] = mycluster2( bow, K )

% Input:
%     bow: data set. Bag of words representation of text document as
%     described in the assignment. 400*100
%
%     K: the number of desired topics/clusters.
% Output:
%     Pwz is P(w|z), a matrix of 100*K, Pdz is P(d|z), a matrix of 400*K,
%     and Pz is P(z), a vector of K*1

    [nd,nw]=size(bow);
    
% Initialize parameters
    Pz=ones(K,1) ./K;
    Pwz=rand(nw,K);
    Pwz=Pwz./repmat(sum(Pwz,1),nw,1);
    Pdz=rand(nd,K);
    Pdz=Pdz./repmat(sum(Pdz,1),nd,1);
    
    max=30;
    iter=0;
    gamma=zeros(nd,nw,K);
    
    while iter<max
        iter=iter+1;
    % Expectation step
  
        for c=1:K
            gamma(:,:,c)=Pz(c)*Pdz(:,c)*Pwz(:,c)';  %gamma: nd*nw     
        end
        gamma=gamma./repmat(sum(gamma,3), [1,1,K]);

    % Maximization step
        for c=1:K
            Pwz(:,c)=sum(bow.*gamma(:,:,c),1)';
            s=sum(Pwz(:,c));
            Pwz(:,c)=Pwz(:,c)./s;
        end
        
        for c=1:K
            Pdz(:,c)=sum(bow.*gamma(:,:,c),2);
            s=sum(Pdz(:,c));
            Pdz(:,c)=Pdz(:,c)./s;
        end

        for c=1:K
            Pz(c)=sum(sum(bow.*gamma(:,:,c),1),2);
        end
        Pz=Pz./sum(Pz);
    end
end

