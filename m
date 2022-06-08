Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E54B5C43334
	for <cocci@archiver.kernel.org>; Wed,  8 Jun 2022 17:45:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7Kv/iiGq04j2ueKSFrnbij8ebnRJ7IhZI/I2x7EdwbM=;
  b=stdillbSVHqROa/E+e8bz2y8AojdIVe/zI2rZ5dpXpm7TNKbbyGa27FA
   SF/KFa+lpoIc8wzjBewf8U//53afPu0qSC/c940rT2RMlTI/9WLHXKWxU
   TnxhxIw/mqIpf3nyfmBnWzRwFgUccE+cPW1fJC9t0BBBsebY7FtzbRpGA
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="40093212"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Jun 2022 19:45:22 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 52346E02DC; Wed,  8 Jun 2022 19:45:22 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 75E24E00A1
	for <cocci@sympa.inria.fr>; Wed,  8 Jun 2022 19:45:18 +0200 (CEST)
IronPort-SDR: ppuhfG9+eGOYgTtypd5pBahNR1vcIsUFkq96kQ1Ea/J0wkp0mdE6PYAudBTyb9kIgglcPjVxeg
 wq46szF3yotuSHZuewxV0HmB8XSUjaXnNewnIicpmjPvdksIc7MvJv7i4Nm8lkhoSqwuK+/1NH
 brbGEQrrF4E/Jk2vL8h32UyYxOKt/T4f5vE7WIfL0p6MUzih8epiPFf/u8uLQ/TPMTnn+UhzKk
 UcUjcu+e9jTkHwerxziLpCQoIw2zFjlNsIC4B+VOXuBYazsuaK2hXUjDQxfDJymUdK6mMyN6Ss
 zMWVPgX5nAiGDg+3fGc+w/Uu
X-IPAS-Result: =?us-ascii?q?A0BSAACx3qBihw4P49RaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4IkgVcuBAtEhE6OaYIohCGHCYcbijaBaAsBAwENPwECBAEBgg6Ca?=
 =?us-ascii?q?goChUYCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBA?=
 =?us-ascii?q?QwNCQUICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLG?=
 =?us-ascii?q?gIRFQICVwYBDAgBAYJ5gmUBAw0jB60XgTGBAYIIAQEGhEofLCJSgVwJgREsj?=
 =?us-ascii?q?W96JxCBVUSBPIJTMD6BD4JuRz+DF4JljS2KTCcEDwMaLTQSgSFxAQgGAwMHC?=
 =?us-ascii?q?gUyBgIMGBQEAhMSUx0CEgUHChwOFBwkGQwPAxIDEQEHAgsSCBUsCAMCAwgDA?=
 =?us-ascii?q?gMjCwIDFwkHCgMdCAocEhAUAgQTHgsIAxkfLAkCBA4DRQgLCgMRBAMTGAsWC?=
 =?us-ascii?q?BAEBgMJLw0oCwMFDw8BBgMGAgUFAQMgAxQDBScHAyEHCyYNDQQcBx0DAwUmA?=
 =?us-ascii?q?wICGwcCAgMCBhcGAgJvCiYNCAQIBBwdJBAFAgcxBQQvAh4EBQYRCQIWAgYEB?=
 =?us-ascii?q?QIEBBYCAhIIAggnGwcWGR0ZAQU2JwYLCSEcCh8LBgUGFgMjcQUKPg8pNTY8F?=
 =?us-ascii?q?hwhFAYiARsCmFwBa7Iukk80B4IUgT2BRAyeLQYTLZZRDgaRAXWWaRkHpxOBe?=
 =?us-ascii?q?IF+MxokgzdOAQIBAg0BAgIDAQIBAgkBAQKOHRmEDIotPzQ7AgYBCgEBAwmFR?=
 =?us-ascii?q?wEBiTsBAQ?=
