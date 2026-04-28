import sys

jsp_path = r"c:\Users\LENOVO\git\Youth_Travel\src\main\webapp\views\users\user-dashboard.jsp"
with open(jsp_path, "r", encoding="utf-8") as f:
    lines = f.readlines()

new_content = """                        </div>

                        <div style="display: flex; gap: 30px; align-items: flex-start;">
                            <!-- LEFT COLUMN: Filters -->
                            <div style="width: 280px; flex-shrink: 0; position: sticky; top: 100px;">
                                <div class="filter-card" style="display: flex; flex-direction: column; gap: 20px; padding: 25px;">
                                    <h4 style="font-weight: 800; margin-top: 0; margin-bottom: 5px; border-bottom: 1px solid rgba(255,255,255,0.1); padding-bottom: 15px; color: #fff;">Filters</h4>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Destination</label>
                                        <select name="destination" class="form-select-custom" style="width: 100%;">
                                            <option value="All Destinations">All Destinations</option>
                                            <c:forEach var="dest" items="${destinations}">
                                                <option value="${dest}" ${currentParams.destination==dest ? 'selected' : ''}>${dest}</option>
                                            </c:forEach>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Trip Type</label>
                                        <select name="tripType" class="form-select-custom" style="width: 100%;">
                                            <option value="All Types">All Types</option>
                                            <option value="Adventure" ${currentParams.tripType=='Adventure' ? 'selected' : ''}>Adventure</option>
                                            <option value="Solo" ${currentParams.tripType=='Solo' ? 'selected' : ''}>Solo</option>
                                            <option value="Group" ${currentParams.tripType=='Group' ? 'selected' : ''}>Group</option>
                                            <option value="Workation" ${currentParams.tripType=='Workation' ? 'selected' : ''}>Workation</option>
                                            <option value="Festivals" ${currentParams.tripType=='Festivals' ? 'selected' : ''}>Festivals</option>
                                            <option value="Volunteering" ${currentParams.tripType=='Volunteering' ? 'selected' : ''}>Volunteering</option>
                                            <option value="Nightlife" ${currentParams.tripType=='Nightlife' ? 'selected' : ''}>Nightlife</option>
                                            <option value="Content Creation" ${currentParams.tripType=='Content Creation' ? 'selected' : ''}>Content Creation</option>
                                            <option value="Wellness" ${currentParams.tripType=='Wellness' ? 'selected' : ''}>Wellness</option>
                                            <option value="Budget Backpacking" ${currentParams.tripType=='Budget Backpacking' ? 'selected' : ''}>Budget Backpacking</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Duration</label>
                                        <select name="duration" class="form-select-custom" style="width: 100%;">
                                            <option value="All Durations">All Durations</option>
                                            <option value="1-3 Days" ${currentParams.duration=='1-3 Days' ? 'selected' : ''}>1-3 Days</option>
                                            <option value="4-7 Days" ${currentParams.duration=='4-7 Days' ? 'selected' : ''}>4-7 Days</option>
                                            <option value="7+ Days" ${currentParams.duration=='7+ Days' ? 'selected' : ''}>7+ Days</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Group Type</label>
                                        <select name="groupType" class="form-select-custom" style="width: 100%;">
                                            <option value="All">All</option>
                                            <option value="Solo">Solo</option>
                                            <option value="Group">Group</option>
                                        </select>
                                    </div>
                                    
                                    <div>
                                        <label class="filter-label" style="margin-bottom: 8px;">Price Range</label>
                                        <div class="price-range-container">
                                            <input type="range" name="maxPrice" class="price-slider" min="0" max="100000" step="500" value="${currentParams.maxPrice}" oninput="updatePrice(this.value)">
                                            <div class="price-values">
                                                <span>₹0</span>
                                                <span id="priceVal">₹${currentParams.maxPrice}+</span>
                                            </div>
                                        </div>
                                    </div>
                                    
                                    <div class="filter-actions" style="display: flex; flex-direction: column; gap: 10px; margin-top: 10px; padding-top: 20px; border-top: 1px solid rgba(255,255,255,0.05);">
                                        <button type="submit" class="btn-apply" style="width: 100%; border-radius: 12px;">Apply Filters</button>
                                        <button type="button" class="btn-reset" onclick="window.location.href='/user/dashboard'" style="width: 100%; justify-content: center; border-radius: 12px;">Reset</button>
                                    </div>
                                </div>
                            </div>
                            
                            <!-- RIGHT COLUMN: Packages -->
                            <div style="flex: 1;">
                                <div class="results-meta" style="margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; border-bottom: 1px solid rgba(255,255,255,0.05); padding-bottom: 20px;">
                                    <div style="font-weight: 700; font-size: 16px;">Showing ${totalCount} packages</div>
                                    <div class="sort-container" style="display: flex; align-items: center; gap: 10px;">
                                        <span style="font-size: 13px; font-weight: 700; color: var(--text-muted);">Sort by:</span>
                                        <select name="sortBy" class="form-select-custom" style="width: auto; padding: 8px 15px; border-radius: 10px;" onchange="this.form.submit()">
                                            <option value="latest" ${currentParams.sortBy=='latest' ? 'selected' : ''}>Latest</option>
                                            <option value="priceLow" ${currentParams.sortBy=='priceLow' ? 'selected' : ''}>Price: Low to High</option>
                                            <option value="priceHigh" ${currentParams.sortBy=='priceHigh' ? 'selected' : ''}>Price: High to Low</option>
                                        </select>
                                    </div>
                                </div>
                    </form>
"""

# Replace lines 496 to 730
new_lines = lines[:495] + [new_content + "\n"] + lines[730:]

# Now insert two closing divs right before </main>
for i, line in enumerate(new_lines):
    if "</main>" in line:
        new_lines.insert(i, "                            </div> <!-- End Right Column -->\n                        </div> <!-- End Flex Container -->\n")
        break

with open(jsp_path, "w", encoding="utf-8") as f:
    f.writelines(new_lines)

print("Replacement successful")
