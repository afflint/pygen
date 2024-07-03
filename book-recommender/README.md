### Prof. Alfio Ferrara

## Book Recommender: note di progetto



#### Acquisizione dei dati

1. Raccolta dei dati dal dataset [Books - A Dataset for Recommender Systems](https://www.kaggle.com/datasets/thedevastator/book-recommender-system-itembased)
2. Apertura dei file con [Pandas](https://pandas.pydata.org/)
   1. Introduzione a `Pandas`: `Series` e `DataFrame`
3. Archiviazione dei dati in un database relazionale 
   1. Introduzione a [SqlAlchemy](https://www.sqlalchemy.org/)
   2. Integrazione fra `SqlAlchemy` e `Pandas`
4. Analisi e visualizzazione dei dati
   1. Esempi di semplici statistiche descrittive con `Pandas`
   2. Introduzione a [Matplotlib](https://matplotlib.org/) e [Seaborn](https://seaborn.pydata.org/)

#### Rappresentazione e manipolazione dei dati

1. Creazione di oggetti per la rappresentazione di libri e utenti
   1. Introduzione alla programmazione a oggetti
   2. Modellazione concettuale

#### Data encoding

1. Introduzione al concetto di spazio vettoriale
   1. Introduzione a [NumPy](https://numpy.org/doc/stable/index.html)
   2. Matrici e vettori in `NumPy`
2. Rappresentazione dei generi e del profilo utente in termini vettoriali
3. Normalizazione e riduzione dimensionale
   1. Introduzione a [scikit-learn](https://scikit-learn.org/stable/)
4. Matching fra utenti e libri