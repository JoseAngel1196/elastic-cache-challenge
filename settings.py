import os

from dotenv import load_dotenv

load_dotenv()

HOST = os.environ.get('host')
DATABASE = os.environ.get('database')
USER = os.environ.get('user')
PASSWORD = os.environ.get('password')
PORT = os.environ.get('PORT')