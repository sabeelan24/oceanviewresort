package com.oceanview.util;

import javax.servlet.http.HttpSession;

public class MessageUtil {

    public static void setFlashMessage(javax.servlet.http.HttpServletRequest request, String type, String message) {
        HttpSession session = request.getSession();
        session.setAttribute("flashType", type); // e.g., "success" or "danger"
        session.setAttribute("flashMessage", message);
    }
    
    // This is called just before forwarding to JSP to ensure clean state if needed
    // However, the real cleaning happens in the JSP using JSTL (c:remove) or a Scriptlet.
}