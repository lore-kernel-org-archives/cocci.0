Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37B59C43334
	for <cocci@archiver.kernel.org>; Thu,  9 Jun 2022 15:07:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=BG9Xz7EyeXJyLmodocSZFPyXnrcLrs6wMAqZdqyyFUI=;
  b=ELZTMCCEObg3+bMYulBe3yRjon8tOVv/rk7JhvOBQcQh2GYr7pNLHSW2
   yKieu3k55gQldrAeKJM+cZ2wZrO17nuuQ64fLx/EfYncF2uMXKiPxilXk
   lMGMf0Q7y1xwmv5n+ZJZD1NS3PIul+q/vFUWe3Trh7uFtUoQEBGiUHpy+
   E=;
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
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208,217";a="40260580"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Jun 2022 17:07:29 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2E65CE02AD; Thu,  9 Jun 2022 17:07:29 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 291AEE010B
	for <cocci@sympa.inria.fr>; Thu,  9 Jun 2022 17:07:27 +0200 (CEST)
IronPort-SDR: tOZ3MQkrRm8bevZgisbpgZGYhYuGb/vtZCv96kOwR4qD6cDgX8MwQ98JU0sNK8D86VDldaxbA/
 v+trq9szOgrrzjvvX6KDiRNKNAErN/lVAppdJHTzdRE9axLVw5kUIRwcxVFvcDBKRqFiOlGDod
 /hOnqrxZtUhApG2a/9giqtdR6Vt9ZNd5u/R7siarwuT8c9pj+Noi5Ka+WhXKdXIhzLpm7P2Alh
 eTda8U9TnqZzQf3Lmtm1qT0/PhzfkXDqZz1s65/Tq62Mn9p0XeQLEiSKmT0W9xR9E7hOUMEOoI
 YAYH5lJkfcbv2JdPqdbsFuKd
X-IPAS-Result: =?us-ascii?q?A0AdAADFC6Jih07ASNlaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBgg+CJIFXLgQLRIROkRGEIYcJkzkLAQMBDT8BAgQBAYIOgnQCh?=
 =?us-ascii?q?UYCHQcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNC?=
 =?us-ascii?q?QUICgcOEAU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBDwsEPgICV?=
 =?us-ascii?q?wYBDAgBAYJ5gmUBAw0jB6tngTGBAYIIAQEGhEofLCJSgVwJgT2HQQGGLnonE?=
 =?us-ascii?q?IFVRIEVJwyCRzA+gQ+HC4Jll38HJgQPAxotNBKBIXEBCAYDAwcKBTIGAgwYF?=
 =?us-ascii?q?AQCExJTHQISBQcKHA4UHCQZDA8DEgMRAQcCCxIIFSwIAwIDCAMCAyMLAgMXC?=
 =?us-ascii?q?QcKAx0IChwSEBQCBBMeCwgDGR8sCQIEDgNFCAsKAxEEAxMYCxYIEAQGAwkvD?=
 =?us-ascii?q?SgLAwUPDwEGAwYCBQUBAyADFAMFJwcDIQcLJg0NBBwHHQMDBSYDAgIbBwICA?=
 =?us-ascii?q?wIGFwYCAm8KJg0IBAgEHB0kEAUCBzEFBC8CHgQFBhEJAhYCBgQFAgQEFgICE?=
 =?us-ascii?q?ggCCCcbBxYZHRkBBTYnBgsJIRwKHwsGBQYWAyNxBQo+Dyk1NjwvIRwKEgYiA?=
 =?us-ascii?q?R2YeKEFpGY0B4IUgT2BRAyeLQYTLZZRDgaRAXWWahkHpxOBeIF+MxokgzdOA?=
 =?us-ascii?q?QIBAg0BAgIDAQIBAgkBAQKOHRmEDIotPzQ7AgYBCgEBAwmFRwEBiUgBAQ?=
