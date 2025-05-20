package com.spring.study;

import static org.junit.Assert.fail;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import lombok.extern.log4j.Log4j;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/root-context.xml",
									"file:src/main/webapp/WEB-INF/spring/appServlet/servlet-context.xml"})
@Log4j
public class MockMvcTest {
	
	@Autowired  //필드를 통해 주입하는 방식
	private WebApplicationContext ctx;
	
	private MockMvc mockMvc;
	
	@Before		//진행하기 이전- 사전에 처리해야 할 것  <=> @After
	public void setup() {
		this.mockMvc = MockMvcBuilders.webAppContextSetup(ctx).build();
	}
	
	
	@Test
	public void test() throws Exception{
		String resultPage = mockMvc
							.perform(MockMvcRequestBuilders.get("/sample/ex04")
									.param("name", "홍길동")
									.param("age", "20")
									.param("page", "8"))
							.andReturn().getModelAndView().getViewName();
	
	log.info(resultPage);
	}

}
