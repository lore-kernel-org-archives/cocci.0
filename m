Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A811C433EF
	for <cocci@archiver.kernel.org>; Sat, 26 Mar 2022 19:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nHpWn44+1mO0X6wTwhXw0H941uAkdK0wwWLHNSSjF/Y=;
  b=Wx8KFX7gkqXSAC2wZ+ygQ00uv5krhHXSYePqsqqJIiaC+7oSW/7Cqj7h
   VNgMkCiuHai2v4Sh9rc+jRC907sgyuolokh4j40Lojp6DFCpfAgylFkKZ
   uTOawi1td3h4lzk2/nW0ZUKHRu7FUuu2RrglU7kWbPEXQIRBIKEfD9Rrc
   U=;
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
X-IronPort-AV: E=Sophos;i="5.90,213,1643670000"; 
   d="scan'208";a="28440004"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Mar 2022 20:26:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 3E3C5E4372; Sat, 26 Mar 2022 20:26:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BC5B2E436E
	for <cocci@sympa.inria.fr>; Sat, 26 Mar 2022 20:26:26 +0100 (CET)
IronPort-SDR: VYVG0qJz2hXt1XrBNOXxBukhHSUYw/RHbD3xyQOvwSc3HlrUpZdkkOhiM0jlftBledul09C0v0
 axApZHx0zbjG01gBtfFI1D8VwLovwGtErQVfXf6Iy6mz+qOxdu+puXyxe2uzl1yYGsinXTxXei
 gDHG4CLnC+oOOUqB/0VyN4cLRETDXgFkJb7woDH6AMh7AyUpEfdfOLuqK46jti17NRNlT5uEwd
 EMXEKswIXLLWl97Z2Djbx5bMphjkoBc4i1FfvgFzhtKRDOKm8AIaf/k3RRQvjvXVoXOMGrgxXL
 9B4Od9qJESW+lgJAarp4DxRx
X-IPAS-Result: =?us-ascii?q?A0DZCQC6Zz9ihwQP49RagQmBXIE6AgFpflcrBAtEhFSIK?=
 =?us-ascii?q?Ihzkj2KKIF7CwEDAQ0SAQEjCQECBAEBhEJFAoROAh0HAQQ4Ag0BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBDA0JBQgKBw4QBTYGXgZkBIFLB?=
 =?us-ascii?q?IF0CwcIJQ2CNSKDbAECAgEjHQEBEScECwsaAiYCAlcTCAEBgwABgmQBAw0lC?=
 =?us-ascii?q?64WgTGBAYIIAQEGgT8BgRyBbB8sIlKBXAMGgRAqAwEBjkcnEIFVRIE8DIJHM?=
 =?us-ascii?q?D6CYwKBYE2CTYJll2eCLSKCG5JCrXU0B4ISgTqBQQyJQpRPBhQug2KSYQ4Gk?=
 =?us-ascii?q?W+WXI0WlUuEI4IPgWczGiSDOE4BAgECDQECAgMBAgECCQEBAoVLiGuDWTOKL?=
 =?us-ascii?q?EA0OAIGAQoBAQMJhUcBAYwXAQE?=
