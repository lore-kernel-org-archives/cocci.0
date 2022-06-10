Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B84C433EF
	for <cocci@archiver.kernel.org>; Fri, 10 Jun 2022 18:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=QwgAAbC6Usipws6Sg4OUD1etzrAsGIbJm3dc4NJPiGU=;
  b=jKLx6LopEMvV1/ViwUQQ8BWn3k93ydmSSDdVHCHji3c809y5MyQblNCm
   0Xcd31MpAa52HwVdl1MVHAfrw7wh7xswXacRNrSGPAl4nHwEH0bmE3hRx
   Mehogv3JNsNO2yotV7SoAA2bcNDn+F8ks9lcIVRmZ1NJfkoo4iuHE6HaG
   I=;
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
X-IronPort-AV: E=Sophos;i="5.91,291,1647298800"; 
   d="scan'208";a="40473385"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2022 20:05:34 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0BD7BE0137; Fri, 10 Jun 2022 20:05:34 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 75E2DE0038
	for <cocci@sympa.inria.fr>; Fri, 10 Jun 2022 20:05:31 +0200 (CEST)
IronPort-SDR: UU+UHa10AeKmQPNQrh/1ijkSDv/kVIRyQWN9Sxe7x2gt7BJgda7xoejCFmiylJLKn2iS59ex4b
 fbTZZh+yY3agXir5734lsOUAzlAtq9XnGMAnlwC/CN5x2phNJ0A93/X05QZCJDYCxMfvkweZfR
 IEUzlDq3pCbFkfcL+jWjS4+JvGZ+rVuwh6TNDx7gjWniM21thFF8F2OG89VYP8N4dv+pwxcvG/
 UiGvXUudzqGDO5sGGNXtwSz5NTnka4efEEEdRhniE2nROTf2kMZGR72qktrXxhHGgchvmJTe4q
 HyxJE4nmh9VQWKg+Lzty+OFM
X-IPAS-Result: =?us-ascii?q?A0D5AACZhqNihwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CJIFXLgQLRIROkRGEIYcJhxuMHgsBAwENPwECBAEBgg6CagoChUcCHQcBB?=
 =?us-ascii?q?DQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBEwEBAQwNCQUICgcOE?=
 =?us-ascii?q?AU2Bl4GZASBSwSBdAs0DYI1KQGDZAECAgEjHQEBESYBBAsLGgImAgJXBgEMC?=
 =?us-ascii?q?AEBgnmCZQEDDSMHrHuBMYEBgggBAQaESh8sIlKBXAmBESyNdHonEIFVRIE8g?=
 =?us-ascii?q?lMwPoEPgzWDVoJlmDEnBA8DGi00EoEhcQEIBgMDBwoFMgYCDBgUBAITEk0GH?=
 =?us-ascii?q?QISBQcKBhYOFBwSEhkMDwMSAxEBBwILEggVLAgDAgMIAwIDIwsCAxcJBwoDH?=
 =?us-ascii?q?QgKHBIQFAIEEx4LCAMZHywJAgQOA0UICwoDEQQDExgLFggQBAYDCS8NKAsDB?=
 =?us-ascii?q?Q8PAQYDBgIFBQEDIAMUAwUnBwMhBwsmDQ0EHAcdAwMFJgMCAhsHAgIDAgYXB?=
 =?us-ascii?q?gICGVYKJg0IBAgEGAQdJBAFAgcxBQQvAh4EBQYRCQIWAgYEBQIEBBYCAhIIA?=
 =?us-ascii?q?ggnGwcWGR0ZAQU2JwYLCSEWBgofCwYFBhYDI0onBQo+Dyk1NjwvIRwKUgYiA?=
 =?us-ascii?q?RsCmSRrCBWCaZM1rkU0B4IUgT2BRAyeLQYTLZZRDgaRdpZqIIEHpgyBeIF+M?=
 =?us-ascii?q?xokgzdOAQIBAg0BAgIDAQIBAgkBAQKOHQwNCYQDii0/NDsCBgEKAQEDCYVHA?=
 =?us-ascii?q?QGJEwEB?=
IronPort-PHdr: A9a23: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
 pYDGOczvLMdCf4QTEhoToVqHQ==
