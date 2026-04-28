package com.youthtravel.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.youthtravel.entity.Vendor;
import com.youthtravel.repository.VendorRepository;

import java.util.Optional;

@Service
public class VendorService {

    @Autowired
    private VendorRepository vendorRepository;

    public Vendor registerVendor(Vendor vendor) {
        return vendorRepository.save(vendor);
    }

    public boolean loginVendor(String emailId, String password) {
        if (emailId == null || password == null)
            return false;

        Optional<Vendor> vendor = vendorRepository.findByEmailId(emailId);
        if (vendor.isPresent()) {
            String storedPassword = vendor.get().getPassword();
            return password.equals(storedPassword);
        }
        return false;
    }

    public Optional<Vendor> findByEmailId(String emailId) {
        return vendorRepository.findByEmailId(emailId);
    }

    public Vendor saveVendor(Vendor vendor) {
        return vendorRepository.save(vendor);
    }
}
