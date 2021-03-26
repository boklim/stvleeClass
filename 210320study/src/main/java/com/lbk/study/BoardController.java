package com.lbk.study;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.lbk.study.dto.BoardDto;

@Controller
@RequestMapping(value="/board/*")
public class BoardController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private SqlSession sqlsession;
	
	@RequestMapping(value="/boardList", method=RequestMethod.GET) 
	public String boardListController(Model model) {
		logger.info("boardListController >>>>> ");
		
		List<BoardDto> list = sqlsession.selectList("board.selectBoardList");
		logger.info("boardListController list >>>>> ", list);
		
		model.addAttribute("list", list);
		
		return "board/boardList";
	}
	
	@RequestMapping(value="/writeBoard") 
	public String writeBoardController() {
		logger.info("writeBoardController >>>>> ");
		
		return "board/writeBoardList";
	}
	
	@ResponseBody
	@RequestMapping(value="/registBoard", method=RequestMethod.POST) 
	public Map<String, Object> registBoardController(@RequestParam Map<String, Object> param, BoardDto boardDto, HttpServletRequest req) {
		logger.info("registBoardController >>>>> param" + param);
		
		HttpSession session = req.getSession();
		Map<String, Object> map = new HashMap<String, Object>();
		/* !!! 
		 * 0. 어느 테이블에? - 현재 쿼리 비어있어서 오류
		 * 1. writer 값 뭘로 하나
		 * 2. createTime 형식
		 * 3. sessionId 어떻게 불러오나
		 * 4. date 값은 쿼리에서 now()로 넣어주누다.
		 * 
		 * 4.selectBoardList
		 * */
		boardDto.setWriter((String) session.getAttribute("loginSession"));
		boardDto.setSessionId(session.getId());
		
		boardDto.setTitle((String) param.get("title"));
		boardDto.setContents((String) param.get("content"));
		
		logger.info("registBoardController >>>>> boardDto" + boardDto);
		sqlsession.insert("board.insertBoardList", boardDto);
		
		map.put("result", "ok");
		
		return map;
	}
	
	
}
