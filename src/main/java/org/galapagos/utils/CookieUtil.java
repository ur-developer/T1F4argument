package org.galapagos.utils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class CookieUtil {

    public static void addViewedPostId(HttpServletRequest request, HttpServletResponse response, Long postId) {
        // 현재 사용자의 쿠키 가져오기
        Cookie[] cookies = request.getCookies();

        // 이미 생성된 쿠키가 있는지 확인
        boolean alreadyViewed = false;
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("viewed_posts".equals(cookie.getName())) {
                    alreadyViewed = true;

                    // 이미 조회한 게시물인지 확인
                    String[] viewedPostIds = cookie.getValue().split("/");
                    for (String viewedPostId : viewedPostIds) {
                        if (viewedPostId.equals(String.valueOf(postId))) {
                            // 이미 조회한 게시물이면 중복 조회 방지
                            return;
                        }
                    }

                    // 새로운 게시물 ID 추가
                    cookie.setValue(cookie.getValue() + "/" + postId);
                    response.addCookie(cookie);
                    break;
                }
            }
        }

        // 새로운 쿠키 생성
        if (!alreadyViewed) {
            Cookie newCookie = new Cookie("viewed_posts", String.valueOf(postId));
            newCookie.setMaxAge(24 * 60 * 60); // 24시간 유지
            response.addCookie(newCookie);
        }
    }
}