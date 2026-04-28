import sys

jsp_path = r"c:\Users\LENOVO\git\Youth_Travel\src\main\webapp\views\users\user-dashboard.jsp"
with open(jsp_path, "r", encoding="utf-8") as f:
    content = f.read()

css_addition = """
                .offcanvas-filter {
                    position: fixed;
                    top: 0;
                    right: -350px;
                    width: 320px;
                    height: 100vh;
                    background: var(--dark-card);
                    box-shadow: -5px 0 25px rgba(0,0,0,0.8);
                    z-index: 1050;
                    transition: right 0.3s cubic-bezier(0.4, 0, 0.2, 1);
                    padding: 0;
                    overflow-y: auto;
                    border-left: 1px solid rgba(255,255,255,0.05);
                }
                .offcanvas-filter.show {
                    right: 0;
                }
                .offcanvas-overlay {
                    position: fixed;
                    top: 0;
                    left: 0;
                    width: 100vw;
                    height: 100vh;
                    background: rgba(0,0,0,0.6);
                    backdrop-filter: blur(4px);
                    z-index: 1040;
                    display: none;
                    opacity: 0;
                    transition: opacity 0.3s ease;
                }
                .offcanvas-overlay.show {
                    display: block;
                    opacity: 1;
                }
                .btn-filter-toggle {
                    background: rgba(255,255,255,0.05);
                    border: 1px solid rgba(255,255,255,0.1);
                    color: #fff;
                    padding: 12px 20px;
                    border-radius: 12px;
                    font-weight: 700;
                    cursor: pointer;
                    transition: var(--transition);
                    display: flex;
                    align-items: center;
                    gap: 8px;
                }
                .btn-filter-toggle:hover {
                    background: rgba(255,255,255,0.1);
                    border-color: var(--primary-blue);
                }
"""

content = content.replace("/* Search & Filters */", "/* Search & Filters */" + css_addition)

header_find = """                            <div class="search-container">
                                <input type="text" name="search" value="${currentParams.search}"
                                    placeholder="Search trips, destinations...">
                                <i class="fa fa-search"></i>
                            </div>
                        </div>

                        <div style="display: flex; gap: 30px; align-items: flex-start;">
                            <!-- LEFT COLUMN: Filters -->
                            <div style="width: 280px; flex-shrink: 0; position: sticky; top: 100px;">
                                <div class="filter-card" style="display: flex; flex-direction: column; gap: 20px; padding: 25px;">
                                    <h4 style="font-weight: 800; margin-top: 0; margin-bottom: 5px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 15px; color: #fff;">Filters</h4>"""

header_replace = """                            <div style="display: flex; gap: 15px; align-items: center;">
                                <div class="search-container" style="width: 300px;">
                                    <input type="text" name="search" value="${currentParams.search}"
                                        placeholder="Search trips, destinations...">
                                    <i class="fa fa-search"></i>
                                </div>
                                <button type="button" class="btn-filter-toggle" onclick="toggleFilter()">
                                    <i class="fa fa-sliders"></i> Filters
                                </button>
                            </div>
                        </div>

                        <!-- Offcanvas Overlay -->
                        <div class="offcanvas-overlay" id="filterOverlay" onclick="toggleFilter()"></div>

                        <!-- OFFCANVAS FILTER SIDEBAR -->
                        <div class="offcanvas-filter" id="filterSidebar">
                            <div style="display: flex; justify-content: space-between; align-items: center; padding: 25px; border-bottom: 1px solid rgba(255,255,255,0.05);">
                                <h4 style="font-weight: 800; margin: 0; color: #fff; font-size: 20px;">Filters</h4>
                                <button type="button" onclick="toggleFilter()" style="background: none; border: none; color: var(--text-muted); font-size: 20px; cursor: pointer;">
                                    <i class="fa fa-times"></i>
                                </button>
                            </div>
                            
                            <div style="display: flex; flex-direction: column; gap: 20px; padding: 25px;">"""

content = content.replace(header_find, header_replace)


middle_find = """                                        <button type="button" class="btn-reset" onclick="window.location.href='/user/dashboard'" style="width: 100%; justify-content: center; border-radius: 12px;">Reset</button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- RIGHT COLUMN: Packages -->
                            <div style="flex: 1;">
                                <div class="results-meta" style="margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;">"""

middle_replace = """                                        <button type="button" class="btn-reset" onclick="window.location.href='/user/dashboard'" style="width: 100%; justify-content: center; border-radius: 12px;">Reset</button>
                                    </div>
                                </div> <!-- End Padding Container -->
                            </div> <!-- End Offcanvas Sidebar -->
                            
                            <!-- MAIN CONTENT AREA -->
                            <div style="width: 100%;">
                                <div class="results-meta" style="margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;">"""

content = content.replace(middle_find, middle_replace)


js_addition = """
                function toggleFilter() {
                    const sidebar = document.getElementById('filterSidebar');
                    const overlay = document.getElementById('filterOverlay');
                    
                    sidebar.classList.toggle('show');
                    
                    if (overlay.classList.contains('show')) {
                        overlay.style.opacity = '0';
                        setTimeout(() => overlay.classList.remove('show'), 300);
                    } else {
                        overlay.classList.add('show');
                        // trigger reflow
                        void overlay.offsetWidth;
                        overlay.style.opacity = '1';
                    }
                }
"""

content = content.replace("</script>", js_addition + "\n            </script>")

with open(jsp_path, "w", encoding="utf-8") as f:
    f.write(content)

print("done")