IronPort-Data: A9a23:GgXBeaK/I8yhRrkUFE+R9JMlxSXFcZb7ZxGr2PjKsXjdYENS0jVUy
 GMYD2qFbv+PYGSjfdEkOtux/EpV75OBmNNiQAQd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6jefSLlbFILas1hpZHGeIcw98z0M68wIFqtQw24LhXVrV4
 YiaT/D3YTdJ5RYkagr41IrY8HuDjNyq0N/PlgFWiVhj5TcyplFNZH4tDfnZw0jQHuG4KtWHq
 9Prl9lVyI92EyAFUbtJmp6jGqEDryW70QKm0hK6UID66vROS7BbPqsTbJIhhUlrZzqhuOhJ5
 fBLmpCJUgJqAJLngPgEXhxRDHQrVUFG0OevzXmXtMuO0wvZfnGqz/gG4EMeZ9RCvLwtXicXq
 rpBcVjhbTjb7w6y6JeyUOpxnYIOKMfxPYUQkm5tx3fVAJ7KRLiaHfmXuI8HjV/cgOhsPLX5f
 Oc0SQNFUx2ZTDdBFnkJGZcXybLAan7XKmAE9gvM+8Lb+VP7xwt627nFK8vQYtXMRMNPn0/eq
 Hiu12DwHRgeMPSNyD+P6Hvqh+nVnCq9Vph6KVGj3vttnUHV2WEZThEbPbemnRWnommGY/96L
 WMYwzEr7pYN31S3V9T4VgLt9RZooSUgc9ZXFuQ77iSExazV/xuVCwA4c9JRVDA1nJJuGWdwi
 jdli/u2VWU/6tV5XFrAru/8kN+kBcQCBUMvDcPuZS4C5cXqqogulHojpf4+TvLs1rUZ9RnKw
 z2Lqiw3gblWtcAC07fTwLwqqzeru4SPUQM/oAnaNo5E0u+bTN77D2BLwQGKhRqlEGp/ZgfZ1
 JTjs5bHhN3i9bnXyESwrBwlRdlFHcqtPjzGmkJIFJI87Tmr8HPLVdkOvW0hdRY1aZ5bI2GBj
 KrvVeV5u8870JyCMv4fXm5NI5hzpUQdPYm5B66PNLKinLArLlbdpkmCmnJ8L0i0zRRyyPhhU
 XtqWZ/iVD4bD7hq1jy7W68U3tcWKtMWlQvuqWTA503/i9K2PSbLIZ9caQfmRr1nsMus/VuEm
 /4CZpPi40gOC4XWP3iHmaZNdQ1iBSZhWfje9ZcNHsbdeVUOJY3UI6SMqV/XU9c/zvw9eyah1
 i3VZ3K0P3Kl2SSbdlvXMi46AF4tNL4mxU8G0eUXFQ7A8xAejUyHtc/zrrM7Iusq8vJN1/lxQ
 6VXcsmMGKodVTnNvTgQNMGvoItnfRWtpASPIyv8PGlhJcE9HVSR94+2ZBbr+QkPEjGz65k0r
 Yqg4QWHE5ANcAJvUZTNY/W1wlLt5nUQwbogX0bBLtRJVl/r9Yxmd374gvMtfZMTJB+FyjbDj
 1SaBhIRpO/spY4p8YCV1P7e8NrzS7NzRxMIEXPa4LC6MTjh0lCimYIQAvyVeT39VX/v/Pvwb
 +tiz8b6bK8NkmFMvtcuCL1s168/u4DiqrIGnARpGHLHMwaiBr96eyDU2M5SqutSy7UftQbvA
 hCD/dxTOLOoPsL5EQdNdVR/MbnZjakZymvI8PA4AETm/ysprrCJZkVlOUXegiJqKrYoYpgux
 v0suZJN5gHj2AAmNM2K0nJd+2iWdyVSVqI6qtcFDYWthgdykgNOZpnVCynX5pCTaowQYxdwf
 WLO3PLP1+ZG207PU3svDnyTj+BTspQ5vkwYxlE1IVnUyMHOgeU63UEK/Dk6JuiPIs6rDw6u1
 qlX20xJyWGm+jB1mI5cUmrqFwwp6Nh1PKDu4wNhqYEbZxDAuq/xwKkVJuuHukwUm46ZViYO5
 6mWkQ4JTh6zFPwcHUIOtYpNtPHpC9B8nuEHdAZLAOzdd6QHjfHZbmNCqIbGR9YLwS/8uaEfm
 dRXwQ==
IronPort-HdrOrdr: A9a23:p/MhTqt9Co7XS/zRmZkRUDF77skDUtV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouVvvJrIuQ/EpU0dNj2ChpsQlTuQM2ygYzBLrIIqP/AEKK
 Y=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.91,291,1647298800"; 
   d="scan'208";a="16455879"
X-MGA-submission: =?us-ascii?q?MDGA/V0Vv78eG9SettIwVGTs3hHcxaJW2YKqub?=
 =?us-ascii?q?WzD9OVLr0MKs4z/YAa90zhZk+20AgPxaPpyizdJeirzUP7BzxpxdPasD?=
 =?us-ascii?q?yVd4Gv3D5PfURcpX+EGReFgklMxAjsQX928d0mTUQhwn3eMfoEGKcKFN?=
 =?us-ascii?q?Hts5XPXQMzMiOxAFIHlueptg=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 20:05:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1654884328;
	bh=QwgAAbC6Usipws6Sg4OUD1etzrAsGIbJm3dc4NJPiGU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=JZN3hnEgO7VILEJmz1onSRGhBUrjJ/Li8Ql3+uk+N8YVoIq/7nQN+YwuppymFxOHw
	 vKffc3228w7fnezVbQC3xC87qBLgbVxUkeoGcHiwEb4RBTBordspaEBQzWH23qqdbG
	 ttppOVdz7sxPru7j5EGCVJnhzYaa9DDOpjEkvf2A=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.243.185.55]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Md6tt-1nPYqZ3Hkp-00aAlf; Fri, 10
 Jun 2022 20:05:28 +0200
