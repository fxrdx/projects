var app = angular.module('identitycard', [])
.controller('identitycard', function($scope, $http) {
    
    $request = '../cardjs/services/xhr/request.php';
    $dirUpload = '../cardjs/services/xhr/upload_file.php';

    $functions = {
        "log":"login",
        "bug":"bugInside",
        "com":"comment",
        "mod":"modRegister",
        "reg":"regEmployeed",
        "syn":"synch"
    };

// datos por defecto de tabla de employeed
    $scope.default = {
        photo: '', // mediumblob
        name: '', // char(60)
        lastname: '', // char(60)
        country: 'V', // char(5)
        identitycard: '', // char(255)
        gender: '', // enum('m', 'f')
        birthday: '', // date
        blood_type: '', // enum('a', 'b', 'ab', 'o')
        rh_factor: '', // enum('+', '-')
        role: '', // int(11)
        homeaddress: '', // varchar(255)
        email: '', // char(60)
        phone: '', // int(11)
        mobile: '' // int(11)
    };
    
    $scope.reset = function(param) {
        $scope.employeed = angular.copy($scope.default);
        document.getElementById('divFileUpload').style.backgroundImage = "url(bg/avatar.jpg)";
    };

    /*$http.get("./js/scripts/errno.json").then(function(response) {
        $error = response.data.errno;
    });

    $http.get("./js/scripts/alerts.json").then(function(response) {
        $alert = response.data.alert;
    });*/

    $scope.upload = function() {
        formData = new FormData(document.getElementById("regEmployeed"));
        formData.append("dato", "valor");
        let config = {
            headers: {
                "Content-Type": undefined,
            }, transformRequest: angular.identity,
        };
        $http.post($dirUpload, formData, config).then(function(response) {
            xhr = response.data;
            if (xhr.code == 0)  {
                console.log('success'); // funcion fronted indicador de progreso
            } else {
                $scope.bug(xhr);
            }
        }, function(response) {
            alert('get method does not work, contact your network administrator');
        });
    };


    $scope.send = function(fn,param) {

        $http.get($request+"?fn="+JSON.stringify($functions[fn])+"&data="+JSON.stringify(param)).then(function(response) {
            xhr = response.data;
            if (xhr.code == 0)  {
                console.log('success'); // funcion fronted indicador de progreso
            } else {
                if (xhr.code == 1048 && xhr.code != 2) { // el codigo de error debe ser distinto de 1048 y 2
                    $scope.bug(xhr);
                    if (confirm("La informacion del error ya fue enviada a nuestro laboratorio, para ayudarnos a solucionar deja un comentario acerca del error")) {
                        $commentary = prompt("Bien ahora puedes decirnos tu opinion");
                        if ($commentary !== null) {
                            if ($commentary.toLowerCase() == "") {
                                alert("No comentaste, entendemos que no tienes tiempo, esperamos resolver tu inconveniente lo mas pronto posible");
                             } if ($commentary.toLowerCase() != "") {
                                $commentary = {
                                    "commentary": $commentary,
                                    "user": 'getCookie(user)',//se debe remplasar aqui por la cookie real
                                    "date": Date()
                                };
                                $scope.comment($commentary);
                            } 
                        } else { 
                            alert('tu opinion es importante nos ayuda a resolver los fallos con mas precision y en menos tiempo, agradecemos que te hayas detenido a leer estas ventanas');
                        }
                    } else {
                        alert("Ok, entendemos que no tienes tiempo para comentar, esperamos resolver tu inconveniente lo mas pronto posible");
                    }
                } else {
                    $scope.bug(xhr);
                }
            }
        }, function(response) {
            console.log('get method does not work, contact your network administrator');
        });
    };

    $scope.bug = function(obj) {
        console.log(JSON.stringify(obj))
    };

    $scope.comment = function(obj) {
        console.log(JSON.stringify(obj))
    };

    $scope.synch = function(fn,param) {
        $http.get($request+"?fn="+JSON.stringify($functions[fn])+"&data="+JSON.stringify(param)).then(function(response) {
            xhr = response.data;
            $scope.listEmployeed = xhr.listEmployeed;
            $scope.listDepartament = xhr.listDepartament;
            $scope.listRole = xhr.listRole;
            x = document.getElementById("text");
            x.value = '16';
        }, function(response) {
            console.log('get method does not work, contact your network administrator');
        });
    };

    $initial = {
        'init':'0',
        'end':'25'
    };

    $scope.synch("syn", $initial);
    
    /*function setCookie(cname, cvalue, exdays) {
        var d = new Date();
        d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
        var expires = "expires="+d.toUTCString();
        document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
    }

    function getCookie(cname) {
        var name = cname + "=";
        var ca = document.cookie.split(';');
        for(var i = 0; i < ca.length; i++) {
            var c = ca[i];
            while (c.charAt(0) == ' ') {
              c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        } return "";
    }

    function checkCookie() {
        var user = getCookie("username");
        if (user != "") {
            alert("Welcome again " + user);
        } else {
            user = prompt("Please enter your name:", "");
            if (user != "" && user != null) {
                setCookie("username", user, 365);
            }
        }
    }*/

});