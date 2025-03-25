import pandas as pd
import pdfplumber
import zipfile
import os
from pathlib import Path

all_tables = []

with pdfplumber.open("downloads/pdfs/Anexo_I_Rol_2021RN_465.2021_RN627L.2024.pdf") as pdf:
    for page in pdf.pages[2:]:
        tables = page.extract_tables()
        print(f"extracting page:{page}")
        for table in tables:
            header = table[0]
            rows =  table[1:]
            page_dataframe = pd.DataFrame(rows, columns=header)
            all_tables.append(page_dataframe)


final_dataframe = pd.concat(all_tables, ignore_index=True)
final_dataframe.rename(columns={
    "OD": "Seg. Odontológica",
    "AMB": "Seg. Ambulatorial"
}, inplace=True)
final_dataframe.to_csv("question2.csv", index=False)


output_dir = Path(os.getcwd())/"downloads/extracted_data"
output_dir.mkdir(exist_ok=True) 


zip_path = output_dir / "Teste_Yago_Lobo.zip"
with zipfile.ZipFile(zip_path, 'w') as zipf:
    zipf.write("question2.csv")