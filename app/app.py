from flask import Flask, jsonify, render_template
import datetime
import socket

app = Flask(__name__)

@app.route('/')
def index():
    return render_template('index.html')

@app.route('/api/status')
def status():
    return jsonify({
        "status": "Healthy",
        "timestamp": datetime.datetime.now().isoformat(),
        "hostname": socket.gethostname(),
        "message": "DevOps Pipeline is fully functional!"
    })

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
