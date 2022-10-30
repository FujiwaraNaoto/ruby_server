=begin
ハッシュ関数に関するテスト
=end

require "digest"

sha256=Digest::SHA256.new

password1=Digest::SHA256.digest("password")
p password1
p password1.to_s


password2=sha256.digest("password")
p password2


password3=sha256.hexdigest("wwww")
p password3