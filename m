From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Sat, 11 Jul 2015 15:41:22 +0900
Subject: [Cocci] [PATCH] coccinelle: api: extend spatch for dropping
	unnecessary owner
In-Reply-To: <alpine.DEB.2.10.1507100901030.2559@hadrien>
References: <1436503986-21487-1-git-send-email-k.kozlowski@samsung.com>
 <alpine.DEB.2.10.1507100901030.2559@hadrien>
Message-ID: <CAJKOXPfYnXwVpc90bQG+S1+R32mh652QpSzaf=4NF6xBmfrA0w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2015-07-10 22:01 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> Acked-by: Julia Lawall <Julia.Lawall@lip6.fr>
>
> As a semantic patch, it looks fine.  Have you sent any patches based on
> it?  I find hundreds of occurrences.

Yes, I sent patches fixing this for drivers I was able to compile
(allyesconfig on arm, arm64, i386, x86_64, ppc64). There were many of
them so I sent it only to specific maintainers, They are present on
patchwork e.g.:
https://patchwork.kernel.org/patch/6761401/
In Google: https://www.google.co.kr/webhp?sourceid=chrome-instant&ion=1&espv=2&ie=UTF-8#q=kozlowski+Drop+owner+assignment+from+i2c_driver+platform_driver

Best regards,
Krzysztof
