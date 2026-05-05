const fs = require('fs');

const path = "f:\\springboot\\youth--travel\\src\\main\\webapp\\views\\vendor\\edit-trip.jsp";
let content = fs.readFileSync(path, 'utf-8');

// The file has 12 <div class="form-step" id="stepX"> blocks.
// We want to insert the buttons right before the closing </div> of each form-step.

for (let i = 1; i <= 12; i++) {
    // Find the opening tag for step i
    const stepRegex = new RegExp(`<div class="form-step(?: active)?" id="step${i}">`, 'g');
    const match = stepRegex.exec(content);
    if (!match) continue;
    
    // To find the end of this step, we'll find the next step's opening tag, or if i=12, we find the end of the form-card or <div class="form-step" ...>
    // A better way: just replace the end of each step block? Actually, regex parsing HTML is tricky.
    // Let's use a simpler approach. If we split by `<div class="form-step"`, we get the blocks.
}

// Since JS regex for matching nested divs is hard, I will do it differently.
// Look for `<!-- STEP X` or `<div class="form-step"`
const blocks = content.split(/<div class="form-step/);
// blocks[0] is everything before step 1.
// blocks[1] is step 1 without the prefix. It starts with ` active" id="step1">` or `" id="step1">`.
// We need to insert before the last `</div>` of each block, except blocks[0].

for (let i = 1; i < blocks.length; i++) {
    // find the last </div> in blocks[i] before any other major structure (which should just be at the end)
    let b = blocks[i];
    let lastDivIdx = b.lastIndexOf('</div>');
    
    let buttonsHTML = '';
    if (i === 1) {
        buttonsHTML = `
        <div class="mt-4 text-end">
            <button type="button" class="btn btn-submit" onclick="nextStep(2)">Next <i class="fa fa-arrow-right"></i></button>
        </div>
        `;
    } else if (i > 1 && i < 12) {
        buttonsHTML = `
        <div class="mt-4 d-flex justify-content-between">
            <button type="button" class="btn btn-prev" onclick="prevStep(${i-1})"><i class="fa fa-arrow-left"></i> Previous</button>
            <button type="button" class="btn btn-submit" onclick="nextStep(${i+1})">Next <i class="fa fa-arrow-right"></i></button>
        </div>
        `;
    } else if (i === 12) {
        buttonsHTML = `
        <div class="mt-4 d-flex justify-content-between">
            <button type="button" class="btn btn-prev" onclick="prevStep(11)"><i class="fa fa-arrow-left"></i> Previous</button>
            <button type="submit" class="btn btn-submit">Update Package <i class="fa fa-check"></i></button>
        </div>
        `;
        // In Step 12, there's already a submit button somewhere?
        // Wait, add-trip.jsp originally had a "Publish Trip" button. Let's see if it's already there and remove it so we don't duplicate.
        // Actually, my previous script changed "Publish Trip" to "Update Package".
        // Let's just remove any existing "Update Package" button from step 12.
        b = b.replace(/<button[^>]*>Update Package.*?<\/button>/g, '');
    }

    if (lastDivIdx !== -1) {
        blocks[i] = b.substring(0, lastDivIdx) + buttonsHTML + b.substring(lastDivIdx);
    }
}

content = blocks.join('<div class="form-step');
fs.writeFileSync(path, content, 'utf-8');
console.log("Buttons added successfully");
