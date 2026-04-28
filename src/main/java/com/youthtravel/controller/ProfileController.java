package com.youthtravel.controller;

import com.youthtravel.entity.*;
import com.youthtravel.repository.*;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.*;
import java.util.*;
import java.util.stream.Collectors;

@Controller
@RequestMapping({"/user/profile", "/profile"})
public class ProfileController {

    @Autowired
    private PostRepository postRepository;

    @Autowired
    private FollowerRepository followerRepository;

    @Autowired
    private HighlightRepository highlightRepository;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private AdviceRepository adviceRepository;

    @GetMapping("")
    public String showProfile(HttpSession session, Model model) {
        User user = (User) session.getAttribute("user");
        if (user == null) return "redirect:/user/login";
        
        user.setProfileViews(user.getProfileViews() + 1);
        userRepository.save(user);
        session.setAttribute("user", user);

        model.addAttribute("user", user);
        return "/users/profile";
    }

    @GetMapping("/api/data")
    @ResponseBody
    public ResponseEntity<?> getProfileData(@RequestParam(value = "username", required = false) String username, HttpSession session) {
        User loggedInUser = (User) session.getAttribute("user");
        if (loggedInUser == null) return ResponseEntity.status(401).build();

        User profileUser = loggedInUser;
        if (username != null && !username.isEmpty()) {
            Optional<User> foundOpt = userRepository.findByUsername(username);
            User found = foundOpt.orElse(null);
            if (found == null) {
                // Fallback to fullName since explore.jsp passes fullName if username is empty
                List<User> matches = userRepository.findAll().stream()
                    .filter(u -> username.equals(u.getFullName()))
                    .collect(Collectors.toList());
                if (!matches.isEmpty()) {
                    found = matches.get(0);
                }
            }
            if (found != null) {
                profileUser = found;
            } else {
                return ResponseEntity.status(404).body("User not found");
            }
        }

        Map<String, Object> data = new HashMap<>();
        data.put("user", profileUser);
        data.put("isOwnProfile", profileUser.getId().equals(loggedInUser.getId()));
        
        List<Post> posts = postRepository.findByUserOrderByCreatedAtDesc(profileUser);
        data.put("posts", posts);
        
        List<Advice> advices = adviceRepository.findByUserOrderByCreatedAtDesc(profileUser);
        data.put("advices", advices);
        
        data.put("followersCount", followerRepository.countByFollowing(profileUser));
        data.put("followingCount", followerRepository.countByFollower(profileUser));
        data.put("postsCount", postRepository.countByUser(profileUser));
        data.put("advicesCount", adviceRepository.countByUser(profileUser));

        // Gather liked IDs for the LOGGED-IN user so the frontend knows what to highlight
        List<Long> likedPostIds = posts.stream()
            .filter(p -> p.getLikedUserIds() != null && p.getLikedUserIds().contains(loggedInUser.getId()))
            .map(Post::getId)
            .collect(Collectors.toList());
            
        List<Long> likedAdviceIds = advices.stream()
            .filter(a -> a.getLikedUserIds() != null && a.getLikedUserIds().contains(loggedInUser.getId()))
            .map(Advice::getId)
            .collect(Collectors.toList());
            
        data.put("likedPostIds", likedPostIds);
        data.put("likedAdviceIds", likedAdviceIds);
        
        return ResponseEntity.ok(data);
    }

