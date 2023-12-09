package com.edu.springboot.smtp;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;

import com.edu.springboot.jdbc.InfoDTO;
import com.edu.springboot.jdbc.MemberDTO;

import jakarta.mail.internet.MimeMessage;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;
import lombok.RequiredArgsConstructor;

/* 스프링 컨테이너 시작시 자동으로 빈을 생성하고, 생성자 설정을 위한
어노테이션 부착 */
@Component
@RequiredArgsConstructor
public class EmailSending {

	// 멤버변수로 메일센더를 선언. 프로젝스 생성시 의존성주입을 했으므로 사용 가능함
	private final JavaMailSender mailSender;
	
	/* 보내는 사람의 이메일. 이 프로젝트는 Naver SMTP를 사용하므로 네이버 메일로
	지정한다. 프로퍼티에 입력된 내용을 가져와서 설정한다. */
	@Value("${spring.mail.username}")
	private String from;
	
	public void myEmailSender(InfoDTO infoDTO, MemberDTO memberDTO) {
		
		try {
			
			// 5자리 난수 생성
			Random rand  = new Random();
	        String randNum = "";
	        for(int i=0; i<5; i++) {
	            String ran = Integer.toString(rand.nextInt(10));
	            randNum+=ran;
	        }
	        
			// 메일을 보내가 위한 설정
			MimeMessage m = mailSender.createMimeMessage();
			// 인코딩 설정
			MimeMessageHelper h = new MimeMessageHelper(m, "UTF-8");
			
			// 보내는 사람
			h.setFrom(from);
			// 받는사람
			h.setTo(memberDTO.getId());
			// 메일 제목
			h.setSubject(infoDTO.getSubject());
			// 메일의 내용
//			if(infoDTO.getFormat().equals("text")) {
			// 메일을 Text 형식으로 발송한다. 순수한 문자열만 전송된다.
			h.setText("인증번호 : "+randNum);
//			}
//			else {
//				/* HTML 형식으로 지정한 경우 미리 만들어둔 메일템플릿(HTML)의
//				내용을 읽어온 후 우리가 입력한 내용으로 변경하는 작업이 필요하다. */
//				String emailTpl = readHTMLFile();
//				// 우리가 입력한 내용을 줄바꿈 처리 한다.
//				String contents = infoDTO.getContent()
//						.replace("\r\n", "<br>");
//				// 메일 템플릿에 우리가 작성한 내용을 삽입한다.
//				emailTpl = emailTpl.replace("__CONTENT__", contents);
//				// HTML인 경우에는 두번째 인수를 true로 설정해야한다.
//				h.setText(emailTpl, true);
//			}
			
			// 여기서 메일 발송
			mailSender.send(m);
			infoDTO.setContent(randNum);
			System.out.println("es randNum을 infoDTO content에 저장 : "+infoDTO.getContent());
			System.out.println("메일 전송 완료");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
public void findPassEmailSender(InfoDTO infoDTO, MemberDTO memberDTO) {
		
		try {
			
			// 5자리 난수 생성
			Random rand  = new Random();
	        String randNum = "";
	        for(int i=0; i<5; i++) {
	            String ran = Integer.toString(rand.nextInt(10));
	            randNum+=ran;
	        }
	        
			// 메일을 보내가 위한 설정
			MimeMessage m = mailSender.createMimeMessage();
			// 인코딩 설정
			MimeMessageHelper h = new MimeMessageHelper(m, "UTF-8");
			
			// 보내는 사람
			h.setFrom(from);
			// 받는사람
			h.setTo(memberDTO.getId());
			// 메일 제목
			h.setSubject(infoDTO.getFindPassSubject());
			// 메일의 내용. Text 형식으로 발송한다. 순수한 문자열만 전송된다.
			h.setText("인증번호 : "+randNum);
			
			// 여기서 메일 발송
			mailSender.send(m);
			infoDTO.setFindPassNum(randNum);
			System.out.println("es randNum을 infoDTO findPassNum에 저장 : "+infoDTO.getFindPassNum());
			System.out.println("메일 전송 완료");
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// HTML문서를 읽어 그 내용을 반환한다.
	public String readHTMLFile() {
		
		// 문서의 내용을 읽어 저장할때는 스프링버퍼가 메모리적으로 유리하다.
		StringBuffer htmlContents = new StringBuffer();
		
		try {
			// HTML 메일 템플릿이 있는 디렉토리의 물리적경로를 가져온다ㅏ
			String uploadDir = ResourceUtils
					.getFile("classpath:static/").toPath().toString();
			String templatePath = uploadDir+"/mailTemplate.html";
			// HTML 파일을 IO스트림을 통해 읽는다.
			BufferedReader br = new BufferedReader(new FileReader(templatePath));
			String oneLine;
			while((oneLine = br.readLine()) != null) {
				// HTML 문서를 한줄씩 읽어 스프링 버퍼에 추가한다.
				htmlContents.append(oneLine + "\n");
			}
			// 문서의 끝까지 읽었다면 스트림을 닫아서 자원반납한다.
			br.close();
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		// 읽어온 내용은 String으로 변환 후 반환한다.
		return htmlContents.toString();
	}
}
