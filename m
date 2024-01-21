Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0769AC47422
	for <cocci@archiver.kernel.org>; Sun, 21 Jan 2024 10:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=gduU4WHg6+4L3c+PfP6pUJ5A81k38MWlD4SKbwqoFDI=;
  b=O6d8lF7R9z6osfagyH2sK7CkDR4iSxtiZWrS5sIa+QvmswIepmGRBmtC
   I2Ipwsq1buIGEMU7AQL65KNAzFI45uf3dga365yxTJ087TEi4IfgNXUjl
   kue2fmoG7Am+qdyB9bXlgILk8HSxdVtzEx+XEI23IdP8io3i1SKVgn5DJ
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147775668"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Jan 2024 11:41:12 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE034E0CD5; Sun, 21 Jan 2024 11:41:12 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 52100E0035
	for <cocci@sympa.inria.fr>; Sun, 21 Jan 2024 11:41:08 +0100 (CET)
IronPort-SDR: 65acf4bf_ZyGyu+ixJ+zHdX5hu29fJgFLLujYe+huWacJ/ZGiPYP4InH
 nsa0fA23GTQcWyntUiTFnte67wb45oks97+QQGg==
X-IPAS-Result: =?us-ascii?q?A0FXAAAe86xl/wwR49RaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YI4B3hTMgQLSIRTkTYwhDuHNodOhGuEBIFWgX4PAQMBDUEBAgQBAQSFAgKHR?=
 =?us-ascii?q?gIeBwEEMQgOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGCAuFL?=
 =?us-ascii?q?z0NglwBgjksgQkBBAEjHQEBESYBBAsLGgIfBwICVgYBFAEBgnyCKwEDDiMHt?=
 =?us-ascii?q?AaBMoEBggoBAQavWR8sIlaBYQmBGi4BiBsBhWeEOycPgVVEgTyDAz6EQ4Nbg?=
 =?us-ascii?q?kYigRt/g0ORUlR/HQOBBQRcDxsQHjcREAUODQMIbh0CMTwDBQMEMgoSDAshB?=
 =?us-ascii?q?VUDQwZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDEkkCEBQDOAMDBgMKMTBVQQxQA?=
 =?us-ascii?q?2gfMgk8DwwaAhsbDScjAixAAxESAhYDJBYENBEJCyYDKgY3AhIMBgYJXSYHD?=
 =?us-ascii?q?wkEJQMIBAMrKQMjdBEDBAoDFAcLB3iCEIFCAxkrHUACAQttPTUGAwsbBj0Cm?=
 =?us-ascii?q?R8GyRM0B4I0gWCBYQyfLwYTL4NukzkOBpJZLoUFglAWkDsgqE2BZAE7gVkzG?=
 =?us-ascii?q?iSDNlILDg+OIDiDc49HQDU7AgcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23:It2aeR/ffTlYUf9uWTm2ngc9DxPPW53KNwIYoqAql6hJOvz6uci4b
 AqFtakm1QCBdL6YwswHotKViZyoYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5Z7ebx9WiDe+br5+I
 wi6oAfMvcQKnIVuLbo8xRTOrnZUYepawn9mK0yOlBjm/Mew+5Bj8yVUu/0/8sNLTLv3caclQ
 7FGFToqK2866tHluhnFVguP+2ATUn4KnRpSAgjK9w/1U5HsuSbnrOV92S2aPcrrTbAoXDmp8
 qlmRAP0hCoBKjU063/chNBug61HoRKhvx1/zJDSYIGJL/p1Y6fRccoHSWZdQspdUipMCZ6+Y
 YQSFeoMJeVWoYfyqFQAsBWwGwesCf3vxDBKmnD40rY30/g4EQzcwAAsA8wCvXbSod7oNKkSS
 +e1zKzQwDvEdfxWwzT96JXTchs8rv+MWbxwcdDQyUkpGAPOk1Kdp4v/MDOP1eQNrnOb4/BvW
 +KrhW4nsQBxoj6gxso3hIjGmJkaxkrZ+ipn2Ys4I8CzR0Fnb9C+CpRQqz2aOJVsQsMkW2xlp
 Ts2x7kGtJOlYCUHxpcqygDdZvGEbYSG7Q7vWumNLTtlmX9rdrCyiwqy/EWuyODyWdW43EpXo
 yZYnNfBtW4A2hrO4caEUvtw5lmt1SuR2wzJ9O1IP0I5mbDGJ5Mj2LI8i4QfvVzHEyL5gkn7g
 rKael8n9+Ws8ejqZrXrq5mBPIJqjgH+L78umtChDuQiLwYOXmma9vqk2bH/+0DyXa9Egecsk
 qbDtZDXPcQbqbC9Aw9Syosj7hG/Dyq60NgCk3gIMklKdAiagIf3I13OIfb4Aumjg1m0jjtn2
 u7KMqf/DpnTLHXPiqrtcLRn50JB1gY/1dVf6IhVCrEFLvLzQEjxtNnAAxE+KQO02eXnCMhm1
 o8EVmyPBqGZMLnTsV+O6eIiOOeNa5EOtzrnNvcq+ebijXkillAFZ6mmwYMXaGykHvRhO0iVf
 2Lggs0dHmcSogo+UOvqhUWGUTFJaXe9RaY85jUgBYOnDIfDQ5uigKab0yuhH51WYHpGClGWH
 nvyeYWEQe8AaDiOLc95jjwESb+hRpc92hGpqAD117tnI/HP+iwYsJLjzMJ66/fSlRE07zx0D
 t6S33uDT2FuzSs0QGoS3ehNoU1/y16Fmfx8gu5YFN5S7vVhXBo4NILH0qpxDNWkHkrjY9OIQ
 R6CS8qvBTV5GtAsx94HJUJ0BNymijjC2TCrCvkbjerPTJcz+and93n3Pcd0jXjch4c7iFxzZ
 8JVNnC9zoN7+RLSAYGBx2CQjaW3buIx2CDX9WGM5XWDtgdUXVgjAu3+QXkDax6O/pzC7UTYQ
 urrUOx/WuMg4cuLK68QL8bskU0DXvDoftLXf2O2nW60QxeO3LKFKoTwKC0GxCuILk8CnkgI+
 GqecxAkD3KEqnjdEScoOFbheULq/sFhpXn9QkJnhxqSYRhZ3qGusgUQmeTaTvoS2rwevyJ0j
 jxuH0ummf/SBcCBoQVJY6hWJ98wsx9czWyMkQt7M9S7Krx6wF4TdwMip0T1yxB+EZlNi+Avq
 242ihV/I+SU3Tutbhu+2pb9cv3SI2j2plW0brLOn0vZ25CQ87sO7/IxrxPiuhuoHwws6Scv1
 d4dyHaa6pjQaWhaGZvsTkY68QR7rLDGc2E84Y3Tz3hlLaiztHfLxdsoAOIvzhvocc1YNeuIE
 wr7EstSAMbLSqRivlGzbQ8fes1W+rQ1OcyOaPaMnqKmfa5hkD+gkWVb8dVlyEvfvyF4S+POw
 9ME26TCh1HBDW2jyg7+9JmtyuUmLXkIE2GyyDbpHttUb6x2J8MQDHu2ZtewzZN4joLsXHhR8
 BiiAUkH0YmnY0n3DRS10AtO2EAQuXHilzG/ymk+tjgzrbeEmgHKzf7jchUvJWNBAmVvxwSJQ
 8D8n5UBUU6kYhJ83j6s/0Xn3O52oKplLm/caVhFdW76IisxN8n4/qrHaMlJ5pQytCxRW+npe
 lGWRIn2pB4C2j/iFW9TrNwiXwmjoY6x3xlziWbHaW12sGKcY8Z7gxHW+N3bQ/dVmDsAXihxz
 zfNVBCwONyg/NPckJmm0Kj2cmu7VYBINwTvw5mBsiST+mBgRxGy1/y+gdzoFwEm3DSzjYAwE
 3+S81ClPc+yjeyzKqp/c1NtBUPg5sYfeMk2iYY2iJwKmDAbipiT4XsbgDL2ONRf17j5aSlFT
 joKztjJpQn9jRc6dDTTnd2/Dyrbm5EyArvyKnkb0S888c1QXaKd7bge2DBwvkL9twXaJ/50g
 jYaz/Iqrn8cmeAA/gQ3nUD/SvgfG1dVOSv0mlGG9de7+e9ybXysbKP2+U5wh9GnA5mdrwsaV
 HuzKfJAVWdgq95yNl7Byii5z4j+e8TLK/8XuAeVlRjokOVfbp483Klv52IvKSf2unsrzPQ+h
 Bpl0MShvYSJHG5q+bqwHh9SMjCmL9NW4DzmirxS29qHx436VIs0AS0FBdG7KJDgWCJXr/nsM
 ByCVSExumvOU6SKBheRsQ9v/XfIDoztKHydYnUUhdwwQR6AOAlPjgcOQzwgktgmGwrsyMGEE
 g8x72IU4UPk7xFL1+RjOl/gX22ZqArgY2UxT4WDaRFN5BxG5AGMOMqSt6R4GCQ9nNXppV6IL
 XGHIg9TBmYTQgrdDlbvZ/+l4tyI5eGcAqDWw+LmR7KIpKQeUv6JwcjqyY5653OWMc7JOHB+D
 vo9004FXHZjGs2flS9dAyoQ3znAacKWvnLesmV+s9y//fL3WQnu+ZrHCr1cNs9q8gy3hqHLP
 vCZhSJwIzJVnp0WwnqAxL8a1V8UwyZgElvlWawHrjLIRbnMl7V/ChkGd2VsOcEO4699lghBN
 MjHi8/kg751ivlmbjUNHVflm8yveYkLOzTnbQmBXhzUcu3ZY2SRkKSVKeumRLZdjftZrUi1s
 DefSQr4Oyib0iPuXFapOP1NiyeSOFpfvpu8e1BjEzuGLpquZxulPdtwlTBzz6czgyaAEGcGM
 iVnNW5JoKeR6yxwnfh1XWBMpCkAT6HMi2OC4u/UJ4xD++NsGThxnvlG7W4SzrxI8GdbSfYzl
 CaY/bsM6xm21+KIzDRgSh9HrD1G0ZmKsUtVMqLc7pBcWHzA8XrlCE2PBh5Mq9Y3UrUHVIhPx
 9KJmK+hcV+qEvrR+tYAQdfZIoSLPSh5WSc=
