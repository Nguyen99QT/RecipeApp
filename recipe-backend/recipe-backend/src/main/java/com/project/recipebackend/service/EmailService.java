package com.project.recipebackend.service;

import com.project.recipebackend.dto.EmailResponse;
import com.project.recipebackend.entity.Mail;
import com.project.recipebackend.repository.MailRepository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

import jakarta.mail.internet.MimeMessage;
import lombok.extern.slf4j.Slf4j;

import java.util.Properties;

@Slf4j
@Service
public class EmailService {

    @Autowired
    private MailRepository mailRepository;

    @Autowired
    private TemplateEngine templateEngine;

    /**
     * Send OTP verification email
     * 
     * @param email Email address to send OTP to
     * @param otp OTP code
     * @param firstname User's first name (default: "User")
     * @param lastname User's last name (default: "")
     * @return EmailResponse containing success status and details
     */
    public EmailResponse sendOtpEmail(String email, Integer otp, String firstname, String lastname) {
        return sendOtpMail(email, otp.toString(), firstname, lastname);
    }

    public EmailResponse sendOtpMail(String email, String otp, String firstname, String lastname) {
        try {
            log.info("=== SENDING OTP EMAIL ===");
            log.info("Email: {}, OTP: {}, Name: {} {}", email, otp, firstname, lastname);

            // Validate input parameters
            if (otp == null || otp.trim().isEmpty() || email == null || email.trim().isEmpty()) {
                String error = "Email and OTP are required";
                log.error(error);
                return EmailResponse.failure(error);
            }

            // Set default values
            if (firstname == null || firstname.trim().isEmpty()) {
                firstname = "User";
            }
            if (lastname == null) {
                lastname = "";
            }

            // Fetch Mail configuration
            Mail smtpConfig = mailRepository.findFirstBy();
            log.info("SMTP config found: {}", smtpConfig != null ? "Yes" : "No");

            if (smtpConfig == null) {
                String error = "Mail details not found - Please configure SMTP settings in admin panel";
                log.error(error);
                return EmailResponse.failure(error);
            }

            // Create JavaMailSender with SMTP configuration
            JavaMailSender mailSender = createMailSender(smtpConfig);
            log.info("Mail sender created with host: {}, port: {}", smtpConfig.getHost(), smtpConfig.getPort());

            // Create email message
            MimeMessage message = mailSender.createMimeMessage();
            MimeMessageHelper helper = new MimeMessageHelper(message, true, "UTF-8");

            // Set email properties
            helper.setFrom(smtpConfig.getSenderEmail());
            helper.setTo(email);
            helper.setSubject("OTP Verification");

            // Create template context
            Context context = new Context();
            context.setVariable("OTP", otp);
            context.setVariable("email", email);
            context.setVariable("firstname", firstname);
            context.setVariable("lastname", lastname);

            // Process HTML template
            String htmlContent = templateEngine.process("otp", context);
            helper.setText(htmlContent, true);

            log.info("Attempting to send email to: {}", email);
            log.info("Mail from: {}", smtpConfig.getSenderEmail());
            log.info("Template: otp");

            // Send the email
            mailSender.send(message);

            log.info("=== EMAIL SENT SUCCESSFULLY ===");
            log.info("Email sent to: {}", email);
            
            return EmailResponse.success("Email sent successfully", message.getMessageID());

        } catch (Exception e) {
            log.error("=== OTP MAIL EXCEPTION ===");
            log.error("Error sending OTP mail: {}", e.getMessage());
            log.error("Stack trace: ", e);
            return EmailResponse.failure(e.getMessage());
        }
    }

    /**
     * Create JavaMailSender with SMTP configuration
     */
    private JavaMailSender createMailSender(Mail smtpConfig) {
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        
        mailSender.setHost(smtpConfig.getHost());
        mailSender.setPort(Integer.parseInt(smtpConfig.getPort()));
        mailSender.setUsername(smtpConfig.getMail_username());
        mailSender.setPassword(smtpConfig.getMail_password());

        Properties props = mailSender.getJavaMailProperties();
        props.put("mail.transport.protocol", "smtp");
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.debug", "false");

        // Handle encryption settings
        if ("tls".equalsIgnoreCase(smtpConfig.getEncryption())) {
            props.put("mail.smtp.starttls.enable", "true");
            props.put("mail.smtp.ssl.trust", "*");
        } else if ("ssl".equalsIgnoreCase(smtpConfig.getEncryption())) {
            props.put("mail.smtp.ssl.enable", "true");
            props.put("mail.smtp.ssl.trust", "*");
        }

        return mailSender;
    }
} 