import tkinter as tk
from collections import deque

GRAFO = {
    "A": ["B", "C"],
    "B": ["D", "E"],
    "C": ["F", "G"],
    "D": [],
    "E": [],
    "F": [],
    "G": []
}

POSICOES = {
    "A": (300, 70),
    "B": (180, 170),
    "C": (420, 170),
    "D": (100, 290),
    "E": (230, 290),
    "F": (370, 290),
    "G": (500, 290)
}

INICIO = "A"
OBJETIVO = "G"


class BFSVisual:
    def __init__(self, janela):
        self.janela = janela
        self.janela.title("Busca em Largura - BFS")

        self.canvas = tk.Canvas(
            janela,
            width=600,
            height=380,
            bg="white"
        )
        self.canvas.grid(row=0, column=0, rowspan=8, padx=20, pady=20)

        tk.Label(
            janela,
            text="Busca em Largura (BFS)",
            font=("Arial", 18, "bold")
        ).grid(row=0, column=1, sticky="w", padx=10)

        self.lbl_passo = tk.Label(
            janela,
            text="Passo: 0",
            font=("Arial", 12, "bold")
        )
        self.lbl_passo.grid(row=1, column=1, sticky="w", padx=10)

        tk.Label(
            janela,
            text="Estado atual:",
            font=("Arial", 11, "bold")
        ).grid(row=2, column=1, sticky="w", padx=10)

        self.lbl_atual = tk.Label(
            janela,
            text="-",
            font=("Arial", 11)
        )
        self.lbl_atual.grid(row=2, column=1, sticky="e", padx=10)

        tk.Label(
            janela,
            text="Fila:",
            font=("Arial", 11, "bold")
        ).grid(row=3, column=1, sticky="nw", padx=10)

        self.txt_fila = tk.Text(
            janela,
            width=28,
            height=3,
            font=("Courier", 12)
        )
        self.txt_fila.grid(row=4, column=1, padx=10, sticky="w")

        tk.Label(
            janela,
            text="Explicação:",
            font=("Arial", 11, "bold")
        ).grid(row=5, column=1, sticky="nw", padx=10)

        self.lbl_explicacao = tk.Label(
            janela,
            text="Clique em 'Próximo passo' para iniciar.",
            justify="left",
            wraplength=260,
            font=("Arial", 11)
        )
        self.lbl_explicacao.grid(row=6, column=1, sticky="nw", padx=10)

        botoes = tk.Frame(janela)
        botoes.grid(row=7, column=1, pady=15)

        tk.Button(
            botoes,
            text="Próximo passo",
            command=self.proximo_passo,
            font=("Arial", 11, "bold"),
            width=14
        ).pack(side="left", padx=5)

        tk.Button(
            botoes,
            text="Reiniciar",
            command=self.reiniciar,
            font=("Arial", 11),
            width=10
        ).pack(side="left", padx=5)

        self.reiniciar()

    def reiniciar(self):
        self.fila = deque([INICIO])
        self.visitados = {INICIO}
        self.analisados = set()
        self.atual = None
        self.passo = 0
        self.finalizado = False
        self.lbl_explicacao.config(
            text="A fila começa com o estado inicial A."
        )
        self.atualizar_painel()
        self.desenhar()

    def proximo_passo(self):
        if self.finalizado:
            return

        if not self.fila:
            self.lbl_explicacao.config(
                text="A fila ficou vazia. O objetivo não foi encontrado."
            )
            self.finalizado = True
            return

        self.passo += 1

        self.atual = self.fila.popleft()

        if self.atual == OBJETIVO:
            self.analisados.add(self.atual)
            self.lbl_explicacao.config(
                text=f"O estado {OBJETIVO} foi retirado da fila. Objetivo encontrado!"
            )
            self.finalizado = True
            self.atualizar_painel()
            self.desenhar()
            return

        novos = []

        for vizinho in GRAFO[self.atual]:
            if vizinho not in self.visitados:
                self.visitados.add(vizinho)
                self.fila.append(vizinho)
                novos.append(vizinho)

        self.analisados.add(self.atual)

        if novos:
            self.lbl_explicacao.config(
                text=(
                    f"{self.atual} saiu da fila.\n"
                    f"Novos estados encontrados: {', '.join(novos)}.\n"
                    f"Eles foram adicionados ao final da fila."
                )
            )
        else:
            self.lbl_explicacao.config(
                text=(
                    f"{self.atual} saiu da fila.\n"
                    "Esse estado não possui novos vizinhos para adicionar."
                )
            )

        self.atualizar_painel()
        self.desenhar()

    def atualizar_painel(self):
        self.lbl_passo.config(text=f"Passo: {self.passo}")
        self.lbl_atual.config(text=self.atual if self.atual else "-")

        self.txt_fila.delete("1.0", tk.END)
        self.txt_fila.insert(tk.END, str(list(self.fila)))

    def desenhar(self):
        self.canvas.delete("all")

        
        for no, vizinhos in GRAFO.items():
            x1, y1 = POSICOES[no]

            for vizinho in vizinhos:
                x2, y2 = POSICOES[vizinho]

                self.canvas.create_line(
                    x1, y1, x2, y2,
                    width=3,
                    fill="gray"
                )


        raio = 30

        for no, (x, y) in POSICOES.items():

            if no == self.atual:
                cor = "orange"
            elif no in self.analisados:
                cor = "lightgray"
            elif no in self.visitados:
                cor = "gold"
            else:
                cor = "white"

            if no == OBJETIVO and self.finalizado:
                cor = "lightgreen"

            self.canvas.create_oval(
                x - raio,
                y - raio,
                x + raio,
                y + raio,
                fill=cor,
                outline="black",
                width=2
            )

            self.canvas.create_text(
                x,
                y,
                text=no,
                font=("Arial", 16, "bold")
            )

        self.canvas.create_text(
            15,
            345,
            anchor="w",
            text="Amarelo = na fila | Laranja = atual | Cinza = analisado | Verde = objetivo",
            font=("Arial", 10)
        )


janela = tk.Tk()
app = BFSVisual(janela)
janela.mainloop()
