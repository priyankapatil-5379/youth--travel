import sys
import re

file_path = 'src/main/webapp/views/vendor/view-trip.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix opacity classes that make text invisible
content = re.sub(r'opacity-\d+', '', content)
content = content.replace('text-white-50', 'text-muted')

# Fix "bg-light" on badges that might render dark
content = content.replace('bg-light text-teal', 'bg-white text-teal')

# Fix info-value text-teal if not intended
# Let's remove text-teal from info-value if it's there
content = content.replace('info-value text-teal', 'info-value text-dark')

# Fix small text readability
content = content.replace('text-muted lead', 'text-dark lead')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Opacity issues and badge background fixed!')
