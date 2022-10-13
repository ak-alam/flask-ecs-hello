from cProfile import run
from flask import Flask
app = Flask(__name__)

@app.route('/', methods=['GET', 'POST'])
def welcome():
    return "Index Page"
    
@app.route('/hello', methods=['GET', 'POST'])
def hello_world():
    return "I'm Github Action"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)