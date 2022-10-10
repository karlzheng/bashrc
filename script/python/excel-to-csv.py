#https://github.com/cms-WebDesign/excel-to-csv/blob/main/excel-to-csv.py
'''
A simple python program that will convert an excel spreedsheet
and its subsheets into valid csv files. It will grab all '.xls' or
'.xlsx' files in the current directory and export them to a 
Excel-friendly csv format. 

Files will be named as 'ExcelFileName.SheetName.csv'
'''

import os
import pandas as pd
import glob
import shutil

# Sets the directory path to the current working directory where the CSV files are located
directory_path = os.getcwd() 

# Replaces the '\' with '/' so python can access the directory and files correctly
#directory_path = directory_path.replace("\\", "/")

# Creates a list of all the xlsx or xlx files in the Q2 Directory.
xlsx_files = glob.glob(os.path.join(directory_path, "*.xls*"))

# Loops through each xls and xlsx file and creats a .csv for each sheet
for file in xlsx_files:
    print("file:", file)
    xlsx_file = pd.read_excel(file, sheet_name=None)

    #Gets the last part of the directory path so we can append it to the file name
    name =file.rsplit('/', 1)[1]
    print(name)

    # Loops through each sheet of the xlx or xlsx file and converts it to a csv
    for key in xlsx_file.keys(): 
        xlsx_file[key].to_csv(name + '{}.csv'.format(key))
        
