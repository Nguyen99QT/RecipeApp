package com.project.recipebackend.util;

import com.project.recipebackend.entity.AdminLogin;
import com.project.recipebackend.repository.AdminLoginRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
public class CreateAdminUtil implements CommandLineRunner {

    @Autowired
    private AdminLoginRepository adminLoginRepository;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Override
    public void run(String... args) throws Exception {
        if (args.length > 0 && "create-admin".equals(args[0])) {
            createDefaultAdmin();
        }
    }

    public void createDefaultAdmin() {
        try {
            String adminEmail = "admin@recipeapp.com";
            
            // Check if admin already exists
            Optional<AdminLogin> existingAdmin = adminLoginRepository.findByEmail(adminEmail);
            
            if (existingAdmin.isPresent()) {
                System.out.println("⚠️  Admin user already exists!");
                System.out.println("📧 Email: " + adminEmail);
                System.out.println("🔑 Password: admin123");
                return;
            }

            // Create new admin
            AdminLogin admin = new AdminLogin();
            admin.setName("Admin");
            admin.setEmail(adminEmail);
            // Hash password using BCrypt (more secure than sha256)
            admin.setPassword(passwordEncoder.encode("admin123"));

            adminLoginRepository.save(admin);

            System.out.println("✅ Default admin created successfully!");
            System.out.println("📧 Email: " + adminEmail);
            System.out.println("🔑 Password: admin123");
            System.out.println("⚠️  Please change the password after first login!");

        } catch (Exception e) {
            System.err.println("❌ Error creating admin: " + e.getMessage());
            e.printStackTrace();
        }
    }
} 