Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2155DC25B7E
	for <cocci@archiver.kernel.org>; Sun,  2 Jun 2024 14:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:date:message-id:mime-version:references:subject:
   reply-to:sender:list-id:list-help:list-subscribe:
   list-unsubscribe:list-post:list-owner:list-archive;
  bh=DNM/j+OiUL3tcyXzS4zHt8U4EhvZuT4BbmpHY8FD/mQ=;
  b=aKbaqMXA2VELlDxmjeLjZjpDeWe1tBEX3PtktvTD9LjJ5uEbnW4MquEc
   R/nh24TupQL1ZHzxmzHSy99mTGETFuc/H5NC0JmnkXdzuHF1QpRdcINFi
   QNFT22rDU3WYHV6hM4N0rugq7HOJbpIDcl6CCsaP7eAOW7RcRHDJ0fKxN
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@samsung.com
X-IronPort-AV: E=Sophos;i="6.08,209,1712613600"; 
   d="scan'208,217";a="168585898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Jun 2024 16:21:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4F36EE0141; Sun,  2 Jun 2024 16:21:42 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2DD4EE0133
	for <cocci@sympa.inria.fr>; Sun,  2 Jun 2024 16:18:04 +0200 (CEST)
IronPort-SDR: 665c7f1b_one+3cdlmp5DychSri3w7CmudbfYnU7xAVxhSi3nYfCVtmj
 Y4wv7QEXiPBzPnjJVAEZGWRw0gEiiPysuzeRRug==
X-IPAS-Result: =?us-ascii?q?A0H7CwCJflxmmAtkvdNaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?U8CgT+BA3oCPSAwBwhIHY01hFuFVZBRi3uBQD4PAQMBDAEUExsCBAEBAwSNX?=
 =?us-ascii?q?QIfBgEEMgcOAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBA?=
 =?us-ascii?q?QEBAR4ZBQ4QJ4V0AQyCYBiBDl5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBE?=
 =?us-ascii?q?QIIYQEfBi0TAQE4DwIBTjElAQEEG4J4AYIcSAEBBgKuXoE0gQGCDAEBBoJm2?=
 =?us-ascii?q?TeBYwmBSAGCVjSBZ4M/ASSBMYQkhEMnD4FVRIQPAYt0mWWMKCYLQYgTLIEfI?=
 =?us-ascii?q?gMmMzIBDxE1ExcLPh0CFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjAwgEA0IDI?=
 =?us-ascii?q?HERAwQGFAQLB3WDJQQTRAOBN4lzgzuCIIQcS4RwgWsOYYgcgXOBQ4FqUoErg?=
 =?us-ascii?q?R8dQAMLB2Y9NRQbBgIBgTWlbASEF4JLgWqhakeOBZRRNAeEFgWBVwYMn0suF?=
 =?us-ascii?q?6o2hjSSMCCoQAICAgIJAheBbAMwLoEuTSODN08DFwIPjjqDYck1eDsCBwsBA?=
 =?us-ascii?q?QMJhWmDOSwBgRsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b7Kq7Ox3l2r
IronPort-HdrOrdr: A9a23:ZKM4WKpETMgm70ArphGj3EkaV5q+eYIsimQD101hICG9Kvbo7f
 yGttAgkSLFsRp5YgBWpTnyAtj8fZq8z+8F3WFyVY3JYOCCggaVxe5ZnPPfKlHbakjDH41mpN
 ddmspFeabN5DFB5K6QjGbXc6dCsbu6GeKT9K7jJhxWPGZXgtRbnn5E43GgYytLrWd9dP4E/B
 P23Kt6T7TJQwVkH7GG7qVsZZmxm/T70LjDW1ojDx4jyCTmt0Ld1JfKVzK95FMkVTVT5b8j9E
 jp+jaJkJlL+MvLtiM0n1WjkKi+tuGRtOd+OA==
X-Talos-CUID: 9a23:c2uP4m18yz2l5lmAER2bK7xfM+kHUmX2nEnpEWCySjpvUrLLT2e8wfYx
X-Talos-MUID: 9a23:/Eow7gox5VHeNJuD5tIezzNAM95U7P71MxgQicQ7ps6WaidJGijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,209,1712613600"; 
   d="scan'208,217";a="168585639"
X-MGA-submission: =?us-ascii?q?MDFZURgT5es2H5R8bjBHD+2hvaoK4IcvWj21Z0?=
 =?us-ascii?q?XZcAL0Ei8DhPzUyb+USTGN0WnLDYZZlva8lzQBKF6m1czgz8H0YVSG3p?=
 =?us-ascii?q?kRmjq9vx0wtvFxsINAtaK51bbxHqXgbJowRELe4gKkMlVplZk82lqwZp?=
 =?us-ascii?q?XiiEEJ2uNvPWUtTa5onqFAcQ=3D=3D?=
