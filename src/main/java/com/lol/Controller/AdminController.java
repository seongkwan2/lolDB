package com.lol.Controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class AdminController {

    @GetMapping("/admin")
   // @PreAuthorize("hasAuthority('ADMIN')")
    public String adminPage() {
        // ADMIN 권한이 있는 사용자만 접근 가능
        return "Admin Page";
    }
}
