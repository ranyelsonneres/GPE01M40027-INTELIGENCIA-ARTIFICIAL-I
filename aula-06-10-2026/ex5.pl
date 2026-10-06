% =========================
% BASE DE CONHECIMENTO
% =========================

distancia(joao, curta).
chuva(joao, nao).

distancia(maria, longa).
chuva(maria, sim).
possui_carro(maria).

distancia(pedro, longa).
chuva(pedro, nao).

% =========================
% REGRAS
% =========================

transporte(X, caminhada) :-
    distancia(X, curta),
    chuva(X, nao).

transporte(X, bicicleta) :-
    distancia(X, longa),
    chuva(X, nao).

transporte(X, carro) :-
    chuva(X, sim),
    possui_carro(X).

% =========================
% CONSULTAS
% =========================

% ?- transporte(joao, X).
% X = caminhada.

% ?- transporte(maria, X).
% X = carro.

% ?- transporte(pedro, X).
% X = bicicleta.

% Todas as recomendacoes
% ?- transporte(Pessoa, Transporte).
% Pessoa = joao, Transporte = caminhada ;
% Pessoa = pedro, Transporte = bicicleta ;
% Pessoa = maria, Transporte = carro.