IronPort-Data: A9a23:GtI8aqILWPW1hxcVFE+R/pQlxSXFcZb7ZxGr2PjKsXjdYENS3zFRm
 2ROUWGGafnZa2TwKYx+Ptng9kgA7Z/VmNRiSgUd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf4s9JIGjhMsf7b8Uk35KiaVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuKEq35qhvPE4MPZw/475uCkFrr
 cAkEWVYBvyDr7reLLOTT+5xmoI8IcOtMI53VnNIl2iDS6x8HtaaHOOTv7e03x9o7ixKNdPXf
 ckEcnxCaBraYhtAEkgaAtQykY9Eg1GmL2IH9w/L+/dfD2771Chgy6S1LsPpPYK2BupWj2u0r
 z3F4DGsav0dHJnFodafyVqoj/DGmSfTSoMXHqexsP9smlyagGIJYDUdUlCwoNGim0umUpReL
 VYV82wgt8APGFeDS97gQ1unrXTCshN0t8dsLtDWITqlksL8izt1zEBdJtLsQIVOWBMeLdDr6
 rOIoz8tLTloraHTVn+XsLuZxd931e75MkdaDRLojyNcizUgnG33pg3CRJBvHcZZS/XrTCroz
 WniQDcW3t0uYA1i60l/1U/KiXSgq/Ali+LzChr/BgqY0++yWGJpi0FEJ7QWATas4bt1lmW8g
 UU=
