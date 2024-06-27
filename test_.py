import os
import tempfile

import pytest

from app import app


@pytest.fixture
def client():
    app.config['DOWNLOAD_FOLDER'] = tempfile.mkdtemp()
    flask_app = app
    client = flask_app.test_client()
    yield client

    for filename in os.listdir(app.config['DOWNLOAD_FOLDER']):
        file_path = os.path.join(app.config['DOWNLOAD_FOLDER'], filename)
        try:
            os.remove(file_path)
        except Exception as e:
            print(f"Failed to delete {file_path}. Reason: {e}")

    os.rmdir(app.config['DOWNLOAD_FOLDER'])


def test_index(client):
    rv = client.get('/')
    assert b'<!doctype html>' in rv.data


def test_download(client):
    url = 'https://www.youtube.com/watch?v=dZu98_pC0kU&pp=ygUNc21va2V5IG5hZ2F0YQ%3D%3D'
    test_data = client.post("/download", data=dict(url=url))
    assert test_data.status_code == 200


if __name__ == '__main__':
    pytest.main()
