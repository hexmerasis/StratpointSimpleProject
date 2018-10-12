<div class="row">
	<div class="col-6 col-md-2" style="background-color: #ccffff;"></div>
	<div class="col-6 col-md-8" style="background-color: lavender;">
		<hr>
		<h1>Profile</h1>
		<hr>
		<h2 id="nameTag"></h2>
		<table class="table table-borderless">
			<tbody id="tblBody">
			</tbody>
		</table>
		<div align="center">
			<button type="button" class="btn btn-success btn-md" id="backToHome">Okay</button>
		</div>
	</div>
	<div class="col-6 col-md-2" style="background-color: #ccffff;"></div>
</div>
<script>
	//-Parse the data received from servlet to javascript object
	var json = JSON.parse('${message}');
	var id = '${id}';
	//-Loops the javascript object until the parameter id  from servlet has been matched 
	//-Insert the data with matched parameter to the display table
	for (var i = 0; i < json.length; i++) {
		var obj = json[i];
		if (obj.id.trim() == id.trim()) {
			var content = "<tr><td>"
					+ "<img src=\"" + obj.picture + "\" class=\"img-thumbnail\"width=\"100\" height=\"100\"></td>"
					+ "<td id =\"tableData\"><h1>"
					+ obj.name.first.trim()
					+ " "
					+ obj.name.middle.trim()
					+ ". "
					+ obj.name.last.trim()
					+ "</h1></td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>ID:</b></td><td>"
					+ obj.id.trim()
					+ "</td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>Profile:</b></td><td>"
					+ obj.profile.trim()
					+ "</td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>Email:</b></td><td>"
					+ obj.email.trim()
					+ "</td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>Phone:</b></td><td>"
					+ obj.phone.trim()
					+ "</td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>Address:</b></td><td>"
					+ obj.address.trim()
					+ "</td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>Age:</b></td><td>"
					+ obj.age
					+ "</td></tr>"
					+ "<tr><td style=\"text-align:right\"><b>Balance:</b></td><td>"
					+ obj.balance.trim() + "</td></tr>";
			$("tblBody").insert(content);
			break;
		}
	}
	/*-Reload the page to "HOME" after clicking the Okay button 
	 */
	$("backToHome").observe("click", function() {
		window.location.assign(contextPath);
	});
</script>

