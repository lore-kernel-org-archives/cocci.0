Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E669C25B0E
	for <cocci@archiver.kernel.org>; Tue, 16 Aug 2022 17:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=CFQx2wKK4xdqusKumNV6wkS9jFRxcaRUJQ7TuhQrqnM=;
  b=fl15zYGKLPPO6nJp7lDSAEwCAig8MtfPSN9V0X/dPmn974YemrLUWmE+
   LWM2v/H4NcGsM8nYMy3LwgfrZoUfR6IW/WjEdMD+2qsfeB1owWVxnTZt2
   l17TvGAcQHaAUrZcyohXukwnpCZsq/jzSUDyKqEYJGlx1HQEoTKhBl2K1
   c=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.93,241,1654552800"; 
   d="scan'208";a="48936841"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Aug 2022 19:55:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DB070E0382; Tue, 16 Aug 2022 19:55:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 47A93E0380
	for <cocci@sympa.inria.fr>; Tue, 16 Aug 2022 19:55:27 +0200 (CEST)
IronPort-SDR: euji/RNeTOnTzuJslzjPVGxAy4woVpRZjMJoLSfRuEqFs3O0ehwbBC3nhsi1+4e5zzJXLJDJNR
 gFGeCjwbX7SXPZ1kw+QxuxJ9viS9SwXCTCB2NWsiumFbtpAPd4T2ZYwonSY5RUKLVTQFnTyGp+
 wAlBknWai63e0O+M7SZc+0MI6DrRMOLenH0flwnIjyId8RcIjcALUCXhJG32VYtiSCH+MM9I/U
 qXQildDK0omAi05QsrrdBGJBbkr5eiefI0fh24eUhVbf6ay4BP+hDMpLDBwRVdd+LEpE3ewYjh
 f0Suz58T4bcfVgKEEZnwT4OJ
X-IPAS-Result: =?us-ascii?q?A0DRAgAh2ftihwMP49RaHQEBAQEJARIBBQUBQIFPgiSBW?=
 =?us-ascii?q?C4EC0WETo5ngXcxhCWHD4cejCYLAQMBDT8BAgQBAYITgnQChHkCHQcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOEAU2B?=
 =?us-ascii?q?l4GZASBSwSBdAs0DYI1IoNsAQICASMdAQERJwQLCw4MAiYCAlcGAQwIAQGCe?=
 =?us-ascii?q?YJtAQMNJQeodIExgQGCCAEBBoROHywiUoFcCYERLIslhCInEIFVRIE8gwM+h?=
 =?us-ascii?q?ESDVoJlmTQmBA4DGiseQgIBC1IICRcSEBACBBEaCwYDFj4JAgQOA0AIDQMRB?=
 =?us-ascii?q?AMPGAkSCBAEBgMxDCULAwUPDAEGAwYFAwEDGwMUAwUkBwMZDyMNDQQYBx0DA?=
 =?us-ascii?q?wUlAwICGwcCAgMCBhUGAgJOOQgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEB?=
 =?us-ascii?q?AQEFQIQCAIIJxcHExgbGQEFMicQCSEcCgQaCgYFBhMDIG0FCjsPKDM1PCsfG?=
 =?us-ascii?q?wqBEiopFQMEBAMCBhMDAyICEC4xAxUGKRMSLQcrdQkCAyJpBQMDBCosAwkfH?=
 =?us-ascii?q?wcJIiY9BQVfOgEEAwQVIiQCnhRYkhauWjQHghaBP4FEDJ48BhMull0OBpF6l?=
 =?us-ascii?q?wIgpzmBeIF+MxokT4JnTgECAQINAQICAwECAQIJAQECjh0MDQmEA4otPzQ7A?=
 =?us-ascii?q?gYBCgEBAwmFRwEBhT4BAQ?=
