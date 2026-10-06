% =========================
% BASE DE CONHECIMENTO
% =========================

aluno(joao).
aluno(maria).
aluno(pedro).
aluno(ana).

matriculado(joao).
matriculado(maria).
matriculado(ana).

% =========================
% REGRA
% =========================

pode_acessar(X) :-
    aluno(X),
    matriculado(X).

% =========================
% CONSULTAS
% =========================

% ?- pode_acessar(joao).
% true.

% ?- pode_acessar(pedro).
% false.

% ?- pode_acessar(X).
% X = joao ;
% X = maria ;
% X = ana.
