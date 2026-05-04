
import re
from collections import Counter

file_path = r'C:\Users\LENOVO\git\Youth_Travel\src\main\java\com\youthtravel\entity\Trip.java'

with open(file_path, 'r') as f:
    lines = f.readlines()

methods = []
for line in lines:
    match = re.search(r'public\s+[\w<>]+\s+(\w+)\s*\(', line)
    if match:
        methods.append(match.group(1))
    match = re.search(r'protected\s+[\w<>]+\s+(\w+)\s*\(', line)
    if match:
        methods.append(match.group(1))

duplicates = [item for item, count in Counter(methods).items() if count > 1]
print("Duplicate methods found:", duplicates)
