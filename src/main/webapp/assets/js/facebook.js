
    window.fbAsyncInit = function() {
    FB.init({
        appId      : 'YOUR_APP_ID',
        cookie     : true,
        xfbml      : true,
        version    : 'v19.0'
    });

    FB.AppEvents.logPageView();

};

    function checkLoginState() {
    FB.getLoginStatus(function(response) {
        if (response.status === 'connected') {
            FB.api('/me', {fields: 'id,name,email'}, function(userInfo) {
                // Send user info to server (servlet)
                document.getElementById("fbId").value = userInfo.id;
                document.getElementById("fbName").value = userInfo.name;
                document.getElementById("fbEmail").value = userInfo.email;
                document.getElementById("fbForm").submit();
            });
        }
    });
}
