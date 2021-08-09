function [feat] = pmu( data, answer, numK )
% Pairwise Mutli label Utility
% function [feat] = pmu( data, answer, numK )

fcol = size( data, 2 );
lcol = size( answer, 2 );

f_ent = zeros( fcol, 1 );
fl_ent = zeros( fcol, lcol );
for k=1:fcol
    f_ent( k, 1 ) = p_entropy( data(:,k) );
    for m=1:lcol
        fl_ent(k,m) = p_entropy( [data(:,k) answer(:,m)] );
    end
end

l_ent = zeros( 1, lcol );
ll_ent = zeros( lcol, lcol );
for k=1:lcol
    l_ent( 1, k ) = p_entropy( answer(:,k) );
    for m=k+1:lcol
        ll_ent(k,m) = p_entropy( [answer(:,k) answer(:,m)] );
        ll_ent(m,k) = ll_ent(k,m);
    end
end

rel = zeros( fcol, 1 );
for k=1:fcol
    for m=1:lcol
        rel(k) = rel(k) + f_ent(k) + l_ent(m) ...
            - fl_ent(k,m);
    end
end

red = zeros( fcol, fcol );
red(:,:) = NaN;

ld = zeros( fcol, 1 );
for k=1:fcol
    for m=1:lcol
        for n=m+1:lcol
            ld(k) = ld(k) ...
                + f_ent(k) + l_ent(m) + l_ent(n) ...
                - fl_ent(k,m) - fl_ent(k,n) - ll_ent(m,n) ...
                + p_entropy( [data(:,k) answer(:,m) answer(:,n)] );
        end
    end
end

rel = rel - ld;

% Selecting First Feature
feat = zeros(0,1);
[val idx] = max( rel );
feat(end+1,1) = idx;

for k=2:numK
    j_value = rel;
    
    for m=1:fcol
        for n=1:k-1
            if isnan( red(m,feat(n)) )
                % Need Calculation
                red(m,feat(n)) = 0;
                for a=1:lcol
                    red(m,feat(n)) = red(m,feat(n)) ...
                        + f_ent(m) + f_ent(feat(n)) + l_ent(a) ...
                        - fl_ent(m,a) - fl_ent(feat(n),a) ...
                        - p_entropy( [data(:,m) data(:,feat(n))] ) ...
                        + p_entropy( [data(:,m) data(:,feat(n)) answer(:,a)] );
                end
                red(feat(n),m) = red(m,feat(n));
            end
            
            j_value(m) = j_value(m) - red(m,feat(n));
        end
    end
    
    j_value(feat(1:k-1)) = -inf;
    [val idx] = max( j_value );
    feat(k,1) = idx;
    
    % fprintf( '.' );
    % if mod(k,20) == 0
    %     fprintf( '\n' );
    % end    
end
% fprintf( '\n' );