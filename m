Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23275C432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 20:42:03 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 490E42075C
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 20:42:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LIQiuFI+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 490E42075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATKfimS014788;
	Fri, 29 Nov 2019 21:41:44 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 78A8577D4;
	Fri, 29 Nov 2019 21:41:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CEBD177CC
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 01:35:51 +0100 (CET)
Received: from mail-yw1-xc2d.google.com (mail-yw1-xc2d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:c2d] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAT0ZpWY017309
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 01:35:51 +0100 (CET)
Received: by mail-yw1-xc2d.google.com with SMTP id 4so10006763ywx.4
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 16:35:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:thread-topic:thread-index:date:message-id
 :references:in-reply-to:accept-language:content-language
 :mime-version; bh=FlzqedRxQSp0a6a5XIFVZ0/ydPIR5KC0sAIrqV5XrJA=;
 b=LIQiuFI+WfahJxzfDbhYKH4s2V+UkWoGbO+4IqkvrAQEoF7/vImH96uVxEVTPVFUi3
 m5L6NLSKVSVwEkIRw+bse5510lg/bNNh2SF9lcNP0P9dfEw/haDJQceCoOixzsu8GgTn
 qI57kxVYd56kKIWHPpXqzWXWQwCAISKsb/eHaB974q+aKtcewC4R/iJ7GezB9rexpsUt
 LvPp3JApOTd8gsma9GFsRXihxHuzhbWttDbSjjVHFN+fYyxFct4JVX9dcgFPeDW/eB6b
 NVgzY3/N2peiXcNlu2bc1mjwlHMdii8R3YU6WvXwnP6GWJdMOZhGpsusPWuVYaYLKV73
 D53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:thread-topic:thread-index
 :date:message-id:references:in-reply-to:accept-language
 :content-language:mime-version;
 bh=FlzqedRxQSp0a6a5XIFVZ0/ydPIR5KC0sAIrqV5XrJA=;
 b=s7GWVTPi2yFgks0F7pp1SlszoMPhDMM3TR2QAJKWQORrXxU5eXOD8sawnYRpqWhnmZ
 AQNZ10nHItmEmk5qAhHDcEI15XLIA2QWlKcMHshyXffS2SkNycIMw0QMr+bmoRSa8kAl
 5wRMuIpZMeN35sBDkmVaTFB4wziXScmpLueV6sGnjGx1buwrjrZhwk29jEQo3jSiZN1N
 xU83RMfrZ76CkIBjl52JtccKUu95Jidpo0rQfKDeKi7gJy2FUjc2jpOtpnN2MyuAOmzK
 W+z/Kq8x+kYL6nFWud1Xfc/Oo2t/+TRSEYQTsHGOq/5+FayjvqEMvPc15vKPrBLPbv4a
 o8Xw==
X-Gm-Message-State: APjAAAWqnheUDkmIg/HB/el5B+O1nzSe/sNKR9pT9mLYbm/dr4flU+kW
 JHT0uCs3anxie8PXSMzxYF6RYfd2
X-Google-Smtp-Source: APXvYqy0YAgvNVNXmCzvRrceMh/CXJ63d9ElcZZGHlVmWbvODmh1z1PNEcZJSAZcH501MYsxDJMKSw==
X-Received: by 2002:a0d:ddc2:: with SMTP id g185mr2252192ywe.265.1574987750146; 
 Thu, 28 Nov 2019 16:35:50 -0800 (PST)
Received: from CY4PR1801MB2005.namprd18.prod.outlook.com
 ([2603:1036:906:80::5])
 by smtp.gmail.com with ESMTPSA id i9sm9029944ywb.33.2019.11.28.16.35.48
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 28 Nov 2019 16:35:49 -0800 (PST)
From: Jorge Pereira <jpereiran@gmail.com>
To: "stracelabs@gmail.com" <stracelabs@gmail.com>,
        Markus Elfring
 <markus.elfring@web.de>
Thread-Topic: [Cocci] Replacing printf() parameters according to used data
 types
