%base de conhecimento

aluno(joao).
aluno(maria).
aluno(pedro).
aluno(ana).

matriculado(joao).
matriculado(maria).
matriculado(ana).

%regra
pode_acessar(X) :-
    aluno(X),
    matriculado(X).


% consultas
% pode_acessar(joao).
% pode_acessar(pedro).
%pode_acessar(X).
