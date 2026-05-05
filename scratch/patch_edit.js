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

// 6. Change Submission Button text
content = content.replace(/Publish Trip/g, "Update Package");

// 7. Step Navigation (Allow free navigation)
const js_replacement = `
                function nextStep(step) {
                    $('.form-step').removeClass('active');
                    $('.step-item').removeClass('active');
                    $('#step' + step).addClass('active');
                    $('#stepIndicator' + step).addClass('active');
                    
                    // update completed states
                    $('.step-item').removeClass('completed');
                    for(let i=1; i<step; i++){
                        $('#stepIndicator'+i).addClass('completed');
                    }
                    window.scrollTo({ top: 0, behavior: 'smooth' });
                    if(step === 12 && typeof updateReview === 'function') {
                        updateReview();
                    }
                }
                function jumpToStep(stepIndex) {
                    nextStep(stepIndex + 1);
                }
                function prevStep(step) {
                    nextStep(step);
                }
`;
content = content.replace(/<\/script>\s*<\/body>/i, js_replacement + '\n</script>\n</body>');

// 8. Form Submission AJAX override
const ajax_submit = `
                $('#editForm').on('submit', function(e) {
                    e.preventDefault();
                    
                    var formData = new FormData(this);
                    
                    $.ajax({
                        url: $(this).attr('action'),
                        type: 'POST', // or PUT depending on API
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

// Pre-fill Select Option (like tripDuration, meals, etc)
content = content.replace(/<select([^>]*?)name="([^"]+)"([^>]*?)>(.*?)<\/select>/gs, (match, before, name, after, inner) => {
    // A simplistic way to check the right option is doing it in JS, but we can also do it server-side using JSTL if we wanted.
    // We will just add a small JS block at the end to auto-select all selects based on the trip data.
    return match;
});

const auto_select_js = `
                $(document).ready(function() {
                    // Pre-select fields manually if needed
                    $('select[name="tripDuration"]').val('\${trip.tripDuration}');
                    $('select[name="state"]').val('\${trip.state}');
                    // any other selects can be bound similarly if their options match the text
                });
`;
content = content.replace(/<\/script>\s*<\/body>/i, auto_select_js + '\n</script>\n</body>');

// Save as edit-trip.jsp
fs.writeFileSync(edit_trip_path, content, 'utf-8');

console.log("Created edit-trip.jsp");
