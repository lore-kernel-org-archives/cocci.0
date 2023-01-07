Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166BEC46467
	for <cocci@archiver.kernel.org>; Sat,  7 Jan 2023 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=j7GTVgyHC50v3Vc2qUJPxgDVUUAqWYr2UAB4IlAugjM=;
  b=g3vy+/zy8BHta6mIfr26sas7BBpKMp7YoWrTBWeNQwhEfyb5JLreqLfA
   e3AUceWnKAOHWh/NO/TIoQBn52QpCYow+eBTnh/F9zW33eWF9yAbFLPm7
   fVcSFIA81h/BzS/4a3y6uTjURpz2t9wyYmyOmLYax/jqJgKQMe04dq3Bj
   g=;
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
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86415151"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jan 2023 14:12:02 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 49033E5A73; Sat,  7 Jan 2023 14:12:02 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D23C4E5A70
	for <cocci@sympa.inria.fr>; Sat,  7 Jan 2023 14:11:58 +0100 (CET)
IronPort-SDR: 63b96f9f_Vr+Ei+zi0Kh5u10bh+i4iHfjnCfM/vRMVj0x23ZcWDujCiq
 uxfHKIF2gsl25SJmcZatsfHkqdj2W0bpiu/53Jw==
X-IPAS-Result: =?us-ascii?q?A0EuBwCybrljhwMP49RaHgEBCxIMQIFRgiuBXS4EC0WET?=
 =?us-ascii?q?5EihCuHJYcxiGKDFj4PAQMBDUEBAgQBAQMEhH4ChRICHQcBBDUFDQECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBARoJFwcOEAUihTsIJQ2CO?=
 =?us-ascii?q?CkBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHUz0BAgIBIx0BAREnB?=
 =?us-ascii?q?AsLGgImAgJXBgEMCAEBgnqCbgEDDiMHsFeBMoEBgggBAQacCB8sIlOBXgmBF?=
 =?us-ascii?q?C2Mb4QxJxCBVUSBPAyCdz6IG4JnjxWKToE9fIEnDoFJJQQOAxkrHUACAQttC?=
 =?us-ascii?q?kA1CQILSysaGweBCiooFQMEBAMCBhMDIAINKDEUBCkTDScmawkCAyJhBQMDB?=
 =?us-ascii?q?CgtCSEfBxURJDwHVjcBBAMCDx83BgMJAwIfUHACLhETBQMLFSpHBAg2BQYbN?=
 =?us-ascii?q?hICCA8SDwYmRA5CNzYTBoEHCw4TA1CBTgQvXn8KBlGhNMMINAeCI4FPgVAMn?=
 =?us-ascii?q?nEGEy6DZgGTDw4Gkhsdlywgp2KBeiKBXDMaJE+CZ08DGQ+NQ10ZhAyKLEA0O?=
 =?us-ascii?q?wIHAQoBAQMJhUcBAYZaAQE?=
IronPort-PHdr: A9a23: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
 9/SiOTsJT0E/9+GpaP04uDLJcjBPHdzaXLU
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:LLgQZqOwcAOZOMBcT3v155DYdb4zR+YMi2TDj3oBMCC8cqSj9v
 xG785rrSMc6QxhHE3I9urwXZVoLUmyyXcx2/h2AV7AZnighILLFvAH0WKK+VSJcEeSmtK1l5
 0QFJSWY+eRMbEOt7eZ3ODOKadC/DDoys6VbKzlvgxQpElRGttdB/sSMHfRLqWILjM2TabQ6v
 Cnl4N6TnObCAgqhsjXPAh5Y8HT49LMj57oehgAGlou7xSPlyqh7PrgHwGfxQp2aUI6/V4Oyx
 m2r+XC3NTXj9irjhvHk2PD5ZVfn9XsjtNFGcyXk8AQbjHhkByhaohtU6CL+GldmpDY1H861N
 3X5xswNcV67H3cOmmzvBv2wgHllDIj8WXrx1OUiWbq5cb5WDU5Acxcgp8xSGqv12Mw+NVnlK
 5b1WOQsJRaSRvGgSTm/tDNEwpnk0KlyEBS4tI7njhaS88TebVRpYsQ8AdeC5EbBj/374ghDa
 1nENzc7Ow+SyLRU1nJ+m10hNC8VHU6GRmLBkIYvNaOzjRQlHdli0MF2c0EmGsa/p5VcegI2w
 yMWp4Y2o2nOKctHONA7Mlre7r2NoSNKSi8fF57VjzcZe4601Knke+13Fz03pDbRHR6pKFC2q
 gpfGkoxFLaIXiedvFm9Kc7jCwkQg2GLHHQ9v0=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,308,1665439200"; 
   d="scan'208";a="86415143"