IronPort-PHdr: A9a23:2mo+dRPJxXJWI4kTfNkl6nZrBxdPi9zP1u491JMrhvp0f7i5+Ny6Z
 QqDv64r1gKVFtyCtLptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys9ZDfeRtEiTqybL99M
 Rm6sAfcvdQKjIV/Lao81gHHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2Q
 rJeDDQ9LmA6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD+/6
 apgVR3mhzodNzMh82/ZhMN/g6xGrhy/qRxxw4zbb52aOvdlYqPdZMkXSXZdUstfVSFMBJ63Y
 YsVD+oGOOZVt47zqEEUrRu9GAmsH/7kxDBMhn/4x6060uIhEQ7b1wEnGNwBqm7UrNboNKcJS
 +y7w63IzTvZb/NX3zf955PFcx4/rv6XR75/bNTexFApGgjYgVqetZbrMCmJ1uQRrWeb9exgW
 PqghmM6pAx8oTqiytoyh4fGmI8Yyk7J+CtnzIs7JNC0VE12bNC5HJdMqSyUOIt7Tt4mTmxqp
 Cs0yqAKtJ61cSUEzpks2h3Ra+SffoSW/x7vSvydLSlmiH9nYr6zmha//VKux+HkUsS53kxGo
 jdLn9TMrHwByh3e58edRvZ+40us3yuE2RrJ5eFeO080kLLWK54/zb40kZoeqUHDHijrmEXql
 qOXeFsr9fOy5+v6fLrqvp6cN4lqhQHiKqkihNGzDfoiPgQQQWSW+/6w2KDj8EHjTrhGlvg2n
 bPYsJDeK8QbvKm5AwpN34gk8Rm/FTSm0MkDnXUdI1xFfByHj5LoO1HIL/D1Fvm+jEq3nztx2
 v/JIKXtApPWIXfbirfuYa5961JAyAo01d1T+opYCqsdL/LrRk/xqNvYAwclPAyz3+noFNR92
 5gFWWOPB6+ZKLndvUWJ5uIpOemMZZUatCzzK/g/tLbSiiobkFwad+GK2oAcaH28VqBkIEHJO
 yKqjdYdOWgPtws6CuftjQvGGTVUbH2zd6M6/DAyToy8XqnZQYX4pbWb3zqgVrBSaHpHDF/ER
 VLhbYaZQLEhbCyII8luuiMJX/6tRtlyhlmVqAbmxu8/faLv8SoCuMe7vDAUz+jalBVpsCdxE
 9zYyGaVCWd9gmIPQTYymqF5u010jFmZguBjm/INM9tV6rtSVxsic4bGxrlfAsrxRxmHU9OHU
 legTf25DDt3Qt9ii8QWbRNFEs65xgvGwzLsBrYUk7KRA5lh16vG3GXqYet5xWzH0qYJkFQsB
 MdCZiW9nqAq0Q/VCsbSllmB0aancaNJxCnW6GKK1naDpmldVxNsF7rIVzYTayM6tPzf4UXPB
 /+rALUjaU5azNKab7BNcpvvhElHQ/HqPJLfZXiwkiG+H0TAwLTEd4fsd2gHuUeVQEEZjwAe+
 2qHPgkiF2+gpWzZFjlnCVPoZQvl7+B/rHqxSkJ8wRuNagVt0L+8+xhdgvL5Kbtb+7seuzo67
 RhwEky82d3+FNeK4QZsPe1dbd47/FZbxDfBrQUudpekLq1kmhsfa1Et5hmojU8oTNwd15N5y
 RFihBB/Iq+Zzl5bIjaR3JSrf6bSNnG35xe3LajfxlDZ1t+SvKYJ8vUx7Vv572TLXgIv9Wtq1
 95N3j6S/JLPWUA3WIjyT11x2hx0vbDcbQEi6omS2XAmYszW+nfSnskkAuco0EPqWt5FM76fU
 iL2HdcbAceGN+Eg3VSkJEFhXqga5Os/OMWocOGD0aigMbN7nT6oum9A5Zh0zkOG8ycUpvfg5
 58e2LnY2wKGU2y5l1K9qoXsnpgCYzgOH225wCyiBYhLZ6Q0c5xZQWupJsS2wJ15ifuPEzZ9/
 USgGkhA9cunYxuUYHTi0AcW2UlfrXG8mCS+xiB5iHlz9/DZhnaRhb2/MkFPM3UDXGR4iFbwP
 YW46rJSFFOlaQQkjlrt5Er3wbRauLUqKmDSRUlSeC2lZ2pmU6a2qv+De5sVsclu638IFr3hJ
 wvJL9y16wEX2C7iAWZEkTUydjXx/478gwQ/k2WFanB6sHvef8h0gxbZ/t3VA/BLjV9kDGF1j
 yfaAl+kMpyn59KRwt3mu/q9Snnne5ldayjtwqufuSH96WAgUnjd17ij38bqFwQ3y3qx8tBwV
 jjT6jv4bJPq0auSLu9tOEVlTgyZiYIyCsR1lY0+g4sV0H4Ri8CO/HYJpmz0NM1SxaP0aHdeD
 S5O2dPe5xLpnVFyNn/cjZysTW2Tm4EyArvyKnNTwC826NpGTbuZ/KAR1zUguUK29ErQeaQvx
 G5Hj6F0tzhD2b9P4VB9iX/AZ9JaVUhAYX62zk7OtYrh6vwKIj7oK+X41VIiz4r4VvfY+F4aA
 Sm/ItB4Qmdx9pktaguTliKprNi1Ip+KMYJU7Ezx8V+IjvAJesJr0KNU2Gw+ZDO75Tp/laY6l
 UA8h8jl+tfdbT81o+ThRUQHfjztO5FJo26r0vwYx5fMmd7zWc8/f1dDFJrwEaD4SnRL66mhb
 VzfVmRn8j+aAeaNTVXZsRk76SiUS9bxbTnSLX0dh72OXTG7I0pSyEARVTQ+xdsiExyygdfma
 AF/7ywQ4Vjxrl1NzPhpPl/xSDWXogDgcToyRJWFSXgepghf+0fYN9Cf5eNvDmlZ+JOmtgmEN
 m2cYUxBE2gIXkWOA12rMKOp4JHM9O2RB+z2KPWrA/3GsetFS/KB3o6iyKNj+CuQcNqCND9uA
 rxz20ZOW2x4B9WMmzgLTH9y9WqFZMqaqRGgvyxv+5rmqrKxAl2pvNbJUOg3U50n4R29jKadO
 vTFgS94LW0dzZYQ3TrTz6BZ2lcOiiZofj3rELIatCeLQriD/80fRxMddS53M9NFqqwm2QwYc
 +vSkNDozfhVivAvClFKfUPskIelaIZZRgP1fEOCH0uNOLmccHfTxNrrZKqnVbBKpOBTqgH2p
 juRVUPudGfm9XGhR1WkNudCizueNRpVtdSmcxpjPmPkScrvdhyxNNIfZdge3rA+wH/HZzZ02
 dlUdkRQsvuP4CkejvgtQwSpAVJ6IOPClyvLtoHl
