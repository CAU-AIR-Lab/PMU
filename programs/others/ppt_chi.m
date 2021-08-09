function [res] = ppt_chi( feats, labels, x )
% Pruned Problem Transformation
% function [res] = ppt_chi( feats, labels, x )

[frow fcol] = size( feats );
[lrow lcol] = size( labels );

if frow ~= lrow
    error( 'The number of the row of feats and labels must be same' );
end

res = zeros( fcol, 2 );
res(:,1) = 1:fcol;

[t t nlabel] = unique( labels, 'rows' );
ndata = feats;

for k=1:length(nlabel)
    idx = find( nlabel == k );
    if length(idx) <= x
        nlabel(idx,:) = [];
        ndata(idx,:) = [];
    end
end

% Tabulation
for k=1:fcol
    tab = crosstab( ndata(:,k), nlabel );

    % Now we have weighted contingency table
    % Calculate chi-square
    tChi = 0;
    total = sum(sum(tab));
    for m=1:size(tab,1)
        for n=1:size(tab,2)
            expected = sum(tab(m,:))*sum(tab(:,n))/total;
            
            tChi = tChi + ((tab(m,n)-expected)^2)/expected;
        end
    end
    
    res(k,2) = tChi;
end

% Univariate Feature Selection
res = sortrows( res, -2 );