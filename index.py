from flask import Flask

app = Flask(__name__)

@app.route('/')
def index():
    return "サンプルだよ！"

if __name__ == '__main__':
  # app.run(debug=True)
  app.run(host='0.0.0.0', port=9090, threaded=True)
