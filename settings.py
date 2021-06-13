import os

from dotenv import load_dotenv

load_dotenv()

HOST = os.environ.get('host')
DATABASE = os.environ.get('database')
USER = os.environ.get('user')
PASSWORD = os.environ.get('password')
PORT = os.environ.get('port', 5432)
REDIS_URL = os.environ.get('redis_url')
