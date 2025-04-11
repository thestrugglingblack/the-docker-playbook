import boto3
import polars as pl
import os
from io import StringIO
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
import traceback
import tempfile
import pickle


def train_and_predict(
        S3_BUCKET_NAME: str,
        DATA_FOLDER: str,
        RESULTS_FOLDER: str,
        MODEL_FOLDER: str
):
    try:
        print('Reading data...')
        s3 = boto3.client('s3')
        response = s3.get_object(Bucket=S3_BUCKET_NAME, Key=DATA_FOLDER)
        print(f"The key '{DATA_FOLDER}' does not exist in the bucket '{S3_BUCKET_NAME}'.")
        body = response['Body'].read().decode('utf-8')
        df = pl.read_csv(StringIO(body))

        features = ['x', 'y', 'a', 'dis', 'o', 'dir']
        target = 's'
        df = df.drop_nulls(subset=features + [target])

        X = df.select(features).to_numpy()
        y = df.select(target).to_numpy().ravel()

        X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

        print('Training model...')
        model = RandomForestRegressor(n_estimators=100, random_state=42)
        model.fit(X_train, y_train)

        print('Running predictions...')
        y_pred = model.predict(X_test)

        results_df = pl.DataFrame({
            'x': X_test[:, 0],
            'y': X_test[:, 1],
            'a': X_test[:, 2],
            'dis': X_test[:, 3],
            'o': X_test[:, 4],
            'dir': X_test[:, 5],
            'actual_s': y_test,
            'predicted_s': y_pred
        })

        csv_buffer = StringIO()
        results_df.write_csv(csv_buffer)
        s3.put_object(Bucket=S3_BUCKET_NAME, Key=RESULTS_FOLDER, Body=csv_buffer.getvalue())
        print('Savings prediction results to temp...')
        temp_dir = tempfile.mkdtemp()
        model_path = os.path.join(temp_dir, 'model.pkl')

        with open(model_path, 'wb') as f:
            pickle.dump(model, f)
        print('Uploading results to S3...')
        with open(model_path, 'rb') as f:
            s3.upload_fileobj(f, S3_BUCKET_NAME, MODEL_FOLDER)

        print("✅ Successfully trained model, results are now in S3.")
        return {
            'statusCode': 200,
            'body': 'Model trained and files saved to S3 successfully.'
        }

    except Exception as e:
        print("❌ An error occurred during training or prediction.")
        print(f"Error: {e}")
        traceback.print_exc()
        return {
            'statusCode': 500,
            'body': f'Error: {str(e)}'
        }


if __name__ == "__main__":
    S3_BUCKET_NAME = os.getenv("S3_BUCKET_NAME")
    DATA_FOLDER = os.getenv("DATA_FOLDER")
    RESULTS_FOLDER = os.getenv("RESULTS_FOLDER")
    MODEL_FOLDER = os.getenv("MODEL_FOLDER")


    if not all([S3_BUCKET_NAME, DATA_FOLDER, RESULTS_FOLDER, MODEL_FOLDER]):
        print(f"S3_BUCKET_NAME: {S3_BUCKET_NAME}")
        print(f"DATA_FOLDER: {DATA_FOLDER}")
        print(f"RESULTS_FOLDER: {RESULTS_FOLDER}")
        print(f"MODEL_FOLDER: {MODEL_FOLDER}")
        raise EnvironmentError("Missing one or more required environment variables.")

    train_and_predict(
        S3_BUCKET_NAME=S3_BUCKET_NAME,
        DATA_FOLDER=DATA_FOLDER,
        RESULTS_FOLDER=RESULTS_FOLDER,
        MODEL_FOLDER=MODEL_FOLDER
    )
