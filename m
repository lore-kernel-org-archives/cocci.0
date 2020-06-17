Return-Path: <SRS0=bgdO=76=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32612C433DF
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 03:29:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7E1CF2073E
	for <cocci@archiver.kernel.org>; Wed, 17 Jun 2020 03:29:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yf77IAiY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7E1CF2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05H3TVth009597;
	Wed, 17 Jun 2020 05:29:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 746997577;
	Wed, 17 Jun 2020 05:29:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C0FAB3D0F
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 05:29:29 +0200 (CEST)
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:b35])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05H3TS9L027921
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 17 Jun 2020 05:29:29 +0200 (CEST)
Received: by mail-yb1-xb35.google.com with SMTP id j202so540366ybg.6
 for <cocci@systeme.lip6.fr>; Tue, 16 Jun 2020 20:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=X4EybcHRxenEDQuoXysg3XTtLrroRlrKNIE/sS/uwO4=;
 b=Yf77IAiYZerB6rv3nSikba7LLrxWq+6bEmGYm108IU0CmxQNCn4OODktBghWgp/ev1
 d9Tz4BflgEjDaWaD6kii7mV7fflDonP/GXf0iR45HTb+szRcpJvG23454ZK1R3+Oaq7i
 LH2qKUBkME+3Cf+BezYPIdl8gNxcAToMl1CLWXUnMofVbPQPjANwfj/KKXUFckGlmiVZ
 MV7BW87+X1nsk3O21LAAtC39FxW7peMoJ4/9qqpkdRzihJ4PeirnnU0P4f+9JZ9cyy6n
 GyJ3n6Kp0w3EnQCabYX+uHAzqHVyGxG8s+d7mlyE4AbcsggUy38m+denavtdUh58kz4G
 QMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=X4EybcHRxenEDQuoXysg3XTtLrroRlrKNIE/sS/uwO4=;
 b=FuHoJto83uxNnjts87RUzviqAP/yhl0AJCvZOch6iK1bq7lPosYUtuKKRwrU31Gqki
 CU9/8alFo44aqvvlndCHmBS8LRqWPWtEaIRpj7j9IA53BA99DTxL0nelpk/Juuj538lx
 5EwYLEF9xGRiuUp7Bn9Sly9NV4rL8JkoHYUhP8JIXyjv4eC9nLFpURushPs6KY0ZVA/q
 eYrs7q/CdDBwhmMNAIKJaMAUJVpZ3dWfUf/RhGnJpzH2j6H+ASHOHRT/Ff+vkwYz6tHB
 afwyT2pN+W/DAPFGbeu/V2MhJjNb4jE/c2Lg3NF7KY4DKj3EULID2gryC7Uizu/X91yJ
 c/FA==
X-Gm-Message-State: AOAM533EGWnJ3K9+izQcwd8PmlRdiBGhhmkB13+eYekquhRAg045wYUI
 GeuDv56Mp+bMJCujc1D3mX56r3uqHDf/rXBXQLY=
X-Google-Smtp-Source: ABdhPJydSMM1qf6myV/xfliXH7TL/5PZNG9sas+GptxlGnZnbqZsC+wG/qaiFwKyd9zUvwixCIcmAMUxHfVLL9uXPWM=
X-Received: by 2002:a05:6902:68b:: with SMTP id
 i11mr9236778ybt.396.1592364568034; 
 Tue, 16 Jun 2020 20:29:28 -0700 (PDT)
MIME-Version: 1.0
References: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
In-Reply-To: <37e4e561-8d88-263a-0037-f58cb8c1861e@web.de>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Date: Wed, 17 Jun 2020 08:59:17 +0530
Message-ID: <CALOnNCpr_-1BLPN+Bayof6XjLLvVrMgR4Z+EHpC_8RnAOWiD0Q@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 17 Jun 2020 05:29:31 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 17 Jun 2020 05:29:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Software analysis around data type annotations
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
Content-Type: multipart/mixed; boundary="===============1266113976=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1266113976==
Content-Type: multipart/alternative; boundary="0000000000006e3ed805a83f4475"