IronPort-PHdr: A9a23:nwB8cBHDXFAa9DDO+MD0sp1Gf9dGhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31xmQBdSQtKMMotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5ZPebx9ViDahZb5+I
 xe7oAHMvcQKnIVuLbo8xAHUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2Q
 rxeFzQmLns65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD+v9
 LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQds4YS2VcRMZcTzBODICyY
 YQAAeUPIPhWopfzp1UOrxSzHhOjCP/1xzJSmnP706833uI8Gg/GxgwgGNcOvWzTotrvLqcSU
 v21zLLVxjvMa/NW1y396InOchAuvPqBWrV+ftDLyUksCgPFlU+cp4PhPzObzOQNsm6b7+V7W
 OOhlWEosBt9rSWxyco1jITCm40axEze+ypj3IY1OcO3SFR9YdO8DJZeuSGUO5dqT84sTG9lt
 js2x6AEtJKnYSQH1JQpyR7fZfGacYWG4g/vWPifLzp3i3xreKyziwu9/EWi1+HyWM+520tJo
 CpditTAqG0B2h7J5sWFVPdx5Fqt1DKR2wzJ6OxJIlg4mK7VJpI737I9mIQfvV7eEiL2mEj6l
 rKae0oq9+Wu9u/peK/ppoWGOI9xkgz+Mrohmsi4AekgNwgOWHWb+fim2Lzt40L2W69GgeAon
 aXBsZDaI9oUprKhDgNLz4ou6QyzAjW43NgCgHUKKExJdAiFgoXqI13OJer3Dfa7g1Siijdrw
 PXGM6XmDJrXNHjDk6rhfa1n50BTzAozw8pf55NSCrEOO//yVFH+u8fCAhAkLQO42+DnB85l2
 YMERW2PGrOZML/VsVKQ+O4jO/OMa5MNuDbhN/gl4ObjjXsjll4TZ6ap2Z8XZWu5H/RnJkWWe
 mDsjc0bHWcLuAo+Vu3qh0eYXT5dfXa+R7g86S0jCIK6EYfDQZigj6CG3CinApJWZ3tLCkuME
 Hftb4WLQe0AaCOUIs97kzwLT6KtS4E71ULmiAiv6adjL+Oc3iQHvJbnnIx3+unSnFc2/CN9C
 8C10meXTmgykHleA3cUXbr+pF1K7lqN2LVijrQMF9FJ6vZYFAM3O5fB1eFSDd3uUx7EeZGCT
 1PwEfu8BjRka9srwMIVK2t5Fc+jiB+Liw+jGbwIjPqmAJIu86TT92f8LYBxxiCVh+Eak1A6T
 54XZiWdjall+l2WXtaR+634v6OjdKBHmTXI6H/G1m2W+kdRTA93V6zBG3EZfErf69rjtQvZV
 7H7L7MhP0NazNKabLNQY4jMhE9FWeylFdDQeWO3lE+vCBzOyr7fJJHydTAl1T7GQFMBjxhV+
 H+HMQYkASL0hmvEDyF1U3/rbVnt9+ZWt36xCEM5nEmRd0M08b2z91YOgOCEDfMe2rVRoCA6t
 zB9B0qwxfrTDMec4RVsduNQbLvR+X9h0mTU/0x4N52kdOV5g0IGNh9wpwXo3gl2DYNJlY4rq
 mkrxUx8M/DQ1lQJbD6e0Z3qX9+fYmDv4BCibbLX0VDCwZ6X/KkI8vExt1TkukmgCEMj93xt1
 9Qd3WGb493GCw8bUJS5VUhSlVAygrjAYTQmoa7Q22dtN6acrTLInd4kRaMkxhumY9ZDIfacD
 gahW8YeBsWoNKkrgw3zN01CY7oUrf9ueZz2JJ7kkOaxMe1tnSyrlzFC6YF5iQeX8jZkD/XPx
 9ADyu2Z2Q2OU3H9ik2gu4b5g9MhB3laE2yhxCzjHIMUaLd1eNNBLG60INCsgPh6iYTsXXFw6
 1OpQV8LkpzMG1Lafxnm0Atc2F5C61mugyil1HpZlz8zr6yQ9DPDyaLueVBUXwwDDHknhlDqL
 4+uitkcV0X9dAklmiyu4kPizrRarqByR4XKaX9BZDO+b2RrU6/r86GHf9YK85Qw9yNeTOW7Z
 1meDL/7uRoTlS35TSNSwzUydjfivZuc/VQyrWuHL2to6lfdd9txwxj3+9HWA/JcljYLXyh3j
 zDLC0P0ZYD2u4rO0c6S6KbhByqoTdVLfDPuzJ+cuSfehyUiGhC5k/2p25XmHQU8zS7nxoxvX
 CTMogz7Z9qj3KC7POR7O0hwUQWltIwlQMcnw9F228FDvBpSzo+Y9ncGj2rpZNBS2KalKWEIW
 SZO2NnNpg7sxExkKHuNgYP/THSUhMV7NLzYKisb3Dww68dSBeKa9rtByGFQq0C7sBmXTPxzh
 DYbxtMx5XRcj+xD629Phm2NR6sfG0VVJ3mmsh2S7M2l6ohTanyud7eYy0d029ysRuLnwEkUS
 DPyfZEsGjV158N0PQfX0XH93YrjfcHZcdMZshDH2weFleVeL4g90+YbnScyc3yopmUrkqRo6
 H4mlYH/poWMLH9hub60EgINfCOgfNsdo3nslfoMxJ/Mmdr1QdM4QGtNBcG4Cqj1dVBa/fX/a
 1TUSWd68C3EX+OCW1fYshourmqTQcrybTfNfiZflIokHF7HewRemFxGBmxl2MFjUFn7noq7L
 Bc+vGF0hBawqwMQmLIycUChDyGG+VbuMnBuFtCeNEYEtFgdoRiPd5bGsaQrWHsHtpy58F7Xc
 zPdOF4OVDBTHBLYQAq9W9vmrdjYr7rIXKzncaaIO+/f77UFD7+J3c79gtEgpmjRcJ/UZj84V
 bV+005HFxiVAuz/nDMCA2wSniPJNIuAoQukvzZwtoa5+ejqXwTm4c2ODaFTOJNh4UL+h6DLL
 OOWiCtjTFQQnpoR2X/FzqQe118OmmlvcTeqC7EJqS/KSurZhKZWCxcRby47OtFP6uow2QxEO
 MiTjd2QtPYwlvkuF1JMTkDsgOmsYtEWZX6wPhXLCQfDNbiLIyHK39CiYa64Tu417q0cvBmxt
 DCHVk77a27ayH+2DVb2YLsK03HIWX4W8JuweRtsF2X5GdfvaxngdcRykSVz2roswHXDKW8bN
 zF4NUJLtLyZqy1C0ZAdUyRM6GRoKe6clmOX9e7df9wzuOFoHz8yuuZU+nU8xJNK4SsCSPE/y
 06w5pZ+5kqrlOWC0G8tSB1VtjNCn56Gp21nPrjFsIZNUzDI8VheiAfYQwRPrNxjBNr1vqlWw
 dWaj6P/JgBJ9NfM9NcdDczZQCpiGGUsO1zlFWyMZOPqZSGmPyfTih4E+Blz3niSs4R8tZXm3
 pYDGOczaQ==
