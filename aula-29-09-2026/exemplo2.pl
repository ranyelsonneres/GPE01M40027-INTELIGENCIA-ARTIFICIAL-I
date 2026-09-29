% fatos
nota(joao, 8).
nota(maria, 6).
nota(pedro, 9).

frequencia(joao, 80).
frequencia(maria, 90).
frequencia(pedro, 60).


%regra
%O aluno está aprovado SE
% nota >= 7
% frequencia >= 75
aprovado(X) :-
    nota(X, N),
    frequencia(X, F),
    N>=7,
    F>=75.