IronPort-PHdr: A9a23:J+zNZRz9JAYz1qPXCzIlwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 heZvK0yxwaQBc3y0LFts6LuqafuWGgNs96qkUspV9hybSIDktgchAc6AcSIWgXRJf/uaDEmT
 owZDAc2t360PlJIF8ngelbcvmO97SIIGhX4KAF5Ovn5FpTdgsip2e2+4YDfbxlKiTayfL9+M
 Qm6phjNu8cLhodvNrw/wQbTrHtSfORWy2JoJVaNkBv5+8y94p1t/TlOtvw478JPXrn0cKo+T
 bxDETQpKHs169HxtRnCVgSA+H0RWXgLnxVSAgjF6Bb6Xortsib/q+Fw1jWWMdHwQLspQjmp8
 btlRwH0hycGLz458X/YispsjKJAvRmtowVzz5PIbI2JMfZzeL7Wc9EHSmpbRstfVCJPDYyyY
 IUSEeQMI+hYoYn/qFQSohWzHhWsBPr1xzNUmnP706833uI8Gg/GxgwgGNcOvWzTotrvLqcSU
 v21zLLVxjvMa/NW1y396InOchAuvPqBWrV+ftDLyUksCgPFlU+cp4PhPzObzOQNsm6b7+V7W
 OOhlWEosBt9rSWxyco1jITCm40axEze+ypj3IY1OcO3SFR9YdO8HpVeuSCXOpZyT84sTG9lp
 CU3x70It5KnfiUHy5UqyhDDZ/GIc4WF/A/uWfuPLTp5h39oe66yiheu/UWh1OHxWM+520tJo
 CpditTAqG0B2wLJ5sSZVPdw/F2t1SuP2gzJ9+1JLlg4mbTBJ5I/zbM9mYAfvVnHEyPrgkn6k
 aybelgi9+O18eroeK/mqYWZN4JsigHxLKAumsunDOQ9NQgOQnSb9f6y1bL95kL1WqhFgeMun
 qnYtpDVO9gbq7anDwNIzIov8QizAymk3dgCgHUKLEhJdA+IgoTxPlHBOvH4DfOxg1S2lzdrw
 ujLMLr7DZXXLXjDjazhcaxy5U5Yxgoz19Ff55RbCrwaLvP8RFT+uMbFARAnKwC0xf3oB81n1
 owCQWKPHrOZMKTKvFOW/u4vOfWDZJcJuDbhLPgo//rugmU3mFAHeamp2YAaaXG5HvRjOEqZe
 2Djjs0AEWcMpAo+TfblhEeMUT5Jf3qyRb4z5iknCIK6CofOXpyigLud0yinH51bfXtGC1CJE
 XfwbYqIQfYMaCSIIs9giDMIT7ahS5VynS2p4S3nz7tuZs7d5SQcsdq31sVx5uSVkRgt/DhwJ
 8WbyWCECW9uyCdAZb4sXaVulmhwxF6ey6Uw1/5VD9FW9rVNXwkzKITR5+p3F9nuXwWHddCMH
 gWIWNKjVBQ4VNEs2JcjZ0hnGtOtxkTm1jCpHqRTuriFHp0y/YrD0nK3K8srmCWO77Uok1RzG
 pgHDmahnKMqslGLX+Yh8m2cnqeuL+EH2TLVsX2ExiyItV1ZVwh5VePEW2oebw3Yt4ex/VvMG
 pmpD7lvKQ5d0YiaMKIfT9TzjkhdAtrnNs7fZW2ZhGq6QxqFlfuXdIS/Q2wGx23GDVQc1QUa/
 HKILw87UwKouWHDF3pDEVz1YkXj2fZzojW3Qxx81BmEOmtm0bf94RsJnbqcRvcUi6oDozsko
 i5oEUyV2tXLF5yfqgAncKg0jcoVxlBB2CqZsgV8OsblNKV+nhsEdA8xuUry1hJxA4EGkM4wr
 XpswhAgYaSfmEhMcT+Vx/WScvXeN3Xy8RazaqXXxkCW0dCY/b0K4eg5rFOrtR+gF04r+XFqm
 9dP1H7U6pLPBQsUGZX/NyR/vz1zvbLHeW8Q443O1HtjGba5uHnO1pNhBecozAqhY8YKKLmNR
 0f5F8wXAdTrKfR/wQHzKEheY6YLqehtY5DDFbPOwqOgMed+kSjziG1G5No4yUeQ729mTeWO2
 Z8Zwvae1w/BVjHmjV7nvNqk/OIMLTwUAGe7zjDpQYBLYagnN6MCE2SzOIuawttkhpjic2FV/
 hivChlVva3hMQrXdFH70QBKgA4yqGakhDD+4jh6iTAvoYKA0SaIz+moJ39lciZbAWJli1nrO
 429idsXCVOpYwYenxyg/U/mxqJfqcyTNkHrSFxTN2jzJmBmCO6rs6aaJtRI49UuuDlWV+K1Z
 RabTKT8ql0UyXGrE2xbzTE9Pzak3/ex1zlzkmGANzBeqHTDeMd/7QjS7prQSLZd0yEHSy9xl
 TTMTgLlZZ/zp4rSzsqF67z2XnnpTpBJdCj30Y6M0UnzrXZnBxGyhbH7m9HqFxQ7zT6u0tBrU
 SvSqxOvKoLv1qm8LadmZhwyXQW6sZAlXNgj1NJs1/RykTAAi56Y/GQKizL2ONRfg+flaWYVA
 CQMyJjT6RTk30tqKjSIwZj4XzOT2JgEBZHyb2UI1yY6980PBr2T6ekOuCJvoUej6y/Vb+J8m
 Dg11vYkrnIXybJs2kJl3mCGD7YeEFMNdwnljReV9JaTqKtNZWCgWae93gxykJryadPK6hEZU
 3H/dJA4GCZ25cgqK1PA3kr47YT8ccXRZ9Ye5VWE1g3NhO9PJNcth+IH0GB5bHnlsyRvmItZx
 VR+mIu3t4+dJyBx8bKlV1RGYybtaZpb+ymx3/wHxIDMhd/pR88/XGxRDNyyEJfKWHoTrai1b
 V/UVmdm9THCRPyHWlXCoEZ+8yCVSsrtbSvIYiBGi40lHkbVJVQD0lpNA3NlxNhgR1rsnpCxN
 x0og1JZrl/g9kkckKQxaUS5CzqO4l/vMGl8SYDDfkAPsUcdvQGPaZPYtqUpQGlZ5sHz9lXSb
 DPBIV0ZVydXBgveWTWBdvGv/YWSo7LeX7TjaaGUMPPX8rQWVu/Ul8L1lNI4onDWbZ3JZCMqS
 vQ/3gArsWlRPcPfln1PTiUWk3iIdMuHvFKm/SYxqMmj8fPtUQap5I2VCrIUP889sxaxybyOM
 eKdnkMbYX5Ry48MyHnUybMewE9aiidgcCOoGKgBsiiFRbzZm6teBRoWIy1pM84A46U51whLc
 cnV77G9nqZ/leIwAkxZWEbJn8a0eYoVLmv7OF6GTEeHObKaJCHalsH6ZaTvLN8YxO5QthC2p
 XOaCxq5Z27FzWO2EUnyd7gQ30T5dFREtYqwcwhgEz3mRdPiMFigNcNvyCcxyvsyj2/LMmgVN
 X59dVlMp/ue93A94L03Fmpf435iNeTBlTye6rySD58MsuZwRAlwmfhb5nsS1LZfqi1JDq8Q+
 mOavpt1rleqn/PagCJgSwZLoy1XiZijuEJ/JePG+5MGVXuOr3dvpS2ATh8NodViENjmvatdn
 8POmKzEIzBH69vI/MEYCqA8x+qYPXBnPRe7QVY87SMASiO3c37SjQpRnaPKnpVwhoc3oN7gl
 chWIoI=