IronPort-Data: A9a23:eIFWsqMvPQwF83TvrR3MkcFynXyQoLVcMsEvi/4bfWQNrUp20jdRm
 jYWDT2BPq7ZNGf3L49ybIi18EkHuMfUn9dnTXM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/vgqoPUUIYoAAgoLeNfYHpn2EsLd9IR2NYy24DnW1PV4
 rsenuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Xgu53+
 NFQ66WdcioWbvbexdxCUkFhRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNJepbwxWDAUs
 6NIQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojacmdGPmRuIYCtNs2rt0NB+veS
 8ZGUyp2chHLYUNSGgY+S6tryY9EgVGmLmEG8QvLzUYt2EDXxRN41LzFItvQcMaDA8RThEeR4
 Gzcl0zyBRoRNfSE2D+d+zStgPXOlGX1Quov+KaQ8/l3nBuMy2ZVBBB+uUaHTeeRlFOAXeJbN
 hIt1xEDkvhp5hGTEdilZkjtyJKbhSI0V91VGuw8zQiCzKvI/gqUblQ5oi59hM8O6ZZsFG1xv
 rOdt4K1VGU32FGAYSjFrt+pQSWO1T89AUJqWMPpZQ4C/sWlv4w5yB7CJjqCLEJXpo2rcd0T6
 2rSxMTbu1n1pZBTv0lc1Q6d6w9AXrCTEmYICvz/BwpJFD9Rao+/fJCP4lPG9/tGJ4vxZgDf4
 SRbwpPGt75RVs/leMmxrAMlQ+HBCxGtb2y0vLKTN8V7n9hQ0yP/LN4LulmS2m8zaZhbKVcFn
 3M/SSsIucMNZSL0BUOGS9v/Uowry7TtD9LoSrjdYbJzjmtZJGe6ENVVTRfIhQjFyRBy+YlmY
 MvzWZvyUR4yVPo2pBLrFr91+eJ6nUgWmDKDLbillE7P+eTFOxaopUItawbmghYRt//f/204M
 r93a6O39vmoeL2mOHmOoNVDdDjn7xETXPjLliCeTcbbSiIOJY3rI6W5LWoJd9M3kqJLuP3P+
 33hCEZUxECh12LKI0OGZyk7Or/oWJ9+q1M9PDAtZAr5hSJ8PNz3tKpPJYEqebQH9fB4yaAmR
 fcye/KGXqZFRAPB9mlPdpL6toFjKE+miFvWbSqoaTQyZbB6QAnN9oO2dwfj7ndcESe988cz+
 uXy2gTeSJsFZgJjEMePNKPxlQzs5yBFlbsrDUXSI9RVdEH9y6RQKnT83q0tPsUBCRTf3T/Eh
 QyYNhcvo7WfqYEC9tSU17uPqJ2kErclE0dXQzvb4LKxOXWI92av29YZAuOPYCybS27+vqmvP
 L0Hw/b5OfwBvVBLr4slT+c1l/1jvYO3qu8I1BlgEVXKc0+vVOFqLE6G6s8T5KdD8blU5FmtU
 UWV99gGYriEZJH/HFgKKFZ3Z+iPz6hNyDzV8OhzP0jwoiN6peLVXUJXNhiKqSpcMLosbNJ7m
 7h84pZO5lztkAcuP/aHkjtQqTaGIEsAZKN75JsUN4nm11gwwVZYbJ2AUSL77fljsTmX3pXG/
 9NVuEbDu1iY7k/FbmZ1CnXHm+ZQ7XjLVNam03daT2llWPKc7hP04PGV2Ss6REJZw32rFsptb
 3NzORQdybqmpl9VaQsqY4xoMx5MDluV9yQdDrfPeHLxFyGVa4AGEIHx1SthMqzUH6KwswW3J
 I2l9Vs=
