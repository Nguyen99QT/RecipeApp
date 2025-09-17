package com.project.recipebackend.service;

import jakarta.servlet.http.HttpSession;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class FlashMessageService {

    private static final String FLASH_MESSAGES_SESSION_KEY = "flash_messages";

    public void addMessage(HttpSession session, String type, String message) {
        Map<String, List<String>> flashMessages = getFlashMessages(session);
        flashMessages.computeIfAbsent(type, k -> new ArrayList<>()).add(message);
        session.setAttribute(FLASH_MESSAGES_SESSION_KEY, flashMessages);
    }

    public void addSuccess(HttpSession session, String message) {
        addMessage(session, "success", message);
    }

    public void addError(HttpSession session, String message) {
        addMessage(session, "error", message);
    }

    public void addWarning(HttpSession session, String message) {
        addMessage(session, "warning", message);
    }

    public void addDelete(HttpSession session, String message) {
        addMessage(session, "delete", message);
    }

    public void addEdit(HttpSession session, String message) {
        addMessage(session, "edit", message);
    }

    @SuppressWarnings("unchecked")
    public Map<String, List<String>> getFlashMessages(HttpSession session) {
        Map<String, List<String>> flashMessages = 
            (Map<String, List<String>>) session.getAttribute(FLASH_MESSAGES_SESSION_KEY);
        
        if (flashMessages == null) {
            flashMessages = new HashMap<>();
        }
        
        return flashMessages;
    }

    public Map<String, List<String>> getAndClearFlashMessages(HttpSession session) {
        Map<String, List<String>> flashMessages = getFlashMessages(session);
        session.removeAttribute(FLASH_MESSAGES_SESSION_KEY);
        return flashMessages;
    }

    public boolean hasMessages(HttpSession session) {
        Map<String, List<String>> flashMessages = getFlashMessages(session);
        return !flashMessages.isEmpty() && flashMessages.values().stream()
                .anyMatch(list -> !list.isEmpty());
    }
} 