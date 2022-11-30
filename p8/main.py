import datetime

def openTabop():
    tabopFile = open("tabop.txt", "r")
    tabop = dict()
    for currentLine in tabopFile:
        nemonics=currentLine.split(" ") 
        tabop[nemonics[0]]=nemonics[1]
    tabopFile.close()
    return tabop

if __name__ == "__main__":

    filename=input("Ingresa la ruta y con el nombre del archivo asm: ")
    asmFile = open(filename,"r")

    outputPath=filename[:-3]+"lst"
    outputFilenameList = outputPath.split("\\")
    outputFilename = outputFilenameList[len(outputFilenameList)-1]

    outputFile = open(outputFilename,"w")

    tabopDict=openTabop()

    outputString = outputFilename
    outputFile.write(outputString+"-- Lisseth Abigail Martinez Castillo -- \n\n")

    outputString=str(datetime.datetime.now())
    outputFile.write("["+outputString+"]\n\n")

    outputString = ""

    lineCounter = 0
    contloc = 0
    headerLst="="
    for i in range (99):
        headerLst+="="
    
    headerString="[LINE]      LOC:                                SOURCE\n"
    outputFile.write(headerLst+"\n")
    outputFile.write(headerString)
    outputFile.write(headerLst+"\n")

    
    for currentLine in asmFile:
        auxList = []
        operandList = []
        lineCounter += 1
        
        outputString = "[{:>6}]    ".format(lineCounter)
        line = currentLine.strip()
        newLine = line.split(" ") #linea del archivo asm actual hecho lista
        # print(newLine)
        # print(lineCounter)
        # input()
        if newLine[0].upper() in tabopDict:
            if(len(newLine)) == int(tabopDict[newLine[0].upper()]):
                outputString+="0{0:x}:".format(contloc).upper()
                contloc+=int(tabopDict[newLine[0].upper()])

            elif (len(newLine)) < int(tabopDict[newLine[0].upper()]):
                auxList = []
                operandList = []
                
                if "," in newLine[1]:
                    auxList.append(newLine[0])
                    operandList = newLine[1].split(",")
                    
                    auxList.append(operandList[0])
                    auxList.append(operandList[1])

                if(len(auxList))== int(tabopDict[auxList[0].upper()]):
                    outputString+="0{0:x}:".format(contloc).upper()
                    contloc+=int(tabopDict[auxList[0].upper()]) 


            else:
                auxList = []
                operandList = []
                   
                for i in newLine:
                    if ";" in i:
                        break

                    if i != "":
                        auxList.append(i) 
                
                # print(auxList)
                # input()

                if(len(auxList))== int(tabopDict[auxList[0].upper()]):
                    outputString+="0{0:x}:".format(contloc).upper()
                    contloc+=int(tabopDict[auxList[0].upper()])

                elif (len(auxList)) < int(tabopDict[auxList[0].upper()]):
                    auxiliar=[]
                    finalOutput =[]
                    if "," in auxList[1]:
                        finalOutput.append(auxList[0])
                        auxiliar = auxList[1].split(",")
                        
                        finalOutput.append(auxiliar[0])
                        finalOutput.append(auxiliar[1])

                    if(len(finalOutput))== int(tabopDict[finalOutput[0].upper()]):
                        outputString+="0{0:x}:".format(contloc).upper()
                        contloc+=int(tabopDict[finalOutput[0].upper()]) 
                
                


                    
                
        elif newLine[0].upper() == 'ORG':
                contloc = int(newLine[1][:-1],base=16)
                outputString+="    :"
              
        else:
                outputString+="    :  "

        outputString += "                             {:<5}".format(line)
        outputFile.write(outputString+"\n")
    
    outputFile.close()
    asmFile.close()
    input("Archivo lst generado, presione enter para finalizar")

        


        


        

