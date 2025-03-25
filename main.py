from selenium import webdriver
from selenium.webdriver.common.by import By
import time
import os 
from pathlib import Path
import zipfile

home = Path(os.getcwd())
download_dir = str(home/"Downloads/pdfs")
os.makedirs(download_dir, exist_ok=True)

options = webdriver.ChromeOptions()
prefs = {
    "download.default_directory": str(download_dir),
    "plugins.always_open_pdf_externally": True,
    "download.prompt_for_download": False,
}
options.add_experimental_option("prefs",prefs)
options.add_argument("--start-maximized")

driver = webdriver.Chrome(options=options)

try:
    driver.get("https://www.gov.br/ans/pt-br/acesso-a-informacao/participacao-da-sociedade/atualizacao-do-rol-de-procedimentos")
    time.sleep(2)
    accept_cookies = driver.find_element(By.XPATH, "/html/body/div[5]/div/div/div/div/div[2]/button[3]")
    
    if accept_cookies:
        accept_cookies.click()
    else:
        print("Accept cookies button not found")

    first_link = driver.find_element(By.XPATH, '//*[@id="cfec435d-6921-461f-b85a-b425bc3cb4a5"]/div/ol/li[1]/a[1]')
    if first_link:
        first_link.click()
    else:
        print("First PDF link not found")
    time.sleep(2)


    second_link = driver.find_element(By.XPATH, '//*[@id="cfec435d-6921-461f-b85a-b425bc3cb4a5"]/div/ol/li[2]/a')
    if second_link:
        second_link.click()
    else:
        print("Second PDF link not found")
    time.sleep(2)

    downloaded_pdfs = [file for file in os.listdir(download_dir) if file.endswith(".pdf")]
    
    downloaded_paths = [os.path.join(download_dir, file)for file in downloaded_pdfs]


    zip_path = os.path.join(os.getcwd(), "pdfs_bundle.zip")
    with zipfile.ZipFile(zip_path, 'w') as zipf:
        for pdf_file in downloaded_paths:
            zipf.write(pdf_file, arcname=os.path.basename(pdf_file))

except Exception as e:
    print(f"The following error happened while downloading PDFs: {e}")

finally:
    driver.quit()



