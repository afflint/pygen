from sqlalchemy import create_engine, text 
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import numpy as np
from sklearn.preprocessing import MinMaxScaler
from sklearn.metrics import pairwise_distances

sns.set_theme(style="ticks")


class KMeans:
    
    def __init__(self, k: int, data: np.ndarray):
        self.k = k
        self.data = data
        indexes = np.random.choice(range(data.shape[0]), 
                                size=k, replace=False)
        self.centroids = data[indexes]
        self.assignment = np.zeros(len(self.data.shape))
    
    def distance(self):
        delta = pairwise_distances(self.data, self.centroids)
        return delta
    
    def assign(self, delta):
        assignment = []
        for x in delta:
            assignment.append(np.argmin(x))
        self.assignment = np.array(assignment)
    
    def rss(self, delta):
        rss = 0
        for i, x in enumerate(delta):
            d = delta[i, self.assignment[i]]
            rss += d
        return rss

    def update_centroids(self):
        clusters = {}
        for i in range(self.centroids.shape[0]):
            cluster_points = []
            for j, a in enumerate(self.assignment):
                if a == i:
                    cluster_points.append(self.data[j])
            clusters[i] = np.array(cluster_points)
        for k, v in clusters.items():
            self.centroids[k] = v.mean(axis=0)
            
    def run(self, max_iterations: int = 1000):
        history = []
        current_rss = float('inf')
        for execution in range(max_iterations):
            delta = self.distance()
            self.assign(delta=delta)
            rss = self.rss(delta=delta)
            history.append(rss)
            diff = current_rss - rss 
            if diff < 0.00001:
                break
            current_rss = rss
            self.update_centroids()
        return history
        
    

class Books:
    
    def __init__(self, connection_string: str, scaling: bool = True):
        self.engine = create_engine(connection_string)
        self.sql_2 = """
        SELECT B.author, R.rating
        FROM rating AS R JOIN books AS B
        ON R.book = B.id
        WHERE B.author in ('Douglas Adams', 'Markus Zusak')
        """
        self.sql_1 = """
        SELECT B.author, AVG(R.rating) AS avg_rating, COUNT(*) AS num_ratings
        FROM rating AS R JOIN books AS B
        ON R.book = B.id
        GROUP BY B.author
        """ 
        self.sql_3 = """
        SELECT R.user, G.genre, SUM(R.rating) AS score
        FROM rating AS R JOIN genre AS G
        ON R.book = G.book
        GROUP BY R.user, G.genre
        """
        self.profile = self.vectorize_users(scaling=scaling)

    
    def search(self, sql: str):
        conn = self.engine.connect()
        answer = pd.read_sql(sql=text(sql), con=conn)
        conn.close()
        return answer
    
    def create_plots(self):
        answer_2 = self.search(sql=self.sql_2)
        answer_2bis = self.search(self.sql_1)
        fig, ax = plt.subplots(figsize=(10, 10), ncols=2, nrows=2)
        sns.boxplot(answer_2, x='author', y='rating', 
            palette="vlag", hue='author', ax=ax[0, 0])
        sns.stripplot(answer_2, ax=ax[0, 1], x='author', y='rating')
        sns.scatterplot(answer_2bis, x='avg_rating', 
                        y='num_ratings', ax=ax[1, 0])
        sns.histplot(answer_2bis, x='num_ratings', ax=ax[1, 1])
        plt.tight_layout()
        plt.show()
        
    def vectorize_users(self, scaling: bool = True):
        answer_3 = self.search(sql=self.sql_3)
        genre_list = list(answer_3.genre.unique())
        user_list = list(answer_3.user.unique())
        profile_matrix = np.zeros((len(user_list), len(genre_list)))
        users = answer_3['user']
        scores = answer_3['score']
        genres = answer_3['genre']
        for i, user in enumerate(users):
            u, s, g = user, scores[i], genres[i]
            user_index = user_list.index(u)
            genre_index = genre_list.index(g)
            profile_matrix[user_index, genre_index] = s
        if scaling:
            scaler = MinMaxScaler()
            profile_matrix = scaler.fit_transform(profile_matrix)
        return pd.DataFrame(profile_matrix, index=user_list, columns=genre_list)
    
    def get_user_profile(self, user: int):
        return self.profile.loc[user]
    
    def get_genre_profile(self, genre: str):
        return self.profile[genre]
    
    
        
