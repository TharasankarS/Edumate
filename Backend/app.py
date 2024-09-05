# server.py
from flask import Flask, request, jsonify

app = Flask(__name__)


@app.route('/name', methods=['GET', 'POST'])
def generate():

    global response

    if (request.method == 'POST'):
        request_data = request.data
        request_data = json.loads(request_data.decode('utf-8'))
        name = request_data['name']
        print(name)


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
