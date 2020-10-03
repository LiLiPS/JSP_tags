<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.util.*, java.sql.*, newPaquete.Empleado" %>

<%
	ArrayList<Empleado> datos = new ArrayList<>();
	

	try{
		Class.forName("com.mysql.cj.jdbc.Driver");
		Connection miConexion = DriverManager.getConnection("jdbc:mysql://localhost:3306/tags_jsp","root","");
		Statement miStatement = miConexion.createStatement();
		String instruccionSQL = "Select * from empleados";
		ResultSet rs = miStatement.executeQuery(instruccionSQL);
		
		while(rs.next()){
			datos.add(new Empleado(rs.getString(1), rs.getString(2), rs.getString(3), rs.getDouble(4)));
		}
		rs.close();
		miConexion.close();
		
	}catch(Exception e){
		out.println("Ha habido un error");
	}
	
	pageContext.setAttribute("losEmpleados", datos);

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Segundo y tercer ejemplo tags</title>
<style>
	.cabecera{
		font-weight:bold;
	}
</style>
</head>
<body>
	<table border=1>
	<tr class="cabecera">
	<td>Nombre</td>
	<td>Apellido</td>
	<td>Puesto</td>
	<td>Salario</td>
	</tr>
	<c:forEach var="EmpTemp" items="${losEmpleados}">
		<tr>
		<td>${EmpTemp.nombre}</td>
		<td>${EmpTemp.apellido}</td>
		<td>${EmpTemp.puesto}</td>
		<td>
			<c:if test="${EmpTemp.salario<40000}">
			${EmpTemp.salario+5000}
			</c:if>
			<c:if test="${EmpTemp.salario>=40000}">
			${EmpTemp.salario}
			</c:if>
		</td>
		</tr>
	</c:forEach>
	</table>
</body>
</html>