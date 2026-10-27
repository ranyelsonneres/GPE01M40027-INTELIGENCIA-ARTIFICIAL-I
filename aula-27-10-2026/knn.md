## KNN — https://scikit-learn.org/stable/modules/generated/sklearn.neighbors.KNeighborsClassifier.html

## Base de dados: https://www.kaggle.com/competitions/titanic/data

## Etapa 1 — Importar bibliotecas

```python
import pandas as pd
import matplotlib.pyplot as plt

from sklearn.model_selection import train_test_split
from sklearn.neighbors import KNeighborsClassifier
from sklearn.preprocessing import StandardScaler
from sklearn.metrics import (
    accuracy_score, precision_score, recall_score, f1_score,
    ConfusionMatrixDisplay
)
```

## Etapa 2 — Coletar e carregar os dados

```python
from google.colab import files

files.upload()

dados = pd.read_csv("train.csv")
print(dados.head())
```

## Etapa 3 — Explorar os dados

```python
print("Quantidade de passageiros:", len(dados))
print("\nDistribuição das classes:")
print(dados["Survived"].value_counts())
print("\nValores ausentes por coluna:")
print(dados.isnull().sum())
```

## Etapa 4 — Selecionar e transformar características

```python
X = dados[["Pclass", "Sex", "Age"]].copy()
y = dados["Survived"]

X["Sex"] = X["Sex"].map({"male": 0, "female": 1})

print(X.head())
```

## Etapa 5 — Separar treinamento, validação e teste

```python
X_treino, X_temp, y_treino, y_temp = train_test_split(
    X, y, test_size=0.30, random_state=42, stratify=y
)

X_val, X_teste, y_val, y_teste = train_test_split(
    X_temp, y_temp, test_size=0.50, random_state=42, stratify=y_temp
)

print("Treinamento:", len(X_treino))
print("Validação:", len(X_val))
print("Teste:", len(X_teste))
```

## Etapa 6 — Limpar e padronizar os dados

```python
mediana_idade = X_treino["Age"].median()

X_treino = X_treino.fillna({"Age": mediana_idade})
X_val = X_val.fillna({"Age": mediana_idade})
X_teste = X_teste.fillna({"Age": mediana_idade})

escala = StandardScaler()

X_treino_esc = escala.fit_transform(X_treino)
X_val_esc = escala.transform(X_val)
X_teste_esc = escala.transform(X_teste)

print("Mediana utilizada para a idade:", mediana_idade)
print("Dados prontos para o KNN!")
```

## Etapa 7 — Treinar o primeiro KNN (K = 5)

```python
modelo = KNeighborsClassifier(n_neighbors=5)
modelo.fit(X_treino_esc, y_treino)

previsoes_val = modelo.predict(X_val_esc)
print("Acurácia inicial na validação:",
      f"{accuracy_score(y_val, previsoes_val):.2%}")
```

## Etapa 8 — Avaliar com mais métricas (validação)

```python
print("Acurácia:", f"{accuracy_score(y_val, previsoes_val):.2%}")
print("Precisão:", f"{precision_score(y_val, previsoes_val, zero_division=0):.2%}")
print("Recall:", f"{recall_score(y_val, previsoes_val, zero_division=0):.2%}")
print("F1-score:", f"{f1_score(y_val, previsoes_val, zero_division=0):.2%}")

ConfusionMatrixDisplay.from_predictions(
    y_val, previsoes_val,
    display_labels=["Não sobreviveu", "Sobreviveu"],
    cmap="Blues"
)
plt.title("Matriz de confusão — validação (K = 5)")
plt.show()
```

## Etapa 9 — Otimização simples: testar alguns valores de K

```python
valores_k = [1, 3, 5, 7, 11]
resultados = []

for k in valores_k:
    candidato = KNeighborsClassifier(n_neighbors=k)
    candidato.fit(X_treino_esc, y_treino)
    previsoes = candidato.predict(X_val_esc)

    resultados.append({
        "K": k,
        "Acurácia": accuracy_score(y_val, previsoes),
        "F1-score": f1_score(y_val, previsoes, zero_division=0)
    })

tabela = pd.DataFrame(resultados)
print(tabela.round(3).to_string(index=False))

melhor = tabela.sort_values(
    ["F1-score", "Acurácia"], ascending=False
).iloc[0]

melhor_k = int(melhor["K"])
print("\nMelhor K na validação:", melhor_k)
```