X-MGA-submission: =?us-ascii?q?MDEH9f3u6wDMAjRuRA8G7s0x0osqHWTxawmLPR?=
 =?us-ascii?q?wvmqIkLnt/W0k70+3opkZYCttjmAUf9uduMJhW0V76AgFnCdWwsXZcMv?=
 =?us-ascii?q?WKOEVDdFhoTAqxQ6LfFkGMWWjvl8HGNr4lilNy8zuwyG91vOz3qwX4sI?=
 =?us-ascii?q?5nLTzZEUW/MAvBb/YGBRi/4g=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2023 14:11:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1673097118; bh=j7GTVgyHC50v3Vc2qUJPxgDVUUAqWYr2UAB4IlAugjM=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=DbGqY64gTjow10beI9JcwjOiweKeKlaOuS26IyD5tBV1fygu/Y8OGcMTD0FsTFep9
	 Cd6CRMFSxGO6ghZZ/HwX4w1pSbtoWpIgRTEcKP+IhOcnUQ2Iqpz7NLSSfGU8dIAaga
	 sokLXh/ioPj6Hkx2IRVgBKyxHhbKx0HSsJKpteblzP/noKbZCmbgwzbLNWTP5iVzrz
	 xKLQbG1Ni60u5apyfYbSDHBqUTrwKm6zdS8oa8rVoXKks0pvP7EnFg9gRVRcHZ+JJs
	 1QvBW52iPK1oR3NeIihcR6S8ydxyAKxFLBx4Xg5+ZVP1PGskR8OBV0uiUdMxyIUkSd
	 7TPxy1P5PXiEA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsKF-1oWWNi3NQJ-00ik3v; Sat, 07
 Jan 2023 14:11:57 +0100
Message-ID: <cfa05a5d-1835-c58b-dc28-4b017cebe2f2@web.de>
Date: Sat, 7 Jan 2023 14:11:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <7da2d07d-c1fb-1a58-8b57-3d1248f70c87@web.de>
 <alpine.DEB.2.22.394.2212260740380.2980@hadrien>
 <ae73c3b9-1f8e-4069-5bce-9380a187e1ac@web.de>
 <9fcc50af-da1a-6d71-934-b87d383ed38c@inria.fr>
 <c8d60641-ae23-948b-5b03-ceb9fc16210e@web.de>
 <alpine.DEB.2.22.394.2301071354000.2795@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2301071354000.2795@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vtoMQoow6Zn7sdvgqqGEMQftkIB3M1PNLPpt2KD1cvVBI8A1Uh9
 ZGl7Ozs/eeY2Dbp9cM2iDSR8n+RW2EioTiilcKYqVYFpEG05MESIHGGViYsjS0qxN1P5vNZ
 NN7XtxXIgw1s7yLjPF61h+bGHL9HC2yPupXyU+yr/J7t73q217oY1QlTpBJRsQ8bId1lJjM
 JE3RBrcEgwIb1sN8taYsg==
UI-OutboundReport: notjunk:1;M01:P0:99E3JAUmUfI=;LyKj6mQD9jtVH2BVe3aN2WdkzeH
 Yvj2OMl8dlc457RmTbMnlGJ7DlRqgEoapL1zB65qkuVhV2Fpe+WVCo5NsLKsFiV+mfx+8O4ax
 ZZYi/gN9rv5+flFJ67OBaDzvWmsM01e9nDacwc7QEDwCju+bJv5q111IDURko3LHAhvZ6kA0E
 dahurnhmgpkPvNqXRyzlh9d/ODUx1q7shudk/nks8JWUqMMjrpW3vZ+52cMF9f+mIpdsmmFTl
 y3sO+RwIBzi77M2fY390jNMyLMTFule+ZmTfRj2Rz3DocWhkDZzIKaPbGpBjHW6F6jzRDzwgm
 KaOCeJ4lHLa+uZuacpfCd0hC5rP6/WYBF7ma21EYoN2hWO4C3l47xkR7mzcbtmgbNajdbaFVu
 ZawA0wODlKGucuJRL2zy4ZXqflP5+e4isNWRFEZLsXS74dpv4aiZnFsItzf7lRBFeDGhc9tGk
 NWQQVC5CYhCO6yszH55vTMZ1TxgF4PLVdEQllLNJ7LoTv3tFWTtu/6qj2v2LMtbdWspD2PgSZ
 D2HksiD+AwD+O286QgVBYIQelvIsAoQjVIwy/GbfL5F2xxPCyRE9TBDIcPWkxwSgRKyMvC401
 vFMo9wX7C4eh6fJm9RmFM0vb0HjXYhimAfqUk5odKqsLdQH7/rSaTOx3zlvqRJFwkHWhaEs0g
 3C2qblXzPMJ/CnvZze8R1HvbxDmtm/JZ4Z6kkrmpwEqAccrnsjnbEy1v85GPSh9AEGK5PyayZ
 pRKdJUY7BIvK6QjVxN6WvYqnnSdjdJlXNdOXiZlgdN46Drf4ppDHwjbIvT+2xOOAtxKJupJbs
 wmtAjUlDRdVaC0TmgJItZBl/6IDwVh4tJVGWSj+irQtKERHgSyS4vBVVjPx6qLel9YRkyU97a
 /xQ3Imc0TkkkU2nsBjg3cyHpnxBnbHd8D/mA10pdeRKlVytkGy/UlPMDmCbwX3kGp6EkAvhmz
 ffeGrQ==
Subject: Re: [cocci] Working with filled data structures
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 808
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/cfa05a5d-1835-c58b-dc28-4b017cebe2f2%40web.de>

> If you want to be sure that the list is not empty, you can either use
> python to put a constraint on the length


Would this data processing approach need an extra SmPL rule for
a supported scripting language?


> or make a pattern that contains one element followed by a list.

Would this design variant need pairs of metavariables?


How do you think about the possibility to add a corresponding metavariable
type like =E2=80=9Carray=E2=80=9D?

Regards,
Markus
