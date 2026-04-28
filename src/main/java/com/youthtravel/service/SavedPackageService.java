package com.youthtravel.service;

import com.youthtravel.entity.SavedPackage;
import com.youthtravel.repository.SavedPackageRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class SavedPackageService {

    @Autowired
    private SavedPackageRepository savedPackageRepository;

    public List<SavedPackage> getSavedPackagesByEmail(String email) {
        return savedPackageRepository.findByUserEmail(email);
    }

    public void saveTrip(com.youthtravel.entity.User user, com.youthtravel.entity.Trip trip) {
        SavedPackage saved = new SavedPackage(user, trip);
        savedPackageRepository.save(saved);
    }

    public void removeSavedTrip(com.youthtravel.entity.User user, com.youthtravel.entity.Trip trip) {
        List<SavedPackage> saved = savedPackageRepository.findByUser(user);
        for (SavedPackage sp : saved) {
            if (sp.getTripPackage().getId().equals(trip.getId())) {
                savedPackageRepository.delete(sp);
                break;
            }
        }
    }
    
    public boolean isTripSaved(com.youthtravel.entity.User user, com.youthtravel.entity.Trip trip) {
        List<SavedPackage> saved = savedPackageRepository.findByUser(user);
        for (SavedPackage sp : saved) {
            if (sp.getTripPackage().getId().equals(trip.getId())) {
                return true;
            }
        }
        return false;
    }
}
