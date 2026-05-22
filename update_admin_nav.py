import os
import glob

admin_views_dir = r"c:\Users\LENOVO\git\Youth_Travel\src\main\webapp\views\admin"

payout_link = """                <a href="<c:url value='/admin/payouts'/>" class="admin-nav-item ">
                    <i class="fa fa-money"></i> Payout Requests
                </a>"""

for filepath in glob.glob(os.path.join(admin_views_dir, "*.jsp")):
    if "payouts.jsp" in filepath or "login.jsp" in filepath:
        continue
    
    with open(filepath, "r", encoding="utf-8") as f:
        content = f.read()
        
    if "Payout Requests" in content:
        continue
        
    # Find the Vendor Requests link and inject after it
    # <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item ">...</a>
    # Or active state
    
    lines = content.split('\n')
    new_lines = []
    
    in_vendor_block = False
    for i, line in enumerate(lines):
        new_lines.append(line)
        if "value='/admin/vendors'" in line:
            in_vendor_block = True
        elif in_vendor_block and "</a>" in line:
            in_vendor_block = False
            new_lines.append(payout_link)
            
    with open(filepath, "w", encoding="utf-8") as f:
        f.write('\n'.join(new_lines))
        
print("Updated all admin JSPs.")