IronPort-HdrOrdr: A9a23:QwE8eqpL/nsPAZanIIMAzQ4aV5oFeYIsimQD101hICG9vPbo8/
 xG785rtyMc6Qx8ZJhEo7u90ca7L080maQFh7X5eI3SJTUO21HIEGgB1+TfKlTbckWSygce79
 YGT0EUMqySMbEVt7ee3OD1KbYdKMLsytHRuQ4y9QYXcelSAZsQlTuQgWugeHFLeA==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,287,1647298800"; 
   d="scan'208,217";a="16343512"
X-MGA-submission: =?us-ascii?q?MDGTJVTSHKPB5JZwGEiifaALmtrMiLd/VXe+tS?=
 =?us-ascii?q?91hNUoYr9vKFfKcwIo6zs9QOXusFI0O55O5iqXUDtMqtnHBESD1Ccxog?=
 =?us-ascii?q?Ty2jghMcZmwDhvJ/Gz4Xo9W7q1ZcaAbOkditSFAP5lq0HwTiJaoDL6s3?=
 =?us-ascii?q?dVAsvO3yChe6TurLBPYLLuKg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 17:07:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654787244;
	bh=QsFn0qPpOQLe1W0QdLMGGPblAgROeTON0C9fwzG/Ud4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Y6IR+YAFHfcuFfXaSM//aZ/rOxOHAwfN2stUJbRrgdtA4vV/hciwPBQCDE9W1R/f3
	 jExeNKi7QCZn8k4g+3vprXZauJ0ibJg0xxmQGgxEnD6jmsxv+GpooXaBGATFNQ8nNN
	 LtSryZovdMIqehqi9Fo2e+jR3lwRVLDYhXlby+d0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.155.143]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1My6lR-1npMBP06W7-00zXyN; Thu, 09
 Jun 2022 17:07:24 +0200
