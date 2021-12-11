package com.fc.controller;

import com.fc.model.Post;
import com.fc.model.User;
import com.fc.service.PostService;
import com.fc.service.QiniuService;
import com.fc.service.UserService;
import com.fc.util.MyConstant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private PostService postService;

    @Autowired
    private QiniuService qiniuService;

    @RequestMapping("/toMyProfile.do")
    public String toMyProfile(HttpSession session,Model model) {
        int sessionUid = (int) session.getAttribute("userId");
        User user = userService.getProfile(sessionUid, sessionUid);
        List<Post> postList =  postService.getPostList(sessionUid);
        model.addAttribute("user",user);
        model.addAttribute("postList",postList);
        return "myProfile";
    }

    @RequestMapping("/toProfile.do")
    public String toProfile(int userId, Model model, HttpSession session) {
        int sessionUid = (int) session.getAttribute("userId");
        if(sessionUid == userId){
            return "redirect:toMyProfile.do";
        }
        boolean following = userService.getFollowStatus(sessionUid,userId);
        User user = userService.getProfile(sessionUid, userId);
        List<Post> postList =  postService.getPostList(userId);
        model.addAttribute("following",following);
        model.addAttribute("user",user);
        model.addAttribute("postList",postList);
        return "profile";
    }

    @RequestMapping("/toEditProfile.do")
    public String toEditProfile(HttpSession session,Model model){
        int userId = (int) session.getAttribute("userId");
        User user = userService.getEditInfo(userId);
        model.addAttribute("user",user);
        return "editProfile";
    }

    @RequestMapping("/editProfile.do")
    public String editProfile(User user){
        System.out.println(user);
        userService.updateUser(user);
        return "redirect:toMyProfile.do";
    }


    @RequestMapping("/updatePassword.do")
    public String updatePassword(String password,String newpassword,String repassword,HttpSession session,Model model){
        int sessionUid = (int) session.getAttribute("userId");
        String status = userService.updatePassword(password,newpassword,repassword,sessionUid);
        if(status.equals("ok")){
            return "redirect:logout.do";
        }else {
            model.addAttribute("passwordError",status);
            return "editProfile";
        }
    }

    @RequestMapping("/forgetPassword.do")
    public @ResponseBody
    String forgetPassword(String email){
        userService.forgetPassword(email);
        return "";
    }


    @RequestMapping("/afterForgetPassword.do")
    public String afterForgetPassword(){
        return "prompt/afterForgetPassword";
    }

    @RequestMapping("/updateHeadUrl.do")
    public String updateHeadUrl(MultipartFile myFileName,Model model,HttpSession session) throws IOException {
        String[] allowedType = {"image/bmp", "image/gif", "image/jpeg", "image/png"};
        boolean allowed = Arrays.asList(allowedType).contains(myFileName.getContentType());
        if (!allowed) {
            model.addAttribute("error3","图片格式仅限bmp，jpg，png，gif~");
            return "editProfile";
        }
        if (myFileName.getSize() > 3 * 1024 * 1024) {
            model.addAttribute("error3","图片大小限制在3M以下哦~");
            return "editProfile";
        }
        String fi = myFileName.getOriginalFilename();
        String fileNameExtension = fi.substring(fi.indexOf("."), fi.length());
        String remoteFileName = UUID.randomUUID().toString() + fileNameExtension;
        qiniuService.upload(myFileName.getBytes(), remoteFileName);

        int userId = (int) session.getAttribute("userId");
        userService.updateHeadUrl(userId,MyConstant.QINIU_IMAGE_URL + remoteFileName);

        return "redirect:toMyProfile.do";
    }

    @RequestMapping("/follow.do")
    public String follow(int userId,HttpSession session){
        int sessionUid = (int) session.getAttribute("userId");
        userService.follow(sessionUid,userId);
        return "forward:toProfile.do";
    }

    @RequestMapping("/unfollow.do")
    public String unfollow(int userId,HttpSession session){
        int sessionUid = (int) session.getAttribute("userId");
        userService.unfollow(sessionUid,userId);
        return "forward:toProfile.do";
    }

    @RequestMapping("/verify.do")
    public String verify(String code){
        userService.verifyForgetPassword(code);
        return "redirect:toLogin.do";
    }
}

