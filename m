Return-Path: <SRS0=im/Y=K6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC5C6C4743D
	for <cocci@archiver.kernel.org>; Fri,  4 Jun 2021 19:27:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EE761404
	for <cocci@archiver.kernel.org>; Fri,  4 Jun 2021 19:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EE761404
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=googlemail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 154JRVJA025314;
	Fri, 4 Jun 2021 21:27:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EAE483F99;
	Fri,  4 Jun 2021 21:27:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6385B3E3B
 for <cocci@systeme.lip6.fr>; Fri,  4 Jun 2021 20:53:16 +0200 (CEST)
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:22d])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 154IrBqk027999
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 4 Jun 2021 20:53:12 +0200 (CEST)
Received: by mail-lj1-x22d.google.com with SMTP id w15so12791931ljo.10
 for <cocci@systeme.lip6.fr>; Fri, 04 Jun 2021 11:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=qxVn/yUG45dKftO0TfqR+SNYkBiPSWtBpTpxmLOnfH4=;
 b=Pjsr3/EBWDJiFr+ghxfKY1GZo1s25He8DBClLfFfhdYAZ0CzW5vzcmAQwPZ2hB0h6d
 C9Ft1C7upnQ1KyPg0vpYxHHDmW94w7Et75qERHDhHPzS8+F3yZWo0hyJgTxmfDgEwFFZ
 rCFNyKktswmk4oqOpr+YCYRMWVnNOw0P1Dd1jeExz0eClDCZyI8+9+5zvoeH2EKoV6dw
 Ss+14VgPhw/LBpi6e22efvkGAwABw+AB5schGNtIftw8BKa03vN49+NC/7d80rvhpnBd
 ttUSU035I64WU8gT5lpnK0VsUZ0IyS43U6lw9CrjTEe/7r4rHSd1QQsWq/seHYlpv/fj
 +f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=qxVn/yUG45dKftO0TfqR+SNYkBiPSWtBpTpxmLOnfH4=;
 b=lt4/eVWCaJEKCOyecKTe4KBT2T4iZaTWosuOLzORTtb+ohOuhhcN1iJmsXNdP7D3lZ
 oac4sJ9aSyO0U3NdFAZbyleYH2jws38cPx3oVxDRG1sPMOc9xudk9rbiGyBCy/8lWqnH
 LBhGRhcYWCpcBLTQCHRRe3DRn0xnc6BImvZa6eANuvLeUiinufjUu+8u1mh6Gk0SBCoz
 ChqU5e+es/cBUB3ZboNc7ZuaHy1DLwO/14tNRgHe21RzqQeTQBk5gKLczxqVKiMGqK7y
 xFZM8rNHCapHvsKL2Kz5rdLmdlMmBpr0M1a8Ks340MS3tKX0pv/RCnt+GWhZhQT1c6CR
 6E5A==
X-Gm-Message-State: AOAM5307fB3vil447POZOeLS6AZcHa5AMwNCbu8U2LEeOmYfFH9qYMWO
 fvDKn9b2rnnm1ahWGnrcnhY6pwDY+lr526uK/5ko7j1GiEk=
X-Google-Smtp-Source: ABdhPJzxpMG4jFD3g9wFcLoL4FXU9LKzNZpSCBlkfl7a9Iksl/ikkncfXwVtkXWxPcu/p/RAzuEVngr20/aRngyhga0=
X-Received: by 2002:a2e:9d7:: with SMTP id 206mr4473732ljj.27.1622832791233;
 Fri, 04 Jun 2021 11:53:11 -0700 (PDT)
MIME-Version: 1.0
From: Jonas Schrottenbaum <jonasschrottenbaum@googlemail.com>
Date: Fri, 4 Jun 2021 20:51:06 +0200
Message-ID: <CAPwUoMR6dc0Ovs2DEUicSB2FqT6TkjUDbUoA8z-04Jd4mk_WTw@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 04 Jun 2021 21:27:32 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 04 Jun 2021 20:53:12 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Fri, 04 Jun 2021 21:27:29 +0200
Subject: [Cocci] No coccicheck target
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
Content-Type: multipart/mixed; boundary="===============1285454860=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1285454860==
Content-Type: multipart/alternative; boundary="0000000000000d276a05c3f534a7"

--0000000000000d276a05c3f534a7
Content-Type: text/plain; charset="UTF-8"

Hello,

i'm currently trying to check out coccinelle and already could apply a
simple semantic patch to a small C program with the spatch command.

Please excuse me, but i'm quite a beginner in this field.

I read on this
<https://www.kernel.org/doc/html/v4.16/dev-tools/coccinelle.html> page,
about coccicheck and the different modes.
It says, that i have to run:

make coccicheck MODE=report
or
make coccicheck MODE=patch

in order to switch the mode.

But where do i have to run this? Is this just for using coccinelle on the
linux kernel? Is it not relevant, if i want to use coccinelle for general C
programs?

I thought it is a make target for coccinelle itself, but there is no target
called coccicheck defined in the coccinelle makefile, as far as i can tell.
So if i run it in the same dir as the make install for coccinelle, all i
get is:

make: *** no rule to make target coccicheck. stop.

So, am i doing something wrong, or is coccicheck only relevant for linux
kernel development?
It says: "A Coccinelle-specific target is defined in the top level
Makefile."
which Makefile? The linux top level Makefile?

Best regards,
Jonas

--0000000000000d276a05c3f534a7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hello,=C2=A0<div><br></div><div>i&#39;m currently trying t=
o check out coccinelle and already could apply a simple semantic patch to a=
 small C program with the spatch command.</div><div><br></div><div>Please e=
xcuse me, but i&#39;m quite a beginner in this field.=C2=A0=C2=A0<br></div>=
<div><br></div><div>I read on=C2=A0<a href=3D"https://www.kernel.org/doc/ht=
ml/v4.16/dev-tools/coccinelle.html">this</a>=C2=A0page, about=C2=A0cocciche=
ck and the different modes. </div><div>It says, that i have to run:=C2=A0</=
div><div><br></div><div>make coccicheck MODE=3Dreport</div><div>or</div><di=
v>make coccicheck MODE=3Dpatch</div><div><br></div><div>in order to switch =
the mode.</div><div><br></div><div>But where do i have to run this? Is this=
 just for using coccinelle on the linux kernel? Is it not relevant, if i wa=
nt to use coccinelle for general C programs?</div><div><br></div><div>I tho=
ught it is a make target for coccinelle itself, but there is no target call=
ed coccicheck defined in the coccinelle makefile, as far as i can tell.</di=
v><div>So if i run it in the same dir as the make install for coccinelle, a=
ll i get is:</div><div><br></div><div>make: *** no rule to make target cocc=
icheck. stop.</div><div><br></div><div>So, am i doing something wrong, or i=
s coccicheck only relevant for linux kernel=C2=A0development?</div><div>It =
says: &quot;A Coccinelle-specific target is defined in the top level Makefi=
le.&quot;</div><div>which Makefile? The linux top level Makefile?</div><div=
><br></div><div>Best regards,</div><div>Jonas</div><div><br></div></div>

--0000000000000d276a05c3f534a7--

--===============1285454860==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1285454860==--
