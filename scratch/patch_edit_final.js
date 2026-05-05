const fs = require('fs');

const add_trip_path = "f:\\springboot\\youth--travel\\src\\main\\webapp\\views\\vendor\\add-trip.jsp";
const edit_trip_path = "f:\\springboot\\youth--travel\\src\\main\\webapp\\views\\vendor\\edit-trip.jsp";

let content = fs.readFileSync(add_trip_path, 'utf-8');

// 1. Update Title and Header
content = content.replace("<title>Add New Trip | Youth Travel</title>", "<title>Edit Trip | Youth Travel</title>");
content = content.replace('value="add-trip"', 'value="tours"');
content = content.replace("Create New Adventure", "Edit Adventure");
content = content.replace("List your professional trip on the Youth Travel platform.", 'Updating details for <strong>${trip.title}</strong>');

// 2. Update Form Action and Add ID
content = content.replace(/id="regForm"/g, 'id="editForm"');
content = content.replace(/<form action="<c:url value='\/vendor\/add-trip'\/>"/g, '<form action="/api/packages/${trip.id}"');
content = content.replace(/enctype="multipart\/form-data">/g, 'enctype="multipart/form-data">\n                        <input type="hidden" name="id" id="tripId" value="${trip.id}">');

// 3. Remove all 'required' attributes
content = content.replace(/\s+required/g, '');

// 4. Pre-fill text and number inputs
content = content.replace(/<input\s+type="(text|number|url)"([^>]*?)name="([^"]+)"([^>]*?)>/g, (match, type, before, name, after) => {
    if (match.includes('value=')) return match;
    if (['photoFiles'].includes(name)) return match;
    return `<input type="${type}"${before}name="${name}" value="\${trip.${name}}"${after}>`;
});

// 5. Pre-fill textareas
content = content.replace(/<textarea([^>]*?)name="([^"]+)"([^>]*?)>(.*?)<\/textarea>/gs, (match, before, name, after, inner) => {
    return `<textarea${before}name="${name}"${after}>\${trip.${name}}</textarea>`;
});

// 6. Fix step-item CSS from previous width: 25% bug
content = content.replace(/width:\s*25%;/g, 'flex: 1; cursor: pointer;');

// 7. Remove WIZARD FOOTER completely
// We know it is marked with <!-- WIZARD FOOTER -->
// We will replace everything from <!-- WIZARD FOOTER --> to the closing </div> of the form card.
// Wait, regex might be tricky. Let's do string splitting.
const wizardStart = content.indexOf('<!-- WIZARD FOOTER -->');
if (wizardStart !== -1) {
    const nextDiv = content.indexOf('</div>', wizardStart);
    const nextNextDiv = content.indexOf('</div>', nextDiv + 1);
    const nextNextNextDiv = content.indexOf('</div>', nextNextDiv + 1);
    // Let's just use string replace for the buttons:
    content = content.replace(/<button[^>]*id="prevBtn"[^>]*>[\s\S]*?<\/button>/, '');
    content = content.replace(/<button[^>]*id="nextBtn"[^>]*>[\s\S]*?<\/button>/, '');
    content = content.replace(/<button[^>]*id="launchBtn"[^>]*>[\s\S]*?<\/button>/, '');
}

// 8. Add buttons at the end of each step
const blocks = content.split(/<div class="form-step/);
for (let i = 1; i < blocks.length; i++) {
    let b = blocks[i];
    let lastDivIdx = b.lastIndexOf('</div>');
    
    let buttonsHTML = '';
    if (i === 1) {
        buttonsHTML = `
        <div class="mt-4 text-end">
            <button type="button" class="btn btn-submit" onclick="nextPrev(1)">Next <i class="fa fa-arrow-right"></i></button>
        </div>
        `;
    } else if (i > 1 && i < 12) {
        buttonsHTML = `
        <div class="mt-4 d-flex justify-content-between">
            <button type="button" class="btn btn-prev" onclick="nextPrev(-1)"><i class="fa fa-arrow-left"></i> Previous</button>
            <button type="button" class="btn btn-submit" onclick="nextPrev(1)">Next <i class="fa fa-arrow-right"></i></button>
        </div>
        `;
    } else if (i === 12) {
        buttonsHTML = `
        <div class="mt-4 d-flex justify-content-between">
            <button type="button" class="btn btn-prev" onclick="nextPrev(-1)"><i class="fa fa-arrow-left"></i> Previous</button>
            <button type="submit" class="btn btn-submit">Update Package <i class="fa fa-check"></i></button>
        </div>
        `;
    }

    if (lastDivIdx !== -1) {
        blocks[i] = b.substring(0, lastDivIdx) + buttonsHTML + b.substring(lastDivIdx);
    }
}
content = blocks.join('<div class="form-step');

// 9. Override validateStep to always return true (careful string replacement to avoid Syntax Error)
// We find "function validateStep() {" and find its closing brace.
// Simplest way: replace the entire function string by searching for its exact text from add-trip.jsp.
// Or just replace the body of the function.
content = content.replace(/function validateStep\(\) \{[\s\S]*?return true;\s*\}/, `function validateStep() { return true; }`);
// Wait, earlier I found that validateStep has multiple `return true;`.
// Let's replace the whole function definition!
content = content.replace(/function validateStep\(\) \{[\s\S]*?\}\s*\/\/ Sub-categories Mapping/g, `function validateStep() { return true; }\n\n                // Sub-categories Mapping`);


// 10. Form Submission AJAX override
const ajax_submit = `
                $('#editForm').on('submit', function(e) {
                    e.preventDefault();
                    var formData = new FormData(this);
                    $.ajax({
                        url: $(this).attr('action'),
                        type: 'POST',
                        data: formData,
                        processData: false,
                        contentType: false,
                        success: function(response) {
                            alert("Package updated successfully");
                            window.location.href = "<c:url value='/vendor/tours'/>";
                        },
                        error: function(xhr) {
                            alert("Sorry, please edit the details again");
                        }
                    });
                });
`;
content = content.replace(/<\/script>\s*<\/body>/i, ajax_submit + '\n</script>\n</body>');

// 11. Pre-select Options
const auto_select_js = `
                $(document).ready(function() {
                    $('select[name="tripDuration"]').val('\${trip.tripDuration}');
                    $('select[name="state"]').val('\${trip.state}');
                });
`;
content = content.replace(/<\/script>\s*<\/body>/i, auto_select_js + '\n</script>\n</body>');


fs.writeFileSync(edit_trip_path, content, 'utf-8');
console.log("Created edit-trip.jsp successfully");