Content-Type: multipart/alternative;
 boundary="------------LkDhXGMChUmc410Y30RGoOs0"
Message-ID: <15a253a6-469b-9632-8c7d-983554604451@web.de>
Date: Thu, 9 Jun 2022 17:07:06 +0200
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
X-Provags-ID: V03:K1:65simx9GFdaefms9vEN0COzsM+rBlCry0A8EtP3gFRJrhdy15oD
 rNH8dvZEJqMl6KtkeDlIHJ8IpV+V8XXscfgY8GAmlQ2xELGXWYJdIcUIcMdvGAeN2rOXUO8
 1erUPDkAiyZvxy1lHk2GShODMGwofOPHMuWyjJBPKsHlpA9JG+ewAXaD2ttb83NYeTTItQG
 Wg9uTCNsQThoQYux294Yw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nxaMhywmXnE=:ZEWC//tGo0+AQFFmsu+tGY
 oDPOE322KbUYRlPKEII04fFhjd7BWAqjvOVU9HNOeH6+oBbi0Gqn62kl+Bghc18syqxmV9KQ/
 VleprNeNigxGcyjImX1edhXuFMuuCngSO95EzDmvtL2j4sqLUlNh576K2GdT0KiSr5psd9zNv
 IN8S4N/jsOGI4zv1FRUqwm2iqrHkG7z8YVX3nazPjW0hivLJtXMAT1uwujTnkXDffG/O3tY5e
 lINVLpSikS0Vr72h1VbPioLFdcX4NXuFxjpG5hpKgOGl/Tjtr9Ixfai9/IiOV9WzkP0zdsO+r
 Lj4vuqytfdC659YxqIMMKpqVSZ+qwSDpp13NjB77ic62fzJMfLgL6ooNQfH/al8tqsEiMyN16
 mkZY6Z1UctwEKpzuCJ/tD/KXMWWUvIYbPqCg4iB3e6NHG70QKUP3hZOPtf/580ZWAKcPb0Yaf
 8/FbdGhOomSB2bsHrgJXoi8WCqVyhamPmh3A/jKo8vnHV5zf3zlVmQ/p0p85Ikmkqj1N0WSxq
 03SJYGQbXRAlDp881MRrKJfW6p+e0yXhrtw4/+HQukFEEq0RHj5nQyXzI8FVWC8vfq1Rledb3
 mpeS8Nd5eehxwU64fLWilNm5XwQwL+ODaNctI1V5Z+60DZk2/0UBXVPL5CKVvGvs9t/ttCoGQ
 GERjoZovjPG2qfJDWabujx2u1KAuU4aRubSLHxcYHxyxbamrUyaX8Wl/SiM75OXlqGt8Na0sw
 ZmmptAvUBzBiEGJMHiozPZo0CTIh0SrDy6PLqVfAjFJCr9yGWbF2hAl9F/sB9C+BAw5B5V/t8
 Cs1p9nvAEnQiqRMXafyleqeXZdkTc+uwRWUELbEbeJjRCCljh9OSR8gDkSnIEI8v1pzAFhY/l
 Fje+Nz3AfMnCZL5rJM9sAF+y5F9BxcCih8UEoFj2pOmB9hPZSYlXJRJ/CGbNJu8C8mbNsnmS9
 ODVIca86DnPpY14OibZfVrAcvhILm4HD05Rv6EVfxYbrQCDDbF0O0yLt3PNW8ceP1akQ7wKQZ
 Q4/29rLYQQieEoFuz7bezRYqtF/SjfBq/GMj5ITX54L5IgbYlaom5YejvpkTJOpu6+lNt3iFD
 OYiUuY0iRLaPS5en6SFUMUgCGgc1u6tVFjtW7LQxqshq1grdf2yQp7MQQ==