    @PostMapping("/api/update")
    @ResponseBody
    public ResponseEntity<?> updateProfile(
            @RequestParam(value = "fullName", required = false) String fullName,
            @RequestParam(value = "username", required = false) String username,
            @RequestParam(value = "profession", required = false) String profession,
            @RequestParam(value = "profilePhoto", required = false) MultipartFile profilePhoto,
            @RequestParam(value = "coverPhoto", required = false) MultipartFile coverPhoto,
            HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        if (fullName != null) user.setFullName(fullName);
        if (username != null) user.setUsername(username);
        if (profession != null) user.setProfession(profession);

        try {
            String rootDir = System.getProperty("user.dir");
            Path profilePath = Paths.get(rootDir, "uploads", "profiles");
            if (!Files.exists(profilePath)) Files.createDirectories(profilePath);

            if (profilePhoto != null && !profilePhoto.isEmpty()) {
                String fileName = "avatar_" + user.getId() + "_" + System.currentTimeMillis() + "_" + profilePhoto.getOriginalFilename().replaceAll("\\s+", "_");
                Path filePath = profilePath.resolve(fileName);
                Files.copy(profilePhoto.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                user.setProfilePhoto("/uploads/profiles/" + fileName);
            }

            if (coverPhoto != null && !coverPhoto.isEmpty()) {
                String fileName = "cover_" + user.getId() + "_" + System.currentTimeMillis() + "_" + coverPhoto.getOriginalFilename().replaceAll("\\s+", "_");
                Path filePath = profilePath.resolve(fileName);
                Files.copy(coverPhoto.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);
                user.setCoverPhoto("/uploads/profiles/" + fileName);
            }
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body("Error saving images: " + e.getMessage());
        }

        userRepository.save(user);
        session.setAttribute("user", user);
        return ResponseEntity.ok(user);
    }

    @PostMapping("/api/posts/upload")
    @ResponseBody
    public ResponseEntity<?> uploadPost(@RequestParam("media") MultipartFile file, 
                                       @RequestParam("caption") String caption,
                                       HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        if (!file.isEmpty()) {
            try {
                String rootDir = System.getProperty("user.dir");
                Path path = Paths.get(rootDir, "uploads", "posts");
                if (!Files.exists(path)) Files.createDirectories(path);

                String fileName = "post_" + System.currentTimeMillis() + "_" + file.getOriginalFilename().replaceAll("\\s+", "_");
                Path filePath = path.resolve(fileName);
                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                Post post = new Post();
                post.setUser(user);
                post.setMediaUrl("/uploads/posts/" + fileName);
                post.setMediaType(file.getContentType().startsWith("video") ? "video" : "image");
                post.setCaption(caption);
                
                postRepository.save(post);
                return ResponseEntity.ok(post);
            } catch (IOException e) {
                e.printStackTrace();
                return ResponseEntity.status(500).body("Error: " + e.getMessage());
            }
        }
        return ResponseEntity.badRequest().body("File is empty");
    }

    @PostMapping("/api/upload-photo")
    @ResponseBody
    public ResponseEntity<?> uploadPhoto(@RequestParam("photo") MultipartFile photo, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        if (!photo.isEmpty()) {
            try {
                String rootDir = System.getProperty("user.dir");
                Path path = Paths.get(rootDir, "uploads", "profiles");
                if (!Files.exists(path)) Files.createDirectories(path);

                String fileName = "user_" + user.getId() + "_" + System.currentTimeMillis() + "_" + photo.getOriginalFilename().replaceAll("\\s+", "_");
                Path filePath = path.resolve(fileName);
                Files.copy(photo.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                user.setProfilePhoto("/uploads/profiles/" + fileName);
                userRepository.save(user);
                session.setAttribute("user", user);
                return ResponseEntity.ok(user);
            } catch (IOException e) {
                e.printStackTrace();
                return ResponseEntity.status(500).body("Error: " + e.getMessage());
            }
        }
        return ResponseEntity.badRequest().body("File is empty");
    }

    @DeleteMapping("/api/posts/{id}")
    @ResponseBody
    public ResponseEntity<?> deletePost(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Post> postOpt = postRepository.findById(id);
        if (postOpt.isPresent() && postOpt.get().getUser().getId().equals(user.getId())) {
            Post post = postOpt.get();
            // Delete physical file
            try {
                String rootDir = System.getProperty("user.dir");
                Path filePath = Paths.get(rootDir, post.getMediaUrl().replace("/", File.separator));
                Files.deleteIfExists(filePath);
            } catch (IOException e) {
                e.printStackTrace();
            }
            postRepository.delete(post);
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.status(403).build();
    }

    @PostMapping("/api/posts/{id}/update")
    @ResponseBody
    public ResponseEntity<?> updatePost(@PathVariable Long id, 
                                       @RequestParam(value = "caption", required = false) String caption,
                                       @RequestParam(value = "media", required = false) MultipartFile file,
                                       HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Post> postOpt = postRepository.findById(id);
        if (postOpt.isPresent() && postOpt.get().getUser().getId().equals(user.getId())) {
            Post post = postOpt.get();
            if (caption != null) post.setCaption(caption);
            
            if (file != null && !file.isEmpty()) {
                try {
                    // Delete old file
                    String rootDir = System.getProperty("user.dir");
                    Path oldPath = Paths.get(rootDir, post.getMediaUrl().replace("/", File.separator));
                    Files.deleteIfExists(oldPath);

                    // Upload new file
                    String fileName = "post_" + System.currentTimeMillis() + "_" + file.getOriginalFilename().replaceAll("\\s+", "_");
                    Path newPath = Paths.get(rootDir, "uploads", "posts").resolve(fileName);
                    Files.copy(file.getInputStream(), newPath, StandardCopyOption.REPLACE_EXISTING);
                    
                    post.setMediaUrl("/uploads/posts/" + fileName);
                    post.setMediaType(file.getContentType().startsWith("video") ? "video" : "image");
                } catch (IOException e) {
                    e.printStackTrace();
                    return ResponseEntity.status(500).body("Error updating media: " + e.getMessage());
                }
            }
            
            postRepository.save(post);
            return ResponseEntity.ok(post);
        }
        return ResponseEntity.status(403).build();
    }

    @PostMapping("/api/follow/{id}")
    @ResponseBody
    public ResponseEntity<?> followUser(@PathVariable Long id, HttpSession session) {
        User follower = (User) session.getAttribute("user");
        if (follower == null) return ResponseEntity.status(401).build();

        Optional<User> followingOpt = userRepository.findById(id);
        if (followingOpt.isPresent()) {
            User following = followingOpt.get();
            if (followerRepository.existsByFollowerAndFollowing(follower, following)) {
                Optional<Follower> f = followerRepository.findByFollowerAndFollowing(follower, following);
                f.ifPresent(followerRepository::delete);
                return ResponseEntity.ok("Unfollowed");
            } else {
                followerRepository.save(new Follower(follower, following));
                return ResponseEntity.ok("Followed");
            }
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/api/highlights")
    @ResponseBody
    public ResponseEntity<?> createHighlight(@RequestParam("title") String title, 
                                           @RequestParam("cover") MultipartFile file,
                                           HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        if (!file.isEmpty()) {
            try {
                String rootDir = System.getProperty("user.dir");
                Path path = Paths.get(rootDir, "uploads", "highlights");
                if (!Files.exists(path)) Files.createDirectories(path);

                String fileName = "hl_" + System.currentTimeMillis() + "_" + file.getOriginalFilename().replaceAll("\\s+", "_");
                Path filePath = path.resolve(fileName);
                Files.copy(file.getInputStream(), filePath, StandardCopyOption.REPLACE_EXISTING);

                Highlight highlight = new Highlight();
                highlight.setUser(user);
                highlight.setTitle(title);
                highlight.setCoverImage("/uploads/highlights/" + fileName);
                
                highlightRepository.save(highlight);
                return ResponseEntity.ok(highlight);
            } catch (IOException e) {
                e.printStackTrace();
                return ResponseEntity.status(500).body("Error: " + e.getMessage());
            }
        }
        return ResponseEntity.badRequest().build();
    }

    @DeleteMapping("/api/highlights/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteHighlight(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Highlight> hlOpt = highlightRepository.findById(id);
        if (hlOpt.isPresent() && hlOpt.get().getUser().getId().equals(user.getId())) {
            highlightRepository.delete(hlOpt.get());
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.status(403).build();
    }

    @PostMapping("/api/posts/{id}/like")
    @ResponseBody
    public ResponseEntity<?> likePost(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Post> postOpt = postRepository.findById(id);
        if (postOpt.isPresent()) {
            Post post = postOpt.get();
            if (post.getLikedUserIds().contains(user.getId())) {
                post.getLikedUserIds().remove(user.getId());
                post.setLikes(Math.max(0, post.getLikes() - 1));
            } else {
                post.getLikedUserIds().add(user.getId());
                post.setLikes(post.getLikes() + 1);
            }
            postRepository.save(post);
            return ResponseEntity.ok(post);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/api/advices/{id}/like")
    @ResponseBody
    public ResponseEntity<?> likeAdvice(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Advice> adviceOpt = adviceRepository.findById(id);
        if (adviceOpt.isPresent()) {
            Advice advice = adviceOpt.get();
            if (advice.getLikedUserIds().contains(user.getId())) {
                advice.getLikedUserIds().remove(user.getId());
                advice.setLikes(Math.max(0, advice.getLikes() - 1));
            } else {
                advice.getLikedUserIds().add(user.getId());
                advice.setLikes(advice.getLikes() + 1);
            }
            adviceRepository.save(advice);
            return ResponseEntity.ok(advice);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/api/posts/{id}/view")
    @ResponseBody
    public ResponseEntity<?> viewPost(@PathVariable Long id, HttpSession session) {
        Optional<Post> postOpt = postRepository.findById(id);
        if (postOpt.isPresent()) {
            Post post = postOpt.get();
            post.setViews(post.getViews() + 1);
            postRepository.save(post);
            return ResponseEntity.ok(post);
        }
        return ResponseEntity.notFound().build();
    }

    @PostMapping("/api/advices/post")
    @ResponseBody
    public ResponseEntity<?> postAdvice(@RequestBody Map<String, String> body, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Advice advice = new Advice();
        advice.setUser(user);
        advice.setTitle(body.get("title"));
        advice.setCategories(body.get("categories"));
        advice.setContent(body.get("content"));
        
        adviceRepository.save(advice);
        return ResponseEntity.ok(advice);
    }

    @DeleteMapping("/api/advices/{id}")
    @ResponseBody
    public ResponseEntity<?> deleteAdvice(@PathVariable Long id, HttpSession session) {
        User user = (User) session.getAttribute("user");
        if (user == null) return ResponseEntity.status(401).build();

        Optional<Advice> adviceOpt = adviceRepository.findById(id);
        if (adviceOpt.isPresent() && adviceOpt.get().getUser().getId().equals(user.getId())) {
            adviceRepository.delete(adviceOpt.get());
            return ResponseEntity.ok().build();
        }
        return ResponseEntity.status(403).build();
    }
}
