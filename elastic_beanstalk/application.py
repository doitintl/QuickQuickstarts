from flask import Flask

application = Flask(__name__)

application.add_url_rule('/', 'index', (lambda: 'Hello, World!' ))

if __name__ == "__main__":
    application.run()