Subject: Re: [cocci] coccinelle: ifaddr: Find address test in more complex
 conditions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 426
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/15a253a6-469b-9632-8c7d-983554604451%40web.de>

This is a multi-part message in MIME format.
--------------LkDhXGMChUmc410Y30RGoOs0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

>> I don't really understand the above, but it made me realize that actual=
ly
>> the following is sufficient:
>>
>> @@
>> expression x;
>> @@
>>
>> *&x || ...
>>
>> This forces &x to appear as a test expression.  There can be 0 or more
>> occurrences of ||, so eg &x && y is also matched.


How does this promising feedback fit to the following information from
the software =E2=80=9CCoccinelle 1.1.1=E2=80=9D (OCaml 4.14.0)?

Markus_Elfring@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe> =
spatch --parse-cocci show_address_determination_in_checks-20220609.cocci
=E2=80=A6
@display@
expression x;
@@


(
*&*x *|| *...
|
*&*x *!=3D *NULL *|| *...
|
*&*x *|| *...
|
*NULL *!=3D *&*x *|| *...
)


No grep query


Would another transformation be needed for the omission of trailing binary=
 operators
(according to the shown combinations with SmPL ellipses)?


Regards,
Markus

--------------LkDhXGMChUmc410Y30RGoOs0
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<html>
  <head>
    <meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DUTF-=
8">
  </head>
  <body>
    <blockquote type=3D"cite"
      cite=3D"mid:alpine.DEB.2.22.394.2206072138160.2960@hadrien">
      <blockquote type=3D"cite">
        <pre class=3D"moz-quote-pre" wrap=3D"">I don't really understand t=
he above, but it made me realize that actually
the following is sufficient:

@@
expression x;
@@

*&amp;x || ...

This forces &amp;x to appear as a test expression.  There can be 0 or more
occurrences of ||, so eg &amp;x &amp;&amp; y is also matched.</pre>
      </blockquote>
    </blockquote>
    <p><br>
    </p>
    How does this promising feedback fit to the following information
    from<br>
    the software =E2=80=9CCoccinelle 1.1.1=E2=80=9D (OCaml 4.14.0)?<br>
    <br>
    <p><span style=3D"font-family:monospace"><span
          style=3D"color:#000000;background-color:#ffffff;">Markus_Elfring=
@Sonne:/home/altes_Heim2/elfring/Projekte/Coccinelle/Probe&gt;
          spatch --parse-cocci
          show_address_determination_in_checks-20220609.cocci
        </span><br>
        =E2=80=A6 <br>
        @display@
        <br>
        expression x;
        <br>
        @@
        <br>
        <br>
        <br>
        (
        <br>
        *&amp;*x *|| *...
        <br>
        |
        <br>
        *&amp;*x *!=3D *NULL *|| *...
        <br>
        |
        <br>
        *&amp;*x *|| *...
        <br>
        |
        <br>
        *NULL *!=3D *&amp;*x *|| *...
        <br>
        )
        <br>
        <br>
        <br>
        No grep query
        <br>
        <br>
      </span></p>
    <p><br>
    </p>
    <p>Would another transformation be needed for the omission of
      trailing binary operators<br>
      (according to the shown combinations with SmPL ellipses)?</p>
    <p><br>
      Regards,<br>
      Markus<br>
    </p>
  </body>
</html>

--------------LkDhXGMChUmc410Y30RGoOs0--
