# Fabric notebook source

# METADATA ********************

# META {
# META   "kernel_info": {
# META     "name": "synapse_pyspark"
# META   },
# META   "dependencies": {
# META     "lakehouse": {
# META       "default_lakehouse": "caea25e2-1b4f-4b81-913a-7fd6b66cce9e",
# META       "default_lakehouse_name": "LH_Bronze",
# META       "default_lakehouse_workspace_id": "dff63297-ff0e-4927-8e91-bc223e951376",
# META       "known_lakehouses": [
# META         {
# META           "id": "caea25e2-1b4f-4b81-913a-7fd6b66cce9e"
# META         }
# META       ]
# META     }
# META   }
# META }

# CELL ********************

import csv
import requests
import re
from bs4 import BeautifulSoup
import time

QUESTIONS = [
    [
        "https://data.un.org/Data.aspx?d=POP&f=tableCode%3a46&c=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18&s=_countryEnglishNameOrderBy:asc,refYear:desc,areaCode:asc&v=",
        "p_un_quarters.csv"
    ],
    [
        "https://data.un.org/Data.aspx?d=POP&f=tableCode:29&c=0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18&s=_countryEnglishNameOrderBy:asc,refYear:desc,areaCode:asc&v=",
        "r_un_attendance.csv"
    ]
]
HEADERS = {
    "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36"
}
BASE_FILE_PATH = "/lakehouse/default/Files/"

def clean_top(data):
    clean_headers = []
    for i, h in enumerate(data):
        # 1. Keep only alphanumeric and underscores
        name = re.sub(r'[^a-zA-Z0-9]+', '_', h).strip('_').lower()
                        
        # 2. Handle empty names or purely numeric names (not allowed by some DBs)
        if not name or name[0].isdigit():
            name = f"col_{i}_{name}" if name else f"column_{i}"
                        
        # 3. Truncate to 128 characters
        name = name[:128]
                        
        # 4. Ensure uniqueness
        if name in clean_headers:
            name = f"{name}_{i}"
                            
        clean_headers.append(name)
    return clean_headers

def get_rows(url, file_name):
    page = 1
    finished = False
    rows = []
    while not finished:
        time.sleep(3)

        current_url = url + str(page)
        response = requests.get(current_url, headers=HEADERS)
        soup = BeautifulSoup(response.content, 'html.parser')
        container = soup.find("div", class_="DataContainer")
        print(f"Scrapping page {page}")

        if not container:
            print("Error: Could not find 'DataContainer' on the page.")
            continue

        table = container.find("table")
        new_rows = table.find_all("tr") if table else []

        if len(new_rows) <= 1:
            print(f"Page {page} doesn't exist. Saved data until page {page-1} to file {file_name}")
            break
        
        rows.extend(new_rows)
        page += 1
    return rows

def save_data(url, file_name):
    print(f"Starting to scrap for file {file_name}")
    rows = get_rows(url, file_name)
    with open(BASE_FILE_PATH + file_name, "w", newline="", encoding="utf-8") as file:
        writer = csv.writer(file)
        for index, row in enumerate(rows):
            cells = row.find_all(["td", "th"]) 
            data = [cell.get_text(strip=True) for cell in cells]
            if data:
                if index == 0:
                    data = clean_top(data)
                writer.writerow(data)

for q in QUESTIONS:
    save_data(q[0], q[1])

# METADATA ********************

# META {
# META   "language": "python",
# META   "language_group": "synapse_pyspark"
# META }
