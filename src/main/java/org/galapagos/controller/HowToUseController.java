package org.galapagos.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Controller
@Log4j
public class HowToUseController {
	
	
	
	private static final Logger logger = LoggerFactory.getLogger(HowToUseController.class);
	
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/howtouse", method = RequestMethod.GET)
	public String howtouse() {
		
	
		return "howtouse";
	}
	
	
}