Thread-Index: AQHVpdAivwhZDvLPpEaLFOuLCcobRaehTjxN
X-MS-Exchange-MessageSentRepresentingType: 1
Date: Fri, 29 Nov 2019 00:35:47 +0000
Message-ID: <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>,
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
In-Reply-To: <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
Accept-Language: pt-BR, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-Exchange-Organization-SCL: -1
X-MS-TNEF-Correlator: 
X-MS-Exchange-Organization-RecordReviewCfmType: 0
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 21:41:45 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 Nov 2019 01:35:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 29 Nov 2019 21:41:42 +0100
Cc: "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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
Content-Type: multipart/mixed; boundary="===============0714496278=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0714496278==
Content-Language: en-US
Content-Type: multipart/alternative;
	boundary="_000_CY4PR1801MB200527E64CB2C5ECF218EFF4A3460CY4PR1801MB2005_"

--_000_CY4PR1801MB200527E64CB2C5ECF218EFF4A3460CY4PR1801MB2005_
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

For now, I just would like to detect and patch the mentioned example. I cou=
ld imagine that could be possible do using Python,.

Get Outlook for Android<https://aka.ms/ghei36>

________________________________
From: Markus Elfring <Markus.Elfring@web.de>
Sent: Thursday, November 28, 2019 4:50:55 AM
To: stracelabs@gmail.com <stracelabs@gmail.com>
Cc: cocci@systeme.lip6.fr <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing printf() parameters according to used data t=
ypes

> @r1_stack@
> struct mydata SMD;
> format F =3D~ "s";
> @@
> -my_printf("%@F@", SMD.name);
> +my_printf("%m", &SMD);
> $
>
> But, I can match only with partial content as can be seen below.

I find this information for =93partial content=94 unclear at the moment.

* Would you like to transform any more source code variants by using
  additional SmPL ellipses and disjunctions?

* How do you think about to extend and improve the shown change specificati=
ons?

Regards,
Markus

--_000_CY4PR1801MB200527E64CB2C5ECF218EFF4A3460CY4PR1801MB2005_
Content-Type: text/html; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3DWindows-1=
252">
<meta name=3D"Generator" content=3D"Microsoft Exchange Server">
<!-- converted from text --><style><!-- .EmailQuote { margin-left: 1pt; pad=
ding-left: 4pt; border-left: #800000 2px solid; } --></style>
</head>
<body>
<div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
For now, I just would like to detect and patch the mentioned example. I cou=
ld imagine that could be possible do using Python,.<br>
<br>
</div>
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
<span id=3D"x_OutlookSignature">
<div dir=3D"auto" style=3D"direction:ltr; margin:0; padding:0; font-family:=
sans-serif; font-size:11pt; color:black">
Get <a href=3D"https://aka.ms/ghei36">Outlook for Android</a></div>
</span><br>
</div>
<hr tabindex=3D"-1" style=3D"display:inline-block; width:98%">
<div id=3D"x_divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" =
color=3D"#000000" style=3D"font-size:11pt"><b>From:</b> Markus Elfring &lt;=
Markus.Elfring@web.de&gt;<br>
<b>Sent:</b> Thursday, November 28, 2019 4:50:55 AM<br>
<b>To:</b> stracelabs@gmail.com &lt;stracelabs@gmail.com&gt;<br>
<b>Cc:</b> cocci@systeme.lip6.fr &lt;cocci@systeme.lip6.fr&gt;<br>
<b>Subject:</b> Re: [Cocci] Replacing printf() parameters according to used=
 data types</font>
<div>&nbsp;</div>
</div>
</div>
<font size=3D"2"><span style=3D"font-size:11pt;">
<div class=3D"PlainText">&gt; @r1_stack@<br>
&gt; struct mydata SMD;<br>
&gt; format F =3D~ &quot;s&quot;;<br>
&gt; @@<br>
&gt; -my_printf(&quot;%@F@&quot;, SMD.name);<br>
&gt; &#43;my_printf(&quot;%m&quot;, &amp;SMD);<br>
&gt; $<br>
&gt;<br>
&gt; But, I can match only with partial content as can be seen below.<br>
<br>
I find this information for =93partial content=94 unclear at the moment.<br=
>
<br>
* Would you like to transform any more source code variants by using<br>
&nbsp; additional SmPL ellipses and disjunctions?<br>
<br>
* How do you think about to extend and improve the shown change specificati=
ons?<br>
<br>
Regards,<br>
Markus<br>
</div>
</span></font>
</body>
</html>

--_000_CY4PR1801MB200527E64CB2C5ECF218EFF4A3460CY4PR1801MB2005_--

--===============0714496278==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0714496278==--
