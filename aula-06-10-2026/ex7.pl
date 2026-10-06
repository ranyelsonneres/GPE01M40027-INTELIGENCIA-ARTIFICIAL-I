% =========================
% SISTEMA ESPECIALISTA
% Diagnostico de conexao com a Internet
% =========================

diagnostico :-
    write('O roteador esta ligado? (sim/nao): '),
    read(Roteador),

    write('O computador esta conectado ao Wi-Fi? (sim/nao): '),
    read(Wifi),

    write('A Internet esta funcionando? (sim/nao): '),
    read(Internet),

    analisar(Roteador, Wifi, Internet).

% =========================
% REGRAS
% =========================

analisar(nao, _, _) :-
    write('Diagnostico: verifique o roteador.').

analisar(sim, nao, _) :-
    write('Diagnostico: verifique a conexao Wi-Fi.').

analisar(sim, sim, nao) :-
    write('Diagnostico: verifique o provedor de Internet.').

analisar(sim, sim, sim) :-
    write('Diagnostico: conexao funcionando normalmente.').

% =========================
% CONSULTA
% =========================

% ?- diagnostico.
