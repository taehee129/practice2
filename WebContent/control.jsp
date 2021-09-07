<%@page import="java.awt.print.PageFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import ="java.util.ArrayList, model.member.*, model.product.*"  %>
<% request.setCharacterEncoding("UTF-8") ;%>    
<jsp:useBean id="memberVO" class="model.member.MemberVO"/>
<jsp:useBean id="memberDAO" class="model.member.MemberDAO"/>
<jsp:useBean id="productVO" class="model.product.ProductVO"/>
<jsp:useBean id="productDAO" class="model.product.ProductDAO"/>
<jsp:setProperty property="*" name="memberVO"/>    
<jsp:setProperty property="*" name="productVO"/>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	String action = request.getParameter("action");
	

	if(action.equals("main")){
		ArrayList<ProductVO> datas = productDAO.getDBList(new ProductVO());
		request.setAttribute("datas", datas);
		pageContext.forward("main.jsp");
	}
	else if(action.equals("login")){
		MemberVO member = memberDAO.getdata(memberVO);
		if (member != null){
			session.setAttribute("member", member);
			ArrayList<ProductVO> basket=  new ArrayList<ProductVO>();
			session.setAttribute("basket", basket);
			out.println("<script>alert('로그인에 성공하였습니다!');location.href='control.jsp?action=main'</script>");
		}else{
			out.println("<script>alert('로그인에 실패하였습니다!');history.go(-1)</script>");
		}
		
	}
	else if(action.equals("logout")) {
		session.invalidate();
		response.sendRedirect("control.jsp?action=main");
	}else if (action.equals("buy")){
		System.out.println(session.getAttribute("member"));
		if (session.getAttribute("member")==null){
			out.println("<script>alert('로그인 해야 이용할 수 있습니다!');history.go(-1)</script>");
		} else {
			
		ProductVO vo = productDAO.getDBData(productVO); //vo 는 db에 담긴 상품의 수량이 // procutvo 에는 사용자가 선택한 수량이 담겨있음
		if (vo.getStock()< productVO.getStock()){
			out.println("<script>alert('상품의 개수가 부족합니다!');history.go(-1)</script>");
		}
		System.out.println("control buy 처리 중 ");
		
		
		ArrayList<ProductVO> basket=(ArrayList<ProductVO>) session.getAttribute("basket");// 로그인할 때 바스켓 생김
		if(basket ==null){
			System.out.println("basket == null");
		}
		vo.setStock(productVO.getStock());
		basket.add(vo);
		
		out.println("<script>alert('해당 상품이 장바구니에 담겼습니다!');location.href='control.jsp?action=main'</script>");
			
		}
		
	}else if (action.equals("update")){
		ProductVO vo = productDAO.getDBData(productVO);//vo 는 db에 담긴 상품의 수량이 // procutvo 에는 사용자가 선택한 수량이 담겨있음
		if (vo.getStock()< productVO.getStock()){
			out.println("<script>alert('상품의 개수가 부족합니다!');history.go(-1)</script>");
		}
		System.out.println("control update 처리 중 ");
		ArrayList<ProductVO> basket=(ArrayList<ProductVO>) session.getAttribute("basket");
		for (int i=0; i<basket.size(); i++){
			if(productVO.getPnum()==basket.get(i).getPnum()){
				basket.get(i).setStock(productVO.getStock());
			}
		}
		out.println("<script>alert('수정이 완료되었습니다!');location.href='mypage.jsp'</script>");
	} else if(action.equals("delete")){
		ArrayList<ProductVO> basket = (ArrayList<ProductVO>)session.getAttribute("basket");
		for (int i=0;i<basket.size();i++){
			if (basket.get(i).getPnum()==productVO.getPnum()){
				basket.remove(i);
				
				
			}
			
		}
		out.println("<script>location.href='mypage.jsp'</script>");
	} else if(action.equals("add")){
		if(productDAO.addDBDate(productVO)){
			out.println("<script>alert('메뉴 추가에 성공했습니다!');location.href='control.jsp?action=manager'</script>");
			
		}else {
			
			out.println("<script>alert('메뉴 추가에 실패했습니다!');location.href='control.jsp?action=manager'</script>");
		}
		
		
		
		
	}else if (action.equals("manager")){
		ArrayList<ProductVO> datas = productDAO.getDBList(new ProductVO());
		request.setAttribute("datas", datas);
		pageContext.forward("manager.jsp");
		
	}else if (action.equals("mupdate")){
		
		if(productDAO.updateDate(productVO)){
			out.println("<script>alert('메뉴 변경에 성공했습니다!');location.href='control.jsp?action=manager'</script>");
		}else {
			
			out.println("<script>alert('메뉴 추가에 실패했습니다!');location.href='control.jsp?action=manager'</script>");
		}
		
		
	}else if (action.equals("mdelete")){
		
		if(productDAO.deleteDate(productVO)){
			out.println("<script>alert('메뉴 삭제에 성공했습니다!');location.href='control.jsp?action=manager'</script>");
		}else {
			
			out.println("<script>alert('메뉴 삭제에 실패했습니다!');location.href='control.jsp?action=manager'</script>");
		}
	}else if(action.equals("find")){
		ArrayList<ProductVO> datas = productDAO.getDBList(productVO);
		request.setAttribute("datas", datas);
		pageContext.forward("main.jsp");
		
	}else if (action.equals("pay")){
		ArrayList<ProductVO> basket = (ArrayList<ProductVO> )session.getAttribute("basket");
		int price= 0;
		for(ProductVO vo : basket){
			price += vo.getPrice()*vo.getStock();
			
			
		}
		
		request.setAttribute("price", Integer.toString(price));
		pageContext.forward("pay.jsp");
		
	}else if (action.equals("charge")){
		ArrayList<ProductVO> basket = (ArrayList<ProductVO> )session.getAttribute("basket");
		boolean flag=true;
		for(ProductVO vo : basket){
			
			if(!productDAO.minusStock(vo)){
				flag=false;
			}
			
			
			
		}
		if(!flag){
			out.println("<script>alert('결제에 실패했습니다!');location.href='control.jsp?action=pay'</script>");
		}
		basket.clear();
		out.println("<script>alert('결제에 성공했습니다!');location.href='control.jsp?action=main'</script>");
		
		
		
	
		
		
	}
		
			
			
		
		
		


%>

</body>
</html>