## Etapa 10 — Gráfico da otimização

```python
plt.figure(figsize=(8, 4))
plt.plot(tabela["K"], tabela["Acurácia"], marker="o", label="Acurácia")
plt.plot(tabela["K"], tabela["F1-score"], marker="s", label="F1-score")
plt.xlabel("Número de vizinhos (K)")
plt.ylabel("Desempenho")
plt.title("Comparação de valores de K — validação")
plt.ylim(0, 1)
plt.xticks(valores_k)
plt.grid(True)
plt.legend()
plt.show()
```

## Etapa 11 — Treinar modelo final e avaliar no teste

```python
X_final = X.loc[X_treino.index.union(X_val.index)].copy()
y_final = y.loc[X_final.index]

mediana_final = X_final["Age"].median()
X_final = X_final.fillna({"Age": mediana_final})
X_teste_final = X.loc[X_teste.index].fillna({"Age": mediana_final})

escala_final = StandardScaler()
X_final_esc = escala_final.fit_transform(X_final)
X_teste_final_esc = escala_final.transform(X_teste_final)

modelo_final = KNeighborsClassifier(n_neighbors=melhor_k)
modelo_final.fit(X_final_esc, y_final)
previsoes_teste = modelo_final.predict(X_teste_final_esc)

print("Acurácia:", f"{accuracy_score(y_teste, previsoes_teste):.2%}")
print("Precisão:", f"{precision_score(y_teste, previsoes_teste, zero_division=0):.2%}")
print("Recall:", f"{recall_score(y_teste, previsoes_teste, zero_division=0):.2%}")
print("F1-score:", f"{f1_score(y_teste, previsoes_teste, zero_division=0):.2%}")
```

## Etapa 12 — Matriz de confusão e gráfico das métricas finais

```python
ConfusionMatrixDisplay.from_predictions(
    y_teste, previsoes_teste,
    display_labels=["Não sobreviveu", "Sobreviveu"],
    cmap="Blues"
)
plt.title("Matriz de confusão — teste final")
plt.show()

nomes = ["Acurácia", "Precisão", "Recall", "F1-score"]
valores = [
    accuracy_score(y_teste, previsoes_teste),
    precision_score(y_teste, previsoes_teste, zero_division=0),
    recall_score(y_teste, previsoes_teste, zero_division=0),
    f1_score(y_teste, previsoes_teste, zero_division=0)
]

plt.figure(figsize=(8, 4))
plt.bar(nomes, valores)
plt.ylim(0, 1.1)
plt.ylabel("Valor da métrica")
plt.title("Avaliação final do KNN")
for i, valor in enumerate(valores):
    plt.text(i, valor + 0.02, f"{valor:.2%}", ha="center")
plt.show()
```

## Etapa 13 — Simulador: novos passageiros

```python
classe = int(input("Classe da passagem (1, 2 ou 3): "))
sexo = int(input("Sexo (0 = masculino, 1 = feminino): "))
idade = int(input("Idade: "))

passageiros = pd.DataFrame([
    [classe, sexo, idade],
    [1, sexo, idade],
    [3, sexo, idade]
], columns=["Pclass", "Sex", "Age"])

passageiros_esc = escala_final.transform(passageiros)
resultados = modelo_final.predict(passageiros_esc)

passageiros["Previsão"] = [
    "Sobreviveu" if r == 1 else "Não sobreviveu"
    for r in resultados
]

passageiros.index = ["Informado", "Classe 1", "Classe 3"]
print(passageiros)
```

## Etapa 14 — Votos dos vizinhos e gráfico

```python
votos = modelo_final.predict_proba(passageiros_esc)
indice = list(modelo_final.classes_).index(1)
percentuais = votos[:, indice] * 100

for perfil, valor in zip(passageiros.index, percentuais):
    print(f"{perfil}: {valor:.1f}% dos vizinhos votaram por sobrevivência")

plt.bar(passageiros.index, percentuais)
plt.ylabel("Vizinhos que votaram em sobrevivência (%)")
plt.ylim(0, 100)
plt.title("Comparação das previsões dos três perfis")
plt.show()
```

