import re

file_path = r"f:\springboot\youth--travel\src\main\webapp\views\vendor\register.jsp"
with open(file_path, "r", encoding="utf-8") as f:
    content = f.read()

# HTML Replacements
content = content.replace(
    '''<div class="col-md-6 form-group">
                                    <label>Business Name</label>
                                    <input type="text" name="businessName" class="form-control"
                                        placeholder="Adventure Co. Ltd">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Contact Person Name</label>
                                    <input type="text" name="ownerName" class="form-control" placeholder="John Doe">
                                </div>''',
    '''<div class="col-md-6 form-group">
                                    <label>Business Name</label>
                                    <input type="text" name="businessName" id="businessName" class="form-control"
                                        placeholder="Adventure Co. Ltd">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Contact Person Name</label>
                                    <input type="text" name="ownerName" id="ownerName" class="form-control" placeholder="John Doe" oninput="this.value = this.value.replace(/[^A-Za-z\\s]/g, '')">
                                </div>'''
)

content = content.replace(
    '''<div class="col-md-6 form-group">
                                    <label>Phone Number</label>
                                    <input type="text" name="phoneNumber" class="form-control"
                                        placeholder="10-digit Mobile Number" maxlength="10"
                                        title="Please enter exactly 10 digits">
                                </div>''',
    '''<div class="col-md-6 form-group">
                                    <label>Phone Number</label>
                                    <input type="text" name="phoneNumber" id="phoneNumber" class="form-control"
                                        placeholder="10-digit Mobile Number" maxlength="10"
                                        title="Please enter exactly 10 digits" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                </div>'''
)

content = content.replace(
    '''<div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Company Registration Number</label>
                                    <input type="text" name="registrationId" class="form-control"
                                        placeholder="REG-12345678">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>GST Number (for India)</label>
                                    <input type="text" name="gstNumber" class="form-control"
                                        placeholder="22AAAAA0000A1Z5">
                                </div>
                            </div>''',
    '''<div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Business Type & Registration Number</label>
                                    <div class="d-flex" style="gap: 10px;">
                                        <select id="companyType" class="form-control" style="width: 40%; background: rgba(255, 255, 255, 0.05); color: #fff;">
                                            <option value="CIN" style="color: #000;">Company (CIN)</option>
                                            <option value="LLPIN" style="color: #000;">LLP (LLPIN)</option>
                                        </select>
                                        <input type="text" name="registrationId" id="registrationId" class="form-control"
                                            placeholder="L12345KA2020PLC123456" style="width: 60%;" oninput="this.value = this.value.toUpperCase()">
                                    </div>
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>GST Number (for India)</label>
                                    <input type="text" name="gstNumber" id="gstNumber" class="form-control"
                                        placeholder="29ABCDE1234F1Z5" maxlength="15" oninput="this.value = this.value.toUpperCase().replace(/[^A-Z0-9]/g, '')">
                                </div>
                            </div>'''
)

content = content.replace(
    '''<div class="col-md-4 form-group">
                                    <label>WhatsApp Number</label>
                                    <input type="text" name="whatsappNumber" class="form-control"
                                        placeholder="10-digit WhatsApp Number">
                                </div>
                                <div class="col-md-4 form-group">
                                    <label>Instagram/FB Link</label>
                                    <input type="url" name="instagramUrl" class="form-control"
                                        placeholder="https://instagram.com/profile">
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Set Password</label>
                                <input type="password" name="password" class="form-control" autocomplete="new-password">
                            </div>''',
    '''<div class="col-md-4 form-group">
                                    <label>WhatsApp Number</label>
                                    <input type="text" name="whatsappNumber" id="whatsappNumber" class="form-control"
                                        placeholder="10-digit WhatsApp Number" maxlength="10" oninput="this.value = this.value.replace(/[^0-9]/g, '')">
                                </div>
                                <div class="col-md-4 form-group">
                                    <label>Instagram/FB Link</label>
                                    <input type="url" name="instagramUrl" id="instagramUrl" class="form-control"
                                        placeholder="https://instagram.com/profile">
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 form-group">
                                    <label>Set Password</label>
                                    <input type="password" name="password" id="password" class="form-control" autocomplete="new-password">
                                </div>
                                <div class="col-md-6 form-group">
                                    <label>Confirm Password</label>
                                    <input type="password" name="confirmPassword" id="confirmPassword" class="form-control" autocomplete="new-password">
                                </div>
                            </div>'''
)

