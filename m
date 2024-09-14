Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFAFEC021A0
	for <cocci@archiver.kernel.org>; Sat, 14 Sep 2024 14:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=otr/Fanph/ZBx2E0YWs7aAENovFVbw+paDqnBja9p6Q=;
  b=VjDoqFbE/D/g3+bPNnJAO09p2QDFkpyj6Zu2BQzQNXJgR0mhGE4ZnfZj
   3Et6bX7o2CEwAeqaTLX6VmlUsE5T+dtFhgsj8+s7j45HV0ZK4c6Y7i3Sx
   N4XGD3U9I8JRwJzDB19eGyQ6WqJkTv4KzPyluoxi2Bwrly94WamJHI2Zj
   s=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.10,229,1719871200"; 
   d="scan'208";a="183141433"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Sep 2024 16:41:39 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F1CDE0CCE; Sat, 14 Sep 2024 16:41:39 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A09ABE0131
	for <cocci@sympa.inria.fr>; Sat, 14 Sep 2024 16:41:31 +0200 (CEST)
IronPort-SDR: 66e5a09b_F7TDT+KGXVr6dztIYWINYu7ARZ5Mh6wbJTouXBRXZDFA7oW
 RTya63TE9wbCF3c6UILuhTwyuzWuExCqoG+QBsQ==
X-IPAS-Result: =?us-ascii?q?A0HbAADhn+Vm/wMP49RaHQEBAQEJARIBBQUBQIE7CAELA?=
 =?us-ascii?q?YJDB3ZaMwQLSAglhCmIHYcvgXUthD6YA4FWgUA+DwEDAQ07BgECBAEBAwEDg?=
 =?us-ascii?q?UlDgnQCd4kGAh4HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEB?=
 =?us-ascii?q?gECgQoIC4UvRg2CYwEQeRt0MAIBAQEBAQEBAQEBAQEBAQEBAQEXAg06RAIBA?=
 =?us-ascii?q?yMEGQEBESYBDwsaAiYCAlYHFAEBgn0Bgi8BAzEHDQavTH8zgQGCDAEBBoJn1?=
 =?us-ascii?q?3MfLCJXgWMDBoEaLgGISgGGIYQ6Jw+BVUSBPAuCeD6CYQSBXk2DDoJpjmyDI?=
 =?us-ascii?q?4cghE4liGdwj1RSexwDWSETAVUTFwsJBYk5CoMcKYFFJoQWCIErFYNfgWcJY?=
 =?us-ascii?q?YdnYoENgT6BWQFGgnJKg1WBeAU4SYJRa045Ag0CN4IpJW6CXIEvBAWDAR1AA?=
 =?us-ascii?q?gELbT01CQsbBj2rGoFZSIJyUQErlTAUkAOiZzQHgjeBY4FjDIomlSsGEy+XP?=
 =?us-ascii?q?g4GknOYdSKNWZsigWc9gVkzGiSDNlILDg+OIYN6M8YpQTUCATgCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGGQ4FLAQE?=
