Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B4DBC6FA86
	for <cocci@archiver.kernel.org>; Thu, 22 Sep 2022 12:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:date:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OZb/9CgM8qcE9BBNlCHlVGIEvwJ5beFFtDBtUbR5uNQ=;
  b=mMbAVnbI24qHZKskj9vB90Bad+jCY8YQjNifFVSofC0CZEnfrAM5no1w
   m+OaB+T9nUdQnNrqREgJ5v7EnJxwFIXWfJZSv3K2kXrfZhPqjmWovp2k/
   Dgbli87xx5TXjZru1412PmMVVEG2Mn67qq/5NpoD9z/tcK3p1HY/6AKKa
   M=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54036632"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Sep 2022 14:28:28 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EB543E0130; Thu, 22 Sep 2022 14:28:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1865AE0091
	for <cocci@sympa.inria.fr>; Thu, 22 Sep 2022 13:58:10 +0200 (CEST)
IronPort-SDR: 632c4dd1_McQl5Ot70q9YcmgvhCwAdCHkPxoUe3tauNhhOl7ccpza8ga
 E5Bi0tZA3Ma6QO0FYqo7miy/VDQIFDCsIFxj7pQ==
X-IPAS-Result: =?us-ascii?q?A0CJAgABTSxjh//U+S1aHgEBCxIMggQLgiSBVi8EC1yyX?=
 =?us-ascii?q?4F8CwEDAQwBQgQBAYFTgzKEbgIdBwEEMAkOAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBEwEBAQEYCRcHDhAFIoV1gjUihGtWaAENgwKDIQOsVIEBi?=
 =?us-ascii?q?B2BZYE9inaFWhyBSUSED26LAASZGTgDCQMHBSwdQQMLHw0WNAMVAxQDBSQHA?=
 =?us-ascii?q?xkPIw0NBB0MAwMFJQMCAhsHAgIDAgYTBQICFx4YNggECAQrJA8FAgcvBQQvA?=
 =?us-ascii?q?h4EBQYRCAIWAgYEBAQEFQIQCAIIJhcHEzMZAQVZEAkhFgYoDQUGEwMgSSYFB?=
 =?us-ascii?q?z0PKDFrKx0bCoEMKgkfFQMEBAMCBhMDAyICECoxFAQpExItBytzCQIDImwDA?=
 =?us-ascii?q?wQoLAMJIR8HKCY8B1gSKAUDAxAiPQYDCQMCJFp2DCwUFAUDDRkmCAUkFh0EC?=
 =?us-ascii?q?DwCBQZXEwIKEgOaZoEPf4EpwkuDYoFJDJ5JGjKpBJcKIKIfWoQnAgQCBAUCF?=
 =?us-ascii?q?oFhOoFbMxoIGxWDI00DFwIPjjkejhlEbAIGCwEBAwmJUIESAQE?=
