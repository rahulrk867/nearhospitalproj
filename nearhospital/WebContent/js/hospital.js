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
	var name=document.getElementById("Hospital Name").value;
	
	if(name=="")
		{
		alert("Enter Hospital Name");
		document.getElementById("Hospital Name").focus();
		return false;
		}
	if(/^[a-z\s]+$/i.test(name))
	{
		
	}
	else
	{
		alert("Hospital Name Should Be Alphabetic");
		document.getElementById("Hospital Name").focus();
		return false;
	}
	var address=document.getElementById("Address").value;
	if(address=="")
		{
		alert("Enter Address");
		document.getElementById("Address").focus();
		return false;
		}
	var city=document.getElementById("City").value;
	if(city=="")
		{
		alert("Select City");
		document.getElementById("City").focus();
		return false;
		}
	var area=document.getElementById("Area").value;
	if(area=="")
		{
		alert("Select Area");
		document.getElementById("Area").focus();
		return false;
		}
	var phone=document.getElementById("Phone").value;
	if(phone=="")
		{
		alert("Enter Phone No");
		document.getElementById("Phone").focus();
		return false;
		}
	if(phone.length!=10)
		{
		alert("Enter Valid Phone No");
		document.getElementById("Phone").focus();
		return false;
		}
	var count = document.getElementById("count").value;
	var chk;
	for(i=0;i<count;i++){
		chk = document.getElementById("chk_"+i).checked;
		break;
	}
	if(!chk){
		alert("Select department");
		return false;
	}
}

function oncity()
{
	var name=document.getElementById("Hospital Name").value;
	var address=document.getElementById("Address").value;
	var city=document.getElementById("City").value;
	var target="hospital.jsp?name="+name+"&add="+address;
	if(city!="")
		{
		target+="&city="+city;
		}
	window.location.href=target;
}

function onarea()
{
	var name=document.getElementById("Hospital Name").value;
	var address=document.getElementById("Address").value;
	var city=document.getElementById("City").value;
	var area=document.getElementById("Area").value;
	var target="hospital.jsp?name="+name+"&add="+address;
	if(city!="")
		{
		target+="&city="+city;
		if(area!="")
			{
			target+="&area="+area;
			}
		}
	window.location.href=target;
}