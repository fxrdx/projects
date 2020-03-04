<?php
    header("content-type: application/json; charset=utf-8");
    error_reporting(0);
    if(!empty($_FILES['file']['name']) && ($_FILES['file']['size'] <= 8388608)){
        if(!empty($_FILES["file"]["type"])){
            $info = new SplFileInfo($_FILES['file']['name']);
            $fileName = md5($_FILES['file']['name']).'.'.$info->getExtension();
            if(($_FILES["file"]["type"] == "image/png")){
                $targetPath = $_SERVER['DOCUMENT_ROOT'].'/cardjs/uploads/'.basename($fileName);
                if(move_uploaded_file($_FILES['file']['tmp_name'], $targetPath)){
                    $outp = array('code'=>0,"error"=>'subido correctamente'); 
                    $outp = json_encode($outp);
                    echo utf8_encode($outp);
                } else {
                    $outp = array('code'=>1,"error"=>'ocurrio un error al subir'); 
                    $outp = json_encode($outp);
                    echo utf8_encode($outp);
                }
            } else {
                $outp = array('code'=>2,"error"=>'no se puede subir una imagen con ese formato'); 
                $outp = json_encode($outp);
                echo utf8_encode($outp);
            }
        } else {
            $outp = array('code'=>3,"error"=>'no es tipo de archivo valido'); 
            $outp = json_encode($outp);
            echo utf8_encode($outp);
        }
    } else {
        $outp = array('code'=>4,"error"=>'no se tomaron archivos'); 
        $outp = json_encode($outp);
        echo utf8_encode($outp);
    }
?>