IronPort-HdrOrdr: A9a23:T518aKvyrpMBSXpguh7OH6GZ7skDotV00zEX/kB9WHVpmwKj5q
 STdYcgpHrJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDpHZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: =?us-ascii?q?9a23=3Ay6w/IGj5+sCdAH2Fz/5piuPgJjJuKUyG6SrRE0C?=
 =?us-ascii?q?CCXdOUeWMQn+1oJ9Yqp87?=
X-Talos-MUID: 9a23:DQSPgQbWV9EQLOBTrxv9ny06Kt5UpPqSS28OgLgqspaHKnkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,209,1701126000"; 
   d="scan'208";a="147775665"
X-MGA-submission: =?us-ascii?q?MDFAW+lLZEBctb1+4OwECGh3jE7PbPm6UFHGjU?=
 =?us-ascii?q?lR5VJJJCpoj/SZp5n6I4tfeOKxCddpXUBJIuq4IXY1py6zLBXCPuCm7V?=
 =?us-ascii?q?IOJOarogEPjKTogP9Utmq3i9P88MR9z8RwiKosQOzEVZtTUoCUY5z+M5?=
 =?us-ascii?q?QuwJK8HC67Nl8GQ2TA8Wqzhg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2024 11:41:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1705833651; x=1706438451; i=markus.elfring@web.de;
	bh=w7b+a0Dnlw4BjB3AmtaNqEWe+09AYCF0MSwPgQLh0d0=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:
	 In-Reply-To;
	b=MbXlPg4Faw4MVtza2E5DmDi6EWAy8JYqFi3e2IO7BTaO/aQzp6f9zK8g/7LBcWPO
	 79RNNqsYsUABXoCPZ3Os4X1jeytNpuJnF+T0XVDr3mg065W/BwGTlTeMk9Rv8OJh2
	 s+Geq5RzSE8RLzF1q0+DDYRplVaPzeJQ227qMqTm+quYH2zD8c9yDalMUsyPH8zLG
	 daaNsvEW1vKAb+3Poi5IcaW7YwFK2WqgGkHwppIet0lg10HusqcrJx2r6GQk+kArc
	 Ib2mpQCwBoymJd92dREn9pKVPbf91gTzzmo2FdZzmsGbQCO5Ew2rSoMItMW/gIKiC
	 caew2rI0EQWyXoKm6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.89.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1rLPdh0vcY-00G62Z; Sun, 21
 Jan 2024 11:40:51 +0100
