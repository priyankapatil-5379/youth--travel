package com.youthtravel.entity;
 
 import jakarta.persistence.*;
 
 @Entity
 @Table(name = "users")
 public class User {
 
     @Id
     @GeneratedValue(strategy = GenerationType.IDENTITY)
     private Long id;
 
     @Column(nullable = false)
     private String fullName;
 
     @Column(nullable = false, unique = true)
     private String email;
 
     @Column(nullable = false)
     private String phoneNumber;
 
     @Column(name = "password_hash", nullable = false)
     private String password;
 
    private String city;
    private String profilePhoto;
    private String coverPhoto;
    
    @Column(unique = true)
    private String username;
    private String bio;
    private String website;
    private String profession;
    private int profileViews = 0;
 
     @Column(name = "created_at", updatable = false)
     private java.time.LocalDateTime createdAt;
 
     @PrePersist
     protected void onCreate() {
         createdAt = java.time.LocalDateTime.now();
     }
 
     // Default Constructor
     public User() {
     }
 
     // Getters and Setters
     public Long getId() {
         return id;
     }
 
     public void setId(Long id) {
         this.id = id;
     }
 
     public String getFullName() {
         return fullName;
     }
 
     public void setFullName(String fullName) {
         this.fullName = fullName;
     }
 
     public String getEmail() {
         return email;
     }
 
     public void setEmail(String email) {
         this.email = email;
     }
 
     public String getPhoneNumber() {
         return phoneNumber;
     }
 
     public void setPhoneNumber(String phoneNumber) {
         this.phoneNumber = phoneNumber;
     }
 
     public String getPassword() {
         return password;
     }
 
     public void setPassword(String password) {
         this.password = password;
     }
 
     public String getCity() {
         return city;
     }
 
     public void setCity(String city) {
         this.city = city;
     }
 
    public String getProfilePhoto() {
        return profilePhoto;
    }

    public void setProfilePhoto(String profilePhoto) {
        this.profilePhoto = profilePhoto;
    }
    
    public String getCoverPhoto() {
        return coverPhoto;
    }

    public void setCoverPhoto(String coverPhoto) {
        this.coverPhoto = coverPhoto;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getBio() {
        return bio;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }

    public String getWebsite() {
        return website;
    }

    public void setWebsite(String website) {
        this.website = website;
    }

    public String getProfession() {
        return profession;
    }

    public void setProfession(String profession) {
        this.profession = profession;
    }

    public int getProfileViews() {
        return profileViews;
    }

    public void setProfileViews(int profileViews) {
        this.profileViews = profileViews;
    }
 
     // Helper methods for JSP EL compatibility
     public String getName() {
         return fullName;
     }
 
     public String getPhone() {
         return phoneNumber;
     }

     public java.time.LocalDateTime getCreatedAt() {
         return createdAt;
     }

     public java.time.LocalDateTime getRegisteredAt() {
         return createdAt;
     }
 }