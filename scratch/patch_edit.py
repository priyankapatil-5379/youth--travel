import re

path = r"f:\springboot\youth--travel\src\main\webapp\views\vendor\edit-trip.jsp"

with open(path, "r", encoding="utf-8") as f:
    content = f.read()

# 1. Remove the bad injected jumpToStep, nextStep, prevStep
content = re.sub(r'function nextStep\(step\)\s*\{.*?\n                \}\n                function jumpToStep\(stepIndex\)\s*\{\s*nextStep\(stepIndex \+ 1\);\s*\}\n                function prevStep\(step\)\s*\{\s*nextStep\(step\);\s*\}', '', content, flags=re.DOTALL)

# 2. Fix showStep null checks
content = content.replace('document.getElementById("prevBtn").style.display = (n == 0) ? "none" : "inline";',
                          'const pb = document.getElementById("prevBtn"); if(pb) pb.style.display = (n == 0) ? "none" : "inline";')

content = content.replace('''if (n == (steps.length - 1)) {
                        document.getElementById("nextBtn").classList.add("d-none");
                        document.getElementById("launchBtn").classList.remove("d-none");
                        populateReview();
                    } else {
                        document.getElementById("nextBtn").classList.remove("d-none");
                        document.getElementById("launchBtn").classList.add("d-none");
                    }''',
                          '''const nb = document.getElementById("nextBtn");
                    const lb = document.getElementById("launchBtn");
                    if (n == (steps.length - 1)) {
                        if(nb) nb.classList.add("d-none");
                        if(lb) lb.classList.remove("d-none");
                        populateReview();
                    } else {
                        if(nb) nb.classList.remove("d-none");
                        if(lb) lb.classList.add("d-none");
                    }''')

# 3. Disable validation
content = re.sub(r'function validateStep\(\)\s*\{.*?return true;\s*\}', 'function validateStep() { return true; }', content, flags=re.DOTALL)

# 4. Hide wizard footer entirely so buttons aren't duplicated at the very bottom
content = content.replace('<!-- WIZARD FOOTER -->\n                        <div class="d-flex justify-content-between mt-5 pt-4 border-top border-secondary">',
                          '<!-- WIZARD FOOTER -->\n                        <div class="d-flex justify-content-between mt-5 pt-4 border-top border-secondary" style="display: none !important;">')

# 5. Fix overlapping step-items
content = content.replace('width: 25%;', 'flex: 1; cursor: pointer;')

# 6. Append inline buttons to each step
blocks = content.split('<div class="form-step')
for i in range(1, 13):
    last_div = blocks[i].rfind('</div>')
    
    if i == 1:
        btns = '\n<div class="mt-4 text-end"><button type="button" class="btn btn-submit" onclick="nextPrev(1)">Next <i class="fa fa-arrow-right"></i></button></div>\n'
    elif 1 < i < 12:
        btns = '\n<div class="mt-4 d-flex justify-content-between"><button type="button" class="btn btn-prev" onclick="nextPrev(-1)"><i class="fa fa-arrow-left"></i> Previous</button><button type="button" class="btn btn-submit" onclick="nextPrev(1)">Next <i class="fa fa-arrow-right"></i></button></div>\n'
    else:
        btns = '\n<div class="mt-4 d-flex justify-content-between"><button type="button" class="btn btn-prev" onclick="nextPrev(-1)"><i class="fa fa-arrow-left"></i> Previous</button><button type="submit" class="btn btn-submit">Update Package <i class="fa fa-check"></i></button></div>\n'
        
    blocks[i] = blocks[i][:last_div] + btns + blocks[i][last_div:]

content = '<div class="form-step'.join(blocks)

with open(path, "w", encoding="utf-8") as f:
    f.write(content)

print("Patch successful!")
