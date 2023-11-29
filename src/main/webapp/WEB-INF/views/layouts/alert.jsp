<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<%@ include file="../layouts/header.jsp" %>

<script>
	var message = "<c:out value='${message}'/>";
	var url = "<c:out value='${url}'/>";

	alert(message);
	
	setTimeout(function() {
		window.location.href = url;
	}, 100); // redirect 0.1s
</script>

<%@ include file="../layouts/footer.jsp" %>