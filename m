Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E53C433EF
	for <cocci@archiver.kernel.org>; Thu, 30 Jun 2022 19:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=OGvE4e1SGrgLVuHvJIj+Z2ZBlKQGFwge8GOcN4KkJ0s=;
  b=CgcDKov5mOYAwGHo6egSg4iXcflBLdXasEwSQuV8PSmcovWJ2Z5WikJl
   0WWSDPAiUBsYgd7eiJKs/9HHEpmvkp+k/XlZBuvYQIx8/jWyAiUTST2Ae
   KSASCwOvRkyuuDMyL5omFJF3T9thDFLpwMlmtNGevZH7RSv0Fn/fz0NQg
   k=;
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
X-IronPort-AV: E=Sophos;i="5.92,235,1650924000"; 
   d="scan'208";a="43685845"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jun 2022 21:12:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id E6C26E0356; Thu, 30 Jun 2022 21:12:28 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 7B578E0092
	for <cocci@sympa.inria.fr>; Thu, 30 Jun 2022 21:12:23 +0200 (CEST)
IronPort-SDR: ALFOv6qRuszVjuIvUcyswHN8cQXvkE4c8w2E76V6bm/qWvgXYbzEW5rq0itR9/DanPlzmlQbZi
 BkEc+HIseCqoWY1Em8D33wdFDEgXMYyScyE4ncAtf/qrL5h+eopJBlkiXDJcOAVEKlU2c3JrI8
 5o/2/GmzaVECk+4zYuRTfDVVRVnKd6Y8bJml/xfUYwfXmQd/T+jPiIND7l2dkE88AQwQaTzr7o
 ksvlYbEH7ig93vrZqeTrC4GjkimSfnCrINUnwiS/5K1ZC8ssN9Y0gMdRk8Tqiw2MeaFmajP3v2
 aLCkHvuDwSiaPeuG/aXmSGYA
X-IPAS-Result: =?us-ascii?q?A0BNAABG9L1ihk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgQFWLgQLRIROjmiBdy4DhCOOKYwjCwEDAQ0yDQECBAEBghCCd?=
 =?us-ascii?q?AKFSwIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBA?=
 =?us-ascii?q?QwLCQcICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLG?=
 =?us-ascii?q?gImAgJXBgEMCAEBgnkBgmQBAw0jBwusU4ExgQGCCAEBBoRLHywiUoFcAwaBE?=
 =?us-ascii?q?SwBil2DJHonEIFVRIEVJ4MDPoEPgzWDVoJlmhQmBA8DGi0vEoEgbgEIBgMDB?=
 =?us-ascii?q?woFMAYCDBgUBAITEk0GHAISBQcKBhUOFBwSEhcMDwMSAxEBBwIJEggVKwgDA?=
 =?us-ascii?q?gMIAwIDIAsCAxYJBwoDHQgKHBIQFAIEER4LCAMZHiwJAgQOA0AICwoDEQQDE?=
 =?us-ascii?q?xgJFggQBAYDCC8NJwsDBQ8NAQYDBgIFBQEDIAMUAwUkBwMhDyYNDQQbBx0DA?=
 =?us-ascii?q?wUlAwICGwcCAgMCBhUGAgIYVi4NCAQIBBgfJA8FAgcvBQQvAh4EBQYRCAIWA?=
 =?us-ascii?q?gYEBQIEBBYCEAgCCCcXBxMYGxkBBTInEAkhFgYKHwoGBQYWAyFIJgUKOw8oN?=
 =?us-ascii?q?DY8LB8bCoEaLAkiFgMEBAMCBhoDAyICECkGMgMWBi0NBiMbApwjgQ8BExICB?=
 =?us-ascii?q?HEbD4EWkmeDBqsxNAeCFIE9gUQMiVGUYAYTLZZWDgaRei2VUXUgjRKaEYF3g?=
 =?us-ascii?q?X8zGiSDN04BAgECDQECAgMBAgECCQEBAlWNSBkeg26EYYVMPzQ7AgYBCgEBA?=
 =?us-ascii?q?wmFRwEBiTwBAQ?=
