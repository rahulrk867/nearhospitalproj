function isFilled()
{
	var username=document.getElementById("username").value;
	var password=document.getElementById("password").value;
	
	if(username=="")
		{
		alert("Enter Username");
		document.getElementById("username").focus();
		return false;
		}
	if(password=="")
		{
		alert("Enter Password");
		document.getElementById("password").focus();
		return false;
		}
	return true;
}