%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%% Array and Matrices%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Clear all the variables
clc; % clear screen
clear all; %clear all previously loaded variables
%Create an array
a = [1 2 3 4];
% create 4 x 4 Matrix; 
% ; symbol also offers the concatenation pf arrays vertically
a = [10 13 15 14; 1 54 4 7; 8 19 10 11; 5 4 8 9];
% This also a way to define Matrix
a = [10 13 15 14
    1 54 4 7 
    8 19 10 11
    5 4 8 9];

% print shape of A
size(a)
% Defining variables and formatted printing
x = 5;
fprintf('The value of x is: %5.8f\n', x);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%Cell Struct and Tables%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
B = [true, false, true]; % A logical array
C = {1, 'text', [1, 2, 3]}; % A cell array can handle multiple data array
fprintf('First element of Cell Array: %5d\n', C{1})  % Access Cell array
%%%% Struct %%%%%
S = {};
S.name = 'John Doe';
S.age = 30;
S.scores = [85, 90, 78]; % A structure
disp(fieldnames(S)); % Print the field in structure S
disp(S.name); % Access a field in S
%%% Table: Alice and Bob is field or variable and 30 and 25 there
%%% corresponding vlaues
T = table({'Alice'; 'Bob'}, [30; 25], 'VariableNames', {'Name', 'Age'});