IronPort-PHdr: A9a23:hpS1vhZ/6Dvhk1h/cIEoUsv/LTGW2oqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1gSPBNiCoKsf06L/iOPJYSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pHNbQhEniexbLNvI
 Bm5sAncuNUaipZ+J6gszRfEvmFGcPlMy2NyIlKTkRf85sOu85Nm7i9dpfEv+dNeXKvjZ6g3Q
 qBWAzogM2Au+c3krgLDQheV5nsdSWoZjBxFCBXY4R7gX5fxtiz6tvdh2CSfIMb7Q6w4VSik4
 qx2UxLjljsJOCAl/2HWksxwjbxUoBS9pxxk3oXYZJiZOOdicq/BeN8XQ3dKUMRMWCxbGo6yb
 IUBAOUPMuhFsYfwuVUOoxu8CgawC+3i0SNIhmbs0KEmz+gsHwPL0Qo9FNwOqnTUq9D1Ob8VX
 ++v1qnIzijDb+hL0jny7IjIfAohofCKXbJ/bMHczk4hGBnfjlWTtIzlJCmZ2OsJs2iV9epgV
 OSvi2E8pgB/vDeg3d0ghZTXiY8MzF3P6Cp2zpovK9KiVE57fcCrEIFWtyyCKYd7X8wvTnxnt
 ism1LEKp522cDQIxZkjwxPSdfKJfpWG7x/nSuqcIDl2iG9qdb6hhxu8/lSsx+z8WMSpzVtHr
 SxImcTCuHAK0hzc8MmHSv1l80emwTaAyQbT6vpZIUAvi6XXMZkhwqQ/lpcVrE/NHTf2lV3og
 KOLdEgo4Oql5/r9brn7opKQKZV4hwP9P6g2nsGyD/40PhUAUmWV4+ix1r7u8VfnTLhFiPA9j
 7PXv4rAJcsBo660Gw9V3Zgn6xa4Fzqm1dMYnWQbLF5fdhOIkZPmN0vTL//mFfu/glKsnyl3x
 /3eILHtH5fAImLBnbv/Z7px9kpRxBQpwd1d5J9YErQBL+jyWk/1utzYFBg5MwmszujgEtp9z
 IAeWX+UAqODP63StVGI5vguI+mKa48Yozj8JOY+6PL0kHA2h0cRfa+y0pQPcnC3AuxmI1mFY
 XrrmtoND38GvhAiQ+zylF2CTTlTam6uUKI7+j40FIOmAJzYRoGthbyBxD20EodXZmBAEFCME
 G3ne5+KW/cWcC6SONNukiQYVbi9TI8szRWuuxX0yrV9KurU/jYVtJPi1Nhw/OLTjws9+SZ1D
 8SbyWGNTnt7knkGRz8sj+hDphk3+FaS2K53y8xFHNobp8xIVgM7PJudhaQuFNH2XgPIe5GZV
 V+gUNS3CDc+ZtIsysADYgB2HND0yljI2CGhApcUkaaKDdo66OaU3HXrIct5jnTP0qg9iEM9a
 tVAOHfghaNl8QXXQYnTnBa3jaGvIIEVxi3Q7y+uyWSUvUdXGFpVWL/GQGtZS0/Yt9X/6WvdQ
 rXoBblxYVgJ8tKLNqYfMo6htl5BXvq2fY2GOwpZ+k+1DBeMnfaXaZbyPn4axGPbAVQFlAYa+
 TCHMxI/D2GvuTGWFyRgQHToZU6k6uxisDWjVEZh6giQbFB6kZex9AQUg/O0VP4ZmL4J6286s
 zshJF+mxJrNDsaY4Q9ofaFSe9Q4tXJOz2HErEpQOpK6LqZtrkETeUJ7shCmzA15X6NHl8Vit
 3Y21ExyJKafhUtGbC+d1IvsN6f/L27v4FawZqSQ1ly2PM++3KAJ5bx4rlziuFrsDU8+6zB81
 MET1XKA55LMBQ5UUJTrU09x+QIo77fdKjIw4Y/ZzxgOeeG9ryPC1tQ1BeAk1gfoftFRN7mBH
 RPzFMtSDtanKegjkVykJhweO+Ua+KkxNsKgP/yIvczjdMNphjG7liJq5I5n00SD3zVxQKjE0
 tdNwv2V2BeGSyaplE2o4Yj8nYFJYy1XH3Lqk3G7QtELIPQjJ8BUWTTLQYX/3Nh1ip/zVmQN8
 VeiAwhDw8q1YV+JaES72wRM1EMRqHjhmC2izjUynSt6y8jXlCHI3enmcwIKf2BRQ2w3x3LlO
 4uplJY3WEaybg4mvASo7wD2yuIIwcY3Z3mWWkpOcyXseitHW7Gzq6HETspB8pIuvg1IXe76b
 V3QGduf61MKlijkGWVZ3jUycTqn7474kxJNg2WYNH9vrXDddKmc3D/n7cfHDb5U1zsCH2xjj
 CXPQ0O7J5+v9MmVkJHKtqa/UXigX9tda3ujwYSFvSq9rWpkZH/319W6gN76Ck4X1SHh1t9lf
 TrFplDwb8Hn2r+7PuRuYkRzTAWltIwlQMcnw9F228FY0GNSnpiP+HsbjWr/VLcTkbnzanYAX
 39DwtLY5hTkxFw2K3uIw4zjUXDOisBlZtS8fiYXwndntp8MV/3Ste0e23Ql8T/a5UrLbPNwn
 ykQ064r4X8e2KQSvRY1iz6aGvYUFFVZOirlk1KJ6cq/peNZfjXKE/D42UxgkNSmFLzHrBtbX
 SOzX544HjJrqOh7PkjN1nLb9YzuPtXdJ4F21FXcg1Lbgu5ZJYhk3N8Dnyl6IiTQuXM/yug0p
 QNj19e2scLUTgcltLL8CRleODrvYsoV8Ty4lqdSkPGd2IW3F4lgEDEGD9P4COilGzUIubH7J
 h6DRXci/2yDF+OVTmr9oA926mjCGJexOzSLKWkFmJ98EQKFKhUXgRhIDm9jxNhjTF/snZa/N
 h4jtndLuzua4lNN0r46bUClFD2F+0HxN3FsD8LCZBtOslMYvh2Ta5bBqLssWXkfpMLprRTRe
 DbCOEIXVydQCxbCXQyzeeP/gLuIu+mAWrjudb2XP+jI8LEPEa/Pn8zn05M6rWzVaYPQZD84V
 6J9gg0ZAjh4A5iLwWxQDXNN0XucNYjF+FDmpEgV5oi+6Ki5CFipvNXSTeEIYJM2oEj+gL/fZ
 b7Kwn8ndHACjctKnyWAjbEb2BR6ZzhGUT6rHPxAsCfMSPmVgapLF1sAbDs1MsJU7qU61w0LO
 MjBi9qz2KQqxvgyQ0xIU1DsgKTLLYQDPn29OVXbBU2KKKXOJDvFxNvyaL+9TrsYhftdthm5s
 zKWW0H5OTHLmz7sXhGpeeZC6UPTdARZo524ew1xBHLLSdX7dlukPdUxgTB3ibw4i3XWNHINZ
 Dhxd0Qey9/YpShcg/h5BylA9i8/dLbCxHzftriCbMlG4p4JSmxumulX4Wo30e5Q5SBAH7lun
 TfK68Vpuxegm/WOzTxuVFxPrCxKjcSFpxYHW+2R+59eVHLD5B9I43+XDkFAgtJ/CcD0/Y1Ux
 MLOkq3bNzpItd7Zt5h5ZYCcOIecPXwtPAC8UibTFxcARCW3OHv3gktAjLeN+3fTopVw+f2O0
 NIeD7RcUlIyDPYTDE9oSccDLJlAVTQhibeHjcQM6BJWQzHOSc8csp2VD5p65N3wJTzfgbQWP
 3PgIJv9KpkPcJL20QpuZwsi9Lk=