IronPort-PHdr: A9a23:PNRfYRLRj/Y/2EPF3dmcuDJsWUAX0o4c3iYr45Yqw4hDbr6kt8y7e
 hCEvbM03AeCAtWTwskHotSVmpijY1BI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDebRlEiCCgbb5xM
 Bm6ogfcu8oLioZ+N6g9zQfErXRPd+lK321kIk6dkQjh7cmq5p5j9CpQu/Ml98FeVKjxYro1Q
 79FAjk4Km45/MLkuwXNQguJ/XscT34ZkgFUDAjf7RH1RYn+vy3nvedgwiaaPMn2TbcpWTS+6
 qpgVRHlhDsbOzM/7WrakdJ7gr5Frx29phx/24/Ub5+TNPpiZaPWYNcWSXNcUspNSyBNB4WxZ
 JYNAeUcJ+ZVt4rzqVUBohSwGAeiBP3hxyFGhnD0waI03P8sER3f3AE6A94CrGrYodfzOawPU
 e611q7IzTDbYv1Rwzj98ovIcg06ofqRUrxwdcTRyVMuFwPDgVWbtIvoMTSP2eQXsGib8vFgW
 fighW4jpQFxuDmvxsEjioTSiIMa1EvL+T9kz4krPNC1TlNwbtG4HpVKrS6aK5d2Td04Q2Fuo
 Cs3170It5C7cSYEy5kqxB3SZvKbf4aH/h7uVfqcLzdkiH9rer+yhAq//0igx+D+SMW531hHo
 yVbn9TOtn0A1h/e586aQfVz+Ueh3CyA1wHV6uxcOk80kq3bK4Ilwr4xkJofq1jMHijzmEjwk
 aSYdV0k9/C25+j6fLnqvIGQO5F2hw3kL6gjmtazDOogPgUKUGWX4+qx2KD58UD6QLhGlPk7n
 6nfvZvHO8kborO5AxRJ0ok98RaxEjam0dUGknQfMF5Ifg+MgZLzNFHUOv/4CO+yg1Synzdvw
 PDLJrjhApLQLnjfirvgc6hy5FVGxAUu099T/5NUCrcfL/LvQkL9qsHUAgEjPwCq3erqCs9x2
 p4eVG6VDKKVKKbSvkWJ5uIrLemMfogVuDPlJvYi/fHul3w5mUIGfaWz0pUXbH64Hu5nI0Wfb
 nrhmdkAHnkRsQYkUePllkWOUThIaHmqRaIz+ik7CJ66DYfEXo2hnaSN3D2nEZ1OemBGFleMH
 G/0eIWDR/gDdCOSL9R6kj0EULihU5Uu2QuvtA/80bpnL/Db9jcWtZL5h5BJ4LjYkho59BR1C
 d6c2ieDVSU8nW4SQTIymaJ2p01hzU2Y+bZ3juYeFtFJ4f5NFAAgOs3y1et/XvX7QAHcZZ+kT
 Fi8Q9OpSWUUR8gy3sRITkJzAdSkgTjc0iDsD7JDxO/DP4A97q+Jhyu5HM160XuTkfB51zHOI
 +NKPGyi3Otk8hTLQpTOmAOfnrqrcqIV2GjM8n2CxCyAphIQSxZ+BIPCW31XfU7KtZLh/EqXa
 ra0Cqk8dCZFx9SDLKRiddDjy1lLF7/4INqLW2uqgC+rAAqQgLaFbY7kYWIYiQDUEksZiEY++
 XicNA4xLjisqSTSAW8mDkrhNmXr9+Q2s3anVgk0wgWNOlVmzKaw8wUJiOa0TvQOwvQbtS1np
 zgc8E+V+dXQBpLAogNgeP8ZetYh+BJd0mmfsQVhP5umJqQkh1gEcg0xsVm8nxNwQp5Nl8Qnt
 hZIhEJ7NL6Y3VVddjiZwYG4O7vZLXP39QyubKie00/X0dKf8KMCoPoirFCrsAasH0sku3Jpt
 rsdm16V/JbXF0w/VZzrU0A43wd3rffWb2h15o/Z02FtLbjhqiXLiJoiAOoozArlfs8KavreU
 lWoTItDWo71e4lI0xCzYxkJPf5f7vsxNsKiLb6d3bKzefxnl3SghHhG54Z01gSN8TB9Q6jGx
 cVgobnQ0w2ZWjP7lFrkvNrwnNUOQDgIHXekjwXgCpRQYKJaYosBT2ujaZ7SpJ02l9v2VnhU+
 UT2TXYPwsy0Yly/a1Ln3Atf/VsaqzqrlGHrql482yFspa2Z0ivUxu3kfxdSIW9HSl5pilL0K
 JS1hdQXNKSxRzAgjwDtpUPzxqwB4b96M3GWW0BDOS7/M2BlVKK08LuEec9Grp0y421bV+G1Y
 FbSTbCYwVNS9ir5HHZFgh0/eSurvJrRgBFwzm6QZHp+t3vWf8hsyAyXvoWGA6QLgXxfGW8jw
 TDMTkCxJdyo4cmZm/Kh+qilWmStW4cSOSjnwIWctTeqsGhjABmxhfe2yZXsFQk31zO+1sE/D
 3yS6kymPc+yiuLhYocFNgFyCVTx6tR3ANR7m4o03tQL3GQCw4+S9jwBmHvyNtNS3eT/amAMT
 HgF2Y2wgkCt1Ut9I3aO34+8WG+ax54rQtCgYX4NnA854dpLDqi887FO2yd46Andz0qZcb1mk
 zERxOF7olsTmeIUo0wAyiuHA7YdNVZVN2rgml7birL25LUSb2Gpf7+q0UN4lt30F7COrDZXX
 3Phc4sjFyt9vY1vdUjB23rp5sT4acHdOJgN4waMnU6K3I03YNoh0+AHji19NSfhsG05nqQl2
 Ad208jytdqCLHhxur20CFhUO3X8NcYU5y2onahZhNmfxYzpAZhrXDkGOfmgBfv6FTUPqbHtM
 BuIGzB6tXqRX7bSVQbN7UB7szfECJq2M3LRfXAfwYwkTx6YQS4XyAlGWTIngtsyDQut3tSnK
 U5/6mlX7Vn94g1FzuYiX/XmekHYogrgKjI9SZzFaQFT8hkH/UDed8qX8uN0GShcuJyntg2Eb
 GKBNUxOCikSV0qICkqGXPHm7MTc8+WeGuu1LuffKbSIp+tEUv6UxJWpmoJ49jeIP8+LMzFsF
 fo+kkZEWHl4HYzelVBtA2QPkDnRaseAuBqm0ihws9z57/nhHg7ipMOOB7ZULdRz6kW2jKOEZ
 IvyzG5yLTdV0I9JxGedkuFFmgRI1Gc3Kn/2QtFi/WbXQandm7FaFUseYiJ3bo5T6r4kmxNKM
 ojdg8/00bhxirg0DU1EXBrvgJLMB4RCLmejOVfAHEvOOq6BIGiB5sjtYr6nD5BUgv9VsRKYp
 juRVUPudGfm9XGhR1W0POdAgTvOdgRZo524ew1xBHLLSdX7dlukPdUxgTB8kthWzjvacGUbN
 zZ7aUZEqLaduDhZjvtIEGtE9nN5LOOAlk5xCsHHJ5xQvfY5WkyceMpF7X58x7YHtUmspdRwn
 zbO6MFjqReqn7vXogc=
