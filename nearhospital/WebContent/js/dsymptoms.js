function ondisease()
{
	var disease=document.getElementById("disease").value;
	var target="dsymptoms.jsp";
	if(disease!="")
		{
		target+="?disease="+disease;
		}
	window.location.href=target;
}

function onsave(){
	var disease=document.getElementById("disease").value;
	if(disease=="")
		{
		alert("Select Disease");
		document.getElementById("disease").focus();
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
		alert("Select Symptoms");
		return false;
	}
}