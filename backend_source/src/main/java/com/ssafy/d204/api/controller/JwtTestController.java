package com.ssafy.d204.api.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.d204.api.service.UserService;

import io.swagger.annotations.ApiOperation;

@RestController
@CrossOrigin("*")
@RequestMapping("/api/jwt")
public class JwtTestController extends SuperController{
	@Autowired
	UserService uSvc;
	
	@PostMapping(value="/secret")
	@ApiOperation(value = "jwtInterceptor Test")
	public ResponseEntity<?> getSecret() throws Exception{
		return new ResponseEntity<String>("this is secret!", HttpStatus.OK);
	}
}