IronPort-Data: A9a23:b60bDaJeFAvzo3/IFE+RxZQlxSXFcZb7ZxGr2PjKsXjdYENS3zVRy
 jFMW2DTP6uKZzSgft12O4jg9UwCuZWHm9ZgGwod+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgb9s9JIGjhMsf7b+Uoz5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuKFiw26xDCwINGZA8+Od9KDFgr
 /Y/EWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHuORjTNb9G9YasRmOP/EZ
 NcCLxdrYg7BZRJnJVodTp4z9AutriCvKGQE8Q7O/MLb5UDy9RJM4ebRauP8Of3JHoJTp3+Kp
 2/ZqjGR7hYycYb3JSC+2nmrjeTOtTjqXZobUry+7P9jxlOJrlH/EzUTUkan5+a0gAiyVrqzN
 nApx8bnloBqnGTDczU3d0TQTNOs53bwh/I4/ywGBACxJm785gGEGi4bQzQHZNFOWArag9A1/
 gfhoj8rLWUHXH6ppba16bqe6z+/UcTQBXFXfjcKFGPp/PG6yLzeTXvzohJLD6O/yNH4cd01L
 /ZmswBm74guYQU3O2lXMLwJb/9AZnQEc+Lt2jjqYw==
IronPort-HdrOrdr: A9a23:50YMnq+aO+Etkjga6Zpuk+AMI+orL9Y04lQ7vn2ZhyYlF/Bw5P
 re+8jzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNSftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIObOEYZmIbsS+V2njbL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AhjhtZ2nPmP1y6vd8KrMjKto03bXXOSb+kG+JDkj?=
 =?us-ascii?q?7MkJ0bL+UQ3bA1vlutPM7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AxStCVw9Lax3W1QEIfOurP3aQf+ZR/ZmfVnxXqLx?=
 =?us-ascii?q?FmorfcipJAiWcgSviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.10,229,1719871200"; 
   d="scan'208";a="183141431"