IronPort-Data: A9a23:DiqbiK8kGfwcxusX2UiwDrUD6XiTJUtcMsCJ2f8bNWPcYEJGY0x3n
 WFNCzyHOvnZZGD3ftxxYNjkoUgCvJCDzIA3QQdvq3hEQiMRo6IpJ/zJdxaqZ3v6wu7rFR88s
 Z1GMrEsCOhuExcwcz/0auCJQUFUjP3OHvymYAL9EngZqTVMEU/Nsjo+3b9j6mJUqYLhWVnV5
 4iq+5a31GKNglaYDEpEs8pvlzs05JweiBtA1rDpTa0jUPf2zhH5PbpHTU2DByOQrrp8QoZWc
 93+IISRpQs1yfuC5uSNyd4XemVSKlLb0JPnZnB+A8BOiTAazsA+PzpS2Pc0MS9qZzu1c99Zw
 Y5Cn8GfVDoSOPfmprgfcQlTK3B8MvgTkFPHCSDXXc27ykrbbz3zzv8oAExe0Y8woL8oRz4Us
 6VJcnZSPnhvhMruqF6/YsxlnMc+N4/GOI0Fu3dv5S7UB7AqTPgvRo2TtYUCgWtp16iiG97SV
 5E5dhtkUyjZOQRhGng3D5ElmOKB0yyXnzpw8Q/J+/NuvQA/1jdZ27/mO9v9Yc2PXcwTn0CCp
 2uA8X6RKhUTK9WbzRKX83emnOaJnCXhWYtUGqfQyxJxqFiU23BVFxAcE1e2yRWktqKgc9sEJ
 GZJ1TcTlq5o3nL3TPvtVCXponHR63bwROFsO+E97QiMzI/d7ACYGnUIQ1Z9VTA2iCMlbWFzj
 A7YxLsFERQ+7OzMERpx45/O9WvaBMQDEYMVTQMpJTbpDvHmp5wvyA3CRJBvHcZZb+EZ+xmgn
 FhmTwBk393/aPLnMY3lpTgrZBry//D0ovYdvFm/Y45cxloRiHSZT4Kp80PHyv1LMZyUSFKM1
 FBdxZXAsbpRUcrXznHcKAnoIF1Pz6nVWNE7qQE/d6TNCxzxohZPgKgNvGAgfx0B3jgsI2a1P
 hG7VfxtCG97ZSb2M/YuPepd+uxzg/GoFNL5W+rSY8YGa5cZSeN01HEGWKJk5Ei0yBJEufhnZ
 /+zKJ/wZV5HV/gP5GfpH481jO5zrghjlDi7bc2qn3yPj+HFDFbLEuhtDbd7RrtlhE9yiF6Iq
 4o32grj40k3bdASlQGJrt9DcQpafCdT6FKfg5U/S9Nv6zFOQAkJY8I9C5t4E2C8t6gKxOrO4
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
IronPort-HdrOrdr: A9a23:llgF/Kow+5p0ZnAwTE3MGiEaV5oPeYIsimQD101hICG9vPbo8v
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLW7bUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadD/DDKysGVbfy19QYXceiGUdAb0+9BYDzrb3Gfz2R9b6YEKA
 ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,235,1650924000"; 
   d="scan'208";a="18225419"
