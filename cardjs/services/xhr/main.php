<?php

    header("content-type: application/json; charset=utf-8");
    error_reporting(0);

    ///////////////////////////////////////////////////

    $host = "127.0.0.1";
    $port = "3306";
    $user = "root";
    $pass = "";
    $db = "cardjs";

    ////////////////////////////////////////////////////

    $baseUrl = $host.":".$port;
    $conn = new mysqli($baseUrl, $user, $pass, $db);
    $error = $conn->connect_error;
    $errno = $conn->connect_errno;

    if ($error == true) {
        $outp = array('code'=>$errno,"error"=>$error); // sin espesificar el codigo de error no solucionado
        $outp = json_encode($outp);
        echo utf8_encode($outp);
        die();
                
    } if ($error == false) {

        class dataProcess {
    		public function regEmployeed($obj) { // inicio de funcion de registro de empleados abreviado en ingles regEmployeed

                $employeed = $GLOBALS['conn']->query("
                    SELECT em.id_employeed
                    FROM employeed
                    AS em
                    WHERE em.country = '$obj->country'
                    AND em.identitycard = '$obj->identitycard'");
                $num_rows = $employeed->num_rows;

                if ($num_rows >= 1) { // si el numero de filas modificado es mayor o igual a uno

                    $outp = array('code'=>2, 'error'=>'duplicate values'); //asignado el cofigo 2 como error de duplicación
                    $outp = json_encode($outp);
                    echo utf8_encode($outp);

                } if ($num_rows === 0) { // si el numero de filas modificado es igual a cero

                    $photo = md5($obj->photo).'.png';

                    $stmt = $GLOBALS['conn']->prepare("
                        INSERT INTO
                            employeed (
                                photo,
                                name,
                                lastname,
                                country,
                                identitycard,
                                birthday,
                                gender,
                                blood_type,
                                rh_factor,
                                role,
                                homeaddress,
                                email,
                                phone,
                                mobile,
                                hiredday,
                                registered)
                        VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,CURRENT_TIMESTAMP)");
                    $stmt->bind_param("ssssssssssssiis",
                        $photo,
                        $obj->name,
                        $obj->lastname,
                        $obj->country,
                        $obj->identitycard,
                        $obj->birthday,
                        $obj->gender,
                        $obj->blood_type,
                        $obj->rh_factor,
                        $obj->role,
                        $obj->homeaddress,
                        $obj->email,
                        $obj->phone,
                        $obj->mobile,
                        $obj->hiredday);
                    $stmt->execute();
                    $GLOBALS['affected_rows'] = $stmt->affected_rows;
                    $GLOBALS['errno'] = $stmt->errno;
                    $GLOBALS['sqlstate'] = $stmt->sqlstate;
                    $GLOBALS['error'] = $stmt->error;
                    $stmt->close();

                    if ($GLOBALS['affected_rows'] === -1) { // si las filas afectadas son identicas a -1
                        $outp = array('code'=>$GLOBALS['errno'],'sqlstate'=>$GLOBALS['sqlstate'],'error'=>$GLOBALS['error']);
                        $outp = json_encode($outp);
                        echo utf8_encode($outp);
     
                    } if ($GLOBALS['affected_rows'] === 1) { // si las filas afectadas son identicas a 1
                        $outp = array('code'=>$GLOBALS['errno'],'sqlstate'=>$GLOBALS['sqlstate'],'error'=>$GLOBALS['error']);
                        $outp = json_encode($outp);
                        echo utf8_encode($outp);
                    }
                } 
            } // fin de registro de empleados
            public function synch($obj) {

                $employeed = $GLOBALS['conn']->query("
                    SELECT *
                    FROM employeed
                    AS em
                    ORDER BY em.lastname ASC
                    LIMIT $obj->init, $obj->end");
                # $num_rows_employeed = $employeed->num_rows;
                $employeed = $employeed->fetch_all(MYSQLI_ASSOC);

                $departament = $GLOBALS['conn']->query("
                    SELECT *
                    FROM departament
                    AS de
                    ORDER BY de.departament ASC");
                # $num_rows_departament = $departament->num_rows;
                $departament = $departament->fetch_all(MYSQLI_ASSOC);

                $role = $GLOBALS['conn']->query("
                    SELECT *
                    FROM role
                    AS ro
                    ORDER BY ro.role ASC");
                # $num_rows_role = $role->num_rows;
                $role = $role->fetch_all(MYSQLI_ASSOC);

                $outp = array('listEmployeed'=>$employeed, 'listDepartament'=>$departament, 'listRole'=>$role);
                $outp = json_encode($outp);
                echo utf8_encode($outp);
            } // fin de sincronizacion
        }
    }
?>