X-MGA-submission: =?us-ascii?q?MDFaf3XjK9Y6CxqYC9TcI/EIkH3B9x05oCXMsb?=
 =?us-ascii?q?HlZbkFkZTegyDW0YjddTC+qR0ub+uO055U6siwBP/sMb4956wprCpjZa?=
 =?us-ascii?q?1H7Zr88EMJs/v0meWDe3RcLeg1Fu7bkysQ9xKwW6xDkJWYH1anP6HWee?=
 =?us-ascii?q?WsjI6bkMLRvq2/AFvlqrcjyg=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2024 16:41:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1726324872; x=1726929672; i=markus.elfring@web.de;
	bh=otr/Fanph/ZBx2E0YWs7aAENovFVbw+paDqnBja9p6Q=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=B7v1HI+k9UL1LkX1EczHGObCNAvPsOaEoNlKe0xDTtRi5u4HilzgywIZ1QSOVPDH
	 +cMsNb096xHsj5C3k8cLFWK49vM0O1jYDM+HDRVUK9RpUOUXsYiMAWEUuPh4Fykjj
	 HUJSdNeFOp6qN1G4W+75FFZxQbt4kubTmNThg49uF81UXlHFjGuZ7kH0xpxoy0+4k
	 u1JJ0+XI2LgZAeUpKERajoRV4LPVMiEJGrmzxsROTKArO4qDL4SPYjkxvSJ8FXuL8
	 IFDxC6XXsuWSsXkUimw/fMRzYXismyEYLXT5K68UacKUUHzP3+SJ81VG2XhoTF0+y
	 mEQOHaY5ZqsXMdQ8Uw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MY5bV-1sUNHh0k3B-00JM7i; Sat, 14
 Sep 2024 16:41:12 +0200
Message-ID: <300b5d1a-ab88-4548-91d2-0792bc15e15e@web.de>
Date: Sat, 14 Sep 2024 16:40:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Heiko_St=C3=BCbner?=
 <heiko@sntech.de>, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Ulf Hansson <ulf.hansson@linaro.org>
References: <20240825183116.102953-1-krzysztof.kozlowski@linaro.org>
 <186de981-7a3c-4fdb-8911-8dfee597c759@web.de>
Content-Language: en-GB
In-Reply-To: <186de981-7a3c-4fdb-8911-8dfee597c759@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HoPsqyKslKdr1/wDHKIm21VHDAszlWtNHLl9bGyfP1+Hg9zGId1
 QqconPycwS+U7U7P6YZzvSULENsCcC6IMS9ZbFvtF43P7ylEFrrqy2UiTFTCAnG/t3xGJPv
 jIy3AbBYK2pS6S91iO8bYnbU/0eGUrfQo/ZpvQYGmEzGUGQloRigSHs+QjCycxpCFWRUubR
 ikpwux6/SRiUOLtTMeufQ==