X-MGA-submission: =?us-ascii?q?MDFfzMQ7o2D0o+w+BN3RE4mjizulOPtFLymhd0?=
 =?us-ascii?q?3wuly0lLLaPztZZrelOF2RxGBozioTDfZjZ1CB91o8T+s8uqO86sKeHG?=
 =?us-ascii?q?pm2vVzJFeSI78BQtMR/6GGFEV2jCr5hDhRKf33iRz/IzXXI1sRrgsN4j?=
 =?us-ascii?q?pAXvtxW4mvt1HayIHoKKNYjw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 21:12:23 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656616322;
	bh=OGvE4e1SGrgLVuHvJIj+Z2ZBlKQGFwge8GOcN4KkJ0s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R5bT9drzpUh+N5tW/jPprUufG8PwxJAN1AMGMbGPUVzD1/7niZAxfHzL6yRR550Ez
	 FmT0Xc7D6ZhbJ0IaoAWf4CRhWmBFAlQQvNk5pok3LvTfQs51egV38XR8tIdzso7xXH
	 4ZRBKwyuPEnKjl9+0H0rVWjgQlg6k/jpwyH8gVAo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([93.133.78.24]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mty5u-1nltKY1vzg-00uav6; Thu, 30
 Jun 2022 21:12:02 +0200
Message-ID: <330a7c11-abfb-c985-0c2a-f4e1b4cdc9d6@web.de>
Date: Thu, 30 Jun 2022 21:10:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-GB
To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>, Fabian Frederick <fabf@skynet.be>,
 Yajun Deng <yajun.deng@linux.dev>, "David S. Miller" <davem@davemloft.net>,
 Phil Edworthy <phil.edworthy@renesas.com>
References: <20220616013253.520310-1-william.xuanziyang@huawei.com>
 <32da2d32-9554-de90-62ca-c4be456ad31a@web.de>
 <6b3eac2c-6e24-46e0-c548-dc87f666709b@huawei.com>
 <0e3d2713-ab8a-2ce5-5423-a72ba36ac1ff@web.de>
 <224eeed0-5429-6dc3-7fe7-e4ff820ccb27@huawei.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <224eeed0-5429-6dc3-7fe7-e4ff820ccb27@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6tSTT1cyZjVjipCBhUZ/UwrutbFz8G1P3GJY7BYwfhVrVpwm674
 2Xl5CnRPV+6hyxvcjr9UBSzhx/Oo/GX5op+h+AacFvdFAw4z7FnQi9SqkC1NOp7pQ16UJoS
 E7/1yQ5Qa0LcxgIO8AJO9hsNffNsoXb6WJKa8zylivvgOOVd+TIGJB9eCAoHXstu8eRY+eI
 IZ7wnMQW+nCl0YcuaOM9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:my92JvetiFU=:wQaN4QbTNJArhskSDD+NGr
 i1cim8JrF5RtyIc13v3lxweY/V3U9EWW2i7Tn/64zj3XUkjsxc+5Bs1Plp/6efQjcjWrA6C9I
 HftnCS3ml7Ns8dPQlT+En3Ah8cn9ldu6OlsEyhPX/a4Lrjh85IBa5PDfrbSIsBE5IYoLK0odH
 SfvHwrUX0fskdCDu74SGNJYY4w9Wk/FlfIHc3lmIWVU7kx8ZJtLMFQxJuz580VGuyIRLLsNze
 mepf8ptjC0Pe+vslk69I0p8MmHp746ikaCfYJKJ5xRuzLGPLE+lj58eamzf3yvqbJrHDi042f
 7XHhPyLHdm3qytv1MylrAuFU0RRCATmLnqetXdhU+K9RuEbhbdNUKRYXaHCkHUaIcMvQknzto
 z9KgvovEPolt//p6t6RcwAFFcYe1BD4FoJWFgBatnbWf1e8XON8His1mttzxqn2zXFupsHxqT
 rEcH9+PjFvTT9mkcfyk3uGFaFKFx0hnAzxJe1ww3C7IS3iFcjoBEWUvKBTXSaNvzfSlTW3/sd
 TadiMapK+svU33rFfiQ+9yJf228SIHvs0+ZRNdvhGlCAH8lwuNo4AFDfVa1dhNb7vY/ENIo79
 xT5+APU1Lhtfv+tU0F6fuYN7dccliXuCGXq3xyRIixS3fFV8E3NIFWrf+IQatNL5OMqVNptaG
 h0YUgH7ToHJS/5D5+WM3MiVs5N4xBo4kPN4JJcPmNP6sM1c9VtDg9PJa3zpu+T5Bqp1F92vKK
 RQ4+qs7z/nquaKXftm2SAGL8lB27xO7rqaKLZQzYDcGsfbw7evRlIi82oieNmwHXoBIRZVAEa
 xhS4TdQuI1g4JbRYxXDF3H15GOVer4gMfwSTXUhIu3q+199aoIPmcC3286UYb8s/DwqnR1uIb
 GU5PkQpjKsYue28/Q+Zgf8wEfX2o9+smEXrC13jZT5Q2WG1LiZvu7ZLhirPnQCZTw6UPBoyIZ
 Nb6mCWTYfYWl0FAohKomKAkxPeT9FN1HDgq3MdOvScdIeu8dd/YWlWGYduPOEmiEMA5NS/tSA
 M7tIpuq5NGwQkoK5eWC0Ki3e3Po9JTHFM7x3NsvfR4MgvijMZmm67j9jJRo2QnGfTshydiBcF
 JgeMfvw78crJEqCc5JwaL2XhLtnl9dBBOF12A0wX+r4Lba8BMOY7g2HMA==
Subject: Re: [cocci] scripts/coccinelle/free: add NULL test before dev_{put,
 hold} functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 470
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/330a7c11-abfb-c985-0c2a-f4e1b4cdc9d6%40web.de>

>> Do you get further software development ideas from a data processing ap=
proach
>> which I published before?
>> https://build.opensuse.org/package/show/home:elfring:semantic_patching:=
Deletion_of_checks_before_specific_function_calls/Deletion_of_checks_befor=
e_specific_function_calls_in_Linux_source_files
> Sorry, I didn't learn about these. I learn about coccinelle recently by =
coccinelle scripts in Linux
> kernel and coccinelle official website. Now I get more resources.

My data processing approach can point special run time characteristics out=
.
The available computation resources influence if all Linux source files
can be analysed (or transformed) within several minutes (or some hours).



> I will give the v2 patch with your suggestions.


Would it become more appropriate to rename the file =E2=80=9Cscripts/cocci=
nelle/free/ifnullfree.cocci=E2=80=9D
so that more redundant checks before selected function calls will be recon=
sidered
(in a consistent way)?
(Further change possibilities are in waiting queues also according to a fu=
nction
like =E2=80=9CIS_ERR_OR_NULL=E2=80=9D, aren't they?)

Regards,
Markus