IronPort-Data: A9a23:/GoB1K682I/jaB0jX+UtUwxRtC3BchMFZxGqfqrLsTDasY5as4F+v
 mVMXWzQb/7Yamb8c4glPYTj9kIG7Z7TyN4wTQs6rHphZn8b8sCt6faxfh6hZXvKRiHgZBs6t
 JtGMoGowOQcFCK0SsKFa+C5xZVE/fjUAOK6UoYoAwgpLeNeYH5JZSlLxqho2eaEvfDjW1nX4
 YOr/ZWFULOY82cc3lw8u/rrRCxH56yaVAMw5jTSstgW1LN2vyB94KM3fcldHVOgKmVnNrLSq
 9L48V2M1jixEyHBpT+Suu2TnkUiGtY+NOUV45Zcc/DKbhNq/kTe3kunXRYRQR8/ttmHozx+4
 ItClJebaz5xApzVoLQyTxpYPy9iYJQTrdcrIVDn2SCS50jBbmeq3PhkSk07VWEa0rwuWycUr
 6NecW1LNXhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2QvIQIhWdq2aiiG97Qa
 5VDWRFoVi6dRANJPXExOoMMme2R0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RP/0BHNmY1CbD7X+mwOPC9c/mZG4MPOO31/VBomTL+l0KME05SVi7jfel13frDrqzN
 Hco0iYpqKEz8mmiQd/8QwC0rRa4Uvg0BIA4/woSt1jl90bE3+qKLjRUH28dNbTKoOdmHmN3h
 jdlivu0XWQHjVGDdZ6K3pu5xd9YEQscN2sZfzIEQGPpCPG8/tho03ojov5JGaK4iJjKBCvs3
 z2PpiUkiN0uYSMj0qKm4RbYjjjqqpWhou8JCuf/DjLNAuBRPd/Ni2mUBb7zs68owGGxEAHpg
 ZT8s5LChN3i9LnU/MB3fM0DHauy+9GOOyDGjFhkEvEJrmrzoyPzLdoLvWokeS+F1/ronxe2M
 Cc/XisOtPdu0IeCNv4fj3+ZVph7k/O6fTgbfqmFM4sSCnSOSON31HgzORDJhj6FfLkEyO9mc
 Zadbcu2C3sGQa1opAdatM9NuYLHMhsWnDuJLbiil0rP+ePHOBa9FOlZWHPTMLFRxP7V+G39r
 ocEX+PXmkU3eLOkPkH/r9VJRXhUdidTOHwDg5cKHgJ1ClE6Qz5J5j646e9JRrGJaIwPzbmQo
 S/sBxAAoLc97FWeQTi3hrlYQOuHdf5CQbgTZETA5H6khCouZ5iB9qAae8dldLUr7rIx0vN+C
 fUIIp3SDvNKQzXB2jIccZik8N08Lkv231rWMnr3eiU7cr5hWxfNpI3ucDzvwy9SXCC5gs0z/
 u+73QTBTJtfHAlvVZ6EaP+mw16rk2IaneZ+AxnBLtVJJhfz/YIsJyGo1q07JMQFKBPiwDqG1
 l/KUElC+rSX+9c4qYCbi7qFooGlF/pFMnBbR2SLv6yrMST6/3a4xdESWui/fQfbCDH+9pKka
 LgH1Pr7KvAGwA1HvocgQbZmyaUyu4nmq7NAl102GXLWcxK0B7kmLnTfhZtDsahEx7l4vwqqW
 xvTq4cAZujTYJvoQAwLOQ4oTuWfzvVKyDPc2vQCJhmo7iFA+rfaA15ZOAOBiXAGIbYpYpkpx
 /wt5Jwf5wCl00N4N9GbkmZL+m7KInFZC/crsZQTAYnKjAs3ywgeMMKGVXKsuMmCO4dWL00nA
 j6In66c1b5S8Ur1dSZhH3b62+cA148FvwpHzQNZKlmE8jYfaiTbAPGMHfULogVpItFv1uVuJ
 i50OkczKajmE/KEQiRcdzjEJu2DLETxFo/NJ58hi2DTCUWlPoAIBHNoIv6DpSj17EoFFgW2P
 9ikJKLNTjvgOs38tsf3tYiJtNS7JeFMGsb+dAxL0ihL81TWodYov0N2WVc1lg==