UI-OutboundReport: notjunk:1;M01:P0:9t68vCu+5is=;nwxrIk6VB5MbEnzetXnqx5U2p6i
 9ype9tcoamIuXMwI8S0Y6oEVcN0fW7/1CgNjFw6ITdkNUTPSSGGPGKuTidxsqvlLMP4URI8oN
 1Y2XMwrRzSmun5ObFsURie8sv+m/4EDEBn8BQ9e3p9fqOKomDEL+D7y6HJTXMGq5bwxLoLEuc
 EDyrxabmDnrlPJGuKBDTQT6cL/HJfr8bE1XyJ1igFgXo03ZveIo1CgTLZKSXJHTP5LYGZJwFw
 oIeXR1GATrPL28gH828b7rl0nnPJ17+0rT6Y8iQfBR3Hl1etwslEGAYJieNKMGI0igP4tRjEE
 NhLyw7KzKvI0/z9nnuF1ZthvE6UV8/+Ub6TdoJmYK4nlJ+0oYgMwIz9kAsbok0+JTWVrMNKvI
 m2Lh12PId+3YPWPoaFnhfVExQxWDkaB4lfTi3Lk8izykTyxNVd/d9E4LKdCkivkIhXO0G4dbD
 zehFF/QkLEIlWdU4FDKhsZqxgW2q5O6dVjARZvdy0eDo5LC7cQt/zDKS4Tbp4O62px+CA4gK1
 e8D6msSQVrDNXHOMm7GK+VM4Ic+z60IhKCc73MZnvHMOIso/6fUVVha5u83gxqY5Hex4UzjdC
 HPGoxYx1kaiRazKT/VE8KHYAo6NGtntnYgnurf3XFDghNUCUnwu4FtuuIMO/M7fWXGCoDjm5y
 i2LZPT5xJWQ55LMbig2B2z4PwkCPYy+kc2XbQC0kXyzWzsPme2QcYSswg4f0ibN1/15uK9TEJ
 4Rzj12o2qsc/gCriD2MjmMuX5l3W0KjpiPoZyGUEt20psLLvFFzC55YPXncbZzt/zFE0m8BND
 KE2QnWaKpHHdjiNTdCQBd7Rw==
Subject: Re: [cocci] Generalising a transformation with SmPL?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1869
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-09/300b5d1a-ab88-4548-91d2-0792bc15e15e%40web.de>

=E2=80=A6
> I found it easy to convert it also into the following small script varia=
nt
> for the semantic patch language (Coccinelle software).
>
>
> @adjustment@
> expression e, x;
> @@
> +of_node_put(e);
>  if (...)
>  {
>  <+... when !=3D e =3D x
> -   of_node_put(e);
>  ...+>
>  }
> -of_node_put(e);
>
>
> 58 patches were accordingly generated for source files of the software =
=E2=80=9CLinux next-20240913=E2=80=9D.
=E2=80=A6

This SmPL script references a known function name.
https://elixir.bootlin.com/linux/v6.11-rc7/source/drivers/of/dynamic.c#L43

I imagine that it can become helpful to avoid duplicate function calls
also in combination with other functions.
But there are development challenges to consider for functions like mutex_=
unlock()
which get addresses passed for data structure members.
Thus I hoped that something can be achieved with the following script vari=
ant.


@extended_adjustment@
expression e, f, x, y;
@@
+f(e);
 if (...)
 {
 <+... when !=3D \( e =3D x \| y(..., &e, ...) \)
(   f(&e);
|
-   f(e);
)
 ...+>
 }
(f(&e);
|
-f(e);
)


But the software combination =E2=80=9CCoccinelle 1.2-00038-g2297fc0f=E2=80=
=9D points details out
for further development considerations.

Markus_Elfring@Sonne:=E2=80=A6/Projekte/Linux/next-analyses> spatch driver=
s/pmdomain/rockchip/pm-domains.c =E2=80=A6/Projekte/Coccinelle/janitor/avo=
id_duplicate_function_call.cocci
=E2=80=A6
previous modification:

  <<< f(e);
CONTEXT

According to environment 2:
   extended_adjustment.e -> pmu->mutex

   extended_adjustment.f -> mutex_unlock


current modification:

  <<< f(e);
CONTEXT

According to environment 2:
   extended_adjustment.e -> &pmu->mutex

   extended_adjustment.f -> mutex_unlock


exn while in timeout_function
extended_adjustment: already tagged token:
C code context
File "drivers/pmdomain/rockchip/pm-domains.c", line 538, column 1, charpos=
 =3D 14292
  around =3D 'if',
  whole content =3D       if (rockchip_pmu_domain_is_on(pd) !=3D power_on)=
 {



How can such a software situation be improved?

Regards,
Markus
