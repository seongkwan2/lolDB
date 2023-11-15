package com.lol;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.client.RestTemplate;

@Configuration
public class AppConfig {
	//restTemplate을 이용해서 API와 응답을 하기위해 Bean등록
	@Bean
	public RestTemplate restTemplate() {
		return new RestTemplate();
	}
}
