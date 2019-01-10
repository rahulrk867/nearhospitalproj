function isLogedin()
{
	var usr=document.getElementById("username").value;
	if(usr=="")
		{
		window.location.href="login.jsp";
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
	var dept=document.getElementById("Department Name").value;
	var service=document.getElementById("Service Name").value;
	if(dept=="")
		{
			alert("Select Department Name");
			return false;
		}
	if(service=="")
		{
			alert("Enter Service Name");
			return false;
		}
	return true;
}

function onDept()
{
	var deptid=document.getElementById("Department Name").value;
	var target="service.jsp";
	if(deptid!="")
		{
		target+="?deptid="+deptid;
		}
	window.location.href=target;
}