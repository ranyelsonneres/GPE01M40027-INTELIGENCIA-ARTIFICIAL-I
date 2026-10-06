% =========================
% BASE DE CONHECIMENTO
% =========================

gosta(joao, futebol).
gosta(maria, musica).
gosta(pedro, futebol).
gosta(ana, jogos).
gosta(lucas, musica).

% =========================
% CONSULTAS
% =========================

% Quem gosta de futebol?
% ?- gosta(X, futebol).
% X = joao ;
% X = pedro.

% Quem gosta de musica?
% ?- gosta(X, musica).
% X = maria ;
% X = lucas.

% Do que Ana gosta?
% ?- gosta(ana, X).
% X = jogos.

% Todas as pessoas e seus respectivos interesses
% ?- gosta(X, Y).
% X = joao, Y = futebol ;
% X = maria, Y = musica ;
% X = pedro, Y = futebol ;
% X = ana, Y = jogos ;
% X = lucas, Y = musica.
