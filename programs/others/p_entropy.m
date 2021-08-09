function [res] = p_entropy( vector )

[uidx,~,single] = unique( vector, 'rows' );
count = zeros(size(uidx,1),1);
for k=1:size(vector,1)
    count( single(k), 1 ) = count( single(k), 1 ) + 1;
end
res = -( (count/size(vector,1))'*log2( (count/size(vector,1)) ) );
