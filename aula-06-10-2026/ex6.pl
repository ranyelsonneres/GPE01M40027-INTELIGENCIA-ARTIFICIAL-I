% =========================
% BASE DE CONHECIMENTO
% =========================

pai(joao, pedro).
pai(joao, ana).
pai(pedro, lucas).
pai(carlos, joao).

mae(maria, pedro).
mae(maria, ana).

% =========================
% REGRAS
% =========================

% X e avo de Z se X for pai de Y
% e Y for pai ou mae de Z
avo(X, Z) :-
    pai(X, Y),
    pai(Y, Z).

avo(X, Z) :-
    pai(X, Y),
    mae(Y, Z).

% X e filho de Y se Y for pai ou mae de X
filho(X, Y) :-
    pai(Y, X).

filho(X, Y) :-
    mae(Y, X).

% X e Y possuem o mesmo pai
mesmo_pai(X, Y) :-
    pai(P, X),
    pai(P, Y),
    X \= Y.

% =========================
% CONSULTAS
% =========================

% Quem e avo de Lucas?
% ?- avo(X, lucas).
% X = joao.

% Quem sao os filhos de Joao?
% ?- filho(X, joao).
% X = pedro ;
% X = ana.

% Quem possui o mesmo pai que Pedro?
% ?- mesmo_pai(pedro, X).
% X = ana.
