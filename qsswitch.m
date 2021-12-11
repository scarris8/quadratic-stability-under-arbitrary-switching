%% QUADRATIC STABILITY UNDER ARBITRARY SWITCHING
clear all; close all;

%System
a = [1 2 3 4];
for i = 1:length(a)
    A(:,:,i) = [1 a(i); 3 1];
end

yalmip('clear');
Const = [];
eta = .0001;
n = size(A,1);
P = sdpvar(n,n);
Const = [Const; P>=eta*eye(size(P))];
for i = 1:length(a)
    mat = A(:,:,i)'*P+P*A(:,:,i);   
    Const = [Const; mat <= -eta*eye(size(mat))];
end

opt=sdpsettings('solver','sedumi','verbose',0);
optimize(Const, [], opt);
PP = value(P);
disp(PP);