Message-ID: <795814f1-ff32-f430-231e-74a7eb2c0436@web.de>
Date: Fri, 10 Jun 2022 20:05:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>,
 =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <a8c3479c-c8f1-da57-23fe-657c2f13872b@web.de>
 <alpine.DEB.2.22.394.2206101941520.2946@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2206101941520.2946@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:D0z+xzPDq6ws9wEE+sTpwv0N9qxq9K31HMAzmvgs6T8bRbYMk0V
 N2RbTEx92oOx/UiiFmq5MdcUFQs+vwJRsLO5FI3TzsN/gMVsKNJ/UDBXX7C8sWvkzM8uF4P
 tl++E5R4CG8RqvxYKKm0I0rGOVXrYx1EjvzceHEh9yZXe5Jx7+hqZLPgRPnVe0JgEm3vlAj
 3uZIDcz6RJ7i3mz9SQB6A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Aw47R2K6EWk=:IJs5rjBkgOAiFfqLbZpUhr
 dBE3WMT2408I2MA7rzZcYo4ZeyMBhm4cXr0CVHlv6cknlKQIi/GjJburY0UG2UFMXSvI+OotD
 Po24Oyc0bPzJlKfNsaqICnDeUTEbQ4yEavAmyp0+8w3FPa3prthuQ8EF8vUoXHkpgGAk4WtP+
 zt2KJke1qEE2nDPNV0faxSf1ycMP9vlVB2sVXhjvA6q97Xm9krjU/fCMjEzfHQFXU5FpWKrEH
 UCodt25fpPq/zp+LBJAK6ffZF6QhgT5yukLbTyv3nfs5iWVsDRMMgV0e/w7V8Rrj16sS/J2Ra
 c3VRt/Cg6EJ08d4ds+JHNSOlMSMZmlA3r6X/9y3CrlF/LFnUqhBa64HJ/uvGJljmxucYuAhxs
 RJMag75DlEkK2I1TNZjkQQL1gpzWxMN4dHLwvNi38sZaMxVk5RE/f6ZUSJeheCmO679yVyjXy
 ucyZr/BHkVvtlhD+0xO09i7C/WU+Xhcwdq1DuOo4rTH+qzbbwv8i3Z7oAvStiw71sYbcUMpwH
 ogG+KdBAUpbmzPy25N03FDT5j0thjUVpqMx9fIX+6HkrXSV91mzNCG0HW3kYFNLXPV3yU4YXF
 rXzBFFA9SCyhcHTV+/DqXOcr+D7xsCo5SbKw5UmH5VAkMwY51mupyr5xcqarJAFsZF2k7+XmA
 kiqFkeFedRzmRifx9Y8SmgyoXd4C6T3+eZRkn9DQPHLFINjCTuy9pAFZcfBrK259ebqQQKTh9
 5q/nTj3cIjkWLP8N7RwkYSRFNsNSo/hYjdSfu7jidjLU/FVBSSLRltRQN4yv4yJesRnJzG0da
 8bPBVaA0TqQ5upcbWm1a8e9OjZvkiN3Zs77h1SwScYctex0BKvS0K2kumkCD56GzHA/57MzHZ
 EwM2HjHDl1qK/PSrXIYBJ+igNZny9Ai0lUlv75oTsi8JloGb1zcC2QuNjYxykVWamsoeaKUFr
 ARVNVyOiq8zGvhJ0CO1J3C6REE+QLAc68cTeHDV5fFrDiZfTOt1PWTLRWDjdrOFdcO0/skY3I
 +cmyPOdI3zv7DL8yPHNEQG4LQXLKqbqk7Gtsn0ywDPYIiW1RSfj0NobnolJzwvqnwzzUOrdxC
 RO/TeBc+gHLx/IQFFU6U7euRun2WH2oWSfc18Y/mcIWVjqElnZDPgiEXw==
Subject: Re: [cocci] coccinelle: Extend address test from ifaddr to every
 test expression
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 436
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/795814f1-ff32-f430-231e-74a7eb2c0436%40web.de>

> void check(void)
> {
> int s =3D 1;
> bool t =3D (&s);
> }
>
>
> Thus I propose to add another case distinction by the means of
> a SmPL disjunction.
>
>
> *\( &x || ... \| &x \)
>
>
> Will any more adjustments become helpful for the handling of optional co=
de
> according to SmPL ellipses?
=E2=80=A6
> Did you actually try this?


My tweak demonstrates that it is possible to extend built-in software func=
tionality.


> Because it will match every occurrence of &x.


I admit that a really complete source code search approach would be
more challenging.


> I don't think that your example represents a real problem.


I found a tiny test case which indicates some implementation details
for further considerations.
I am curious if development interests will grow accordingly.

Regards,
Markus
