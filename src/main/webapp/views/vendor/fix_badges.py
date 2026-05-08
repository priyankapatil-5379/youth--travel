import sys

file_path = 'src/main/webapp/views/vendor/view-trip.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Fix teal badges
old_teal_badge = 'class="badge bg-white text-teal border border-" style="border-color: #008080 !important;"'
new_teal_badge = 'class="badge" style="background-color: #ffffff !important; color: #008080 !important; border: 1px solid #008080 !important; font-weight: 600; font-size: 11px; padding: 6px 12px;"'
content = content.replace(old_teal_badge, new_teal_badge)

# Fix dark text badges
old_dark_badge = 'class="badge bg-white border border-opacity-25 text-dark" style="border-color: var(--border-color);"'
new_dark_badge = 'class="badge" style="background-color: #ffffff !important; color: var(--text-main) !important; border: 1px solid var(--border-color) !important; font-weight: 600; font-size: 11px; padding: 6px 12px;"'
content = content.replace(old_dark_badge, new_dark_badge)

# Fix any remaining 'badge bg-white' that might have been missed
content = content.replace('class="badge bg-white"', 'class="badge" style="background-color: #ffffff !important;"')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('Badges successfully overridden to white!')