IronPort-Data: A9a23:3NPMT6MKqYP+cqzvrR2+kcFynXyQoLVcMsEvi/4bfWQNrUpx0DAAn
 2VLUGmGOPfeZmbyf4hyPork8U0EvJTTy9NrT3M5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EsLd9IR2NYy24DnW1PV4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB3UuvBaz
 81QqqftVCIUObXRttstUzhxRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgTs
 6VEQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacybG/SRv4cJtNs2rs4WM8THQ
 ZU+UxM1Shf8eF5mGwsxA7tryY9EgVGmLmEG8QvLzUYt2EDXxRN41LzFItvQcMaDA8RThEeR4
 Gzcl0zyBRoRNfSE2D+d+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeR12uecNVHN
 lMvpzcLkK8q6WKUftncdkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblQ5oi59hM8O6J5uHWdxv
 rOdt4O1X2Mz2FGAYS/Frt+pQSWO1T89AUJqicUsbgIf58L5vYE+5v4kZok9SfXq5jEZMRv5z
 z2M6ReVU68PkcMO3aih8jj6b9+Eo5/UUkgq6w+RUm/NAuJFiGyNOdfABbvztKcowGOlor+p4
 iFsdy+2srlmMH11vHbRKNjh5Znwjxp/DBXSgER0A74q/Cm39niocOh4uW8jeBkzbJheJmC4O
 Sc/XD+9ArcMbRNGiocoMuqM5zgCkfKI+SnNC6yFMIEUCnSPXFXcongwDaJv44wduBFxzf9mY
 MnznTeEVDhDQaVh0DesQeoBmbYkrh3SNkuDLa0XOy+PiOLEDFbMEeltGALXMogRsf3YyC2Ir
 Yc3H5bbk313DbylCgGKoN57BQ5QcRATW8usw+QJLbHrH+aTMDp8YxMn6eh9INMNcmU8vrugw
 0xRrWcDlgGi1SWZcljVAp2hAZu2NatCQbsAFXREFT6VN7ILOO5DNY8TKMk6e6cJ7utmwaImR
 vUJYZvSHflFDDjKomxPYZ74pY1kVRKqmQPXY3v7OmdiJcY4Slyb4MLgcyvu6DIKUHi9u/w+l
 Lv8hAnVdpwOGlZ5B8HMZfPzlF685CBPmO97U0bSDMNUfUHgrNpjJyDr0K0oLstKJRianmmW0
 AOfABE5o+jRotZpoYeT2v3e99+kSrIsEFBbEm/X6aeNGRPbpmfzk5VdVOuofCzGUD2m8quVZ
 dJTk6P2PsoBkQsYqIF7Cbtqkfkz6taz9b9XygNoQCfCY1ixU+oyJ36bwY9Qu6cLyrIA4Vm6X
 UeG+997P7SVOZq5QQBLe1d/NryOhaMOhz3fzfUpO0GktiV5y7qwVxkANRe7jiEAfqB+N5kow
 Lt6tcNKuRazjAEmboSPgixOrj3eK3sdT+M4u5tcDIKy0lgnzVRLYJr9DC7q4cjTOosWbRRwe
 meZ1PjYmrBR5kveaH5tR3LD6upqg8hcsh59ylJfdU+CncDIh6Ns0RBcmdjtot+5EvmaPyNP1
 mlX24ldIKKT43F3icIFU23E98StwvGG0hSZ9rfLvDSxo4qUuqjlM2A3f+qAlKzc23wJZSBVp
 dl01068OQsHv6jNMu8aRkNv7fDuJTC0Gssuh+j/d/m481IGjfYJT0Ngiafka/cqPC/puHD6m
 A==