IronPort-PHdr: A9a23:o0WNYhU72LWrN8DvmZr0rZD7KxLV8KySXzF92vMcY1JmTK2v8tzYM
 VDF4r011RmVB9+dsq8fwLOM7+jJYi8p2d65qncMcZhBBVcuqP49uEgeOvODElDxN/XwbiY3T
 4xoXV5h+GynYwAOQJ6tL1LdrWev4jEMBx7xKRR6JvjvGo7Vks+7y/2+94fcbglWmjaxe65+I
 RW4oAneq8Uan4RvIbstxxXUpXdFZ/5Yzn5yK1KJmBb86Maw/Jp9/ClVpvks6c1OX7jkcqohV
 bBXAygoPG4z5M3wqBnMVhCP6WcGUmUXiRVHHQ7I5wznU5jrsyv6su192DSGPcDzULs5Vyiu4
 7ttRRT1jioMKjw3/3zNisFoj6xVrh2uqBJizYDUfo+VOvhxcb/Sc94BWWpBR9xcWzBdDo6yb
 YYCCfcKM+ZCr4n6olsDtRywChO2BOPs1z9InWL906I+0+QvCwHG3QogH90Tu3nTq9v6Lr0SU
 eOozKnT1znNYPdW2Tnn6IjJdBAhruqBXLxufsXK00UgCh3Kg0yWpIf4MDybyv4DvHKH7+p8S
 +2vkWgnphltrjWxxskihJTFi4ALx17L9Sh3zok7KN66RUN4YNOpDZVduiKHOoV5Tc0vX3xlt
 SQ7x7AIpJK2fCgHxpsnyhPfbfGMboaG4hXmVOmLIDd4gmpoeL2+hxau8Uig1/bzWtOo31ZNq
 ypIlMTHuHMV1xHL9MSLV+Vx8l2/1TqR1Q3f8PxILEAumafUM5It3KQ8moQcvEnMBCP6hUb7g
 aGMekk5+eWl6eLqaaj8qJCGLY97kAT+P7wumsOhBeQ4NRADX22c+eShyL3v50P4T6tRgfEsj
 6bWrojWJcUdpqGnHw9Yypgv5wuhAzu8ztgUg3sKIEhYdB+HlYTkNEnCIPXiAve+h1Ssni1rx
 /fDPrD5BZvCNGLDkLT8fbZm8UJSxw4zzd5F55JVDLEBL+n+W0Hvu9PDFBM2LhK7z/7hCNpmz
 oweQ36AAreFMKPOtl+F/v8jL/GWZIAJoDb9N+Ql5/n2gHAlnl8SYbWm3ZoMZXCjHvVmJl2Zb
 mD2jtcAF2cKpAs+Q/bwhF2MSz4AL0q1Cqk77To6IIOgF4bKAI6305Kb2yLuO5RMZX1dQn2IH
 23pcYrMD9IFciGPOYlMljIeVL6uY5As31eiuVmpmPJcMuPI93hA5trY399v6riL/flT3Tl9D
 sDHlnqIU3kxhGQDATk/wKF4p0V5jFaFy6lxxfJCRpRI//0cdAA8ONbHyvBiTcjoU1fkd82KV
 U3gb9GoGzA3QfouztVIb0suU866gEX71jGxS6QQi6TNAZU19qzG2H2kAs9nyGvdkoQlgUMnR
 MRnKmCswKJypEDIH4CctUKfmu6xcLgEmi7A8GDW1W2VoERRSxJ9S43AWm0DIFTbp5L16ysuV
 peIDrIqektEwM+GcO5Rb8HxyE9BT7HlMcjfZGS4nyGxAwyJz/WCdtiifWJVxyjbBEUe9mJbt
 X+bKQgzADugqGPCHXRvE1zoeUbl7eh5rjuyUEY1ywiAa0Ap2aCy/1YZgvmVSvVb2bxh2m9pj
 jxuH0ummf/SBcCBoQVJY6hWJ98woR9G2W/fqw1hL8m4NakxzlUacglxowbvz0AtU98Gy5J16
 ip3ilYhTMDQmElMfD6Zw53qb7jeK22ouQuqd7aTwFbVltCf5qYI7v087VTlpgCgUEQ4oBAFm
 5FY1WWR4pLSAU8cS5X0BwwS/gJ5uqqcTy0z/YLS2lVzPKPyvjKIiLdLTKM1jw2tedtSKvbOM
 QboENABQeWqJvYrnVeBcR8Oeuxfvv1RXYvuZ76N36ilO/xllTStgDFc4Yxz5UmL8jJ1Vu/C2
 5ttL+iw5gKcTH+8iV6gtpqygoVYfXQIGWH5zyH4BYlXb6k0fIARCG7oLdfljtl5gpfsXTZf+
 jvBTxsj0dWqZAHUQljzxwxW2mwIrHbhlSbwwzFvkj4vp7aSx2SUmr6kLkBYfDcWAjUqhEykO
 YWuitEGQEWkCmph3ACo40r33ekTpahyKXXSXVYdeiH3K294Va7j/rGGYsNJ9NYpqXANCb76O
 wrFDOeg5UdJtkGrV3FTzz06aTyw75DwnhggzXmYMG42tn3SP8d52RbY4tXYA/9XxDsPAidi2
 ly1ThCxOcek+dKMmtLNqOe7AiiEX4dQbDKt4IeOriq96kV1DBf5k/35ybiFWUAqlDT20dVnT
 3CCiR/mYZTwkYm+P/hmeEZAG1L2rcZ3UNIb8MN4lNQb3n4UgY+Q9HwMnDLoMNlV7qn5aWIEW
 T8Bx9OGqBigwkBoKWiFgp7oTnjIiNU0fMG0OylFv0B1p9APEqqf66ZI2Dd4skbt5xyEeuBzx
 38c0ad8sidAxbtT50x0lHvbW+pCWhMFWE6k3xWQs4Lk9f8RPjzwN+HtkhI5x43pDane8FsFA
 jCjIMhkRHA2toIlbxrNyCGhsNi7PoaKK4tC7FvOz0eH1bkwStp5l+JW13o9fzuj4Dt8lr991
 Vs0g9m7pNTVcTwyuv3jREQAaXutIJlMsjD10fQEx5nQgNrpR8Q7XGtXG8G2KJDgWDMK6aa3b
 UDXTmB68C3KX+OERUee8Bs0/yiJSs72cSvMfD9Dl50nTR2ZbiSzmSgyWzM31t48HwGunon6d
 VthoyoW7Rj+owdNzeRhM1/+VH3erUGmcGV8Tp/XNxdQ4gxYgiWdecWD8uJ+GT1Z9Zy9vUSML
 GKcfQFBEWAOXASNGVniOrCk4dSI/fKfA6KyKP7HYLPGruI7Nb/A3ZW0zo5v5CqBLO2KOWR+S
 eI20AxPUDExGsjUnSkOVz1Cly/JaJ3+xl/08Sl2o8ajtfXzDVi2v83VUeQUaIgpp0PT4+/LL
 eObiSdnJCwN05oNwSWN070DxBsIjCoocTCxELMGvCqLTaTKm6YRAQRIDkE7fMZO8a842RFAf
 MDBjdagnJtxlP0oEBFoUVL7m8emTdMHKSexORmUYSTDfKTDPjDNz8ztNOmkTqZMiexPqxCqk
 TOcDlOlITmJ0TXkHUPKU6kEnGSQOxpQv5u4exBmBD34Td7oXRa8Ncd+kTw8xbBcbpLiMGkBL
 X5jfkkLorDCtUuwZ91gFmYH4nc3dYFsdA6G4uOeJptE6JNW