IronPort-PHdr: A9a23:DySPBhDAPbMFj17HnBstUyQUnUkY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua82ygSSBs6HsbptsKn/i+jYQ2sO4JKM4jgpUadncFs7s/gQhBEqG8WfCEf2f7bAZi0+G
 9leBhc+pynoeUdaF9zjaFLMv3a88SAdGgnlNQpyO+/5BpPeg9642uys9ZDfeQtFiTSzbL99I
 xi6sxjau9ULj4dlNqs/0AbCrGFSe+RRy2NoJFaTkAj568yt4pNt8Dletuw4+cJYXqr0Y6o3T
 bpDDDQ7KG81/9HktQPCTQSU+HQRVHgdnwdSDAjE6BH6WYrxsjf/u+Fg1iSWIdH6QLYpUjmk8
 qxlSgLniD0fOjA57m/alNF+gqxYrhymqBNw34/UbZqJNPZiZK7RYckXSXZdUstXSidPApm8b
 4wKD+cZP+lYspPyp10TphagHwasAv7kxzhIh3/rx6I61fguHhvA3AE7H9IOrW7brdvrO6cTS
 +y60K7IzTDaYv5QxDzy55TGfAo7rvGQQbJ/b9DRyU83Gg3Kk1iep47oMjCW2+kJrmWW8eVuW
 f+ghmAntQx8oiSjy9ouh4TJgo8Y1kzJ+yt6zYs3KtC2R1N3bNq4HZdNsyyXMZZ9TMA6Q2xwt
 ys3yqcKtYC0cSUO0pgr2QPTZ+Kdf4SW4h/uVP6dLSpkiH5/Zb6yhRa//VK9xuHhSMW4ykhGo
 jZGn9TKq3sDzQbc6tKdRft45kqh2SiA1wTU6uxcOkA1lKXaK5E7zbIslZcfqEXDHinslEX2k
 a+ZbEsl9fap6+j9frrmoZqcO5d1igH4LKsuhtSyDOs4PwQUQWSW9uCx2Kf98UHkXrlGlOM6n
 6nZvZzCIMQUvK+5Awtb0oY57Ba/Ci+r0dQFnXYdKlJKZAiIj47yNlHOPfD3F/m+jEqtkDtx2
 //GObjhDo3LLnfYiLjhZ6py61ZAyAovytBS/4xYBqkbIP3vQk/xqMDYDhghPgyw2enmBs9y1
 ocaWW+UA66ZMabSvkSS5u01OeWMZYkVuCz8K/c//fLug2U5lUcHfaa1xZsXdGy4HvN+LkqFZ
 nrjnssOEWYRswolTO3qjUWCXiRJa3azWaI8/DA7B5i8AYfNXID+yICGiXOZA5lXbyZiA0+FF
 XPAdoOeWv5KZjjEZoc1lD0PUryoUMk53BWvpCf7zrNoaOTOrGlQ4Znk39N0z+zVjxA7szJuW
 ZezyWaIGlBpl2VAbDYwlPRuvEV7wV6F+ahliuNVFJpY4PYfAVRyDoLV0+EvU4O6YQnGZNrcE
 D5OI/2jCDA1FJcqxsMWJlx6EJOkhwzC2CyjB/kUkaaKDdo66PGUxGD/cuB6zXuOz6w9lx8+W
 MIaJHCvgKV28SDTGofWnkTfnKGvJuwHxCCYzG6Y1iKVuV1AFgt5UKHLR3caM1rLpNLy70XqT
 6KnFrkmdABGzJ3KMbNEP/vui1gOX/L/IJLebma2zn+3HgqNz6iQYZDCYHcN0yyFWA0FlUYT4
 H+ZOAl4DSCky47HJBppE1+nI0bl8O0k7Wi+Uldx1QaBKUtoy7uy/BcRw/2aUfIamLwe6m8nr
 H1vEVCx0sizaZLIrhd9fKhafdI24UtWnWPfuQtnO5W8LqdkzlcAegVztknq2l15EIJF2cQtq
 XorykJ1J8f6mBtQajqe1pn2Er3KI3b//VakbKuXklDS3dCK+7sevewiogartwWoG0w+tnR/h
 oUIlSHAt9OQVVBUC8+sASNVv1BgqrrXYzcw/dbR3Hxoa+yvtyPansguD60jwwqheNFWNOWFE
 hXzGosUHZvLSqRill63YxYDJO0X+rQzOpbsZuaP3qWiOs5ggTu5gGUB64d4mBHplWI0WqvT0
 pAJzuvNlBqaXjH3hVGJst3+ho1FIzoVGyDsgTihD4lXaKpoeI8NAmr7OMy7yOJ1gJv1UmJZ/
 lqub78f8PegYgHaL1n03AkKkF8SvWTigyyziTp9jzAuqKObmi3I2eXrMhQdaCZHQ2xrjFGkJ
 obR7ZhSTVWhaQMgkjOl+E/lyqkdr6N6Z2XeWkZHeSHqInoqDvb27ObTJZQWstVy7HgfWf/0e
 V2AT7/hvxYWtkGrV3BTwjw2bXDiu5n0mQB7lHPIKX9yqHTDfsQjjRzb5dHaWbtQxm9aGW8i1
 WiRXAHmeYP0oIbx9d+LqO21WmO/W4cGdCDqydnFry6n/ShwBhb5mfmvm9rhGAx80Cnh1tAsW
 z+byXS0KoTtyam+NvpqO0dyA1qpodtnE4d1m40YhIwZxnUbwJ6S+DBU9AW7ecUewq/4YHcXE
 HQa3tfT6wHj8E1+J22ExsTyUXDXkYNxItK9ZG0RwCc06ctHXbyV4LJzlixwulOkrAjVbKsY/
 H9V2b405XUdme1MpBs1w3DXHOUJBUcBd3+kh1GS4tu5tqkSeGu/be36yh9lhd74adPK6gBEB
 CSlJ9F4QX42tJwldgmWmHzrttO4JZ+KMYNV7ETO1Uydx+lNdMBty7xQ2XshYzun+yd4lotZx
 VRvxc3o4NXBcTk8uvjgWFgBZmKyPZJb+ymx3/oD2JzKjsb1R88nQ2RSFJrwEaDxTmJU7KW6c
 VfVVmFjzxXTUbvHQV3GuBog9i2RVc/6cSzJbHgBkYc7HUjbdAoG31FSBmll1p8hSlLznZ2nI
 AEpt3ZIvQC/8UIpqKogNgGjAD6G9UH4LGdlDsHEcVJX9l0Qvh6Ed5zYt70sWXoGucb45A2Vd
 j7CPlUOXSdQBRPCXACre7Cq4ZOoH/GwIO24IrOOZLyPrbYbTPKU3de11YAg+T+QN8KJN30kD
 vsh20MFU2orU8Le0y4CTSAajUevJ4aSuQu89ytrr8u+7OWjWQTh4pGKAqdTNtMn8g6/gKOKP
 eqdzChjLjMQ2pQJzH7OgL8RuTxawzlpbCWoGK8cuDTlV7DAlaYPX1sabWVzKcJX4qN61Q5Ie
 Ibaht7zyr9kn6s1BlNCBjmD0omiYc0HJX34NUuSWBvNbujXY2eSmYetPP7vLN8YxP9ZvBCxp
 zuBRkrqPzDZ0iLsSwjqK+ZHyieSIB1Zvoi5NBdrE2nqCtz8OXjZeJd6iyM7xbosizbEL2kZZ
 HJtbkpLpbSWxSNFi+pyGipK6X8vfozm026JqvLVLJobq64hGiNvi+dT+2g30ZNO/jFLTaQl3
 SrU6N5zqk6rk6+EzT8tA38s4n5bwYmMu0tlI6DQ8JJNDG3F8Bw65mKVEx0WptFhB7UHVIhQ1
 9HQmaO1IzBHoYu8FS40B9XdN8+GdnEmNEixcNY1JBAXXTGibTGahkobkOyb6XCU6JM9r8q08
 Kc=
