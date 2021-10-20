import subprocess
from flask import Flask
app = Flask(__name__)

@app.route('/')
def hello_world():
   return 'Hello World'
   
@app.route('/saveMCworld')
def saveMCworld():
   #Connect to screen session using subprocess
   # https://unix.stackexchange.com/questions/541254/python-open-screen-and-execute-inside-screen
   #Running commands in screen: https://serverfault.com/questions/104668/create-screen-and-run-command-without-attaching
   subprocess.call('ls -la', shell=True)
   return 'Minecraft server world saved'

if __name__ == '__main__':
   app.run(host='0.0.0.0', port=8000, debug=True)
