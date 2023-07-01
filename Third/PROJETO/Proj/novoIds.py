import json
import nanoid
import time

start_time = time.time()

files = ['jtrl_acordaos.json','jtrp_acordaos.json']
for file in files:
    with open(file, 'r', encoding='utf-8') as json_file:
        dataset = json.load(json_file)

    for acordao in dataset:
        acordao["id"] = nanoid.generate(size=10)

    with open(f'{file[:-5]}_Ids.json', 'w', encoding='utf-8') as f:
        json.dump(dataset, f, ensure_ascii=False, indent=4)
        
end_time = time.time()

print("tempo de execução:" + end_time - start_time + "segundos")