IronPort-Data: A9a23:+aKCsqNmPxjvd3XvrR34kcFynXyQoLVcMsEvi/4bfWQNrUon12ACz
 2BKDTzSP6vcYDf3edB0aIS18xkGvsTUzIQ1HHM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2EoLd9IR2NYy24DiWV3V4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2skoxg+
 tBElKWrVDo3MKvFl7o7dQRHRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6BwxDMlNnhvg8qTyai4V/Iqq8AtNsjtM6sAt3smwTyx4fMOG8CfGPSbtIEwMDEYrN9iJu//a
 uUgNwFofTf5W0xRZmkGB8dr9AuvriCiL2MB8Qz9SbAMy2PUxwdw+KP8NcLcPN2MX8Rc2EiCz
 l8q5Ez8BQwGcsOSw3yJ/xpAm9MjgwveVd4DJrix18dxnWCNyGoaB0Mwc0ak9KzRZlGFZ/pTL
 Ekd+ywLpKc09VC2QtSVYyBUsEJorTZBAoABQrZSBBWlm/aFul7x6n0sFGYZAOHKovPaUhQG+
 ze0cz7BADtyrPuKRHjb+rr8QdKO1co9fTJqicwsFFVtDzzfTGcb0EinojFLTvfdszENMWusq
 w1mVQBn71npseYF1r+g4XfMiC+2q57CQ2Ydv1uLDjv4slslOdD5OOREDGQ3C94ffe51qXHe7
 RA5dzS2t7xm4WylyXDcHr5XdF1Xz6zYaWGF6bKQI3XR323wpyD6JN44DMBWfQkwescCZTLzZ
 kLP8QpejKK/z1P6BZKbl7mZUpxwpYC5TYqNfqmNMrJmP8YtHCfaonAGTRPBhwjFzRl3+Ylia
 MfzWZj2UR4yV/89pBLoHLh17FPe7ntjrY8lbcunlEvPPHv3TCL9dIrpx3PTN7hgt/nV+V+9H
 hQ2H5Li9iizmdbWOkH/mbP/53hTRZTiLZyp+cFRaMCZJQ9qRDMoB/PLn+E+doYjk6kMzrXE+
 XS0W0l5zlvjhCSbeFvQNS05MOviDcRlsHY2HS0wJlL2iXItVoaY6vtNfZUAe7R6pvdoyuR5T
 qVedsjZWqZPRz3L9i4zd574qIA+Jh2niRjQbTWoan4zcsc4FQDO/9bleCrp9TUPV3bm65Fh/
 uf4jg6CGMgNXQVvCsrSecmD9VLpsChPgv92UmvJPsJXJhfm/r9qHCqt3PU5FMcBdEfYzTyA2
 gfKWhoVqLWfo4Ix99WV16mIo53wSrl7GVdGWXbW5/C6OHCCrGakxIZBVseOfCzcDT+lpv/9O
 L8Nl/ysYucamFtqspZnF+g5x6wJ5+zp++1QwDNiESiZdF+sEL5hfiKL0JUdrKFL3bMF6wK6V
 ljWo4tfPqiVftzoGhgdKVN9POiE0PgVnBjU7Og0eRmrunUooeDfCUgCbQORjCF9LaduNN13y
 +kWuPkQt161hC0sP4vUlStT7WmNcicNXqhPWkv222M3ZtfHC22uYKAwzgfz54yTLcpBOA8mL
 1d4QUYEa6t0niL/n7gbTBAhHtaxQbwRtRoMwFJqy5GhhI/envFutPFO2W1fc+mWpymrF8psN
 2ItO0AdyWBiOdt3rJArYl1A0D2tyPFUFoIdBrfJeKDko5GUa1Hw