content = content.replace(
    '''<div class="col-md-8 form-group">
                                    <label>Languages Spoken</label>
                                    <select name="languages" class="form-control" multiple
                                        style="height: auto; background: #1a1f2b; color: #fff;">
                                        <option value="English">English</option>
                                        <option value="Hindi">Hindi</option>
                                        <option value="Kannada">Kannada</option>
                                        <option value="Tamil">Tamil</option>
                                        <option value="Telugu">Telugu</option>
                                        <option value="Malayalam">Malayalam</option>
                                        <option value="French">French</option>
                                        <option value="Spanish">Spanish</option>
                                    </select>
                                    <small class="text-white-50">Hold Ctrl/Cmd to select multiple</small>
                                </div>''',
    '''<div class="col-md-8 form-group">
                                    <label>Languages Spoken</label>
                                    <input type="hidden" name="languages" id="languagesInput">
                                    <div class="audience-chips" id="languageChips">
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'English')">English</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'Hindi')">Hindi</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'Kannada')">Kannada</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'Tamil')">Tamil</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'Telugu')">Telugu</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'Malayalam')">Malayalam</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'French')">French</div>
                                        <div class="audience-chip" onclick="toggleLanguage(this, 'Spanish')">Spanish</div>
                                    </div>
                                </div>'''
)

content = content.replace(
    '''<div class="form-group">
                                <label>Business Address</label>
                                <textarea name="companyAddress" class="form-control" rows="2"
                                    placeholder="Full registered office address"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-4 form-group">
                                    <label>Website Link</label>
                                    <input type="url" name="websiteUrl" class="form-control"
                                        placeholder="https://adventure.com">
                                </div>''',
    '''<div class="form-group">
                                <label>Business Address</label>
                                <textarea name="companyAddress" id="companyAddress" class="form-control" rows="2"
                                    placeholder="Full registered office address"></textarea>
                            </div>
                            <div class="row">
                                <div class="col-md-4 form-group">
                                    <label>Website Link</label>
                                    <input type="url" name="websiteUrl" id="websiteUrl" class="form-control"
                                        placeholder="https://adventure.com">
                                </div>'''
)

