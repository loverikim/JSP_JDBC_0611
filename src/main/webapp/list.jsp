<%@page import="java.util.*"%>
<%@page import="com.loverikim.dto.MemberDto"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 리스트</title>
</head>
<body>
	<h2>전체 회원 명단 보기</h2>
	<hr>
	<%
		String sql = "SELECT * FROM member_tbl";
		
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username = "root";
		String password = "12345";
		
		Connection conn = null; //연결 통로 역할, 빈 박스 상태 2.닫기
		Statement stmt = null; //sql 실행 1.닫고
		ResultSet rs = null; //select문 실행시 DB에서 반환되는 데이터를 받기위한 객체준비.
		
		try{
			Class.forName(driverName);//jdbc 드라이버 불러오기
			conn = DriverManager.getConnection(url, username, password);
			
			stmt = conn.createStatement();			
			
			// 중요!!!한 개념. 
			rs = stmt.executeQuery(sql);
			//DB에서 보내주는 SELECT문의 실행결과 데이터를 ResultSet 클래스로 만든 rs 객체로 받아줌
			
			List<MemberDto> members = new ArrayList<MemberDto>();
			
			while(rs.next()){ //가르키는 첫번째 레코드 rs 다음에 목록이 있는지 이동하여 불러옴.
				int mnum = rs.getInt("member_num"); 			
				//DTO를 사용 한 레코드를 저장할 수 있는 타입 만들기 -> MemberDto.java 
				String mname = rs.getString("member_name");
				String memail = rs.getString("member_email");
				String mdate = rs.getString("member_signuptime");
				
				//방법1) 생성자로 초기화시키기
				//MemberDto memberDto = new MemberDto(mnum, mname, memail, mdate);
				
				//방법2)
				MemberDto memberDto = new MemberDto();
				memberDto.setMember_num(mnum);
				memberDto.setMember_name(mname);
				memberDto.setMember_email(memail);
				memberDto.setMember_signuptime(mdate);
				
				members.add(memberDto);
			}
			
			for(int i=0;i<members.size();i++){
				out.println(members.get(i).getMember_num() + " . ");//회원의 번호
				out.println(members.get(i).getMember_name() + " / ");//회원의 이름
				out.println(members.get(i).getMember_email() + " / ");//회원의 이메일
				out.println(members.get(i).getMember_signuptime() + "<br>");//회원의 가입일				
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