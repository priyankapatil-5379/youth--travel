
import re

file_path = r'C:\Users\LENOVO\git\Youth_Travel\src\main\java\com\youthtravel\entity\Trip.java'

with open(file_path, 'r') as f:
    lines = f.readlines()

for i, line in enumerate(lines):
    stripped = line.strip()
    if stripped.startswith('private ') and not stripped.endswith(';') and '=' not in stripped:
        print(f"Potential missing semicolon at line {i+1}: {stripped}")
    if stripped.startswith('private ') and '=' in stripped and not stripped.endswith(';'):
        print(f"Potential missing semicolon at line {i+1}: {stripped}")
