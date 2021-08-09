function [res] = ela_chi( feats, labels )
% Entropy based Label Assignment
% function [res] = ela( feats, labels )

[frow fcol] = size( feats );
[lrow lcol] = size( labels );

if frow ~= lrow
    error( 'The number of the row of feats and labels must be same' );
end

res = zeros( fcol, 2 );
res(:,1) = 1:fcol;

labels(:,find(sum(labels) == 0)) = [];

% Entropy based Label Assignment
ndata = zeros(0,fcol);
nlabel = zeros(0,1);
wts = zeros(0,1);
for k=1:frow
    count = sum( labels(k,:) );
    for m=1:count
        ndata(end+1,:) = feats(k,:);
        wts(end+1,1) = 1/count;
    end
    nlabel(end+1:end+count,1) = find( labels(k,:) == 1 );
end

% Tabulation
lu = unique( nlabel );
for k=1:fcol
    fu = unique( ndata(:,k ) );
    tab = zeros( length(fu), length(lu) );
    
    for m=1:size(ndata,1)
       % Feature Index: rowIdx
       rowIdx = find( fu == ndata(m,k) );
       
       % Summing up Weighted Frequency
       tab( rowIdx, nlabel(m) ) = tab( rowIdx, nlabel(m) ) + wts(m);
    end
    
    % Now we have weighted contingency table
    % Calculate chi-square
    tChi = 0;
    total = sum(sum(tab));
    for m=1:length(fu)
        for n=1:length(lu)
            expected = sum(tab(m,:))*sum(tab(:,n))/total;
            
            tChi = tChi + ((tab(m,n)-expected)^2)/expected;
        end
    end
    
    res(k,2) = tChi;
end

% Univariate Feature Selection
res = sortrows( res, -2 );
