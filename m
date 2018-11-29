Return-Path: <SRS0=F12N=OI=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D2D6C43441
	for <cocci@archiver.kernel.org>; Thu, 29 Nov 2018 18:33:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBE9021104
	for <cocci@archiver.kernel.org>; Thu, 29 Nov 2018 18:33:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBE9021104
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wATIWnBQ019450
          ; Thu, 29 Nov 2018 19:32:49 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B7B7676D3;
	Thu, 29 Nov 2018 19:32:49 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5685376CE
 for <cocci@systeme.lip6.fr>; Thu, 29 Nov 2018 19:19:27 +0100 (CET)
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wATIJPNk029494
 for <cocci@systeme.lip6.fr>; Thu, 29 Nov 2018 19:19:26 +0100 (CET)
X-pt: isis.lip6.fr
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 29 Nov 2018 10:19:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.56,295,1539673200"; 
 d="scan'208,217";a="278887374"
Received: from fmsmsx108.amr.corp.intel.com ([10.18.124.206])
 by orsmga005.jf.intel.com with ESMTP; 29 Nov 2018 10:19:24 -0800
Received: from fmsmsx111.amr.corp.intel.com (10.18.116.5) by
 FMSMSX108.amr.corp.intel.com (10.18.124.206) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Thu, 29 Nov 2018 10:19:24 -0800
Received: from FMSMSX110.amr.corp.intel.com ([169.254.14.33]) by
 fmsmsx111.amr.corp.intel.com ([169.254.12.12]) with mapi id 14.03.0415.000;
 Thu, 29 Nov 2018 10:19:23 -0800
From: "Harris, TerryX" <terryx.harris@intel.com>
To: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Thread-Topic: Make error for coccinelle
Thread-Index: AdSID3SS0PJwLd0+Rwug/yHrVpjpPw==
Date: Thu, 29 Nov 2018 18:19:23 +0000
Message-ID: <D60BDFF2A21FFA448BB004AAB7DD16CD4084D760@FMSMSX110.amr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZjdkZGRiYTAtODI1OC00NzhhLWIxMjAtN2FiNTM2ZTRkNmIzIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjEwLjE4MDQuNDkiLCJUcnVzdGVkTGFiZWxIYXNoIjoiSUdNVVBzMGhSbXZDdmVDY205V0ZMZmVjVDlWV1NvOU9cL3I4MUlJcjRHREt6MkhNZWJSYWtKVzIrMXNUeisyVjkifQ==
dlp-product: dlpe-windows
dlp-version: 11.0.400.15
dlp-reaction: no-action
x-originating-ip: [10.1.200.106]
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 29 Nov 2018 19:32:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 29 Nov 2018 19:19:26 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Thu, 29 Nov 2018 19:32:48 +0100
Subject: [Cocci] Make error for coccinelle
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0337608435=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0337608435==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_D60BDFF2A21FFA448BB004AAB7DD16CD4084D760FMSMSX110amrcor_"

--_000_D60BDFF2A21FFA448BB004AAB7DD16CD4084D760FMSMSX110amrcor_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Trying to build coccinelle-1.0.7 on Ubuntu 14.07.5.LTS

I can't find stdcompat.cma. Is there a configuration option that generates =
this file


gmake: *** No rule to make target `bundles/stdcompat/stdcompat.cma', needed=
 by `parsing_cocci/check_meta.cmo'.  Stop.
Make error for coccinelle




Terry L. Harris | CompuCom
Software Technician
direct 480.554.9839
mobil 480.215.9680
terryx.harris@intel.com<mailto:terryx.harris@intel.com>
www.Compucom.com<http://www.Compucom.com>


--_000_D60BDFF2A21FFA448BB004AAB7DD16CD4084D760FMSMSX110amrcor_
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
@font-face
	{font-family:"Segoe UI";
	panose-1:2 11 5 2 4 2 4 2 2 3;}
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
<p class=3D"MsoNormal">Trying to build coccinelle-1.0.7 on Ubuntu 14.07.5.L=
TS<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I can&#8217;t find stdcompat.cma. Is there a configu=
ration option that generates this file<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">gmake: *** No rule to make target `bundles/stdcompat=
/stdcompat.cma', needed by `parsing_cocci/check_meta.cmo'.&nbsp; Stop.<o:p>=
</o:p></p>
<p class=3D"MsoNormal">Make error for coccinelle<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><b><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#262626">Terry L. Harris</span></b><b><span s=
tyle=3D"font-family:&quot;Arial&quot;,sans-serif;color:#262626"> |
</span></b><b><span style=3D"font-size:10.0pt;font-family:&quot;Arial&quot;=
,sans-serif;color:#C00000">CompuCom</span></b><span style=3D"font-family:&q=
uot;Segoe UI&quot;,sans-serif"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">Software Technician<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">direct 480.554.9839<o:p></o:p></span></p>
<p class=3D"MsoNormal"><span style=3D"font-size:10.0pt;font-family:&quot;Ar=
ial&quot;,sans-serif;color:black">mobil 480.215.9680<o:p></o:p></span></p>
<p class=3D"MsoNormal"><u><span style=3D"font-size:10.0pt;font-family:&quot=
;Arial&quot;,sans-serif;color:#2E74B5"><a href=3D"mailto:terryx.harris@inte=
l.com"><span style=3D"color:#2E74B5">terryx.harris@intel.com</span></a><o:p=
></o:p></span></u></p>
<p class=3D"MsoNormal"><a href=3D"http://www.Compucom.com"><span style=3D"f=
ont-size:10.0pt;font-family:&quot;Arial&quot;,sans-serif;color:blue">www.Co=
mpucom.com</span></a><span style=3D"font-size:10.0pt;font-family:&quot;Aria=
l&quot;,sans-serif;color:black"><o:p></o:p></span></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_D60BDFF2A21FFA448BB004AAB7DD16CD4084D760FMSMSX110amrcor_--

--===============0337608435==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0337608435==--
