package com.lbk.study;

import java.text.DateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.lbk.study.dto.UserDto;

/**
 * Handles requests for the application home page.
 */
@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlsession;
	
	@Autowired
	private JavaMailSender mailSender;
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		logger.info("Welcome home! The client locale is {}.", locale);
		
		Date date = new Date();
		DateFormat dateFormat = DateFormat.getDateTimeInstance(DateFormat.LONG, DateFormat.LONG, locale);
		
		String formattedDate = dateFormat.format(date);
		
		model.addAttribute("serverTime", formattedDate );
		
		return "home";
	}
	

	@RequestMapping(value = "/main")
	public String MainPageController() {
		logger.info("MainPageController >>>>>");
		return "main";
	}

	@RequestMapping(value = "/loginMain")
	public String LoginPageController() {
		logger.info("LoginPageController >>>>>");
		return "loginMain";
	}

	@RequestMapping(value = "/join")
	public String JoinPageController() {
		logger.info("JoinPageController >>>>>");
		return "join";
	}

	@RequestMapping(value = "/loginTry", method = { RequestMethod.POST, RequestMethod.GET })
	@ResponseBody
	public Map<String, Object> loginTryController(@RequestParam Map<String, Object> param, HttpServletRequest req) {
		logger.info("loginTryController >>>>>");
		
		UserDto userDto = sqlsession.selectOne("userInfoMapper.getUserInfo", param.get("id"));
		Map<String, Object> map = new HashMap<String, Object>();
		HttpSession session = req.getSession();
		
		if (userDto == null) {
			map.put("result", "error");
			return map;
		} else {
			if (!param.get("pw").equals(userDto.getPw())) {
				map.put("result", "pwError");
				return map;
			} else {
				session.setAttribute("loginSession", param.get("id")); //세션 설정
				session.setAttribute("result", "LoginSuccess"); //세션 설정
				logger.info("sessionId" + (String) session.getAttribute("loginSession"));
				
				map.put("result", "ok");
				return map;
			}
		}
	}

	@RequestMapping(value = "/joinRegister", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> joinRegisterController(@RequestParam Map<String, Object> param, UserDto user) {
		logger.info("joinRegisterController >>>>>");
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		user.setId((String)param.get("id")); 
		user.setPw((String) param.get("pw"));
		user.setName((String) param.get("name")); 
		user.setBirthday((String)param.get("birth"));
		
		sqlsession.insert("userInfoMapper.insertUserInfo", user);
		map.put("result", "ok");
		return map;
	}

	@RequestMapping(value = "/sendEmail", method = RequestMethod.POST)
	@ResponseBody
	public String emailChkController(@RequestParam Map<String, Object> param) throws Exception {
		logger.info("emailChkController email >>>>>" + param.get("email"));
		
		// 인증번호(난수) 생성
		Random random  = new Random();
		int checkNum = random.nextInt(888888) + 111111;
		logger.info("인증번호" + checkNum);
		
		// 이메일 보내기
		String setFrom = "limbokyoung91@gmail.com";
		String toMail = (String) param.get("email");
		String title = "회원가입 인증 이메일입니다.";
		String content = "홈페이지를 방문해주셔서 감사합니다." 
						+ "<br><br>" 
						+ "인증 번호는 " + checkNum + "입니다."
						+ "<br>"
						+ "해당 인증번호를 인증번호 확인란에 기입하여 주세요.";
		try {
	        MimeMessage message = mailSender.createMimeMessage();
	        MimeMessageHelper helper = new MimeMessageHelper(message, true, "utf-8");
	        helper.setFrom(setFrom);
	        helper.setTo(toMail);
	        helper.setSubject(title);
	        helper.setText(content,true);
	        mailSender.send(message);
	        
	    }catch(Exception e) {
	        e.printStackTrace();
	    }
		
		String num = Integer.toString(checkNum);
		return num;

	}
}
