<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입확인</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8"); //파라미터 값 > utf-8로 인코딩(한글깨짐 방지)
		String mName = request.getParameter("memberName");//회원가입 시 입력한 회원이름 가져오기
		String mEmail = request.getParameter("memberEmail");//회원가입 시 입력한 회원 이메일 가져오기
		
		// DB 연동하기
		String sql = "INSERT INTO member_tbl(member_name, member_email) VALUES('"+mName+"','"+mEmail+"')";	//문자열로 인식되기 때문에 실행시켜봐야 알 수 있음. 
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username = "root";
		String password = "12345";
		
		Connection conn = null; //연결 통로 역할, 빈 박스 상태 2.닫기
		Statement stmt = null; //sql 실행 1.닫고
		
		try{
			Class.forName(driverName);//jdbc 드라이버 불러오기
			conn = DriverManager.getConnection(url, username, password);
			
			stmt = conn.createStatement();
			int success = stmt.executeUpdate(sql); //sql문 실행 > 1이 반환되면 sql문 실행 성공
			
			if(success == 1){ //참이면 sql문 성공적으로 실행
				out.println(mName +"님 회원 가입을 축하드립니다!");
			} else{
				out.println("회원 가입 실패! 다시 확인해주세요.");
			}
							
		} catch(Exception e){
			out.println("DB연동 에러 발생!!");
			e.printStackTrace(); //에러발생 시 에러내용 출력
		} finally{ //메모리에 남아있지 않게 하기 위해 사용하고 난 뒤 없애기 위해
			try{				
				if(stmt != null){ //null값이 아닐 경우만.
					stmt.close();
				}
				if(conn != null){
					conn.close();
				}		
			} catch(Exception e){
				e.printStackTrace();
			}			
		}	
	%>
	
	<hr>
	<a href="list.jsp">회원 리스트 보기</a>
	
	
</body>
</html>