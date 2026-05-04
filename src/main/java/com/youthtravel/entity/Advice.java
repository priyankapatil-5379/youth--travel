package com.youthtravel.entity;

import jakarta.persistence.*;
import com.fasterxml.jackson.annotation.JsonIgnore;
import java.time.LocalDateTime;
import java.util.Set;
import java.util.HashSet;

@Entity
@Table(name = "advices")
public class Advice {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JsonIgnore
    @JoinColumn(name = "user_id", nullable = false)
    private User user;

    @Column(nullable = false, length = 100)
    private String title;

    @Column(length = 255)
    private String categories;

    @Column(nullable = false, length = 2000)
    private String content;

    @Column(columnDefinition = "TEXT")
    private String bestTimeToVisit;

    @Column(columnDefinition = "TEXT")
    private String whatToPack;

    @Column(columnDefinition = "TEXT")
    private String safetyTips;

    @Column(columnDefinition = "TEXT")
    private String budgetTips;

    @Column(columnDefinition = "TEXT")
    private String stayFoodAdvice;

    @Column(columnDefinition = "TEXT")
    private String transportTips;

    @Column(columnDefinition = "TEXT")
    private String connectivityTips;

    @Column(columnDefinition = "TEXT")
    private String localRules;

    @Column(columnDefinition = "TEXT")
    private String environmentalTips;

    @Column(columnDefinition = "TEXT")
    private String proTips;

    private int likes = 0;

    @ElementCollection
    @CollectionTable(name = "advice_liked_users", joinColumns = @JoinColumn(name = "advice_id"))
    @Column(name = "user_id")
    @JsonIgnore
    private Set<Long> likedUserIds = new HashSet<>();

    @Column(name = "created_at", updatable = false)
    private LocalDateTime createdAt;

    @PrePersist
    protected void onCreate() {
        createdAt = LocalDateTime.now();
    }

    public Advice() {}

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }

    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public String getCategories() { return categories; }
    public void setCategories(String categories) { this.categories = categories; }

    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }

    public String getBestTimeToVisit() { return bestTimeToVisit; }
    public void setBestTimeToVisit(String bestTimeToVisit) { this.bestTimeToVisit = bestTimeToVisit; }

    public String getWhatToPack() { return whatToPack; }
    public void setWhatToPack(String whatToPack) { this.whatToPack = whatToPack; }

    public String getSafetyTips() { return safetyTips; }
    public void setSafetyTips(String safetyTips) { this.safetyTips = safetyTips; }

    public String getBudgetTips() { return budgetTips; }
    public void setBudgetTips(String budgetTips) { this.budgetTips = budgetTips; }

    public String getStayFoodAdvice() { return stayFoodAdvice; }
    public void setStayFoodAdvice(String stayFoodAdvice) { this.stayFoodAdvice = stayFoodAdvice; }

    public String getTransportTips() { return transportTips; }
    public void setTransportTips(String transportTips) { this.transportTips = transportTips; }

    public String getConnectivityTips() { return connectivityTips; }
    public void setConnectivityTips(String connectivityTips) { this.connectivityTips = connectivityTips; }

    public String getLocalRules() { return localRules; }
    public void setLocalRules(String localRules) { this.localRules = localRules; }

    public String getEnvironmentalTips() { return environmentalTips; }
    public void setEnvironmentalTips(String environmentalTips) { this.environmentalTips = environmentalTips; }

    public String getProTips() { return proTips; }
    public void setProTips(String proTips) { this.proTips = proTips; }

    public int getLikes() { return likes; }
    public void setLikes(int likes) { this.likes = likes; }

    public Set<Long> getLikedUserIds() { return likedUserIds; }
    public void setLikedUserIds(Set<Long> likedUserIds) { this.likedUserIds = likedUserIds; }

    public LocalDateTime getCreatedAt() { return createdAt; }
}
