function [res] = ppt_mi( feats, labels, x )
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

for k=1:fcol
    res(k,2) = mutualinfo( ndata(:,k), nlabel );
end

% Univariate Feature Selection
res = sortrows( res, -2 );
