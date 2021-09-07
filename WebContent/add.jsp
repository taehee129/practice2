<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<form method="post" action="control.jsp?action=add">
<table>
	<tr>
		<td>상품 이름 </td>
		<td><input type="text" name="pname"> </td>
	
	</tr>
	
	<tr>
		<td>가격</td>
		<td><input type="number" name="price"> </td>
	
	</tr>
	<tr>
		<td>수량</td>
		<td><input type="number" name="stock"> </td>
	
	</tr>
	<tr>
		<td>소개글</td>
		
	
	</tr>
	<tr>
		<td colspan="2"><input type="text" name="account"></td>
	
	</tr>
	<tr>
		<td><input type="submit" value="추가하기"></td>
	</tr>

</table>
</form>
</body>
</html>