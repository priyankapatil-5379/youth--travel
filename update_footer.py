import os

footer_html = """    <section class="footer">
        <div class="container">
            <div class="row">
                <div class="col-md-12">
                    <div class="col-md-6">
                        <div class="footer-content">
                            <div class="footer-logo">
                                <img src="<c:url value='/views/assets/images/footer-logo.png'/>" alt="" />
                            </div>
                            <div class="footer-text">
                                <p>
                                    Travelling is more than just visiting places; it's about the vibes, the stories, and the memories that last a lifetime. Explore the unexplored with Youth Travel!
                                </p>
                            </div>
                            <div class="footer-address">
                                <ul>
                                    <li><i class="fa fa-map-marker" aria-hidden="true"></i> Youth Travel, MG Road, Bengaluru, Karnataka, India
                                    </li>

                                    <li>
                                        <i class="fa fa-phone" aria-hidden="true"></i> +91 98765 43210

                                    </li>
                                    <li>
                                        <i class="fa fa-envelope" aria-hidden="true"></i> support@youthtravel.in

                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="footer-content">
                            <div class="news">
                                <p>
                                    Newsletter Subscribe
                                </p>
                            </div>
                            <div class="subscribe">
                                <form id="newsletterForm" onsubmit="subscribeNewsletter(event)">
                                    <div class="input-group">
                                        <input type="email" id="newsletterEmail" class="form-control" size="50" placeholder="Enter E-mail" required>
                                        <div class="input-group-btn">
                                            <button type="submit" id="subscribeBtn" class="btn btn-danger">Subscribe</button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                            <script>
                                function subscribeNewsletter(e) {
                                    e.preventDefault();
                                    const email = document.getElementById('newsletterEmail').value;
                                    const btn = document.getElementById('subscribeBtn');
                                    const formData = new FormData();
                                    formData.append("name", "Newsletter Subscriber");
                                    formData.append("email", email);
                                    formData.append("message", "Subscribed to newsletter.");
                                    fetch('/enquiry/submit', { method: 'POST', body: formData })
                                    .then(res => {
                                        if(res.ok) {
                                            const originalText = btn.innerHTML;
                                            const originalBg = btn.style.background;
                                            btn.innerHTML = "Subscribed";
                                            btn.style.background = "#4caf50";
                                            btn.disabled = true;
                                            document.getElementById('newsletterEmail').value = "";
                                            setTimeout(() => {
                                                btn.innerHTML = originalText;
                                                btn.style.background = originalBg;
                                                btn.disabled = false;
                                            }, 3000);
                                        }
                                    });
                                }
                            </script>
                            <div class="social-icons">
                                <ul>
                                    <li><a href="https://www.facebook.com/login" target="_blank"><i class="fa fa-facebook" aria-hidden="true"></i> FACEBOOK</a></li>
                                    <li><a href="https://twitter.com/login" target="_blank"><i class="fa fa-twitter" aria-hidden="true"></i> TWITTER</a></li>
                                    <li><a href="https://www.linkedin.com/login" target="_blank"><i class="fa fa-linkedin" aria-hidden="true"></i> LINKEDIN</a></li>
                                </ul>
                            </div>
                            <div class="yt-footer-stores" aria-label="Download our app">
                                <a class="yt-store-btn" href="https://play.google.com/store" target="_blank" aria-label="Get it on Google Play">
                                    <i class="fa fa-android" aria-hidden="true"></i>
                                    <span>
                                        <small>Get it on</small>
                                        <strong>Google Play</strong>
                                    </span>
                                </a>
                                <a class="yt-store-btn" href="https://www.apple.com/app-store/" target="_blank" aria-label="Download on the App Store">
                                    <i class="fa fa-apple" aria-hidden="true"></i>
                                    <span>
                                        <small>Download on</small>
                                        <strong>App Store</strong>
                                    </span>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>"""

files_to_update = [
    "src/main/webapp/views/gallery.jsp",
    "src/main/webapp/views/about.jsp",
    "src/main/webapp/views/contact.jsp",
    "src/main/webapp/views/explore-packages.jsp",
    "src/main/webapp/views/plan-trip.jsp"
]

base_path = "/Users/apple/git/youth--travel/"

for file_rel in files_to_update:
    file_path = os.path.join(base_path, file_rel)
    if os.path.exists(file_path):
        with open(file_path, 'r') as f:
            content = f.read()
        
        # Look for <section class="footer" ... > ... </section>
        # Use a more flexible start tag match
        import re
        footer_pattern = re.compile(r'<section class="footer"[^>]*>.*?</section>', re.DOTALL)
        
        if footer_pattern.search(content):
            new_content = footer_pattern.sub(footer_html, content)
            with open(file_path, 'w') as f:
                f.write(new_content)
            print(f"Updated {file_rel}")
        else:
            print(f"Footer section not found in {file_rel}")
    else:
        print(f"File not found: {file_rel}")