IronPort-HdrOrdr: A9a23:j5rvW6O/iuQ8M8BcTuWjsMiBIKoaSvp037Dk7TEVdfUnSL36qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQFhrX5eI3SOjUO21HHEGgB1+ffKlTbckWSygce79
 YFT0EUMr3N5DZB/KTHCUWDcurJ27O8gduVbArlvg1QpTgBUdAc0+/zZzzwLnFL
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="40093209"
X-MGA-submission: =?us-ascii?q?MDHr0Z9IRkct0vy7VQzzvzZ0qf3E7KcLidvYqO?=
 =?us-ascii?q?jRiZeNE8cMQUP/xi+qvJZ4yIFbH45g3Api+u37RzgNTEsw+LHivmMHOl?=
 =?us-ascii?q?Y7UOssp9AdVq9Fb9wUIPrryyIIk22x0n7Igftbw8qXLuG/8g2ZFiH1Lj?=
 =?us-ascii?q?J9jmcO0+6EcgOabN00wmVvDw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 19:45:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654710315;
	bh=7Kv/iiGq04j2ueKSFrnbij8ebnRJ7IhZI/I2x7EdwbM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=RheHSrmsgtTg8I11Tq4Lz84k+QodPdbF7A8Yups0kFDPrQoXynnxLr/y6JAy1i2oR
	 LP6z6svMrd1Q0QAmrdZVWrkLQdu7dT6uhwN6gEQVNEtZrSOkfmEC1Ws+GoK+yj8Kqb
	 C6nNkjW+mp9wb5USj086jjds2hfTq8Pra1KulKJU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.191.181]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MjxeO-1nJ2Cx2pGC-00kHcM; Wed, 08
 Jun 2022 19:45:15 +0200
