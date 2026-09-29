  %representar um fato
  aluno(joao).
  aluno(maria).
  professor(carlos).

  %relações (fato que junta dois elementos)
  gosta(joao, futebol).
  mora(maria, brasilia).

  %regra (SE..ENTAO)
  % Uma pessoa participa da comunidade academica
  %Ela pode acessar o sistema
  pode_acessar(X) :-
      aluno(X);
      professor(X).




