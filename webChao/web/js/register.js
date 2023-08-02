function checkb(regPassword, confirmPassword){
    const a = regPassword;
    const reg = /^[0-9]{6,16}$|^[a-zA-Z]{6,16}$/; //全是数字或全是字母 6-16个字符
    const reg1 = /^[A-Za-z0-9]{6,16}$/; //数字、26个英文字母 6-16个字符
    const reg2 = /^\w{6,16}$/;  // 由数字、26个英文字母或者下划线组成的字符串 6-16个字符
    if(a.length===0){
        return "密码不能为空";
    }
    else if (regPassword !== confirmPassword) {
        return "两次输入密码不一致";
    }
    else if(a.length<6){
        return "密码长度小于6个字符";
    }
    else if(a.length>16){
        return "密码过长";
    }
    else if(a.length>=6&&a.length<=16){
        if(a.match(reg)){
            return "密码强度弱";
        }
        else if(a.match(reg1)){
            return -1;
        }
        else if(a.match(reg2)){
            return -2;
        }
    }
    return 0;
}
function checka(regUserName){
    if(regUserName === "") {
        return "用户名不能为空";
    }
    return 0;
}
function checkUser(){
    const regUserName = document.getElementsByName("regUserName")[0].value;
    const info = checka(regUserName)
    if(info!==0){
        document.getElementById("info").innerHTML=info;
    }
}
function checkPwd(){
    const regPassword = document.getElementsByName("regPassword")[0].value;
    const confirmPassword = document.getElementsByName("confirmPassword")[0].value;
    const info = checkb(regPassword, confirmPassword)
    if(info!==0){
        document.getElementById("info").innerHTML=info;
    }
}
function is_ok(){
    const regUserName = document.getElementsByName("regUserName")[0].value;
    const regPassword = document.getElementsByName("regPassword")[0].value;
    const confirmPassword = document.getElementsByName("confirmPassword")[0].value;
    if(checka(regUserName) !== 0){
        return false;
    }
    if ((checkb(regPassword, confirmPassword) !== 0) && checkb(regPassword, confirmPassword) !== -1 && checkb(regPassword, confirmPassword) !== -2){
        return false;
    }
}
