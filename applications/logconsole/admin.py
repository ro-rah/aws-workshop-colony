import os
import subprocess
from flask import Flask, render_template,request, send_file, Response
from werkzeug.utils import secure_filename
app = Flask(__name__)

@app.route('/')
def hello_world():
   return 'Hello World'
   
@app.route('/saveMCworld')
def saveMCworld():
   #Connect to screen session using subprocess
   # https://unix.stackexchange.com/questions/541254/python-open-screen-and-execute-inside-screen
   #Running commands in screen: https://serverfault.com/questions/104668/create-screen-and-run-command-without-attaching
   subprocess.run('screen -dmS myserver "/save-all"', shell=True)
   
   #now back up the minecraft server
   #if old zip exists, delete and create new
   filePath = '/tmp/minecraft_save.zip'
   if os.path.exists(filePath):
      os.remove(filePath)
   p = subprocess.run('zip -r /tmp/minecraft_save.zip /opt/minecraft/', shell=True)

   try:
      return send_file('/tmp/minecraft_save.zip', attachment_filename='minecraft_save.zip')
   except Exception as e:
      return str(e)
      
#ToDo: Test this out while in a MC world
@app.route('/stopMCworld')
def stopMCworld():
   #Connect to screen session using subprocess
   # https://unix.stackexchange.com/questions/541254/python-open-screen-and-execute-inside-screen
   #Running commands in screen: https://serverfault.com/questions/104668/create-screen-and-run-command-without-attaching
   subprocess.run('screen -S myserver -p 0 -X quit', shell=True)
   return 'Minecraft server has been stopped'
   
@app.route('/form')
def form():
   return render_template('form.html')
   
@app.route('/renderLog', methods = ['POST', 'GET'])
def renderLog():
   if request.method == 'POST':
        print(request.form['logpath'])
        f = open(request.form['logpath'], 'r')
        filecontents = f.read()
        f.close()
        print(filecontents)
        return Response(filecontents, mimetype='text/plain')
   return f
   
@app.route('/restoreMCworld')
def restoreMCworld():
   filePath = '/tmp/minecraft_save.zip'
   if os.path.exists(filePath):
      stopMCworld()
      subprocess.run('unzip -o /tmp/minecraft_save.zip -d /', shell=True)
      subprocess.run('screen -dmS myserver /usr/bin/java -jar /opt/minecraft/server.jar --nogui', shell=True, cwd='/opt/minecraft')
      return 'MC Server restored!'
   else:
      return 'Save file does not exist in /tmp, have you uploaded it?'
    
      
if __name__ == '__main__':
   app.run(host='0.0.0.0', port=8000, debug=True)
