<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴 성공여부</title>
</head>
<body>
		<%
		request.setCharacterEncoding("utf-8"); //파라미터 값 > utf-8로 인코딩(한글깨짐 방지)
		String mNum = request.getParameter("memberNum");//회원가입 시 입력한 회원번호 가져오기		
		
		// DB 연동하기
		String sql = "DELETE FROM member_tbl WHERE member_num='"+ mNum +"';";
		
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username = "root";
		String password = "12345";
		
		Connection conn = null; 
		Statement stmt = null; 
		
		try{
			Class.forName(driverName);//jdbc 드라이버 불러오기
			conn = DriverManager.getConnection(url, username, password);
			
			stmt = conn.createStatement();
			int success = stmt.executeUpdate(sql); //sql문 실행 > 1이 반환되면 sql문 실행 성공
			
			if(success == 1){ //참이면 sql문 성공적으로 실행
				out.println("회원탈퇴가 정상적으로 처리되었습니다.");
			} else{
				out.println("회원탈퇴가 완료되지 못했습니다.");
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
	
</body>
</html>