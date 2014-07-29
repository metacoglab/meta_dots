  function new_vect = permvect(vect)
%Random permutations of a vector values
%19.09.11
%S.M.

n = max(size(vect));
order = randperm(n);
new_vect = vect(order(1));
for i = 2:n
    new_vect = [new_vect vect(order(i))];
end
