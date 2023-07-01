import requests
import json

with open('datasets/atco1_acordaosIds.json', 'r', encoding='utf-8') as json_file:
    dataset = json.load(json_file)

with requests.Session() as session:
      for acordao in dataset:  
        response = requests.post('http://localhost:3000/acordaos', json=acordao, timeout=30)
        print(response.text)
       