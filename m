Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A877FC433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pxe2b6tuMpFPNcHiTc/xicU+oOeSl2yRKxC0r6/P8EU=;
  b=hVY9cL2mRMFWkZivTKIGAYVpf4FMsETvOO8FIKxSVXSeasfX2mVyPZwm
   xsm7zJHNybeoutmPvP6XJuxPZ5utXAtH3iliosxn3BCrnnmp/FBkewCNt
   oDdvF8uaRIIt3yKHOIvhAvAiYVt7sqIk3s7BZYZFqRA9HiSY/GTMQL795
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29749699"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 16:55:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7F602E033A; Sun,  3 Apr 2022 16:55:47 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 10626E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 16:55:44 +0200 (CEST)
IronPort-SDR: vQbzoimmFjVWjlWBFiGMnPkRE7cBOUIa/g5PorYCptGHPAQa8LUojMYXi8wotX3xaXG2YCEImO
 4FAJV9KRpiZi/eMvedKgwtUQ1CS0tch569QbiUmxGXfaLVraRY8+8vLnMEkbZoESPKYFrFtoD+
 /vuuGgIEyv6nVbnEdaqYSnWMyt9JgNXjrc05nUGrYhkg+uhJTLBVaYE/+HJzSSxFMGoDy68l9d
 5xw9IT+wG10lg3PlRvgy1j9WZifAo346H61DAnUmlkKisuA8goCqauvKDooDjD+nBGxizZA+4C
 4VO5x7LWrlp9sv7xtWJp/jGf
X-IPAS-Result: =?us-ascii?q?A0AJBQA7tElihwQP49RaHgEBCxIMQIFcgiZ+VysEC0SEV?=
 =?us-ascii?q?JEbkkCKKIF7CwEDAQ0yDgECBAEBhQcChFoCHQcBBDYEDQECBAEBAQEDAgMBA?=
 =?us-ascii?q?QEBAQEDAQEFAQEBAgEBAgQEARMBAQEMDQkFCAoHDhAFNgZeBmQEgUsEgXQLN?=
 =?us-ascii?q?A2CNSkBg2QBAgIBIx0BAREmAQ8LGgImAgJXBg0IAQGDAAGCZAEDDSULrlKBM?=
 =?us-ascii?q?YEBgggBAQaBPwGDCB8sIlKBXAMGgRAtjk0nEIFVRIE8glMwPoJjAQECgV6DG?=
 =?us-ascii?q?oJDIpsMwwI0B4ISgTqBQgyJR5RTBhQulkUOBpF2hHWRaY0YmXSBewuBXQwHM?=
 =?us-ascii?q?xokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmDWTOBC4kiPzQCCS0CBgEKAQEDC?=
 =?us-ascii?q?YVHAQGKPQEB?=
