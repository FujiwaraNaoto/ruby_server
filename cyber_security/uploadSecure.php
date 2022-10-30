<?php
 define('UPLOADPATH', '/var/imgCyber');
 
 function get_upload_file_name($tofile){
  //拡張子のcheck
  $info = pathinfo($tofile);
  $ext = strtolower($info['extension']);
  if($ext != 'gif' && $ext != 'jpg' && $ext != 'png'){
   die('filename extension must be jpg, gif or png');
  }
  $count=0;//ファイル名再生試行の回数
  do{
    $file = sprintf('%s/%08x.%s',UPLOADPATH,mt_rand(),$ext);
    $fp = @fopen($file,'x'); 

  }while($fp==FALSE && ++$count<10);
  if($fp == FALSE){
   die("failed to create file");
  }
  fclose($fp);
  return $file;
 }

 $tmpfile = $_FILES['imgfile']['tmp_name'];//一時ファイル名
 $orgfile = $_FILES['imgfile']['name'];//元ファイル名

 if(!is_uploaded_file($tmpfile)){
  die('No file is uploaded');
 }
 $tofile = get_upload_file_name($orgfile);

 if(!move_uploaded_file($tmpfile, $tofile)){//画像を移動
  die('cannot upload file');
 }
 $imgurl = 'download.php?file='.basename($tofile);
?>
 <head>
 <link rel = "stylesheet" type="text/css" href="styleUpload.css"/>
 </head>
 <div class="content">
 <body>
 <h2>Uploaded File</h2>
 <p><a href="<?php echo htmlspecialchars($imgurl); ?>">
 <?php echo htmlspecialchars($orgfile, ENT_NOQUOTES,'URF-8'); ?></a>
</p>
 <p>
 <div class="imageContent"><img src="<?php echo htmlspecialchars($imgurl); ?>"></div> 
 </p>
  <p><a href="../cyber">go back to the previous page</a></p>
 </body>
</div>
