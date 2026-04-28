import os
import re

directory = r'c:\Users\LENOVO\git\Youth_Travel\src\main\webapp\views\vendor'
files_to_update = [
    'add-trip.jsp', 'bookings.jsp', 'earnings.jsp', 'edit-trip.jsp', 
    'guest-list.jsp', 'inventory.jsp', 'messages.jsp', 'profile.jsp', 
    'reviews.jsp', 'tours.jsp'
]

# Map file to its active page name
active_page_map = {
    'add-trip.jsp': 'add-trip',
    'bookings.jsp': 'bookings',
    'earnings.jsp': 'earnings',
    'edit-trip.jsp': 'tours', # edit-trip falls under manage tours
    'guest-list.jsp': 'guest-list',
    'inventory.jsp': 'inventory',
    'messages.jsp': 'messages',
    'profile.jsp': 'profile',
    'reviews.jsp': 'reviews',
    'tours.jsp': 'tours'
}

for filename in files_to_update:
    filepath = os.path.join(directory, filename)
    if not os.path.exists(filepath):
        continue
        
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
        
    # 1. Remove CSS from .sidebar { ... } to .nav-sidebar a.active { ... }
    # Also remove .main-content { ... } because it's now in vendor-sidebar.jsp
    # We will use a regex to match from .sidebar { up to the closing } of .nav-sidebar a.active
    css_pattern1 = re.compile(r'\.sidebar\s*\{.*?\.nav-sidebar a\.active\s*\{[^}]*\}', re.DOTALL)
    content = css_pattern1.sub('', content)
    
    # Remove .main-content CSS
    css_pattern2 = re.compile(r'\.main-content\s*\{[^}]*\}', re.DOTALL)
    content = css_pattern2.sub('', content)
    
    # Remove .sidebar-overlay CSS if exists
    css_pattern3 = re.compile(r'\.sidebar-overlay\s*\{[^}]*\}', re.DOTALL)
    content = css_pattern3.sub('', content)

    # Remove .sidebar-logo CSS if exists
    css_pattern4 = re.compile(r'\.sidebar-logo[^}]*\}', re.DOTALL)
    content = css_pattern4.sub('', content)

    # 2. Replace HTML
    # We want to match from <div class="sidebar-overlay" ... or <div class="sidebar"> 
    # all the way up to <div class="main-content">
    html_pattern = re.compile(r'(<div class="sidebar-overlay"[^>]*></div>\s*)?<div class="sidebar">.*?</ul>\s*</div>\s*(<div class="main-content">)', re.DOTALL)
    
    active_param = active_page_map.get(filename, '')
    replacement = f"""    <jsp:include page="vendor-sidebar.jsp">
        <jsp:param name="activePage" value="{active_param}" />
    </jsp:include>

    \\2"""
    
    content = html_pattern.sub(replacement, content)
    
    # Fix potential double blank lines
    content = re.sub(r'\n\s*\n\s*\n', '\n\n', content)
    
    with open(filepath, 'w', encoding='utf-8') as f:
        f.write(content)
        
print("Updated all vendor pages.")
