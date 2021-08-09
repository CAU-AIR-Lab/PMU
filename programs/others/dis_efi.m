function res = dis_efi( vec, numB )

row = length( vec );
split = 0:(row/numB):row;
val = zeros( numB, 1 );
res = sortrows( vec, 1 );
for k=1:numB
    val(k) = res( round(split(k+1)), 1 );
end
val = unique( val );

res = ones( row, 1 );
for k=1:length(val)
    res( vec > val(k), 1 ) = k+1;
end
