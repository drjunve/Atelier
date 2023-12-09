package com.edu.springboot;

import java.io.File;
import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.edu.springboot.jdbc.IMemberService;
import com.edu.springboot.jdbc.InfoDTO;
import com.edu.springboot.jdbc.MemberDTO;
import com.edu.springboot.sms.SmsController;
import com.edu.springboot.smtp.EmailSending;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletResponse;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import net.nurigo.sdk.message.model.Message;
import utils.Functions;

@Controller
public class MainController {
	
	@Autowired
	EmailSending email;

	//@Autowired
	//Imember dao;

	@Autowired
	IMemberService dao;
	
	@RequestMapping("/")
	public String main() {
		//model.addAttribute("loginPage","1");
		return "/main";
	}

	@RequestMapping("/login")
	public String login(Model model, HttpServletRequest req, InfoDTO infoDTO, HttpSession session) {
		model.addAttribute("loginPage","1");
		try {
		Cookie[] list = req.getCookies();
		for(Cookie cookie:list) {
			if(cookie.getName().equals("logId")) {
				model.addAttribute("logId", cookie.getValue());
			}
			if(cookie.getName().equals("saveEmail")) {
				model.addAttribute("saveEmail", cookie.getValue());
			}
		}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("저장된 id 쿠키없음");
		}
		return "/member/signup";
	}
	
	@RequestMapping("/signup")
	public String signup(Model model) {
		model.addAttribute("loginPage","2");
		return "/member/signup";
	}
	

	@RequestMapping("/RegiIdOverlap")
	public String RegiIdOverlapp() {
		return "/member/RegiIdOverlap";
	}

	@RequestMapping("/emailCheck")
	public String emailCheck() {
		return "/member/emailCheck";
	}
	

	//이메일 인증 번호 발송
	@PostMapping("/emailSendProcess.do")
	public String emailSendProcess(InfoDTO infoDTO, MemberDTO memberDTO, Model model) {
		
		email.myEmailSender(infoDTO, memberDTO);
		
		model.addAttribute("id", memberDTO.getId());
		model.addAttribute("content", infoDTO.getContent());
		
		return "/member/emailCheck";
	}
	

	//발송된 이메일 인증번호와 입력 받은 번호 일치 여부 확인
	@PostMapping("/check.do")
	public String emailSendProcess1(InfoDTO infoDTO, Model model, MemberDTO memberDTO, HttpServletRequest req) {
		
		model.addAttribute("id", memberDTO.getId());
		model.addAttribute("content", infoDTO.getContent());
		model.addAttribute("userContent",req.getParameter("userContent"));
		
		//infoDTO는 model에 저장안하면 없어지고, 저장하면 infoDTO, model 둘 다 남는데, req는 model에 저장 안하면 날아가고, 저장해도 model에만 남는다.

		try {
			int checkmodelContent = Integer.parseInt((model.getAttribute("content")).toString());
		}catch (NumberFormatException e) {
			System.out.println("인증번호 발송 안함");
			model.addAttribute("authsuccess", "-1");
			System.out.println("nullpointerexception");
			return "/member/emailCheck";
		}
		
		try {
			int checkuserContent = Integer.parseInt(model.getAttribute("userContent").toString());
		} catch (NumberFormatException e) {
			System.out.println("인증번호 입력안함");
			model.addAttribute("authsuccess", "-2");
			System.out.println("numberformatexception");
			return "/member/emailCheck";
		}
		
		
		
		if (Integer.parseInt((model.getAttribute("userContent")).toString()) == Integer.parseInt((infoDTO.getContent()).toString())) {
			System.out.println("인증성공");

			model.addAttribute("dto", memberDTO);
			model.addAttribute("authsuccess", "1");

			return "/member/emailCheck";
		} else {
			System.out.println("인증실패");
			
			model.addAttribute("dto", memberDTO);
			model.addAttribute("authsuccess", "0");
			
			return "/member/emailCheck";
		}
		
	}

