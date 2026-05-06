import os
import re

sidebar_template = """<aside class="admin-sidebar">
            <div class="sidebar-header">
                <a href="<c:url value='/'/>">
                    <img src="<c:url value='/views/assets/images/logo.png'/>" alt="Youth Travel">
                </a>
            </div>
            <nav class="admin-nav">
                <a href="<c:url value='/admin/dashboard'/>" class="admin-nav-item {dashboard_active}">
                    <i class="fa fa-th-large"></i> Dashboard
                </a>
                <a href="<c:url value='/admin/trips'/>" class="admin-nav-item {trips_active}">
                    <i class="fa fa-motorcycle"></i> Manage Trips
                </a>
                <a href="<c:url value='/admin/users'/>" class="admin-nav-item {users_active}">
                    <i class="fa fa-users"></i> User Accounts
                </a>
                <a href="<c:url value='/admin/vendors'/>" class="admin-nav-item {vendors_active}">
                    <i class="fa fa-handshake-o"></i> Vendor Requests
                </a>
                <a href="<c:url value='/admin/home-images'/>" class="admin-nav-item {home_images_active}">
                    <i class="fa fa-image"></i> Homepage Photos
                </a>
                <a href="<c:url value='/admin/inquiries'/>" class="admin-nav-item {inquiries_active}">
                    <i class="fa fa-envelope"></i> Inquiries
                </a>
                <div style="margin-top: 50px; border-top: 1px solid rgba(255,255,255,0.05); padding-top: 20px;">
                    <a href="<c:url value='/'/>" class="admin-nav-item">
                        <i class="fa fa-sign-out"></i> Back to Site
                    </a>
                </div>
            </nav>
        </aside>"""

admin_dir = "src/main/webapp/views/Admin"

for filename in os.listdir(admin_dir):
    if not filename.endswith(".jsp") or filename == "login.jsp":
        continue
    
    filepath = os.path.join(admin_dir, filename)
    with open(filepath, 'r', encoding='utf-8') as f:
        content = f.read()
    
    # Determine which item should be active
    dashboard_active = "active" if filename == "dashboard.jsp" else ""
    trips_active = "active" if filename in ["trips.jsp", "trip-detail.jsp"] else ""
    users_active = "active" if filename in ["users.jsp", "user-detail.jsp"] else ""
    vendors_active = "active" if filename in ["vendors.jsp", "vendor-detail.jsp"] else ""
    home_images_active = "active" if filename == "home-images.jsp" else ""
    inquiries_active = "active" if filename in ["inquiries.jsp", "enquiries.jsp"] else ""
    
    sidebar_html = sidebar_template.format(
        dashboard_active=dashboard_active,
        trips_active=trips_active,
        users_active=users_active,
        vendors_active=vendors_active,
        home_images_active=home_images_active,
        inquiries_active=inquiries_active
    )
    
    # Replace the existing sidebar
    # We use regex to match <aside class="admin-sidebar"> ... </aside>
    pattern = re.compile(r'<aside class="admin-sidebar">.*?</aside>', re.DOTALL)
    
    if pattern.search(content):
        new_content = pattern.sub(sidebar_html, content)
        with open(filepath, 'w', encoding='utf-8') as f:
            f.write(new_content)
        print(f"Updated {filename}")
    else:
        print(f"Sidebar not found in {filename}")
