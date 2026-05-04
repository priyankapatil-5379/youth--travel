
file_path = r'C:\Users\LENOVO\git\Youth_Travel\src\main\java\com\youthtravel\entity\Trip.java'

with open(file_path, 'r') as f:
    content = f.read()

stack = []
for i, char in enumerate(content):
    if char == '{':
        stack.append(i)
    elif char == '}':
        if not stack:
            print(f"Extra closing brace at position {i}")
        else:
            stack.pop()

if stack:
    print(f"Missing closing braces. Unclosed at positions: {stack}")
else:
    print("Braces are balanced.")