IronPort-PHdr: A9a23:4iNFPBYVd1/Rfx680yHNpzT/LTHZ2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gWPBNqDoKIdw8Pt8InYEVQa5piAtH1QOLdtbDQizfssogo7HcSeAlf6JvO5JwYzH
 cBFSUM3tyrjaRsdF8nxfUDdrWOv5jAOBBr/KRB1JuPoEYLOksi7ze+/94PNbwlSmTawY69+I
 Bq1oAnMq8IbnZZsJqEtxxXTv3BGYf5WxWRmJVKSmxbz+MK994N9/ipTpvws6ddOXb31cKokQ
 7NYCi8mM30u683wqRbDVwqP6WACXWgQjxFFHhLK7BD+Xpf2ryv6qu9w0zSUMMHqUbw5Xymp4
 rx1QxH0ligIKz858HnWisNuiqJbvAmhrAF7z4LNfY2ZKOZycqbbcNgHR2ROQ9xRWjRCDI2yY
 IQAAfcPM/hWr4f9pVQBsRSwCBKwBOP20DJEmmP60KM43uknDArI3BYgH9ULsHnMq9v6Lr0SU
 eOozKnT0D7NYPdW2Tnn6IjJdBAhruyHULV3f8XL00kvFB7Fjk6KpYLqOzOV2P4Ns2md7+pvT
 u+uhXAopBprrjey2Mghk4/EjZ8axV7Y7yt22po1JcGmR05hZ96pCIZcuz+YOoZ5Qc4sTWNlt
 Sc1x7AbuZC2cjUGxZQkyhPRd/GLbYeG7xDsWuuRIjp2hG9pdrKjixuz8kWuyunxWMmy3V1Xo
 CRFldzMuWoM1xzV8sWHS/19/l2g2TmVzQzT5PtELVg7laraN54hwqMwmYEJvUvfGS/2nUP7h
 7KVeEU84uWk9fnrbqv8qpOCKYN5iBvyPrkul8ClDuk0KgoDUmuB9emz17Dv51D1TKhFg/Esj
 KXUv5bXLtkBqKGjGQ9ayIMj5g6/Dzi41NQYmmEKLFdCeBKak4jlIV/PL+7jAvulnlujji9nx
 /HAPrL/HpXANmbPnKr/cbpn9UJQ1gg+wcpC659UEL0ML+r/Wkrru9zZCh85PRa0w+HiCNhl0
 Y0RQ3iPAqyEMKPJq1OG6eYvI+eWZI8Uvjb9JOMo5vDwgnAig1MSYLem0YMRaH+jBvtmOVmWY
 WLwgtcdFmcHphQyQPTwiFKeST5Te2qyX6Uk6zE/Eo2nA53MRoSpgLGa3Sa7H5hWaXtcCl+WC
 3vodoOEW+0NaC2IOMNhnCYEWaC7S4A9zRGuqBP6y71/I+XI/S0XqY7s1Nlu6u3IlRAy8CR0A
 N6H32GMSWF0hGIISCUs0KBxu0wugmuEhIplh/1RXfha+PpNVk9uN4PYzuU8D9ntUwbFVtaPU
 levBNu8V2IfVNU0lvoHeUVgAJ2Pih7Z3iylS+swnqaIGYdy36bSxXn3KO5ixnyA2KR33Apue
 ddGKWDz3v03zAPUHYOc1hzBz85CFIwZ1S/JryKYyHaW+VpfSEh2WLnEWnYWYg3Xq8747wXMV
 ezmEqwpZy1Gz8PKMa5Wcpvxl1wTYf75O8nFJU+1lX2xAxmg2b6GKobnKC0GxCuIMEEfiEgI+
 Gqecw03ByOvuWXbWRlnD1HyeAXB9edkqXW0ZlA5xUeGYh4pzKK7rzgSg/HUUPYPxvQEtSMm/
 i1zB0q41snKBsCoog18YONDbNl77FovOXvxkQt7M9TgKqljggVbaAFrpwb10A0xDIxckM8sp
 XdszQxoKKve3kkTPzWflYv9PLHaMAyQtFimdrLW11fC0d2X5rZH6fI2rE/mtR2oEUxq+mtu0
 t1c2X+RrpvQCw9aXZX0W0cxvx90wtOSKgw0/YDJzjtBNaeusznN880kDq0px1fofttSNr+FC
 B6nC9cTVIClLO0nnUTsbwpRZrkIsvRuYIX/Kr3ai8vJdK56kTmrjHpK+tV420OIrG9nT/LQm
 o0C27ee1xeGUDH1iBGgtNr2kMZKf2J3fCL3xC76CYpWfqA3c5wMDDLkBsStxchlwbPpVWRZ8
 lGLGF4MnsOkM0n3DRS1zUhL2EIbrGby0w6x1T9piHcEqqSF3SrB6/vvflwLNyQYIQsqxUepK
 o+ygdcAWUGuZAV8jxqp63HxwK1Drbh+JW3eKatRVxD/NHoqEq65t77ZJtVK9IttqiJPFuK1f
 VGdTLf55RocySLqWWVElng3cDSju5OxmBIf6irVCX9pr2fCP+x0yw3e4tP0WvNbmDYLDCV1k
 jjYAFGgMsLhp4zO0c2Z7abnCiT9HpRIOTHm14aBqDe26QgISVWkkva/l8emWQk23Cnn1sV7A
 CDBrRLyeI7uhOyxNeNqeFUtBUepsZMgXNskzc1p2ddMih14zt2P8HEKkHn+K4Be0KP6Nz8WQ
 CIThsXS+E7j0VFiKXSAw8T4UG+cy41vfYrfACte1yQj4sRNEKrR4qZDmH4/h1Oirh/KJ9V5k
 C0cz/QG93MQxe0E8llIrG3VEvUJEE9UMDa53TGB9dOjt+N6YGi1cL6//FVzl5atAfvRx2MUE
 Ga8cZAkEyhq68x5O1+Zy3z/5Lbvf9zIZM4SvBmZwF/QyvJYI5Urmr8WlDJqbCjj6GY9xbdx3
 nkMldmq+ZKKIGJ38OelDw5EY3frMtgL9GiljL4CzJzPhcb1RMonQ29VGsKyHbXyTVdw/bzmL
 1rcSmRm7C3BRvyGQEnHrx0753PXT8LxbivRfiNGi4w9AkHafhMXgRhIDm9jwdhmTEbzlZanK
 hspoWpAgzyw4hpUlrA4bV+mDDqZ/Vr5LG9zEsbXLQIKvFsbuAGKa4rEtr01R2YCodWgtFDfc
 DXEIVsSSzhYAAraWxe5YNzMrZHB67TKVrD4dqWTJ+/U+KoHDK/AxIrzgNs8uW/Sa4PVZSEkV
 adzn0NHWToR993xvTIJRmRXkivMa5XevxKg4mhsqdj59v33WQXp7I/JCr1IMNwp9QrkyaGEf
 /Wdgip0M1M6ntsF2GPIxb4D3VUTlzAmdj+jFq4FvDLMS6SYk7FeDhoSYSd+fMVS6Kd00g5IM
 M/dwtT7s9wwxuYyEEtAXEf9l9uBYMsXPyeiOVmBCEvKfLWKKDvXwt3mNKOxTboD6Ycc/xa0u
 DudDwriJmHZzmOvDUrwd7gRyn3IWX4W8JuweRtsF2X5GdfvaxngdcRykSVz2roswHXDKW8bN
 zF4NUJLtLyZqy1C0ZAdUyRM6GRoKe6clmOX9e7df9wzuOFoHz8yuuZU+nU8xJNK4SsCSPE/y
 06w5pZ+5kqrlOWC0G8tSB1VtjNCn56Gp21nPrjFsIZNUzDI8VheiAfYQwRPrNxjBNr1vqlWw
 dWaj6P/JgBJ9NfM9NcdDczZQCpmGH8mLAavBzPeSgcIH2bD3Y73mEFX1v2fpCT9Rn0StZXm3
 pYDGOczaQ==
