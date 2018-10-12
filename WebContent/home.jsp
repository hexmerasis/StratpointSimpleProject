<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Stratpoint Project</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script
	src="https://maxcdn.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>
</head>
<body>
</head>
<script type="text/javascript" src="core/js/prototype.js"></script>
<script>
	var contextPath = "${pageContext.request.contextPath}";
</script>
<body>
	<div id="tableContainer">
		<div class="row">
			<div class="col-6 col-md-3" style="background-color: #ccffff;"></div>
			<div class="col-6 col-md-6" style="background-color: #d9ffb3;">
				<div class="container">
					<div class="table-responsive">
						<hr>
						<h2>HOME</h2>
						<hr>
						<table id="profileTable" class="table table-hover table-striped">
							<tbody id="tblBody">
								<tr>
									<td><b>Name</b></td>
									<td><b>Age</b></td>
									<td><b>Active</b></td>
									<td><b>Blocked</b></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div>
			</div>
			<div class="col-6 col-md-3" style="background-color: #ccffff;"></div>
		</div>
	</div>
</body>
<script>	
/***** JSON.PARSE and INSERT*********
-Parse the data received from servlet to javascript object
-Loops the javascript object to its length a
-Insert the data from the javascript object to the table for viewing purposes
-Assign the javascript object (id) to the table row element "id"
*/
	var json = JSON.parse('${message}');
	for (var i = 0; i < json.length; i++) {
		var obj = json[i];
		var content = "<tr class=\"tableRow\" id =\""+obj.id +"\"><td>"
				+ obj.name.first + " " + obj.name.middle + ". " + obj.name.last
				+ "</td><td>" + obj.age + "</td><td>" + isChecked(obj.active)
				+ "</td><td>" + isChecked(obj.blocked) + "</td></tr>";
		$("tblBody").insert(content);
	}
	var userId = "";
/***** ROW OBSERVE with AJAX REQUEST*****
-Click any row and get it element by id 
-After clicking initiate a ajax request
-Pass the parameters to servlet
-updates the page to the profile with matched id 
*/
	$$(".tableRow").each(function(row) {
		row.observe("click", function() {
			userId = row.readAttribute("id");
			new Ajax.Request(contextPath + "/getProfile", {
				method : "GET",
				parameters : {
					action : "viewProfile",
					id : userId
				},
				onComplete : function(response) {
					$("tableContainer").update(response.responseText);
				}
			})
		})
	});
/******* CHECKBOX CHECKER**************
-check if the block and active javascript object is true or false
-return checked box to insert in the table if true and unchecked if false
*/
	function isChecked(condition) {
		if(condition){
			return '<input type="checkbox" disabled checked/>';
		} else {
			return '<input type="checkbox" disabled/>'
		}
	}
</script>
</html>