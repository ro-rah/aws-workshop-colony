import os
import subprocess
from flask import Flask, render_template,request, send_file
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
   subprocess.run('screen -dmS myserver "/stop"', shell=True)
   return 'Minecraft server has been stopped'
   
@app.route('/form')
def form():
   return render_template('form.html')
   
@app.route('/uploadMCworld', methods = ['POST', 'GET'])
def uploadMCworld():
   if request.method == 'POST':
        f = request.files['zipFile']
        f.save(secure_filename(f.filename))
        return "File saved successfully"
   return "File not saved"
   
@app.route('/restoreMCworld')
def restoreMCworld():
   filePath = '/tmp/minecraft_save.zip'
   if os.path.exists(filePath):
      stopMCworld()
      subprocess.run('unzip /tmp/minecraft_save.zip -d /', shell=True)
      subprocess.run('screen -dmS myserver /usr/bin/java -jar /opt/minecraft/server.jar --nogui', shell=True)
      return 'MC Server restored!'
   elif:
      return 'Save file does not exist in /tmp, have you uploaded it?'
    
      
if __name__ == '__main__':
   app.run(host='0.0.0.0', port=8000, debug=True)