# Replace validation logic
new_js = '''
                function showError($input, msg) {
                    $input.addClass('is-invalid');
                    if($input.next('.invalid-feedback').length === 0) {
                        $input.after('<div class="invalid-feedback" style="color:#e11d48; font-size:12px; margin-top:5px; display:block;">' + msg + '</div>');
                    } else {
                        $input.next('.invalid-feedback').text(msg).show();
                    }
                }

                function clearError($input) {
                    $input.removeClass('is-invalid');
                    $input.next('.invalid-feedback').hide();
                }

                function validateStep(step) {
                    let isValid = true;
                    // Reset previous validation
                    $('#step' + step + ' .is-invalid').removeClass('is-invalid');
                    $('#step' + step + ' .invalid-feedback').hide();

                    if (step === 1) {
                        const bName = $('[name="businessName"]');
                        if (!/^[A-Za-z][A-Za-z0-9\\s]*$/.test(bName.val().trim())) {
                            isValid = false;
                            showError(bName, 'Must start with alphabet, no numbers at start.');
                        } else { clearError(bName); }

                        const oName = $('[name="ownerName"]');
                        if (!/^[A-Za-z\\s]{2,}$/.test(oName.val().trim())) {
                            isValid = false;
                            showError(oName, 'Only alphabets and spaces allowed, min 2 chars.');
                        } else { clearError(oName); }

                        const email = $('[name="emailId"]');
                        if (!email.val() || !email.val().trim()) {
                            isValid = false;
                            showError(email, 'Email is required.');
                        } else { clearError(email); }

                        const phone = $('[name="phoneNumber"]');
                        if (!/^\\d{10}$/.test(phone.val().trim())) {
                            isValid = false;
                            showError(phone, 'Must be exactly 10 digits.');
                        } else { clearError(phone); }

                        const cType = $('#companyType').val();
                        const regId = $('[name="registrationId"]');
                        if (cType === 'CIN' && !/^[A-Z]{1}[0-9]{5}[A-Z]{2}[0-9]{4}[A-Z]{3}[0-9]{6}$/.test(regId.val().trim())) {
                            isValid = false;
                            showError(regId, 'Invalid CIN format. Example: L12345KA2020PLC123456');
                        } else if (cType === 'LLPIN' && !/^[A-Z]{3}-[0-9]{4}$/.test(regId.val().trim())) {
                            isValid = false;
                            showError(regId, 'Invalid LLPIN format. Example: AAA-1234');
                        } else { clearError(regId); }

                        const gst = $('[name="gstNumber"]');
                        if (!/^[0-9]{2}[A-Z]{5}[0-9]{4}[A-Z]{1}[1-9A-Z]{1}Z[0-9A-Z]{1}$/.test(gst.val().trim())) {
                            isValid = false;
                            showError(gst, 'Invalid GST format. Example: 29ABCDE1234F1Z5');
                        } else { clearError(gst); }

                        const addr = $('[name="companyAddress"]');
                        if (!/^(?=.*[A-Za-z])[A-Za-z0-9,\\s]{10,}$/.test(addr.val().trim())) {
                            isValid = false;
                            showError(addr, 'Required, min 10 chars. Must contain alphabets. No random symbols.');
                        } else { clearError(addr); }

                        const web = $('[name="websiteUrl"]');
                        if (web.val() && !/^(https?:\\/\\/)/.test(web.val().trim())) {
                            isValid = false;
                            showError(web, 'Must start with http:// or https://');
                        } else { clearError(web); }

                        const wa = $('[name="whatsappNumber"]');
                        if (wa.val() && !/^\\d{10}$/.test(wa.val().trim())) {
                            isValid = false;
                            showError(wa, 'Must be exactly 10 digits.');
                        } else { clearError(wa); }

                        const insta = $('[name="instagramUrl"]');
                        if (insta.val() && !/^(https?:\\/\\/)/.test(insta.val().trim())) {
                            isValid = false;
                            showError(insta, 'Must be a valid URL.');
                        } else { clearError(insta); }

                        const pass = $('[name="password"]');
                        const passConf = $('[name="confirmPassword"]');
                        const passRegex = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$/;
                        
                        if (!passRegex.test(pass.val())) {
                            isValid = false;
                            showError(pass, 'Min 8 chars, 1 uppercase, 1 lowercase, 1 number, 1 special char.');
                        } else { clearError(pass); }

                        if (pass.val() !== passConf.val() || passConf.val() === '') {
                            isValid = false;
                            showError(passConf, 'Passwords do not match.');
                        } else { clearError(passConf); }

                    } else if (step === 2) {
                        const about = $('[name="about"]');
                        if (!about.val() || about.val().trim().length < 10) {
                            isValid = false;
                            showError(about, 'Required, min 10 chars.');
                        } else { clearError(about); }

                        const exp = $('[name="experienceYears"]');
                        if (!exp.val() || exp.val() < 0) {
                            isValid = false;
                            showError(exp, 'Required field.');
                        } else { clearError(exp); }

                        const city = $('[name="city"]');
                        if (!city.val()) {
                            isValid = false;
                            showError(city, 'Required field.');
                        } else { clearError(city); }
                        
                        const langs = $('#languagesInput');
                        if (!langs.val()) {
                            isValid = false;
                            const $chips = $('#languageChips');
                            if($chips.next('.invalid-feedback').length === 0) {
                                $chips.after('<div class="invalid-feedback" style="color:#e11d48; font-size:12px; margin-top:5px; display:block;">Please select at least one language</div>');
                            } else {
                                $chips.next('.invalid-feedback').show();
                            }
                        } else { $('#languageChips').next('.invalid-feedback').hide(); }

                        if(!$('#mapsLink').val()) {
                            isValid = false;
                            const $mapDiv = $('#map');
                            if($mapDiv.nextAll('.invalid-feedback').length === 0) {
                                $mapDiv.after('<div class="invalid-feedback" style="color:#e11d48; font-size:12px; margin-top:5px; display:block;">Please select a location on the map</div>');
                            } else {
                                $mapDiv.nextAll('.invalid-feedback').show();
                            }
                        }

                        if(!$('#targetAudienceInput').val()) {
                            isValid = false;
                            const $chips = $('.audience-chips').first();
                            if($chips.next('.invalid-feedback').length === 0) {
                                $chips.after('<div class="invalid-feedback" style="color:#e11d48; font-size:12px; margin-top:5px; display:block;">Please select at least one target audience</div>');
                            } else {
                                $chips.next('.invalid-feedback').show();
                            }
                        }
                    } else if (step === 3) {
                        const filesToCheck = ['idProofFile', 'licenseFile', 'insuranceFile'];
                        filesToCheck.forEach(file => {
                            const $fileInput = $('[name="' + file + '"]');
                            if (!$fileInput.val()) {
                                isValid = false;
                                const $wrapper = $fileInput.closest('.file-upload-wrapper');
                                $wrapper.addClass('is-invalid');
                                if($wrapper.next('.invalid-feedback').length === 0) {
                                    $wrapper.after('<div class="invalid-feedback" style="color:#e11d48; font-size:12px; margin-top:5px; display:block;">This document is required</div>');
                                } else {
                                    $wrapper.next('.invalid-feedback').show();
                                }
                            } else {
                                const $wrapper = $fileInput.closest('.file-upload-wrapper');
                                $wrapper.removeClass('is-invalid');
                                $wrapper.next('.invalid-feedback').hide();
                            }
                        });

                        const termsChecked = $('#termsCheck').is(':checked');
                        if (!termsChecked) {
                            isValid = false;
                            const $checkbox = $('#termsCheck').closest('.custom-checkbox');
                            $checkbox.addClass('is-invalid');
                            if($checkbox.next('.invalid-feedback').length === 0) {
                                $checkbox.after('<div class="invalid-feedback" style="color:#e11d48; font-size:12px; margin-top:5px; display:block;">You must accept the terms</div>');
                            } else {
                                $checkbox.next('.invalid-feedback').show();
                            }
                        } else {
                            const $checkbox = $('#termsCheck').closest('.custom-checkbox');
                            $checkbox.removeClass('is-invalid');
                            $checkbox.next('.invalid-feedback').hide();
                        }
                    }
                    
                    return isValid;
                }'''

