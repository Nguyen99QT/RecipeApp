package com.project.recipebackend.service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.concurrent.CompletableFuture;

@Slf4j
@Service
public class PushNotificationService {

    /**
     * Send push notifications to multiple registration tokens
     * 
     * @param registrationTokens List of FCM registration tokens
     * @param title Notification title
     * @param messageBody Notification message body
     */
    public void sendPushNotification(List<String> registrationTokens, String title, String messageBody) {
        if (registrationTokens == null || registrationTokens.isEmpty()) {
            log.warn("No registration tokens provided for push notification");
            return;
        }

        int totalTokens = registrationTokens.size();
        log.info("Sending push notification to {} tokens", totalTokens);
        log.info("Title: {}", title);
        log.info("Message: {}", messageBody);

        // Process tokens asynchronously for better performance
        registrationTokens.parallelStream().forEach(token -> {
            sendNotificationToToken(token, title, messageBody);
        });
    }

    /**
     * Send push notification to a single registration token
     * 
     * @param registrationToken FCM registration token
     * @param title Notification title
     * @param messageBody Notification message body
     */
    public void sendNotificationToToken(String registrationToken, String title, String messageBody) {
        try {
            // Build the notification
            Notification notification = Notification.builder()
                    .setTitle(title)
                    .setBody(messageBody)
                    .build();

            // Build the message
            Message message = Message.builder()
                    .setNotification(notification)
                    .setToken(registrationToken)
                    .build();

            // Send the message asynchronously
            CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
                try {
                    return FirebaseMessaging.getInstance().send(message);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });

            future.thenAccept(response -> {
                log.info("Successfully sent notification to token: {}", response);
            }).exceptionally(ex -> {
                log.error("Failed to send notification to token: {}", ex.getMessage());
                return null;
            });

        } catch (Exception e) {
            log.error("Failed to send notification to token: {}", e.getMessage(), e);
        }
    }

    /**
     * Send push notification with custom data to multiple registration tokens
     * 
     * @param registrationTokens List of FCM registration tokens
     * @param title Notification title
     * @param messageBody Notification message body
     * @param data Custom data to include in the notification
     */
    public void sendPushNotificationWithData(List<String> registrationTokens, String title, String messageBody, 
                                           java.util.Map<String, String> data) {
        if (registrationTokens == null || registrationTokens.isEmpty()) {
            log.warn("No registration tokens provided for push notification");
            return;
        }

        int totalTokens = registrationTokens.size();
        log.info("Sending push notification with data to {} tokens", totalTokens);

        registrationTokens.parallelStream().forEach(token -> {
            sendNotificationWithDataToToken(token, title, messageBody, data);
        });
    }

    /**
     * Send push notification with custom data to a single registration token
     */
    private void sendNotificationWithDataToToken(String registrationToken, String title, String messageBody, 
                                                java.util.Map<String, String> data) {
        try {
            // Build the notification
            Notification notification = Notification.builder()
                    .setTitle(title)
                    .setBody(messageBody)
                    .build();

            // Build the message with custom data
            Message.Builder messageBuilder = Message.builder()
                    .setNotification(notification)
                    .setToken(registrationToken);
            
            if (data != null && !data.isEmpty()) {
                messageBuilder.putAllData(data);
            }
            
            Message message = messageBuilder.build();

            // Send the message asynchronously
            CompletableFuture<String> future = CompletableFuture.supplyAsync(() -> {
                try {
                    return FirebaseMessaging.getInstance().send(message);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            });

            future.thenAccept(response -> {
                log.info("Successfully sent notification with data to token: {}", response);
            }).exceptionally(ex -> {
                log.error("Failed to send notification with data to token: {}", ex.getMessage());
                return null;
            });

        } catch (Exception e) {
            log.error("Failed to send notification with data to token: {}", e.getMessage(), e);
        }
    }
} 