	@RequestMapping("/dummydate.do")
	public String dddd() {
		return "dummydate";
	}

	/*
	@PostMapping("/uploadData.do")
	public String write(MemberDTO memberDTO) {
		int i = dao.write(memberDTO);

		return "/";
	}
	*/

	@Autowired
	SmsController sms;

	@RequestMapping("/smsCheck")
	public String SmsCheck() {
		return "/member/smsCheck";
	}
	
	// 휴대폰 인증번호 발송
	@PostMapping("/smsauth")
	public String SmsAuth(MemberDTO memberDTO, InfoDTO infoDTO, Model model) {
		
		sms.sendOne(memberDTO, infoDTO);
		
		model.addAttribute("phone", memberDTO.getPhone());
		model.addAttribute("smsContent", infoDTO.getSmsContent());

		return "/member/smsCheck";
	}
	
	// 발송된 번호와 입력된 번호 일치 여부 확인
	@PostMapping("/smscheck.do")
	public String SmsCheckProcess(Model model, MemberDTO memberDTO, HttpServletRequest req, InfoDTO infoDTO) {
		
		model.addAttribute("phone", memberDTO.getPhone());
		model.addAttribute("smsContent", infoDTO.getSmsContent());
		model.addAttribute("userSmsContent",req.getParameter("userSmsContent"));
		
		try {
			int checksessionSmsContent = Integer.parseInt((model.getAttribute("smsContent")).toString());
		}catch (NumberFormatException e) {
			System.out.println("인증번호 발송 안함");
			model.addAttribute("smsAuthsuccess", "-1");
			System.out.println("numberformatexception");
			return "/member/smsCheck";
		}
		
		try {
			int checkUserSmsContent = Integer.parseInt(model.getAttribute("userSmsContent").toString());
		} catch (NumberFormatException e) {
			System.out.println("인증번호 입력 안함");
			model.addAttribute("smsAuthsuccess", "-2");
			System.out.println("numberformatexception");
			return "/member/smsCheck";
		}
		
		if (Integer.parseInt((model.getAttribute("smsContent")).toString()) == Integer.parseInt(model.getAttribute("userSmsContent").toString())) {
			System.out.println("인증성공");
			model.addAttribute("smsAuthsuccess", "1");
			return "/member/smsCheck";
		} else {
			model.addAttribute("smsAuthsuccess", "0");
			System.out.println("인증실패");
			return "/member/smsCheck";
		}
	}
	
	//회원가입
	@PostMapping("/regist")
	public String Regist(MemberDTO memberDTO, Model model) {
		System.out.println("id : "+memberDTO.getId()+"+ pass : "+memberDTO.getPass()+"+ m_name : "+memberDTO.getM_name()+"+ phone : "+memberDTO.getPhone()+"+ zip : "+memberDTO.getZip()+"+ addr1 : "+memberDTO.getAddr1()+"+ addr2 : "+memberDTO.getAddr2()+"+ midx : "+memberDTO.getMidx()+"+ regidate : "+memberDTO.getRegidate());
		int result = dao.insert(memberDTO);
		if (result == 1 ) {
			model.addAttribute("regSuc", "1");
			model.addAttribute("loginPage","1");
		} else {
			model.addAttribute("regSuc", "0");
			model.addAttribute("loginPage","1");
		}
		return "/member/signup";
	}
	
