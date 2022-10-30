<?php
 $tmpfile = $_FILES['imgfile']['tmp_name'];//一時ファイル名
 $tofile = $_FILES['imgfile']['name'];//元ファイル名
 
 if(!is_uploaded_file($tmpfile)){
  die('No file is uploaded');
 }else if(!move_uploaded_file($tmpfile,'img/'.$tofile)){//画像を移動
  die('cannot upload file');
 }
 $imgurl = 'img/'.urlencode($tofile);
?>
 <head>
  <link rel = "stylesheet" type="text/css" href="styleUpload.css"/>
 </head>
 <div class="content">
  <body>
  <h2>Uploaded file</h2>
  <p>
  <a href="<?php echo htmlspecialchars($imgurl); ?>"><?php echo htmlspecialchars($tofile, ENT_NOQUOTES,'URF-8'); ?></a>
  </p>
  <p>
  <div class="imageContent"><img src="<?php echo htmlspecialchars($imgurl); ?>"></div>
  </p>
  <p><a href="../cyber">go back to the previous page</a></p>
  </body>
 </div>