IronPort-Data: A9a23:/QbVnqyYfXJSnpR0bm56t+cUwirEfRIJ4+MujC+fZmUNrF6WrkUEy
 2ROXmGBM//YZ2T3c9x0aY+x904AvpOAmodrGgpopFhgHilAwSbnLYTAfx2oZ0t+DeWaERk5t
 51GAjXkBJppJpMJjk71atANlVEliefSAOKU5NfsYkhZXRVjRDoqlSVtkus4hp8AqdWiCmthg
 /uryyHkEALjimUc3l48sfrZ8ks+5q6q4lv0g3RnDRx1lA+G/5UqJMlHTU2BByOQapVZGOe8W
 9HCwNmRlo8O10pF5nuNy94XQ2VSKlLgFVDmZkl+B8BOtiN/Shkaic7XAhazhXB/0F1ll/gpo
 DlEWAfZpQ0BZsUgk8xFO/VU/r0X0aBuoNf6zXaDXcO740jBLGe32uVSMm4zfpU63tdqWEpx6
 qlNQNwNRkjra+Oe26CrReA01oEiKo/rIYoAt3AmxjbcZRokacyeBf+WtJkChW123J0TdRrdT
 5JxhT5HfQnJZRZGPH8XFZshkebujX76G9FdgA/J/fBmujmMpOB3+J7iNMPYc+OvfIJMl1yfo
 WX9pzWoGDhPYbRzzhLfry7w2Lae9c/hY6oWHaKx8vpCklyWzHYaThwQT1qy5/ej4ma1XNlUK
 mQP6y82pO4z8laqR5/zRXWFTGWspQwMVNMIQ6g77keN16PL7gffDW8BJtJcVDA4nOMzQmM2j
 UaZo+3GAH93kpmkVCu2yajB+FteJhMpBWMFYCYFSy4M7N/ivJw/g3rzczpzLEKmpoapRm6rm
 VhmuABn3u5M15RTv0mu1Qmf22rEm3TfcuIizi7xNl9JAytidp6qbtT4rFndq/ZdJZmUTx+Ku
 31sdymiAAImUsnleM+lGr9l8FSVCxCtbGG0bblHQ8VJythV0yT/Fb28GRknTKuTDu4KeCXyf
 GjYsh5L6ZlYMROCNPEpON3hVpx3lPa+TrwJs8w4iPITOfCdkyfaoElTibO4hTixwCDAb4lmY
 v93jvpA/V5AVPg7kmPnLwvs+b82zz8zxCvPSJv7yROj1rWfaWXdQrBDWGZinchnhJ5oVD79q
 o4FX+PTk0s3eLSnPkH/rNBPRXhXcylTLc6t8aR/KLXcSjeK7Ul6Vpc9N5t6J9c690mU/8+Ul
 kyAtrhwlACh2CKeclnaNhiOqtrHBP5CkJ7yBgR0VX7A5pTpSdrHAH43J8RnL4o0vvdu1+B1R
 PQjcsCNSKYHADfe9jhXKdG3oIV+fV75zUiDLgi0UggZJpRAfg3u/sO7Xw3N8CJVMDG7m/Fjq
 JKd1yTaY6E5eSJcMOjsZsiSkmyB5UompLoqXm/jAMViR0H3wY07dw3zlqAWJu8PGzXixxyb9
 QGaPjlDl9bOvr5vocXohL+FnaitAeBRDkpXJEiFzLeUZA3x3Huv/p9Ea8mMJQvibWLT/L6zQ
 9lVw9XXEuw1rHwTv6VSS79UnL8Dvf3xrLpk/yFYNXTsbWXzLIh/I3ODjPJ9hocUypB34QKJC
 1+yoP9EMrC0OeTgIl4bBCwhSs+hjfg0uD3j3c4ZEXXAxh1c3eS4CB1JHhy2liZiAqN/M9olz
 ccfqccm0VGDpSRwAOmWrBJ/1jqqHiQbXrQFp6MqJtbhqjAWx2FoZb3eDS7L46+zVehcD3lyI
 hKpgPvturcN4GvDbHs5KlbV18V/m5klmU5H3X0CFXuzi/vHgf4+/CNR/W4JViBQ6AtN6MNoG
 21RL0YuD76/zzRpo8liXm6XBABKAiOCyHHx01ckkG74TVGic27wcF0GJueG+X4G/1JmfjR0+
 K+SzEDnW23IeP7d8zQTW0k/jdDeVv10qxP/nf64E/S/H5UVZSTvhomsbzEqrzrlGcYAu13Vl
 9J1/epfabzJCgBImvcVU7Kl7LU3TAyIAEdgQvs7paMAIjz6SQGIgDOLLxi8R9NJK/n06nSHM
 s1JJPweczSl1S2LkCIXOr5UHZ9wg8wSxYQjfpHFGDc4loWx/xtTjYLo1ynhhWUUbc1kvuQjJ
 6jwKT+TMGyiqkFFum3KrcIfIjaKO/QbQyalxOq0reIFKLxYgt5vbHBog6eVvmqUAiRj7Rm7r
 APOXI6I7u1AmKBHvZrgLbVHPCqwcejMbeWv9Buhlvh/dvbNDJv+jBwUoVzZIAhmB7sddNBpn
 7CrstSs/kf6kJspcmLewb+tKrJo4JisYe9pLc7HFnlWsi+cUsvK4RFY2WSZK4RMoexN9PucW
 Aq0R8uhR+E7A+4H6iVuVBFfNBIBB4DcTKTq/3q9psvRLCkt61XMKdf/+EL5aW1eSDQzBKT/L
 Q3K6saevoUS6MwGARIfHPhpDqNpOFKpC+Nsa9T1siLeFWWyxE+Lvrz5jxc79DXXET++Hd3n5
 Y7eDA3LHPhoVHokEPkC22CzgvEWMJq5qfIibk0Uo44zijb8DHMPMukcd54BD/m4V8A0OI7QP
 FnwgKkKUE0RngiotT38/d38UwbZDesLUjs8DiJ85FuaMk9aG6vZaIaMNU5cD7Neeibq0+ymb
 9oZ/xUc+/R3Lo5BHY4u2xBwvQurKj42CJ7FFYARXvEe2yojPIg=
