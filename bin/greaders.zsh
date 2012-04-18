#! /bin/zsh

# Determine number of GReader subscribers a blog feed has.

feed=${1?Must provide arg}
##feed='http://feeds.feedburner.com/Ruby5'
##feed='http://scottthornbury.wordpress.com/feed/'

#http://www.google.com/reader/api/0/stream/details?s=feed/http://scottthornbury.wordpress.com/feed/&tz=-420&fetchTrends=true&output=json&ck=1309112476768

#http://www.google.com/reader/api/0/stream/details?s=feed%2Fhttp%3A%2F%2Ffeeds.feedburner.com%2FRuby5&tz=-420&fetchTrends=true&output=json&ck=1309114122806&client=scroll

cookie='Cookie: GRLD=UNSET:03390784569922201891; PREF=ID=d4579fa8b6f50d36:U=7dd040438052788f:LD=en:NR=100:TM=1291171461:LM=1309112800:GM=1:GC=1:SG=2:S=vFAJs1WEMwHnYu39; NID=48=E5ciW0vK7GqleagsDD5ZSbs4lF1k1ehunRtldCwhW0ZdHPOzrbxipm-V_i6UwaZAk5MjXLFPy_W2sgWjn7ozVd-aiom-1vcXIDV9Maz4R_0Fp4G2d50CmlfTiHlU3g0w; SID=DQAAAOkAAAB4JXUIUTmBF8T-C9xCQfMeKdXeRkPyg0KTWPVDdMCtBoopXTJb5zMSliV49E0xHfPuunzPjDZpSSbsQtu_Ys86V_zAtgD5siBmSn6hQrYJNDE4ElF_oifQr8zJHMQetyuBAiG-QKqMn8e5RpAzSw1Sa4PQO4W9mPnu2wi_jlHOIxbHBMpivz_-r3kOUIGcDqw07fULamVt6DPMi7ubFfS5KX6V_0Ubo1kIeSNQbLdaE3KA98C3ItfVLbQ0im7Cw8CByaE0n5_8segVyCuq3A_FiQS6aacGod8dhDw7eiVUrFLYELK5xPpEceo-HZBxnUM; HSID=AUlAkifDjFIFdfUKQ; SS=DQAAAOEAAADYTi26UgRchdtcPEEwNnvcSFd1TENWBJSzyV7H19BnxdrLk8RuZzidX0iKvq2xKBZUrQP6S7XftE7YEMJvUzP6OMlU2gKz49ULzu3UmQZ3i86-_s6VTRQmCr1RiCGTQN4aJYHdmcpEItCsZizA_iKxzJBisKZ-Q1qBt9fa0gmGowgQucbuxa2JTFr6Pj-kEI48_RIrPYwZpb4h92EJjce2C_-1jcQXVGZHKXHv-0PBq0Ok1lkpYD706Wmb37Ee0i6zb8xozfwuzZ5DhTurwvXroYPvdR0d4FrpKJzxOly7EAB49jN0iO4J0KPiy0Zlv00; W6D=v4=0:ds=0:w=2:l=16:q=0; S=addurl=b3O3-aVKnfBwNu-DKA3SOw:googlebase=uVfEPYUhZ5TzeqohqeiaMw:feedburner-control-panel=lmksfearI8JHIx2QnNbjrg:static_files=ry0qzmITdf0:quotestreamer=mJlpK52Wx3PHk959l4KcLQ'


url="http://www.google.com/reader/api/0/stream/details?s=feed/${feed}&tz=-420&fetchTrends=true&output=json"
#url="$gurl$feed"

curl -H "$cookie" "$url" 2>/dev/null |jazor subscribers |sed -r 's/,//'
#curl -H "$cookie" "$url" |jazor
