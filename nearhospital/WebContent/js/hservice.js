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
	
	var city=document.getElementById("City").value;
	if(city=="")
	{
	alert("Select City");
	document.getElementById("City").focus();
	return false;
	}
	var Hospital=document.getElementById("Hospital").value;
	if(Hospital=="")
	{
	alert("Select Hospital");
	document.getElementById("Hospital").focus();
	return false;
	}
	var department=document.getElementById("Department").value;
	if(department=="")
		{
		alert("Select Department Name");
		document.getElementById("Department").focus();
		return false;
		}
	var count = document.getElementById("count").value;
	var chk;
	for(i=0;i<count;i++){
		chk = document.getElementById("chk_"+i).checked;
		if(chk)
		break;
	}
	if(!chk){
		alert("Select Service");
		return false;
	}
}

function oncity()
{
	var city=document.getElementById("City").value;
	var target="hservice.jsp";
	if(city!="")
		{
		target+="?city="+city;
		}
	window.location.href=target;
}

function onhospital()
{
	var city=document.getElementById("City").value;
	var hospital=document.getElementById("Hospital").value;
	var target="hservice.jsp?city="+city;
	if(hospital!="")
		{
		target+="&hospital="+hospital;
		}
	window.location.href=target;
}
function ondepart()
{
	var city=document.getElementById("City").value;
	var hospital=document.getElementById("Hospital").value;
	var department=document.getElementById("Department").value;
	var target="hservice.jsp?city="+city+"&hospital="+hospital;
	if(department!="")
		{
		target+="&dept="+department;
		}
	window.location.href=target;
}