Received: from mailout1.w2.samsung.com ([211.189.100.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2024 16:18:02 +0200
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
	by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20240602141759usoutp01dfd6001c7cbe2b4d39387cf0e5e52eff~VNbPz_vx42685126851usoutp01F
	for <cocci@inria.fr>; Sun,  2 Jun 2024 14:17:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20240602141759usoutp01dfd6001c7cbe2b4d39387cf0e5e52eff~VNbPz_vx42685126851usoutp01F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1717337879;
	bh=DNM/j+OiUL3tcyXzS4zHt8U4EhvZuT4BbmpHY8FD/mQ=;
	h=From:To:Subject:Date:References:From;
	b=F9dTNcHnJhmC85Fxbm1SIkhvnA++lKcy0m9+x8YopYkqS1Zps5sK7c++zyMPlOUE4
	 68cuLfWYsD5UKTYfigRJw5OtTZPY0+h8fBLkGFrTsZlcxjSZcewzC03y/fbsexIDED
	 JdUVcp4CyybWtzVf/nUaP9PH78j/a8T7XSrSd4YE=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
	[203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240602141759uscas1p2ff06be7ecd368d2cc9643c5f057ef735~VNbPOmDAL2976329763uscas1p2q
	for <cocci@inria.fr>; Sun,  2 Jun 2024 14:17:59 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
	ussmges1new.samsung.com (USCPEMTA) with SMTP id 9B.02.09616.71F7C566; Sun, 
	2 Jun 2024 10:17:59 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
	[203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
	20240602141758uscas1p292dac565d2e37b835caaccab029d456f~VNbO81psc0957609576uscas1p2j
	for <cocci@inria.fr>; Sun,  2 Jun 2024 14:17:58 +0000 (GMT)
X-AuditID: cbfec36d-265ff70000002590-f6-665c7f171276
Received: from SSI-EX1.ssi.samsung.com ( [105.128.3.66]) by
	ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 08.9F.09511.61F7C566; Sun, 
	2 Jun 2024 10:17:58 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
	SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
	(version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.1.2507.35; Sun, 2 Jun 2024 07:17:58 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
	SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2507.035; Sun,
	2 Jun 2024 07:17:58 -0700
From: Ali Raza <ali.raza@samsung.com>
To: "cocci@inria.fr" <cocci@inria.fr>
Thread-Topic: Function name change
Thread-Index: Adq095WBxLVEZ8c8SFCbGlVSQklhhg==
Date: Sun, 2 Jun 2024 14:17:57 +0000
Message-ID: <81137f7b03f14e0fa92ef726f552a102@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: multipart/alternative;
	boundary="_000_81137f7b03f14e0fa92ef726f552a102samsungcom_"
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42LZduzreV3x+pg0g8lHuSxeXmpldWD0mPTi
	EEsAYxSXTUpqTmZZapG+XQJXRmfLbaaClyoVJ1Y/YmlgnKHQxcjJISFgItG1aCtzFyMHh5DA
	SkaJj2ZdjFxA5iwmiUk7DjHD1Hy8OoMdIrGGUeLq5iY2COcjo8TEV/+YQKqEBJYySpw66A8y
	iU1AVeLwHXcQUwTIvPAiFcQUFpCV2HASrFhEQEliw66rzBC2nsTpHxvZQWwWARWJSx0v2EBs
	XgErif9vFzKC2IwCYhLfT60B62UWEJe49WQ+E8RpghKLZu+BOlNM4t+uh2wQtqLE/e8v2SHq
	kyQ27F7JCDFTUOLkzCcsEDWSEgdX3GAB+URC4C27xPUp36EGuUjMudLDDmFLS0xfcxmqoV6i
	89BHqIYeRonLC+YxQiSsJe4d/s8CsY1P4u+vR4wgD0sI8Ep0tAlBlHhIbP8+iQUSUrESZ4/v
	YZ/AqDALyT+zkNw6C8mtEHEdiQW7P7FB2NoSyxa+Zoaxzxx4zIQsvoCRfRWjeGlxcW56arFh
	Xmq5XnFibnFpXrpecn7uJkZgkjn973DuDsYdtz7qHWJk4mA8xCjBwawkwttXF50mxJuSWFmV
	WpQfX1Sak1p8iFGag0VJnNfQ9mSykEB6YklqdmpqQWoRTJaJg1OqgcnU/0a/gIuJb+hL7j63
	0yc3bMvc/LDgzNK8advmmnxfF7SfS9f6iyXfxN4o84AlXSWyDEt4U9tl1IV//2x0P69bW2f7
	clZX6VOPthmTrrTe574eJRvjUpQ0WSPQWOenDevXaxvVE9+I1yYyeFxqWN/uv/rxoijvVyJx
	JurN/2r55FZy7Nozw/6Twmo+rkNzQ47bV6/5v3X9t8pylgVefg2H9CZxLz8mdiMraYpLiMa6
	wm+mV58JOPgcznjj8TJIP3DKyl0v7od9ZF2+YOUbC+OfYe9+PjvY4lMnHcG9SGuDbsbpcie1
	SRzMznxun+3OhUnf3yk452VX4IznvOukLbOWN69v0ErakGgUw/EnRYmlOCPRUIu5qDgRAExP
	X1+hAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrILMWRmVeSWpSXmKPExsWS2cDspCtWH5NmMHejqcXLS62sDowek14c
	YglgjOKySUnNySxLLdK3S+DK6Gy5zVTwUqXixOpHLA2MMxS6GDk5JARMJD5encHexcjFISSw
	ilFi9dR5UM5HRoldrz4ygVQJCSxllOiYr9LFyMHBJqAqcfiOO4gpAmReeJEKYgoLyEpsOAlW
	LCKgJLFh11VmCFtP4vSPjewgNouAisSljhdsIDavgJXE/7cLGUFsRgExie+n1oD1MguIS9x6
	Mp8J4jQBiSV7zjND2KISLx//Y4WwFSXuf3/JDlGfJLFh90pGiJmCEidnPmGBqJGUOLjiBssE
	RuFZSMbOQtIyC0kLRFxHYsHuT2wQtrbEsoWvmWHsMwceMyGLL2BkX8UoXlpcnJteUWycl1qu
	V5yYW1yal66XnJ+7iREYK6f/HY7ZwXjv1ke9Q4xMHIyHGCU4mJVEePvqotOEeFMSK6tSi/Lj
	i0pzUosPMUpzsCiJ8959oJEqJJCeWJKanZpakFoEk2Xi4JRqYGrcclA29MecqPkvXofbO3gw
	+m7jktzFfqb/9pObie5H+rZXPOK0k/2Rb692eOrGGTVf187UTXi3QmVt3In5T6r7pjnnzTfd
	nlYuvsfufkGd8jI7wf3XfQNfbFi1nf3uoVfXnyyeNfWBJ/vEOZd2TBTfz/z5gc+i06uenjoR
	dibk1royvsfNVpH6P8r4d9ZOTPA9MDvgR/8Jn+po+fs3Za9s2z9xz6NfvJoxbDuOM8gZfDH2
	eFiYw5Yzc0E9g5fvpVk/HXzMrpdpKzHY5TysYhKU7da6va5tcrbxyrMGgTeVpip5KS5YsdSm
	ZKPYnpPrn7zmPaRx8fvzi1OX3dBSfSLNqn9baUpnVdwZq3O+n6wClFiKMxINtZiLihMByzOO
	AgQDAAA=
X-CMS-MailID: 20240602141758uscas1p292dac565d2e37b835caaccab029d456f
CMS-TYPE: 301P
X-CMS-RootMailID: 20240602141758uscas1p292dac565d2e37b835caaccab029d456f
References: <CGME20240602141758uscas1p292dac565d2e37b835caaccab029d456f@uscas1p2.samsung.com>
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] Function name change
Reply-To: Ali Raza <ali.raza@samsung.com>
X-Loop: cocci@inria.fr
X-Sequence: 1770
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/81137f7b03f14e0fa92ef726f552a102%40samsung.com>

--_000_81137f7b03f14e0fa92ef726f552a102samsungcom_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi

I am new to using spatch, and I have been through many resources online but=
 cant figure out how to write a patch for the following function name chang=
e.

I have the following.

MY_MACRO(foo(arg1, arg2,
                                           arg3, arg4, arg5));

I want to change foo to bar, as follows.

MY_MACRO(bar(arg1, arg2,
                                           arg3, arg4, arg5));

I have tried many versions of the following, but to no avail.

@@
expression E;
@@
<...
-foo(E)
+bar(E)
...>

Thanks!

Ali


--_000_81137f7b03f14e0fa92ef726f552a102samsungcom_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:#954F72;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I am new to using spatch, and I have been through ma=
ny resources online but cant figure out how to write a patch for the follow=
ing function name change.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have the following.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">MY_MACRO(foo(arg1, arg2,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arg3, arg4, arg5));<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I want to change foo to bar, as follows.<o:p></o:p><=
/p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">MY_MACRO(bar(arg1, arg2,<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; arg3, arg4, arg5));<o:p>=
</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I have tried many versions of the following, but to =
no avail.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">@@<o:p></o:p></p>
<p class=3D"MsoNormal">expression E;<o:p></o:p></p>
<p class=3D"MsoNormal">@@<o:p></o:p></p>
<p class=3D"MsoNormal">&lt;...<o:p></o:p></p>
<p class=3D"MsoNormal">-foo(E)<o:p></o:p></p>
<p class=3D"MsoNormal">&#43;bar(E)<o:p></o:p></p>
<p class=3D"MsoNormal">...&gt;<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks!<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Ali<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_81137f7b03f14e0fa92ef726f552a102samsungcom_--
