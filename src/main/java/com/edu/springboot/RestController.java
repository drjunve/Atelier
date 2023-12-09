package com.edu.springboot;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.edu.springboot.jdbc.IMemberService;
import com.edu.springboot.jdbc.InfoDTO;
import com.edu.springboot.jdbc.MemberDTO;
import com.edu.springboot.smtp.EmailSending;

import ch.qos.logback.core.recovery.ResilientSyslogOutputStream;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@org.springframework.web.bind.annotation.RestController
public class RestController {
	
	@Autowired
	IMemberService dao;
	
	@Autowired
	EmailSending email;
	
	//이메일 중복 검사	
	@PostMapping("/emailOverlap")
	public int emailOverlap(MemberDTO memberDTO) throws Exception {
		return dao.emailOverlap(memberDTO);
	}
	
	//비밀번호 찾기 이메일 인증 번호 발송
	@PostMapping("/findPassEmailSendProcess")
	public HashMap<String, String> findPassEmailSendProcess(InfoDTO infoDTO, MemberDTO memberDTO, HttpSession session, Model model) {
		
		HashMap<String, String> findPassMap = new HashMap<String, String>();
		
		if (memberDTO.getId() == "") {
			System.out.println("아이디 입력 안함");
			return findPassMap;
		}
		
		//nullpointexception을 막기위해, 아이디를 입력 했을 때만 객체 담기 시도
		MemberDTO findPassResult = dao.findPassIdSelect(memberDTO);
		
		if (findPassResult != null) {
			System.out.println("아이디 조회 성공");
			//아이디가 존재할 경우 이메일을 발송한다.
			email.findPassEmailSender(infoDTO, memberDTO);
			//맵 suc 키에 1을 담는다.
			findPassMap.put("findPassIdSuc", "1");
			//세션 영역에 인증번호를 저장한다.
			session.setAttribute("findPassNum", infoDTO.getFindPassNum());
			
			return findPassMap;
			
		} else {
			//입력받은 아이디가 데이터에 없을 경우 객체에 null이 담기게 됨
			System.out.println("아이디 조회 실패");
			//맵 suc 키에 0을 담는다.
			findPassMap.put("findPassIdSuc", "0");
			
			return findPassMap;
		}
	}
	
	//비밀번호 찾기 인증번호 확인하기
	@PostMapping("/findPassCheck")
	public HashMap<String,String> findPassCheck(MemberDTO memberDTO, InfoDTO infoDTO, HttpSession session, Model model) {
		HashMap<String, String> findPassCheckMap = new HashMap<String, String>();
		try {
			if(infoDTO.getFindPassNum()=="") {
				System.out.println("인증번호 입력 안함");
				findPassCheckMap.put("findPassCheckSuc", "-2");
				return findPassCheckMap;
			} else if(session.getAttribute("findPassNum")==null) {
				System.out.println("인증번호 발송 안함");
				findPassCheckMap.put("findPassCheckSuc", "-1");
				return findPassCheckMap;
			} else if (Integer.parseInt(infoDTO.getFindPassNum().toString()) == Integer.parseInt(session.getAttribute("findPassNum").toString())) {
				System.out.println("인증번호 일치");
				
				MemberDTO findPassCheckDaoResult = dao.findPassIdSelect(memberDTO);
				
				findPassCheckMap.put("m_name", findPassCheckDaoResult.getM_name());
				findPassCheckMap.put("pass", findPassCheckDaoResult.getPass());
				findPassCheckMap.put("findPassCheckSuc", "1");
				
				//세션에 저장되어있던 인증번호를 지운다.
				session.removeAttribute("findPassIdSuc");
				System.out.println("인증번호 삭제. session findPassNum : "+session.getAttribute("findPassIdSuc"));
				
				return findPassCheckMap;
			} else {
				System.out.println("인증번호 불일치");
				System.out.println("infoDTOpassnum : "+infoDTO.getFindPassNum());
				System.out.println("session pass Num : "+session.getAttribute("findPassNum"));
				findPassCheckMap.put("findPassCheckSuc", "0");
				return findPassCheckMap;
			} 
		} catch (Exception e) {
			System.out.println("인증번호에 문자를 입력함");
			findPassCheckMap.put("findPassCheckSuc", "-3");
			return findPassCheckMap;
		}
	}
	
	/*
	
	
	@PostMapping()
	public String findPassChangePass(HttpSession session) {
		session.setAttribute("changePassAll", "1");
		return "/member/changePass";
	}
	*/
	
}













