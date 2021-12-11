package utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;

public class CookieUtils {
    public static String   getCookieValue(HttpServletRequest request, String str) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Cookie[] cookies = request.getCookies();
        String userName=null;
        for (int i=0;cookies!=null&&i<cookies.length;i++){
            if(str.equals(cookies[i].getName())){
                userName=cookies[i].getValue();
                return userName;
            }
        }
        return null;
    }
    public static void createCookie(HttpServletResponse response,String name, String value){
        Cookie cookie = new Cookie(name, value);
        // 有效期,秒为单位
        cookie.setMaxAge(3600);
        cookie.setPath("/");
        response.addCookie(cookie);
    }
    public static void updateCookie(HttpServletRequest request,HttpServletResponse response, String name, String value) throws UnsupportedEncodingException {
        request.setCharacterEncoding("utf-8");
        Cookie[] cookies = request.getCookies();
        String userName=null;
        for (int i=0;cookies!=null&&i<cookies.length;i++){
            if(name.equals(cookies[i].getName())){
                userName=cookies[i].getValue();
                if(userName.contains(value)){
                    return;
                }
                userName+='_'+value;
                CookieUtils.createCookie(response,name,userName);
                return;
            }
        }
        createCookie(response,name,value);
    }
}
