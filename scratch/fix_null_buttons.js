const fs = require('fs');
const path = "f:\\springboot\\youth--travel\\src\\main\\webapp\\views\\vendor\\edit-trip.jsp";
let content = fs.readFileSync(path, 'utf-8');

// Replace showStep to add null checks
const oldShowStep = `                    // Buttons
                    document.getElementById("prevBtn").style.display = (n == 0) ? "none" : "inline";
                    
                    if (n == (steps.length - 1)) {
                        document.getElementById("nextBtn").classList.add("d-none");
                        document.getElementById("launchBtn").classList.remove("d-none");
                        populateReview();
                    } else {
                        document.getElementById("nextBtn").classList.remove("d-none");
                        document.getElementById("launchBtn").classList.add("d-none");
                    }`;

const newShowStep = `                    // Buttons (Null Safe)
                    const pBtn = document.getElementById("prevBtn");
                    if(pBtn) pBtn.style.display = (n == 0) ? "none" : "inline";
                    
                    const nBtn = document.getElementById("nextBtn");
                    const lBtn = document.getElementById("launchBtn");
                    if (n == (steps.length - 1)) {
                        if(nBtn) nBtn.classList.add("d-none");
                        if(lBtn) lBtn.classList.remove("d-none");
                        populateReview();
                    } else {
                        if(nBtn) nBtn.classList.remove("d-none");
                        if(lBtn) lBtn.classList.add("d-none");
                    }`;

content = content.replace(oldShowStep, newShowStep);
fs.writeFileSync(path, content, 'utf-8');
console.log("Fixed showStep null errors");