IronPort-HdrOrdr: A9a23:QYYJ8ak8BLlT6PN0bxj7xA38XnrpDfIu3DAbv31ZSRFFG/Fxl6
 iV88jztCWE7Qr5N0tApTntAsS9qBDnhPxICOsqXYtKNTOO0ADDEGgI1+XfKlPbdxEXKoZmpM
 Fdm/8UMqyWMbEDt7eY3ODuKadF/OW6
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.93,335,1654552800"; 
   d="scan'208";a="54029197"
X-MGA-submission: =?us-ascii?q?MDHr3SVUI2rMy3YXDcpB6HN9UnlaWFcwI3nkWS?=
 =?us-ascii?q?Of1tsbQJSZ67V6EFeVJAxuVgXpTd4qyE4sFmQN1alM+SgQgoXenMSFHI?=
 =?us-ascii?q?JAd61JvuJfJWa80nb11p9ukE73seAckf2VBmR+DSu9EyY3WHwcsPPEqB?=
 =?us-ascii?q?FgcqV0TwST11ZMUVXFn/X5+A=3D=3D?=
Received: from szxga08-in.huawei.com ([45.249.212.255])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2022 13:58:08 +0200
Received: from dggpeml500024.china.huawei.com (unknown [172.30.72.57])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MYDFw0812z14S2c;
	Thu, 22 Sep 2022 19:53:56 +0800 (CST)
