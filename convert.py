import subprocess
import xml.etree.ElementTree as ET
import os
import zipfile
from flask import Flask, request, render_template
import shutil


class Convert():

    def __init__(self, file_name, directory=os.getcwd()):

        self.file = file_name
        self.home_dir = directory


    def convert(self):

        '''
            Takes: no parameters, uses self.file_name
            Return Tablature object
        '''
        print os.getcwd()
        ##Feed file to Audiveris and recieve XML

        os.system('./audiveris/Audiveris/bin/Audiveris -batch -transcribe -output "' + self.home_dir + '" -- "' + self.file + '"')

        ##Unzip OMR file

        parsed = str(self.file.split(".")[0])
        try:
                os.makedirs(parsed)
        except:
                pass

        os.chdir(parsed)
        self.unzip_omr(parsed)

        ##Get Tabs

        files = os.listdir(self.home_dir + "/" + parsed)

        final = []
        for name in files:

            if name[:6] == "sheet#":

                 os.chdir(self.home_dir + "/" + parsed + "/" + name)
                 final.append(self.make_tabs(name))


        #clean up

        os.chdir(self.home_dir)
        #os.remove(self.home_dir + "/" + parsed)
        shutil.rmtree(self.home_dir + "/" + parsed)

        #return the results

        f = open("dl.txt", "w")
        for i in final:
            for a in i:
                for b in a:
                    f.write(b)

        f.close()
        return final


    def unzip_omr(self, OMR_file_name):

        print(os.getcwd())
        os.rename(OMR_file_name + ".omr", OMR_file_name + ".zip")

        zip_ref = zipfile.ZipFile(OMR_file_name + ".zip", 'r')
        zip_ref.extractall(self.home_dir + "/" + OMR_file_name)
        zip_ref.close()


    def make_tabs(self, XML_file_name):

        #Parse XML

        tree = ET.parse(XML_file_name + ".xml")
        root = tree.getroot()

        #Setup lists

        rawNotes = [[]]
        new = []
        new2 = []
        new3 = []
        new4 = []
        exception = [18, 14, 11, 7, 4, 0, -3, -7, -10, -14]
        reference1 = [[11, 6, 0],
                     [10, 6, 1],
                     [9.5, 6, 2],
                     [9, 6, 3],
                     [8.5, 6, 4],
                     [8, 5, 0],
                     [7.5, 5, 1],
                     [7, 5, 2],
                     [6, 5, 3],
                     [5, 4, 0],
                     [4.5, 4, 1],
                     [4, 4, 2],
                     [3, 4, 3],
                     [3.5, 4, 4],
                     [2, 3, 0],
                     [1.5, 3, 1],
                     [1, 3, 2],
                     [0.5, 3, 3],
                     [0, 2, 0],
                     [-1, 2, 1],
                     [-1.5, 2, 2],
                     [-2, 2, 3],
                     [-2.5, 2, 4],
                     [-3, 1, 0],
                     [-4, 1, 1],
                     [-4.5, 1, 2],
                     [-5, 1, 3],
                     [-5.5, 1, 4],
                     [-6, 1, 5],
                     [-6.5, 1, 6],
                     [-7, 1, 7],
                     [-8, 1, 8],
                     [-8.5, 1, 9],
                     [-9, 1, 10],
                     [-9.5, 1, 11],
                     [-10, 1, 12],
                     [-11, 1, 13],
                     [-11.5, 1, 14],
                     [-12, 1, 15],
                     [-12.5, 1, 16],
                     [-13, 1, 17],
                     [-13.5, 1, 16],
                     [-14, 1, 19]]


        #Get pitch, staff, and x coord of each note

        line_num = 1

        def test(item):
            return item[1]

        accidentals = []
        for acc in root.iter("alter"):
            if acc.get("shape") == "SHARP":
                accidentals.append(['sharp', acc.get('id')])
            elif acc.get("shape") == "FLAT":
                accidentals.append(['flat', acc.get('id')])

        print accidentals

        relations = []
        for rel in root.iter("relation"):
            for i in accidentals:
                if i[1] == rel.get("source"):
                    relations.append([i[0], rel.get("target")])
        print relations

        for head in root.iter("head"):

            pitch = int(head.get("pitch"))
            for i in relations:
                if head.get("id") == i[1]:
                    if i[0] == 'sharp':
                        if pitch in exception:
                            pitch -= 1
                        else:
                            pitch -= .5
                    if i[0] == 'flat':
                        if pitch - 1 in exception:
                            pitch += 1
                        else:
                            pitch += .5

            if line_num == int(head.get('staff')):
                #rawNotes[line_num - 1].append([head.get('pitch'), head.get('staff'), head.find('bounds').get('x'), head.get('id')])]
                rawNotes[line_num - 1].append([pitch, int(head.find('bounds').get('x')), head.get('id')])
            else:
                #rawNotes.append([[head.get('pitch'), head.get('staff'), head.find('bounds').get('x'), head.get('id')]])
                rawNotes.append([[pitch, int(head.find('bounds').get('x')), head.get('id')]])
                rawNotes[line_num - 2] = sorted(rawNotes[line_num - 2], key = test)
                line_num += 1

        print rawNotes

        #Order notes by X coord
        #Remove X coord from list

        current = 0
        for x in rawNotes:
            new3.append([])
            temp = new3[current]
            for y in x:
                temp.append(y[0])
            current+=1

        #convert pitch to tab fret and finger

        current = 0
        for b in new3:
            new4.append([])
            temp = new4[current]
            for e in b:
                for i in reference1:
                    if e == i[0]:
                        temp.append([i[1], i[2]])

            current+=1

        #compile the tabs
        final = []
        for b in new4:
            string1 = ""
            string2 = ""
            string3 = ""
            string4 = ""
            string5 = ""
            string6 = ""

            for i in b:
                if i[0] == 6:
                    string6 += "-" + str(i[1]) + "-"
                else:
                    string6 += "---"

            for i in b:
                if i[0] == 5:
                    string5 += "-" + str(i[1]) + "-"
                else:
                    string5 += "---"

            for i in b:
                if i[0] == 4:
                    string4 += "-" + str(i[1]) + "-"
                else:
                    string4 += "---"

            for i in b:
                if i[0] == 3:
                    string3 += "-" + str(i[1]) + "-"
                else:
                    string3 += "---"

            for i in b:
                if i[0] == 2:
                    string2 += "-" + str(i[1]) + "-"
                else:
                    string2 += "---"

            for i in b:
                if i[0] == 1:
                    string1 += "-" + str(i[1]) + "-"
                else:
                    string1 += "---"

            temp = []
            if string1 != "":

                temp.append(string1)
                temp.append(string2)
                temp.append(string3)
                temp.append(string4)
                temp.append(string5)
                temp.append(string6)

                print temp

                final.append(temp)

        return final