IronPort-HdrOrdr: A9a23:qMdRUaPU3qXCQ8BcTu+jsMiBIKoaSvp037BZ7TEVdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwJU80sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVydygc378
 ddmsZFeb7N5BRB7PoT+2ODYq4dKTS8gduVbd619QYWcengBpsL0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,241,1654552800"; 
   d="scan'208";a="21381827"
X-MGA-submission: =?us-ascii?q?MDGVhJ/guQRY6nL+kEPhb5Al/SqsaNF+K1LEzn?=
 =?us-ascii?q?BiaUy1dNKoM4IO5hb4x2iIbQoZWjE2pA2x/+8fXgnK5lyE1Z3OwrwPgs?=
 =?us-ascii?q?K1ME8kYNuvlraom0ptxEsqHqjwsbwM87a2/SVJHoGairb/3SK8OyJxEs?=
 =?us-ascii?q?AGXalkqOrFdN6lwrR5gsXvZw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 19:55:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1660672524;
	bh=gbQEKqPmHgObPRx/Cg4xL58ztqMTFm1nSYpKT1LVFcY=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=IX0noL718v2Ic0sUcoX8FjJzCCyn5bW9N/nbAJj7QSnV+xPQLjJAbi9Rm7VBnM3MN
	 hrC8x5rkW44tuqCX3m+GinFOGpB9pwPh65BVQ4ccvii5X74qoce5CZ6GV7m8DR8+Ch
	 2s+V31B53uxMLBvrx/08+PE1WOfWDrdvaL8QRtVY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.135.164.81]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPrLL-1o16Lv1rEZ-00MoCd; Tue, 16
 Aug 2022 19:55:24 +0200
