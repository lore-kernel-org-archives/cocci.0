Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ABDBC432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 10:58:00 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 891DD217BC
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 10:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uc3KdGpq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 891DD217BC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATAviA0003534;
	Fri, 29 Nov 2019 11:57:44 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5455D77D4;
	Fri, 29 Nov 2019 11:57:44 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C4BDE77D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 11:57:42 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:336] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATAvgfU014363
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 11:57:42 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id p17so8646879wma.1
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 02:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:sender:in-reply-to:references:from:date:message-id
 :subject:to:cc;
 bh=OCuKZh5Z1XjyjRX2/yyEfnYkaZTE1g+d1R0jziOYpZk=;
 b=Uc3KdGpq860UXok7SBNvuZp2AxzidgiPgD5IrcvzCfq7EskproFKoGYzm9dlZzHCEt
 J7nfHj0jTkC7Sqwu0SfS+LhHCqZlXyDMIHgYFrwnBBthAWpsI4wIF10gi/A5aijFG6DC
 xNJWQakK6OGrFwpVFM1feeQrolRcI7w6126q5DYOhVdx7bRSEPbPrBuFxiOWPv6LY1Ka
 VC55NVrN5jYYk+i1hjIhDOvIssCi7lJd4PPuuM0a54aDPbRuXAqqb9eY8DGOnJePDCYJ
 +mJT0s+u2Kh5hPw1Mj1tt7Ow8f4B4SHJ17iamg7xEAN2roA9L0RVTXWrngyaHeuKZ/u4
 ymoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
 :date:message-id:subject:to:cc;
 bh=OCuKZh5Z1XjyjRX2/yyEfnYkaZTE1g+d1R0jziOYpZk=;
 b=MMzWKaysgqhVke41SqS5Mk6qfhApnwtT5HsDi4DYl0HCzkDEEcblJYII+IYKiKFl8F
 fYNnvzLtEympjwCJtw+ujSgfnSrxXWH5halTj7mFc0ADx4LmJkAXMNclA+LTB4520Kel
 EYtMHQM34gDd6/YDhDjs5lwCTwLXcMpK3sF9Spe4/wQa1Q12/65C3MutzHi87pZ41UC2
 5R3f/0mhh/rssz37eStLD9P4JPSxwcD16NQrJOP+8JcjMQ0wbyefWVp9mNauohXD4e2S
 f86NdTy17Gri9PmWtQi1J1wpOlCFgSkcKxS9E+pDOC7sObfPdAnJlfvgdhYvEnWg5py3
 XZAw==
X-Gm-Message-State: APjAAAV5vlugo0neMI9ptW59YSfjNrLkbkhRuOYjPgxZZJ3TyYqCqE2f
 GgTL493TN/LHBhIz3glT4MxeeBgAG+xGyxerzuU=
X-Google-Smtp-Source: APXvYqxgGJ87vhbtejS+EvGTw1Vi/D8QhW5sld8OceOKamrTWVO7zRtyN/5X84cDqW+DNorSRQYa0vj3KFW/6YLUI2E=
X-Received: by 2002:a1c:5409:: with SMTP id i9mr13465745wmb.135.1575025061969; 
 Fri, 29 Nov 2019 02:57:41 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a5d:6cb1:0:0:0:0:0 with HTTP; Fri, 29 Nov 2019 02:57:41
 -0800 (PST)
In-Reply-To: <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
From: Strace Labs <stracelabs@gmail.com>
Date: Fri, 29 Nov 2019 08:57:41 -0200
X-Google-Sender-Auth: 1smIQO4G4vLDN1J3rFvV2MSLioQ
Message-ID: <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
To: Markus Elfring <markus.elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 11:57:44 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 Nov 2019 11:57:42 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
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
Content-Type: multipart/mixed; boundary="===============0922687825=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0922687825==
Content-Type: multipart/alternative; boundary="00000000000054c3c605987a192b"

--00000000000054c3c605987a192b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

>. Did you try out to work with SmPL ellipses and disjunctions for this
purpose?

I didn't it, do you have any suggestions or sample that is it possible to
solve my problem? something to based on.

 >> II could imagine that could be possible do using Python,.

> The application of the semantic patch language (Coccinelle software)
should be safer here, shouldn't it?

I mean, the Coccinelle/Python support.


--=20
Sent from my iPowerBall=C2=AE

--00000000000054c3c605987a192b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable





<div>
<div style=3D"color:rgb(33,33,33);background-color:rgb(255,255,255);text-al=
ign:left" dir=3D"auto">
<br>
</div>
<div>
&gt;. Did you try out to work with SmPL ellipses and disjunctions for this =
purpose?=C2=A0</div>
<div dir=3D"auto" style=3D"text-align:left">
=C2=A0</div>
<div dir=3D"auto" style=3D"text-align:left">
I didn&#39;t it, do you have any suggestions or sample that is it possible =
to solve my problem? something to based on.</div>
<div>
<br>
</div>
<div>=C2=A0&gt;&gt; II could imagine that could be possible do using Python=
,.=C2=A0</div>
<div>
<br>
</div>
<div>&gt; The application of the semantic patch language (Coccinelle softwa=
re) should be safer here, shouldn&#39;t it?=C2=A0<br>
</div>
<div>
<br>
</div>
<div dir=3D"auto" style=3D"text-align:left">
I mean, the Coccinelle/Python support.</div>
</div>

<br><br>-- <br>Sent from my iPowerBall=C2=AE<br>

--00000000000054c3c605987a192b--

--===============0922687825==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0922687825==--