IronPort-Data: A9a23:lamdyKBjx05oWRVW/13lw5YqxClBgxIJ4kV8jS/XYbTApGhzgWRWx
 mAaXzqBP/3bMWD3c49xOdmx8kgG7cXTzoVmOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yE6jMlkf5KkYAL+EnkZqTRMFWFw0XqPp8Zj2tQy2YThWFvU0
 T/Pi5S31GGNi2Yc3l08sPrrRCNH5JwebxtF1rCWTakjUG72zxH5PrpHTU2CByeQrr1vIwKPb
 72rIIdVUY/u10xF5tuNyt4Xe6CRK1LYFVDmZnF+A8BOjvXez8A/+v5TCRYSVatYoxCnhfBBw
 /FOiYSTY18NPer0oaNeeDANRkmSPYUekFPGCX24rNDV0EDMNXfhqxlsJBtvZ8tCoLkxWDwIq
 ZT0KxhVBvyHr8e/2rGmUa9Bgso5Lc/kFJwSsDdswFk1CN5/GcyaGv6bvre02h9qtuBpB+T7X
 vMfcAgschHKZhsMFFAIXcdWcOCA3ySjLWQB9jp5v5Ef52HMxQh1+KrsNdDPc5qLQ99UlwCWv
 Aru9GPyCRAyL82a0TPD83S2h+aJkzmTZW4JPLi/6+Isn1CZgGAeYPELabelidyXkG6OUPZcF
 1Q30HIKru8KzQvoZfCoCnVUv0W4lhIbXtNRFcgz5weM1rfY7m6lO4QUctJSQIF/7p5nHlTGw
 nfYw4KwXVSDpZXPESr1y1uCkd+lEQQ4RVLuiAcBShYZpcbuqsc/g3ojr+qP8obl0bUZ+hmpn
 VhmSRTSYZ1N16bnMI3lpDj6b8qE/MShc+LMzly/spiZxg14fpW5QIej9ELW6/1NRK7AEAXR7
 SJYwZDGt7xfZX1oqMBraLpddF1Oz6nUWAAwfXY0QvHNChzwpy/9Jto4DM9WfhszbpxslcDVj
 L/74F4NusYKYhNGnIcuLdv5CsI2wLLmGMitX/+8Uza9SsgZSeNzxwk3PRT49zm1ziAEyPhjU
 b/GL5rEJStEWMxPkWvuL89AgORD7n1vlQv7G8qnpzz5iuD2TCDOFt843K6mNb1RAFWs+1mOr
 L6y9qKil31ibQEJSnKMrt5LdABTciBT6FKfg5U/S9Nv6zFOQAkJY8I9C5t4E2C8t6gKxOrO4
 F+nXUpUlAj2iXHdd1eVZ3olZL62BcRzqncyPCoNO1e02iF/MNj1s/pFL8M6Les96ehu7f9oV
 P1bKc+ONfR4TGiV8Toqa5Sg/pdpcw6mhF7VMif8OGo/cpdsShbn4NjhegezpiACAjDp59Qzq
 fus21qDE5YEQg1jCufQae6ulg/g4yJCxbgqB0aRe4tdYkTh9oRuOhfdtP5vLpFeMwjHyxuby
 x2SX0USq97NlIlpotPHsqaJ8tWyGOxkE0sGRGTW4OrkNSTe+Wb/k4ZMXPzRJGLYU37ovrqvb
 6NZwqikYvEAmV9Ltat6EqpqlP5vuYGw+uUClgk0Tm/Wa1mLC697JifU18d4tppLmu1TtzywV
 x/d4dJdI7iIZJjoHQJDPgYjdejfh/gYliOLtKYwJ1jmojB69vyLXBwKbRWLjSVcKppzMZ8km
 Ltw5pRJtlbn0hd6YMybii109niXKiJSWasQtqYcXN3hhD0txwwQepfbECL3vMqCZtgk3pPG+
 dNIaHcuRoiwx3Yut1I2EmXRm/VQj9ICtXimCbPEy0uhwrL4aj0fhXW9MgjbiixKwx8B3+8b1
 q1DKRhuPavXl9t3rJErYo1vcj2twDWG90a3x1ZheKg1iaW3fjSlEVDR8tphMKzUH6yws9SbE
 HylJL7ZbAvX
