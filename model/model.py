import polars as pl
import joblib
from sklearn.ensemble import RandomForestClassifier
from sklearn.datasets import load_iris

def train_and_predict():
    try:
        # Load Iris dataset
        iris = load_iris()
        X = iris.data  # Features
        y = iris.target  # Target variable

        # Train model
        clf = RandomForestClassifier(n_estimators=100, random_state=42)
        clf.fit(X, y)

        # Save the model to a local file
        joblib.dump(clf, "model.pkl")
        print("Model trained and saved locally.")

        # Convert input data into a Polars DataFrame
        input_data = pl.DataFrame({name: X[:, idx] for idx, name in enumerate(iris.feature_names)})

        # Run predictions
        predictions = clf.predict(X)
        input_data = input_data.with_columns(pl.Series("predictions", predictions))

        # Save predictions to a local file
        predictions_file = "predictions.csv"
        input_data.write_csv(predictions_file)
        print("Predictions completed and saved locally.")
    except Exception as e:
        print(f"Error during training or prediction: {e}")

if __name__ == "__main__":
    train_and_predict()