old_js_start = "function validateStep(step) {"
old_js_end = "function nextStep(step) {"
if old_js_start in content and old_js_end in content:
    start_idx = content.find(old_js_start)
    end_idx = content.find(old_js_end)
    content = content[:start_idx] + new_js + "\n\n                " + content[end_idx:]

toggle_audience_js = '''let audiences = [];
                function toggleAudience(element, value) {
                    $(element).toggleClass('active');
                    if ($(element).hasClass('active')) {
                        audiences.push(value);
                    } else {
                        audiences = audiences.filter(a => a !== value);
                    }
                    $('#targetAudienceInput').val(audiences.join(', '));
                }

                let selectedLanguages = [];
                function toggleLanguage(element, value) {
                    $(element).toggleClass('active');
                    if ($(element).hasClass('active')) {
                        selectedLanguages.push(value);
                    } else {
                        selectedLanguages = selectedLanguages.filter(a => a !== value);
                    }
                    $('#languagesInput').val(selectedLanguages.join(', '));
                }'''

content = re.sub(r'let audiences = \[\];[\s\S]*?\}', toggle_audience_js, content, count=1)

# Real time validation binding
real_time_js = '''
                // Real-time validation
                $(document).ready(function() {
                    $('#vendorRegForm input, #vendorRegForm textarea, #vendorRegForm select').on('blur input', function() {
                        const step = $(this).closest('.form-step').attr('id').replace('step', '');
                        // Check validation quietly to clear errors if they fixed it
                        if ($(this).hasClass('is-invalid')) {
                            validateStep(parseInt(step));
                        }
                    });
                });
'''

content = content.replace(
    '''// Prevent Enter key from auto-submitting the form''',
    real_time_js + '\n                // Prevent Enter key from auto-submitting the form'
)

with open(file_path, "w", encoding="utf-8") as f:
    f.write(content)

print("Patch successfully created.")