IronPort-HdrOrdr: A9a23:eMXMC6NxNIQOccBcTu+jsMiBIKoaSvp037BZ7TETdfUzSL3gqy
 nOpoV86faQsl0ssR4b9uxoVJPwI080sKQFhrX5Xo3NYOCFggeVxehZhOOO/9SjIVybygc378
 ddmsZFebjN5BRB7PoT+2ODYq4dKTS8gduVbd619QYWcengBpsL0ztE
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,213,1643670000"; 
   d="scan'208";a="28439996"
X-MGA-submission: =?us-ascii?q?MDGuQ96ZLpMO7rhTvzheSZAyXLpLEDL3ROvH6e?=
 =?us-ascii?q?cT+/wvSRxEpTgNW9JIC1Lw/ixYiVJ/vfsBo8dXNYqoqAxH32hfVmdrYv?=
 =?us-ascii?q?8c9AGgoXLDPYuET4x9JCAMmUWCr1c14pO+i0ihvSErT04c+K3evX120P?=
 =?us-ascii?q?gZUxxEH/o+NfVu6jHg0W3Mqg=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2022 20:26:26 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648322784;
	bh=nHpWn44+1mO0X6wTwhXw0H941uAkdK0wwWLHNSSjF/Y=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:In-Reply-To;
	b=GqWHsY/oqzbWR3ucxTb2bYwKotOjbC2odLo8y/XAt5564h7ICQefDImUlg+GwdWHa
	 GliVGA/wuzyncWrZQmIbUQfPaPFeZ5PjmPmbwPOGWareRdePMxDPEFoY3hO9LBZ20F
	 fEM4ZOYKxq/q/BwmAqJlKEsHmw/qzUa+Y+RbTem8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.183.187]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N01Za-1oJ23C2BeA-00wwik for
 <cocci@inria.fr>; Sat, 26 Mar 2022 20:26:24 +0100
