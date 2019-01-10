function isLogedin()
{
	var usr=document.getElementById("username").value;
	if(usr=="")
		{
		window.location.href("login.jsp");
		}
}
function ondelete()
{
	return confirm("Are you sure... Want to delete?");
}
function onsave()
{
	var name=document.getElementById("departmentName").value;
	if(name=="")
		{
			alert("Enter Department Name");
			return false;
		}
	if(/^[a-z\s]+$/i.test(name))
	{
		return true;
	}
else
	{
		alert("Department Name Should Be Alphabetic");
		document.getElementById("departmentName").focus();
		return false;
	}
	
	return true;
}