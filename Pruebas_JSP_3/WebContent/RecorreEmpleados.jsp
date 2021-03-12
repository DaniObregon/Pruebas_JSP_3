<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
 <%@ page import="java.util.*, java.sql.*, com.pildorasinformaticas.jsptags.Empleado" %>
 
 <%
 
 	ArrayList<Empleado> datos = new ArrayList<>();
 	
 	try{
 		
 		Class.forName("com.mysql.jdbc.Driver");
 		
 		Connection conexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/proyecto_jsp", "root", "");
 		
 		Statement miStatement = conexion.createStatement();
 		
 		String sql = "SELECT * FROM empleados";
 		
 		ResultSet rs = miStatement.executeQuery(sql);
 		
 		while(rs.next()){
 			
 			datos.add(new Empleado(rs.getString(1), rs.getString(2), rs.getString(3), rs.getDouble(4), rs.getDouble(5), rs.getDouble(6)));
 			
 		}
 		
 		rs.close();
 		conexion.close();
 		
 	}catch(Exception e){
 		out.println("Error en conexión con base de datos wachiiinnn  -  " + e.toString());
 	}
 	
 	
 	pageContext.setAttribute("losEmpleados", datos);
 
 %>
 
    
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>

<style>
	.cabecera{
		font-weight: bold;
	}

</style>

</head>
<body>
	<table border="1" >
	
		<tr class="cabecera">
			<th>Nombre</th>
			<th>Apellido</th>
			<th>Puesto</th>
			<th>Salario</th>
			<th>Bonus</th>
			<th>Total</th>
			
		</tr>
		
		<c:forEach var="EmpTemp" items="${losEmpleados}">
		
			<tr>
				<td>${EmpTemp.nombre}</td>
				<td>${EmpTemp.apellido}</td>
				<td>${EmpTemp.puesto}</td>
				<td>${EmpTemp.salario}</td>
				<td><c:if test="${EmpTemp.salario < 40000}">${EmpTemp.bonus = 5000}</c:if>
					<c:if test="${EmpTemp.salario >= 40000}">${0}</c:if>
				</td>
				<td>${EmpTemp.total + EmpTemp.salario + EmpTemp.bonus} </td>
				<br>
			</tr>
		
		</c:forEach>
	
	</table>

</body>
</html>