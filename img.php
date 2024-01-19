<?php
if (isset($_GET['filename'])){
    $filename = preg_replace("~^/~","",$_GET['filename']);
    render_no_img($filename);
    $data = getimagesize($filename);
    resizeImg($filename, $data);
}

function render_no_img($fn){
    $mime = mime_content_type($fn);

    $arr = array(
        "application/pdf"=>"i/icon_pdf.png",
        "image/jpeg" => "",
        "image/gif"  => "",
        "image/png"  => "",
    );

    foreach ($arr as $k => $v){
        if ($k == $mime){
            if ($v == ""){
                return false;
            }
            header('Content-type: image/png');
            $image = imagecreatefrompng($v);
            imagepng($image);
            exit();
        }
    }
    header('Content-type: image/png');
    $image = imagecreatefrompng("i/icon_default.png");
    imagepng($image);
    exit();
}

function resizeImg($filename, $params = ""){
    if ($params == ""){
        $params = getimagesize($filename);
    }

    $width = $params[0];
    $height = $params[1];
    if (isset($_GET['width']) && isset($_GET['height'])){
        $newWidth = $_GET["width"];
        $newHeight = $_GET["height"];
    }elseif (isset($_GET['width']) && !isset($_GET['height'])){
        $newWidth = $_GET["width"];
        $newHeight = round($height * $_GET["width"] / $width);
    }elseif (!isset($_GET['width']) && isset($_GET['height'])){
        $newHeight = $_GET["height"];
        $newWidth = round($width * $_GET["height"] / $height);
    }elseif (isset($_GET['widthMax']) && isset($_GET['heightMax'])) {
        $newHeight = $_GET["heightMax"];
        $newWidth = round($width * $_GET["heightMax"] / $height);
        if ($newWidth > $_GET['widthMax']) {
            $newWidth = $_GET["widthMax"];
            $newHeight = round($height * $_GET["widthMax"] / $width);
        }
    }else{
        $newWidth = $width;
        $newHeight = $height;
    }


    $image_p = imagecreatetruecolor($newWidth, $newHeight);
    if ($params["mime"] == "image/jpeg"){
        $image = imagecreatefromjpeg($filename);
    }elseif ($params["mime"] == "image/png"){
        $image = imagecreatefrompng($filename);
        imageAlphaBlending($image, false);
        imageSaveAlpha($image, true);
    }elseif ($params["mime"] == "image/gif"){
        $image = imagecreatefromgif($filename);
    }
    if ($params["mime"] == "image/png"){
        addTransparency($image_p, $image);
    }
    imagecopyresampled($image_p, $image, 0, 0, 0, 0, $newWidth, $newHeight, $width, $height);

    header('Content-type: '.$params["mime"]);
    if ($params["mime"] == "image/jpeg"){
        imagejpeg($image_p, NULL, 85);
    }elseif ($params["mime"] == "image/png"){
        imagepng($image_p);
    }elseif ($params["mime"] == "image/gif"){
        imagegif($image_p);
    }
    return 1;
}

function addTransparency($dst, $src) {
    $t_index = imagecolortransparent($src);
    $t_color = array(
        'red' => 255,
        'green' => 255,
        'blue' => 255
    );
    if ($t_index >= 0) {
        $t_color = imagecolorsforindex($src, $t_index);
    }
    $t_index = imagecolorallocate(
        $dst,
        $t_color['red'],
        $t_color['green'],
        $t_color['blue']
    );
    imagefill($dst, 0, 0, $t_index);
    imagecolortransparent($dst, $t_index);
}