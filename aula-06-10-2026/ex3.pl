% =========================
% BASE DE CONHECIMENTO
% =========================

professor(carlos).
professor(ana).

coordenador(maria).

aluno(joao).
aluno(pedro).

% =========================
% REGRA COM DISJUNÇÃO
% =========================

pode_entrar(X) :-
    professor(X);
    coordenador(X).

% =========================
% CONSULTAS
% =========================

% ?- pode_entrar(carlos).
% true.

% ?- pode_entrar(maria).
% true.

% ?- pode_entrar(joao).
% false.

% ?- pode_entrar(X).
% X = carlos ;
% X = ana ;
% X = maria.