--0000000000006e3ed805a83f4475
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

I'm away from my computer right now so can't test this, but try declaring
__iomem as an attribute:

@display@
identifier action;
attribute name __iomem;
@@


On Tue, 16 Jun 2020, 10:21 p.m. Markus Elfring <Markus.Elfring@web.de wrote=
:

> Hello,
>
> The support for data processing with attributes was extended recently.
>
> https://github.com/coccinelle/coccinelle/commits?q=3Dcommitter-date%3A%3C=
2020-06-16
>
> Under which circumstances will a source code analysis approach become
> supported
> by a script (like the following) for the semantic patch language?
>
>
> @display@
> identifier action;
> @@
> *void __iomem * action(...)
>  { ... }
>
>
> elfring@Sonne:~/Projekte/Coccinelle/janitor> spatch --parse-cocci
> show_iomem_functions.cocci
> =E2=80=A6
> minus: parse error:
>   File "show_iomem_functions.cocci", line 4, column 14, charpos =3D 46
>   around =3D '*',
>   whole content =3D *void __iomem * action(...)
>
>
> Regards,
> Markus
>

--0000000000006e3ed805a83f4475
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><span style=3D"font-family:sans-serif;font-size:12.8=
px">Hi Markus,</span><div dir=3D"auto" style=3D"font-family:sans-serif;font=
-size:12.8px"><br></div><div dir=3D"auto" style=3D"font-family:sans-serif;f=
ont-size:12.8px">I&#39;m away from my computer right now so can&#39;t test =
this, but try declaring __iomem as an attribute:</div><div dir=3D"auto" sty=
le=3D"font-family:sans-serif;font-size:12.8px"><br></div><div dir=3D"auto" =
style=3D"font-family:sans-serif;font-size:12.8px">@display@</div><div dir=
=3D"auto" style=3D"font-family:sans-serif;font-size:12.8px">identifier acti=
on;</div><div dir=3D"auto" style=3D"font-family:sans-serif;font-size:12.8px=
">attribute name __iomem;</div><div dir=3D"auto" style=3D"font-family:sans-=
serif;font-size:12.8px">@@</div><br><br><div class=3D"gmail_quote"><div dir=
=3D"ltr">On Tue, 16 Jun 2020, 10:21 p.m. Markus Elfring &lt;<a href=3D"mail=
to:Markus.Elfring@web.de">Markus.Elfring@web.de</a> wrote:<br></div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex">Hello,<br>
<br>
The support for data processing with attributes was extended recently.<br>
<a href=3D"https://github.com/coccinelle/coccinelle/commits?q=3Dcommitter-d=
ate%3A%3C2020-06-16" rel=3D"noreferrer noreferrer" target=3D"_blank">https:=
//github.com/coccinelle/coccinelle/commits?q=3Dcommitter-date%3A%3C2020-06-=
16</a><br>
<br>
Under which circumstances will a source code analysis approach become suppo=
rted<br>
by a script (like the following) for the semantic patch language?<br>
<br>
<br>
@display@<br>
identifier action;<br>
@@<br>
*void __iomem * action(...)<br>
=C2=A0{ ... }<br>
<br>
<br>
elfring@Sonne:~/Projekte/Coccinelle/janitor&gt; spatch --parse-cocci show_i=
omem_functions.cocci<br>
=E2=80=A6<br>
minus: parse error:<br>
=C2=A0 File &quot;show_iomem_functions.cocci&quot;, line 4, column 14, char=
pos =3D 46<br>
=C2=A0 around =3D &#39;*&#39;,<br>
=C2=A0 whole content =3D *void __iomem * action(...)<br>
<br>
<br>
Regards,<br>
Markus<br>
</blockquote></div></div></div>

--0000000000006e3ed805a83f4475--

--===============1266113976==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1266113976==--
