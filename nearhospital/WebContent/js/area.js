function isLogedin()
{
	var usr=document.getElementById("username").value;
	if(usr=="")
		{
		window.open("login.jsp");
		window.close();
		}
}
function onlogout()
{
	document.getElementById("username").value="";
}
function ondelete()
{
	return confirm("Are you sure... Want to delete?");
}
function onsave()
{
	var city=document.getElementById("City Name").value;
	var area=document.getElementById("Area Name").value;
	if(city=="")
		{
			alert("Select City Name");
			return false;
		}
	if(area=="")
		{
			alert("Enter Area Name");
			return false;
		}
	if(/^[a-z\s]+$/i.test(area))
	{
		return true;
	}
	else
	{
		alert("Area Name Should Be Alphabetic");
		document.getElementById("Area Name").focus();
		return false;
	}
	return true;
}

function onCity()
{
	var cid=document.getElementById("City Name").value;
	var target="area.jsp";
	if(cid!="")
		{
		target+="?cid="+cid;
		}
	window.location.href=target;
}