Received: from huawei.com (10.175.112.208) by dggpeml500024.china.huawei.com
 (7.185.36.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 22 Sep
 2022 19:58:03 +0800
From: Yuan Can <yuancan@huawei.com>
To: <Julia.Lawall@inria.fr>, <nicolas.palix@imag.fr>, <cocci@inria.fr>
CC: <yuancan@huawei.com>
Date: Thu, 22 Sep 2022 11:55:33 +0000
Message-ID: <20220922115535.44132-1-yuancan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.208]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500024.china.huawei.com (7.185.36.10)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 0/2] coccinelle: Introduce cocci script to detect
 missing mutext and spin lock initialization
Reply-To: Yuan Can <yuancan@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 571
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-09/20220922115535.44132-1-yuancan%40huawei.com>

This series introduce two scripts to help detect the use of mutext or spin
locks without initialization.
---
changes in v3:
- remove the redundant matching expression
- remove the redundant asterisk

changes in v2:
- adjust commit msg
- add Confidence: tag
- print out more information in the report

Yuan Can (2):
  coccinelle: locks: add missing_mutex_init.cocci script
  coccinelle: locks: add missing_spin_lock_init.cocci script

 .../coccinelle/locks/missing_mutex_init.cocci | 76 ++++++++++++++++++
 .../locks/missing_spin_lock_init.cocci        | 79 +++++++++++++++++++
 2 files changed, 155 insertions(+)
 create mode 100644 scripts/coccinelle/locks/missing_mutex_init.cocci
 create mode 100644 scripts/coccinelle/locks/missing_spin_lock_init.cocci

-- 
2.17.1