IronPort-HdrOrdr: A9a23:pPAN66CQQCN7lcPlHemC55DYdb4zR+YMi2TDj3oBLiC8cqSj+P
 xG785rsyMc6QxhIk3I9urwW5VoLUmwyXcx2/h0AV7AZniahILLFvAB0WKK+VSJcEfDH6xmpM
 JdmsNFZuEYeGIbsS+M2miF+rgbrOVvu5rY/Ns2h00dNT2CRZsQlDtENg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="10411393"
X-MGA-submission: =?us-ascii?q?MDERS8R/xBBitj+Syp4F3FZ1+cabsZEEf8uwp8?=
 =?us-ascii?q?rptELjXD12b/h5bEcakteyM6Ciy0SXWw2E8SqyCvc/bu/0atBOlmTA0l?=
 =?us-ascii?q?baI7fL+x/nVD//hBoOhWVFyF1Cl0xK4sQMdCXfg4FBPwPhnKaZV63DHD?=
 =?us-ascii?q?rZR4P4BYOWVCagQvV/ROg2LA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 16:55:43 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1648997742;
	bh=48qxWrOJ0IuqbaJiYv+38pVDgJoUbn6sd0wK8eFDEns=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=qz4r07fp39ZWABBNhQ5/wwj/oxtNBQZ0QZmg2cNthc5ZP75WquhKwsZbBe6IORRGK
	 Ml0hdz680GFehL//vggLRnta5/MvSkPsVFoOvqQt7xBB2Y3CIlnS01QvK+tGSPiomv
	 G3ZQ/7/7I35kOcMHjd1wCdywfygy+s/yBtKRU5yM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.114.24]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlLA1-1oHTmq3QtB-00lKYU; Sun, 03
 Apr 2022 16:55:41 +0200
Message-ID: <9a8c392a-413b-afc0-16c5-a013e403372b@web.de>
Date: Sun, 3 Apr 2022 16:55:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
 <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