Message-ID: <1957d5a6-1303-b410-8a6c-56fb8dbcb7f5@web.de>
Date: Sat, 26 Mar 2022 20:26:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@inria.fr
References: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
In-Reply-To: <c17bb3cc-f839-625a-66a6-2b9de96c9264@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:abTHfI7mrqaLPWF71e5m1o8t0TG3PT3YzyHfZZgEujI8DFE7/Sv
 Jq0fCvDorEHlSFxC9wbqZnTedZTv2hMpg3LqqCc2zhna6LJK32Ewvrh6lIa38+MX4rO01WD
 tIEKD0cRbtFA9oWmU83UKBaU5/Oz54Kj6+vhXVbcEfAA0HZnknkcEuueEBvSgbYuhUkHyfG
 9yqq6Q8Z7x1/yqCFe64pA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:4v3a9ZDbQmM=:zrjNfJUZJ4l/IcLLL8hbUs
 ij9j7FcdRa7w/haLLYnrVaiOaYX+AzPJzSDqiV7GgDMfDH/UdB3azu/WHlFca5lGOitDvrsC5
 ZstEIALBD6BeRvxhdvDuCIV9GhmGs/Ef5hB3p62UBugUWU8iDQUckSr+AQ0NTgUTOx5iRMLHe
 3KFyC5wEB37hZyaOtPkiWxLfbXaSpz6A8RO65ScKGYa0WLH1OL73d6N1npr26XzaC5939mPPW
 isH0jzpEhvSrwUf5BORnkSevTZ/KB278ZfD2Df+a2xOoApBtasHFa1bzGnON3MNggpBNoVHEk
 HqLtE1OFdg/tQ4v7EmNmiiPpc3l5X1yMwS205394W7u5q0eNRHrneMwKGXNEYcwE+JkkLmOXE
 Zv6ajLTyroEUyA7eWDNAu0C3mdUeSTng7ea0jHoLudrxedaF2dOrGYH7rxOQPzGNv+MOqaLuK
 AGTUFeZOSPA/D8giVEEH5+KPXJlczTzST33TohNptNYxVVjkQVfHUfrUvher8QJ7CUxxuXSKC
 pEhO3RGbdU9aCawM7Arnodw3cpW38PXtjka0IHPxpvdRzMSE+Pt2Mhr0eOYELoJ+X97FdFKzy
 PS98HG1UkYlkeKkIGFMNkeK6+NDE+onj2wEaStP/kSzXE2REbbfrXmonLIRlwlPsWTJNeQYKq
 M0CbQwnxWawxk8NdQHKjvsJbKNlBwVMRvcwaO+T1QaHXHVQbwoF5aMFc9qLoM7s96Ozlzo4v8
 JJAHirh3BH6RCXK+DPXsYqJXw4sa228GL+WFNg1qZQ84v/UmWS8idHeA7opMECm5Zd6oC/18q
 /herskU+mHqa6relD699UOf+vRaYE7a6285nSRJggcSITl41MNOFfZmz/EWT98CTRBJZCfkyd
 b9lzb4V3H2MwRualci1Akhll2EMuSMYZEzD7vo0c7wMZr6GZAn/pmVl3p9Ba49WQklCKrXWjf
 RtHH/wY1SJzpHK3v2nCBxQ8GXtGueswZk6CVpDb/BNSEM6IQcbMkWSudYJmwJIk304n5O8BKl
 FgMZ5+cJM7WyU4O4ivmcdl28Ikz2DDV7XID/V4JF1W42lO/CzDs+63WNRnOtCCwL4YiFbnBoI
 fTtwctrSoKpuHI=
Subject: Re: [cocci] Adding metavariable types for the handling of string
 literals?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 293
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/1957d5a6-1303-b410-8a6c-56fb8dbcb7f5%40web.de>

> Additional programming interfaces can also help to handle data parts bet=
ter,
> can't they?


Will the chances eventually grow also for the clarification of previous fe=
ature requests?

Examples:
* 2016-01-06
=C2=A0 Support for string literals by another metavariable type
=C2=A0 https://github.com/coccinelle/coccinelle/issues/55

* 2020-08-21
=C2=A0 Object-orientation for metavariables
=C2=A0 https://github.com/coccinelle/coccinelle/issues/212

Regards,
Markus

