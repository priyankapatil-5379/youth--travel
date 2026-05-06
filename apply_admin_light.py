import os
import re

admin_dir = "src/main/webapp/views/Admin"
css_link = "<link rel=\"stylesheet\" href=\"<c:url value='/views/assets/css/admin-light.css'/>\">\n"

for filename in os.listdir(admin_dir):
    if not filename.endswith(".jsp") or filename == "login.jsp":
        continue
    
    filepath = os.path.join(admin_dir, filename)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Add the css link before </head> if not already there
    if "admin-light.css" not in content:
        content = re.sub(r'</head>', css_link + '</head>', content, flags=re.IGNORECASE)
    
    # Add the class admin-light-theme to body
    if 'class="premium-theme"' in content:
        content = content.replace('class="premium-theme"', 'class="premium-theme admin-light-theme"')
    elif '<body ' in content and 'admin-light-theme' not in content:
        # It has a body tag with some other attributes
        content = re.sub(r'<body ([^>]*)>', r'<body \1 class="admin-light-theme">', content, count=1)
    elif '<body>' in content:
        content = content.replace('<body>', '<body class="admin-light-theme">')
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
    print(f"Processed {filename}")
