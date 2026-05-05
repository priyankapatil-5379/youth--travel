const fs = require('fs');
const path = 'f:/springboot/youth--travel/src/main/webapp/views/vendor/edit-trip.jsp';
let content = fs.readFileSync(path, 'utf8');

// 1. Remove old navigation buttons if they exist (to avoid duplicates)
content = content.replace(/<div class="mt-4 (text-end|d-flex justify-content-between)">[\s\S]*?<\/div>/g, '');

// 2. Add buttons to each step
// We'll find each step and insert the buttons before its closing </div>
// Step divs look like: <div class="form-step active" id="step1"> ... </div>
const stepRegex = /(<div class="form-step[^"]*" id="step(\d+)">[\s\S]*?)(\n\s*<\/div>)/g;
content = content.replace(stepRegex, (match, start, stepNum, end) => {
    let buttons = '';
    if (stepNum == 1) {
        buttons = `
                                <div class="mt-4 text-end">
                                    <button type="button" class="btn btn-submit" onclick="nextPrev(1)">Next <i class="fa fa-arrow-right"></i></button>
                                </div>`;
    } else if (stepNum == 12) {
        buttons = `
                                <div class="mt-4 d-flex justify-content-between">
                                    <button type="button" class="btn btn-prev" onclick="nextPrev(-1)"><i class="fa fa-arrow-left"></i> Previous</button>
                                    <button type="submit" class="btn btn-submit">Update Package <i class="fa fa-check"></i></button>
                                </div>`;
    } else {
        buttons = `
                                <div class="mt-4 d-flex justify-content-between">
                                    <button type="button" class="btn btn-prev" onclick="nextPrev(-1)"><i class="fa fa-arrow-left"></i> Previous</button>
                                    <button type="button" class="btn btn-submit" onclick="nextPrev(1)">Next <i class="fa fa-arrow-right"></i></button>
                                </div>`;
    }
    return start + buttons + end;
});

// 3. Fix JavaScript: redefine showStep and validateStep cleanly
const jsPatch = `
                function showStep(n) {
                    const steps = document.getElementsByClassName("form-step");
                    if (!steps[n]) return;
                    
                    for (let i = 0; i < steps.length; i++) {
                        steps[i].classList.remove("active");
                    }
                    steps[n].classList.add("active");

                    // Indicators
                    updateIndicators(n);
                    
                    // Scroll indicator into view on mobile
                    const activeIndicator = document.getElementById("stepIndicator" + (n + 1));
                    if (activeIndicator) {
                        activeIndicator.scrollIntoView({ behavior: 'smooth', inline: 'center', block: 'nearest' });
                    }
                }

                function nextPrev(n) {
                    const steps = document.getElementsByClassName("form-step");
                    if (n == 1 && !validateStep()) return false;

                    steps[currentStep].classList.remove("active");
                    currentStep += n;
                    if (currentStep >= steps.length) {
                        // Handle form submission or final step
                        return false;
                    }
                    showStep(currentStep);
                    window.scrollTo(0, 0);
                }

                function jumpToStep(n) {
                    const steps = document.getElementsByClassName("form-step");
                    steps[currentStep].classList.remove("active");
                    currentStep = n;
                    showStep(currentStep);
                    window.scrollTo(0, 0);
                }

                function validateStep() {
                    return true;
                }
`;

// Remove existing versions of these functions
content = content.replace(/function showStep\(n\) \{[\s\S]*?\}/, '');
content = content.replace(/function nextPrev\(n\) \{[\s\S]*?\}/, '');
content = content.replace(/function jumpToStep\(\w+\) \{[\s\S]*?\}/g, '');
content = content.replace(/function validateStep\(\) \{[\s\S]*?\}/, '');
content = content.replace(/function nextStep\(step\) \{[\s\S]*?\}/, '');
content = content.replace(/function prevStep\(step\) \{[\s\S]*?\}/, '');

// Append the clean functions to the end of the script block (before </script>)
content = content.replace('</script>', jsPatch + '\n</script>');

// 4. Fix CSS step-item width to avoid overlapping
content = content.replace('.step-item {', '.step-item { cursor: pointer; flex: 1; min-width: 80px; ');
content = content.replace('width: 25%;', '/* width: 25%; */');

fs.writeFileSync(path, content);
console.log('Fixed navigation in edit-trip.jsp');
