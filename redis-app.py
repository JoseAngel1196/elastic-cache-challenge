import psycopg2
from configparser import ConfigParser
from flask import Flask, render_template, g, abort
import redis
import time

def config(filename='config/database.ini', section='postgresql'):
    # create a parser
    parser = ConfigParser()
    # read config file
    parser.read(filename)

    # get section, default to postgresql
    db = {}
    if parser.has_section(section):
        params = parser.items(section)
        for param in params:
            db[param[0]] = param[1]
    else:
        raise Exception('Section {0} not found in the {1} file'.format(section, filename))

    return db

def fetch(sql):
    ttl = 10 # Time to live in seconds
    try:
       params = config(section='redis')
       cache = redis.Redis.from_url(params['redis_url'])
       result = cache.get(sql)

       if result:
         print('Got redis result')
         return result
       else:
         # connect to database listed in database.ini
         conn = connect()
         cur = conn.cursor()
         cur.execute(sql)
         # fetch one row
         result = cur.fetchone()
         print('Closing connection to database...')
         cur.close() 
         conn.close()

         # cache result
         cache.setex(sql, ttl, ''.join(result))
         return result

    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

def connect():
    """ Connect to the PostgreSQL database server and return a cursor """
    conn = None
    try:
        # read connection parameters
        params = config()

        # connect to the PostgreSQL server
        print('Connecting to the PostgreSQL database...')
        conn = psycopg2.connect(**params)
		
        # return a conn
        return conn
        
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)

app = Flask(__name__) 

@app.before_request
def before_request():
    g.request_start_time = time.time()
    g.request_time = lambda: "%.5fs" % (time.time() - g.request_start_time)

@app.route("/")     
def index():         
    retval = ''
    sql = 'SELECT slow_version();'

    db_result = fetch(sql)
    print('db_result', db_result)

    if not db_result:
        abort(500)
    db_version = db_result
    params = config()
    return render_template('index.html', db_version=db_version, db_host=params['host'])

if __name__ == "__main__":        # on running python app.py
    app.run()                     # run the flask app