Message-ID: <f34231dc-186b-4cb9-889b-b3be9224c5a9@web.de>
Date: Sun, 21 Jan 2024 11:40:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Li Zhijian <lizhijian@fujitsu.com>, Julia Lawall <julia.lawall@inria.fr>,
 cocci@inria.fr
References: <20240119062057.4026888-1-lizhijian@fujitsu.com>
 <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, Nicolas Palix <nicolas.palix@imag.fr>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2401202217550.3267@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ry3PyjnlazkKSo/ejkzYISZWX/Ft/sTBSyzwE1f1GeXMS3evifg
 6BOVJUj8a78gxC4QTXsy1uYEESwTQGE46OSDkw3mjkIDkZw1I8aFPBhX8ux9iHg+DichN8T
 Ajf3/pXPaFYGgd0NKFpEsOX0x0uXBYA8xpK0a+9twLqrS0peRtZXp/nHHaV6BiOF2IFYNT+
 71JlLKQ3wIOjZW9Ljw+bQ==
UI-OutboundReport: notjunk:1;M01:P0:bU3/X9sYAlk=;3TzMoTjOmm9Ht2Gzr0Y7CGjADcL
 wjdfq6WqCf9fsCc04/UojySzq53tJZsOmSVd0WhV1jwfWa0XxhPtZ3P+iwM5MkaKzq1u6v7Sn
 aYkXQJSkGYQrkg8if5/DfW3R21i+AePwxSuDfkoyRb8Qu3OCD3iTPUaNWZamDjGvZxhtqgMNX
 zKYIfR5Yy8uTEC3ELZeIkBsOomJd0lVHlCSwqstP9P2a9bgm1B3GsjOco6SlGMd6fFLGF5OEp
 Cz+DcGpyJXwpnubYkw8B+WRke7KSFCEU5yC9moChdC+jegHB+tG9mbgaStabdaG6wPMvYK1LH
 z+GJez1L5B8DQnscTg6ZFCjMjDYyPB1QzpGJ7sZ8h4B0NdL0QqfNOihYTG51CCBFF7jEt3ESu
 CsK5Dw8SDgB2DVHx29w5ZjhyQ6KUVff/WLro/g/RfUbQS66UGC/AUdGfSXOnBxQrnnUc4LfmI
 Xz1rB8ZDoajfCB7QBofkXBr/jfZehDUuodVWaFKu1QIWnU7Rc4aRw3DOy0n8w1wcHpPp5yW87
 JeuZKtDZOpQLUZNlx19VQ1srcsAYw491+74pVUPBATlBUhQue+j4Y7N6SzzQE4+NhAXqKREH1
 0Th6lM6IGHmH+7NgRz5G4nZWrqOlunAZBhgJ44iK8p82Y2Ii4Cjicj+NSJplBVoXdNHiTULVs
 odCrn0hkCIBcXjTyNIyL/w7CoRkVgT4gDmclDfxk5donrEy6PimQS2fRPxmFlZ5blVpX/HE+z
 mKcU5tK54ltNWO3zQ2N6s14Xly0canaznztiMakBBzD3+CmQP1eL4NqhLO0OvuZz5xxSPWFpd
 12Uh7up2YWjti+2kIg7HmAel5uVyEaqNvRc88mIjIStJZ4DstbmEpC24Wl/focrDDLhdxzpAk
 FXZ4Z/bA/7e1WKjJLiBbj1HW0va7bnwWhT9mJCRfBYpWTNllw8yTzdnxgJ+fRwr61c8Gh5L6g
 cZ2wfQ==
Subject: Re: [cocci] [v2] coccinelle: device_attr_show: Adapt to the latest
 Documentation/filesystems/sysfs.rst
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1460
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/f34231dc-186b-4cb9-889b-b3be9224c5a9%40web.de>

> I subsequently simplified the patch case to contain the following:
>
> -              snprintf(BUF, SZ, FORMAT
> +              sysfs_emit(BUF, FORMAT
>                                ,...);
>
> This also works for the case where there are only three arguments.
> It has the benefit that the change is recognized as a line replacement, =
so
> no extra {} are added when the call is in an if branch.

Would you like to consider the application of the following SmPL code vari=
ant?

-snprintf
+sysfs_emit
         (BUF,
-         SZ,
          FORMAT,
          ...
         );

Regards,
Markus
