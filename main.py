'''
 - Improve Front End
    *Make website more dynamic
    *Allow for files
 - Make back end simpler
 - Simplify Back end
 - Improve Performance
 - Improve recognition using Audiveris
    *Sharps and Flats
    *Chords

set FLASK_APP=main.py
flask run

'''

import convert
from flask import Flask, request, render_template

app = Flask(__name__)

@app.route('/')
#@app.route('/<name>')
def index():

   return render_template("index.html")


@app.route('/translate', methods=['POST', 'GET'])
#@app.route('/translate/<name>')
def translate():

   #get request, probably keep in flask file
   if request.method == 'POST':
       f = request.files['file']
       f.save(str(f.filename))

   c = convert.Convert(f.filename)
   final = c.convert()
   return render_template("translate.html", strings=final)

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0', threaded=True)