	//로그인
	@PostMapping("/login.do")
	public String loginProcess(InfoDTO infoDTO, MemberDTO memberDTO, Model model, HttpSession session, HttpServletResponse res, RedirectAttributes red) {
		System.out.println("logindo try.. att : "+session.getAttribute("tryMypageWithNoLogin"));
		System.out.println("logId : "+infoDTO.getLogId());
		System.out.println("logPass : "+infoDTO.getLogPass());
		System.out.println("saveEmail : "+infoDTO.getSaveEmail());
		memberDTO.setId(infoDTO.getLogId());
		memberDTO.setPass(infoDTO.getLogPass());
		try {
			MemberDTO result = dao.login(memberDTO);
			System.out.println(result);
			if (result.getId() != null) {
				if (infoDTO.getSaveEmail() != null) {
					session.setAttribute("saveEmail", "1");
					Cookie cookie = new Cookie("logId", result.getId());
					cookie.setMaxAge(60*60*24*7);
					cookie.setDomain("localhost");
					cookie.setPath("/");
					Cookie cookieS = new Cookie("saveEmail", infoDTO.getSaveEmail());
					cookieS.setMaxAge(60*60*24*7);
					cookieS.setDomain("localhost");
					cookieS.setPath("/");
					res.addCookie(cookie);
					res.addCookie(cookieS);
				}
				else {
					Cookie cookie = new Cookie("logId", null);
					cookie.setMaxAge(0);
					res.addCookie(cookie);
					
					Cookie cookieS = new Cookie("saveEmail", null);
					cookieS.setMaxAge(0);
					res.addCookie(cookieS);
				}
				model.addAttribute("logSucAlert", "1");
				session.setAttribute("logSuc", "1");
				session.setAttribute("memberDTO", result);
				//session.setAttribute("m_name", result.getM_name());
			}
			// 로그아웃 상태로 mypage를 클릭하여 로그인 페이지로 포워드된 이후 로그인한 경우 로그인에 성공하면 mypage로 포워드한다.
			if (session.getAttribute("tryMypageWithNoLogin") == null) {
				return "main";
			} else {
				session.removeAttribute("tryMypageWithNoLogin");
				System.out.println("session try... 확인 : "+session.getAttribute("tryMypageWithNoLogin"));
				return "redirect:mypage";
			}
		} catch (Exception e) {
			model.addAttribute("logSuc", "0");
			model.addAttribute("loginPage","1");
			return "/member/signup";
		}
		
	}
	
	//로그아웃
	@RequestMapping("/logout.do")
	public String logoutProcess(HttpSession session) {
		//session.invalidate();
		session.removeAttribute("logSuc");
		session.removeAttribute("memberDTO");
		return "main";
	}
	
	//비밀번호찾기
	@RequestMapping("/findPass")
	public String findPass() {
		return "/member/findPass";
	}
	
	//마이페이지
	@RequestMapping("mypage")
	public String myPage(HttpSession session, HttpServletRequest req, Model model) {
		System.out.println("mypage log suc : "+session.getAttribute("logSuc"));
		if (session.getAttribute("logSuc")!=null) {
			return "member/mypage";
		} else {
			session.setAttribute("tryMypageWithNoLogin", "1");
			return "forward:login";
		}
	}
	
	@RequestMapping("uploadProfile")
	public String uploadProfile() {
		return "member/uploadProfile";
	}
	
	@PostMapping("uploadProfile.do")
	public String uploadProfileProcess(HttpServletRequest req, Model model, HttpSession session, MemberDTO memberDTO) {
		try {
			String uploadDir = ResourceUtils.getFile("classpath:static/uploads/").toPath().toString();
			System.out.println("물리적 경로 : "+uploadDir);
			Part part = req.getPart("profileo");
			String partHeader = part.getHeader("content-disposition");
			System.out.println("partHeader="+partHeader);
			String[] phArr = partHeader.split("filename=");
			String originalFileName = phArr[1].trim().replace("\"","");
			if(!originalFileName.isEmpty()) {
				part.write(uploadDir+File.separator+originalFileName);
			}
			String savedFileName = Functions.renameFilie(uploadDir, originalFileName);
			model.addAttribute("savedFileName",savedFileName);
			
		}
		catch (Exception e) {
			System.out.println("업로드 실패");
		}
		return "member/uploadProfile";
	}
}