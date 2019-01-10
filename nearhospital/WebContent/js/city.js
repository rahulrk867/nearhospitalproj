function isLogedin()
{
	var usr=document.getElementById("username").value;
	if(usr=="")
		{
		window.location.href("login.jsp");
		}
}
function onlogout()
{
	var usr=document.getElementById("username").value;
	document.getElementById("username").value="";
}
function ondelete()
{
	return confirm("Are you sure... Want to delete?");
}
function onsave()
{
	var city=document.getElementById("City Name").value;
	if(city=="")
		{
			alert("Enter City Name");
			document.getElementById("City Name").focus();
			return false;
		}
	if(/^[a-z\s]+$/i.test(city))
		{
			return true;
		}
	else
		{
			alert("City Name Should Be Alphabetic");
			document.getElementById("City Name").focus();
			return false;
		}
	return true;
}