Message-ID: <5c4fc14e-bf4e-8bbc-cc9e-0b04c849eca5@web.de>
Date: Tue, 16 Aug 2022 19:55:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.2
To: Jakob Koschel <jkl820.git@gmail.com>, cocci@inria.fr
References: <20220816085416.1542114-1-jkl820.git@gmail.com>
 <alpine.DEB.2.22.394.2208161337001.2561@hadrien>
 <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <29F3BFF3-ADB0-4E8C-BE30-298D0ABB8F1A@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:F026ZelB+78z8/A7jhvrEKhh/Zo715XKwpBTiJ+nUJmYJJoj69f
 HZAYnpV8CBxRL5rjBXweUqjZchuZ6c49m62qUX3GV2WgCFfsvjk5zMUY+Zs/uXkspe1fnTB
 okoqJwOj3rVpXNS6oBqjLRwcfXSeV4oal0t/I0Ma1CHy3qlYZZ2DLcUbe/7l9dG7Hse1JXU
 s1OSk8r4u89+KxKP4xDIA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:E0k2WFROYjU=:c0r/EWOsjjexUPXUf5CZ9x
 qK8n4uu9LOVopdR/doPr6WXW/EAuULjiYctdg9s/38CDfrO0/qiEy7os7lf04qs2qpNFUbxMc
 oKEI67Es6PWZNhCtmA5QZIHSIljF7JhEUSPI1OhnfC5hmK7wt8J7TzCSUDKVmb7SAL/+IVcz9
 nyq/503/j/6DDjdYsZwOVKY6FoJAiRnHEsxUmBkczPG4HtiB6CWsRnT77/1TMdvyJdjHv3R6h
 qEMnH73/ux71+lR0MlXXbnYHBDLLbhe0BxZ0sUcH2xkzo9Don3UhUgaHhTWPAC3/5lMujbY4u
 WEUj+Fzu4lkXP4IRG4dJ6NGRxn+972GQIqKSUHEKIvya7jJlhf7eGRbLtrDCixCIgMv7XZ0RQ
 QcJuG/CjvULjXJdfmxosguYrMn1C5hvzu78rt1TFCvFZCVtvtq6AaNa5a7hFumDGJHX7rgJcA
 BXSzgNjrpbEanxH0rvCFw1dBN7Zy6ZYD163p+NMcKyH7Ryr2UJFGA19hE8wmAzv5Gz2ngkOki
 XT6/JlAL5pXudENgFOegWmYYaUZ9n7QN5Mz0GSioUKDEy+KIgiSt3eblyZnieV82B1Wy1KP/c
 nd+HA2Ho46OXTCjDRjuWo0StA2KjgjyN+TLcUMx1h/ONj48uP7j4vRkYN5HUhgM7PMqngLDAK
 5XwMTqyJ2ozVS30oUE1WfI6vRP6gknV2znSji85GOMuk/Cb/RKmV5+ewTirKe9beRh2ytRztS
 N8bQi+EkwgwJWvrxuEF8adcDGWNZKgH8FwIPVDsjS7yaLJgsHHHQN5TjepgfNCMXXmV5VKU+w
 X6eCNNr5Qw0hJrDBJh91jGeXURBMiOFzRlbLnWcmOmokSqncNjNWOmAGGIA1W/f/3xVqH60N0
 NBLHjnm1d64dvCB8isnjYZoUtedZ+6ejrDj//3JvvhA8KUiSiuNOW9+jQvv0buTe+DxEDlcq3
 3T4QHnfzDJM0I1DGCCSFzGbZmMizFxQ9SfYELeBNdTe410WduwVgElwizhz9lylf79newPQvp
 pNnAjbi+JoF3fc4QYCQyvxzAuzRVQ6eelBGNESHuYLr2cSo6NF3uJVNzDt6es62xvKLgNgT0H
 /ye9V25zD+HhsKujmc7tdLvVuThjIrnBEWOq9TAubpQ49wlKjzQLlUkHg==
Subject: Re: [cocci] match arbitrary argument position
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 509
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-08/5c4fc14e-bf4e-8bbc-cc9e-0b04c849eca5%40web.de>

> looking at the following code snippet:
>
> test.c:
=E2=80=A6
>       func3(argc, argv);
>
>       func3(argv);


Would you like to handle function overloading here?



> what doesn't work (matching on the expression list from the parameter li=
st):
>
>    @main4@
>    expression list Es;
>    @@
>
>    int func1(Ps@Es) {
>    ...
>    }


Which type would belong to the metavariable =E2=80=9CPs=E2=80=9D?



> I also tried this:
>
>    @main4@
>    parameter P;
>    expression E;
>    @@
>
>    int func1(..., P@E, ...) {
>    ...
>    }


Does such SmPL code represent a contradiction?


Can any other descriptions indicate your data processing imaginations bett=
er?


>    @main5@
>    expression main4.E;
>    identifier func;
>    @@
>
>      func(..., E, ...);
>    + // add comment
>
>
> But it throws: 'rule starting on line 41 contains unattached metavariabl=
es: main4.E'.

Which software version did you try out here?

I am curious how corresponding considerations will evolve further.


Regards,
Markus

