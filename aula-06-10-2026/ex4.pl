% =========================
% BASE DE CONHECIMENTO
% =========================

professor(carlos).

aluno(joao).
aluno(maria).

autorizado(joao).

% =========================
% REGRA
% =========================

acesso_laboratorio(X) :-
    professor(X);
    (
        aluno(X),
        autorizado(X)
    ).

% =========================
% CONSULTAS
% =========================

% Professor
% ?- acesso_laboratorio(carlos).
% true.

% Aluno autorizado
% ?- acesso_laboratorio(joao).
% true.

% Aluno sem autorizacao
% ?- acesso_laboratorio(maria).
% false.

% Todas as pessoas que podem acessar
% ?- acesso_laboratorio(X).
% X = carlos ;
% X = joao.
