package com.project.recipebackend.middleware;

import com.project.recipebackend.entity.AdminLogin;
import com.project.recipebackend.repository.AdminLoginRepository;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Optional;

@Component
public class AuthenticationMiddleware implements HandlerInterceptor {

    @Autowired
    private AdminLoginRepository adminLoginRepository;

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        String requestURI = request.getRequestURI();
        
        // Skip authentication for login and public endpoints
        if (requestURI.startsWith("/api/auth") || requestURI.startsWith("/api/public")) {
            return true;
        }

        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("userId") == null) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write("{\"error\": \"Authentication required\", \"redirectTo\": \"/login\"}");
            response.setContentType("application/json");
            return false;
        }

        String userId = (String) session.getAttribute("userId");
        
        try {
            Optional<AdminLogin> admin = adminLoginRepository.findById(userId);
            
            if (admin.isEmpty()) {
                session.invalidate();
                response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
                response.getWriter().write("{\"error\": \"Admin not found\", \"redirectTo\": \"/login\"}");
                response.setContentType("application/json");
                return false;
            }

            // Add admin info to request attributes for controllers to access
            request.setAttribute("admin", admin.get());
            
        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\": \"Authentication error\"}");
            response.setContentType("application/json");
            return false;
        }

        return true;
    }
} 