Message-ID: <8089df70-99f5-270d-6ee5-c937ba37cf97@web.de>
Date: Wed, 8 Jun 2022 19:44:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>
Cc: cocci@inria.fr, kernel-janitors@vger.kernel.org,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB760365A0DE3A8522136471BE93A59@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <415ca02b-9618-b447-6471-6bcd0e2215e8@web.de>
 <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206072138160.2960@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mfjTLoI4fuOW+5zNNGpDuAEVFDfO1v7viLV2nXjTweKtC2necS5
 T+DLWoHd8Id1nKJaPNCBC9/PaFJNLGuAwTDhkVFYozP+vNdK9O6UTouEI3Tuj6MKd9K4OMr
 e8V0kKC/qPuCIK0I544pNU+9vApT6H4dkeDVIuKxVluVU44KjUyNcLN1HQgptgGwBa5e++i
 dz/Zc+lcUy2rap1KzQcIg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AHJgbnGbKw4=:7dLFwFCd3B5uA1PDQcjB+N
 e96MV+XulKRDRHD9eLDEqAGT27PreNl6O6i3n5Nt8sMd8n4MQCEJ3aUujPrUIESE8zE2rxWdX
 lXB7dBSNi4Dgd6MaEAT9wONBuBnNwu2ZKqYgVkbqsmZKoNMqzulJaLj903Bk6W/PCZO5Q8zlH
 ACINffTI6nKuwPHXXTuTRRoaeNMn9MPLw7rxI/CM+fhqS+C9ux1EmokjwTm71e53xaV9vH5SM
 HePR6gCCst2+YOyLeoLPFEC9gWdmPFkmUxYwpq5qLUFswI9PyMyZgEMtkHGOJ1nhUr4FPmxiu
 Wo0vXmb2RIfSchUQ1eyoSynekNSedK/hOj3yw3VGAKXVsvpfxVzhZ5aE0IvVo9JWrPZYzArkt
 2lfWugqyXAQWSfMwhB2SjMr2vDhlIUQ7bEIoVMXPSF3xnTQQ1cAgtODAi9x41snnTrIRu8Ini
 Hxof2sGUcYJ/zZ3MKUE0ziqeXPmWvUSi/KLjRO83qF0sxBS0ZK9hFOm0JenXNFp1kLzwbA5i5
 HUOxY0uMMH68l+EzC0lNVh9EwJOoI6RzmGQaO9aHIpM7EHk7l1FO6tG+Ze/WysXZbNvkwfMNl
 +RtGLQ/cYmgtA810XgkKa8ia2I+gY97oJva6/VaIex1gG1wpht7K1nEXLxiHhqSdUC9UR/AzO
 t7YbZu+ZuWfZyBHOy55D4oFyTBlmTYfddKCyQCOnHaOnpyNQ8E4jNdP+Uupld9BU4oa4K33yM
 uq4bacDedWoVbORPZWtdNwiIsuglreivMAl4yBzGMK/hjTC2Xgq8hommGf77zjamwoUcK19/o
 kUVSyWxq4qmh5c3PCiXXuGbUGDwJeYj3gY2BGWOGNR+nPHYD06rN0wDWQfNCQH7cFfYojBgUC
 b+DCgSaLU/sqy1ADz9eWxe8Dxs5g4xmq+llVBr2ECCVf8pCpRWdQTDZPmpaR5copkvx4EWmN+
 YIbCD32A/7rFy+o+ScAc77n0RoqLyjGYcwNQPXqc1l2aT/IZz2rlInceL5NE9JFhs76HEkk0S
 5s+c5lpCYYayOA1hnX6aCGOqPf981osivoP31JFM0arg+jQVOyClkB8RvpRl0oNuJm/jDbgDD
 zJ0+rnrhZaCXauYKMFgKmGAbV8CHuTy5HDqj2uyymzKPQ3w/P9ifcTSbw==
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 425
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/8089df70-99f5-270d-6ee5-c937ba37cf97%40web.de>

> Would you ever dare to adjust the specification another bit for such
> a source code search approach according to the difference in the selecti=
on
> of the operators =E2=80=9C||=E2=80=9D (disjunction) and =E2=80=9C&&=E2=
=80=9D (conjunction)?
> I don't really understand the above,


I proposed to take additional software design possibilities into account.


Is there a need to reconsider also the usage of the SmPL asterisk before
data processing for the operation modes =E2=80=9Corg=E2=80=9D and =E2=80=
=9Creport=E2=80=9D?


> but it made me realize that actually the following is sufficient:


I find this response nice.



> @@
> expression x;
> @@
>
> *&x || ...
>
> This forces &x to appear as a test expression.


Will such an use case become known better?



> There can be 0 or more occurrences of ||,


How do you call the transformation which supports the omission of
a trailing binary operator (according to the discussed combination
with a SmPL ellipsis)?



> so eg &x && y is also matched.


Will this conclusion influence any adjustments for the software documentat=
ion?

Regards,
Markus

