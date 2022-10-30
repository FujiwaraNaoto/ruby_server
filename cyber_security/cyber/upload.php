<?php
$tmpfile=$_FILES['imgfile']['tmp_name'];
$tofile=$_FILES['imgfile']['name'];
//$storeDir = '/var/www/html/cyber/img/';
$storeDir = 'img/';

if(!is_uploaded_file($tmpfile)){
 die('No file uploaded');
}else if(!move_uploaded_file($tmpfile, $storeDir.$tofile)){//move image file
 die('failed to upload');
}
//$imgurl = '/var/www/cyber/img/'.urlencode($tofile);

$imgurl=$storeDir.urlencode($tofile);

?>
<body>
You uploaded
<a href="<?php echo htmlspecialchars($imgurl); ?>"><?php echo htmlspecialchars($tofile, ENT_NOQUOTES,'UTF-8');?></a>
<img src="<?php echo htmlspecialchars($imgurl); ?>">
</body>

<p><a href='/cyber/upload.html'>go back to login page</a></p>
