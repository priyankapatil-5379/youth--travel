
import re
from collections import Counter

file_path = r'C:\Users\LENOVO\git\Youth_Travel\src\main\java\com\youthtravel\entity\Trip.java'

with open(file_path, 'r') as f:
    lines = f.readlines()

fields = []
for line in lines:
    match = re.search(r'private\s+[\w<>]+\s+(\w+)\s*[;=]', line)
    if match:
        fields.append(match.group(1))

duplicates = [item for item, count in Counter(fields).items() if count > 1]
print("Duplicate fields found:", duplicates)