Cc: cocci@inria.fr, Eric Wheeler <cocci@lists.ewheeler.net>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cGdDyolJ+wFo1ZOTfxy6sC7iGG1qoDOFQdCQbjwvNGh1L2+IkPG
 m0pL1f9v2yLrYxOq7UaBfZ6xTN+g33DNyBbWUbNlzUJY9LNjaa0PbAnAmKOxnaG6Un8tL7/
 vdveSNhY1b8j7Ux7AUckdUNKrh965VZiR2YJ0PzoxOPZEOcubDJK8OU+c9ovguN7AHO0nkI
 c+MS8u7DTjyX8qkGUOGCg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tjFVYmkm1Gg=:kJxr5xxQ1HRNf53XQU1CV8
 h9srsB2230aseD6XqBuVfyzZbcSG3Z2l2llhiajzOz6x28floKCLsZ3TDgqy5V2m3t52mkT0T
 98nIPvrxcDkimiJupEDDu4yloVvOet8hLr8nwbh/Zb8o/ZeNGmyGxWmeAbE5OO2wqvsCjWoSS
 QHsvIN8BY5Gz4gjXHjXCPYSnIRiWFl4/nnAOL+UQd1R2mqVeKbKhSyOv66T55/dkGfoPFsGSQ
 pDP9LCV+td24S5oLNifCE8Wg+Cgi/n0v1l75E55t1WF54EJ8cZq7lsBaI1I/f7qUdeo0Y9gP6
 Psj26HJBpm0WsA494XsXX0yKr4Si0lnFrUj2IWMc/k6YFJ4xoMdl07f1rCjT3Pv5EreMKoZlr
 x/5euqKufLMpv71aBrh6qvq3Q/txhOkGtdsTxSIYYiMJfZSiQI0P9yP6rn6AOKiIHslkrN8F+
 NKwdHoz4OpyDduMwajcqSi5ojwcJ0UXtAoMEGb6sj8GNXuuybfvsq3bWAHT7JnSkVUodqs14m
 nZMX6LNRkmqtYiYnSGQHGw5eEMdoSc7sC/VZDm1c88UbUu4vmV28s7dx1c6MEvySZ1XVnX1Ia
 vi51eI7HRhX5Pej2oB2YQz8Ng78LnwR/zIXAhgCNWn53M5U4HKUJIqBpUSEaBcf6hpTfschmJ
 vwMtyyIwTc+YATmZFyTwNtL0WjGV/bPab4Sf1ov0MrFwjr2dOKRCTZQd+JWRDXqA6Dh2QVRVE
 x3FDJWf2cflKFKomqlEd/IG9OkRibstK1vaQKFwnZcd9QtSdELqLTOmWYfeS+Mpx9p8zoQgjU
 ABdXqy/i7dznGklfjoTrOnZxC3fy0m/uuvWS81ju3feoEZ9ZAOMNF/L+JmgAIUPpSv/pJKFzo
 FdYgB0u1PzK+0Np7Txh4oUjYi9qXQ+BLBg4f+BJMHKxklSa2dCX94RIGOgTaVOzcT17tZcS+X
 +QXqCvslwNXWlVOpZi8TnHhEzs2o6yKoQszipie4YrIvqdT/Fg3aR7Dit2E+xGiTs9VRVHbeM
 fVMMGoMz1Xb48UUOLA2V243mAF1cfAcDmb7laGdIshPx2npNo43Q8IC1wpdYF5TUJve+FwBCQ
 BLaTjFBK6IDSuE=
Subject: Re: [cocci] Completing documentation for SmPL scripting interfaces
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 348
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/9a8c392a-413b-afc0-16c5-a013e403372b%40web.de>

>> Also is there a reference for the `coccinelle.` and `cocci.` python cal=
ls
>> that seem to be available in a script:python section?
> There is Coccilib.3cocci, but that is for ocaml.
>
> My understanding is that there are reflective features in python that le=
t
> you find out what functions are available.  python/python_documentation.=
md
> in the source tree also has some information.  Or look at the code in
> python/coccilib.


Would you like to improve the documentation for these programming interfac=
es?
https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7=
a6f4465c286a2792354/python/python_documentation.md#fields-and-methods-expo=
sed-via-cocci-object
https://github.com/coccinelle/coccinelle/blob/31bf3aefce245e43cc58f6b6ff49=
fc9b8e9084ff/python/python_documentation.md#fields-and-methods-exposed-via=
-cocci-object


Should the method =E2=80=9Ccocci.make_expr()=E2=80=9D be explained also?

Regards,
Markus

