import sys

file_path = 'src/main/webapp/views/vendor/view-trip.jsp'
with open(file_path, 'r', encoding='utf-8') as f:
    content = f.read()

# Font
content = content.replace('https://fonts.googleapis.com/css?family=Dosis:300,400,500,600,700,800', 'https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800&display=swap')

# Root vars and body
content = content.replace("body.yt-dark { background: transparent; color: #fff; font-family: 'Dosis', sans-serif; }", ":root { --primary: #008080; --bg-body: #f1f5f9; --bg-card: #ffffff; --border-color: #e2e8f0; --text-main: #0f172a; --text-muted: #64748b; }\n        body.yt-dark { background: var(--bg-body) !important; background-image: none !important; color: var(--text-main); font-family: 'Inter', sans-serif; }")
content = content.replace('<body class="yt-dark">', '<body class="yt-dark" style="background: #f1f5f9 !important; background-image: none !important;">')

# Pseudo element override to kill premium-dashboard.css image
if '<style>' in content:
    content = content.replace('<style>', '<style>\n        body.yt-dark::before, body.premium-theme::before { display: none !important; }\n        .text-teal { color: #008080 !important; }\n        .bg-teal { background-color: #008080 !important; }')

# Replace orange colors with Teal
content = content.replace('#f04c26', '#008080')
content = content.replace('rgba(240, 76, 38,', 'rgba(0, 128, 128,')
content = content.replace('text-orange', 'text-teal')
content = content.replace('bg-orange', 'bg-teal')

# Section Cards
content = content.replace('background: rgba(0,0,0,0.3);\n            backdrop-filter: blur(15px);\n            border-radius: 24px;\n            padding: 30px;\n            margin-bottom: 30px;\n            border: 1px solid rgba(255,255,255,0.05);', 'background: var(--bg-card);\n            border-radius: 16px;\n            padding: 30px;\n            margin-bottom: 30px;\n            border: 1px solid var(--border-color);\n            box-shadow: 0 1px 3px rgba(0,0,0,0.1);')

# Info Item
content = content.replace('background: rgba(255,255,255,0.03);\n            padding: 20px;\n            border-radius: 16px;\n            border: 1px solid rgba(255,255,255,0.05);', 'background: var(--bg-body);\n            padding: 20px;\n            border-radius: 16px;\n            border: 1px solid var(--border-color);')

# Text Colors
content = content.replace('color: #fff;', 'color: var(--text-main);')
content = content.replace('color: rgba(255,255,255,0.5);', 'color: var(--text-muted);')
content = content.replace('color: rgba(255,255,255,0.7);', 'color: var(--text-muted);')
content = content.replace('text-white-50', 'text-muted')
content = content.replace('text-white', 'text-dark')
content = content.replace('style="color: #fff;"', 'style="color: var(--text-main);"')

# Borders
content = content.replace('border: 1px solid rgba(255,255,255,0.1);', 'border: 1px solid var(--border-color);')
content = content.replace('border: 1px solid rgba(255,255,255,0.05);', 'border: 1px solid var(--border-color);')
content = content.replace('background: rgba(255,255,255,0.04);', 'background: var(--bg-body);')

with open(file_path, 'w', encoding='utf-8') as f:
    f.write(content)

print('view-trip.jsp updated successfully!')
