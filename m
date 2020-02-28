Return-Path: <SRS0=NuX8=4Q=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97F7EC3F2D1
	for <cocci@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:36 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BA5FB2469C
	for <cocci@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=yaerobi-com.20150623.gappssmtp.com header.i=@yaerobi-com.20150623.gappssmtp.com header.b="ZOVYiME8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA5FB2469C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=yaerobi.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01SBdF8F016453;
	Fri, 28 Feb 2020 12:39:15 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7E22A780A;
	Fri, 28 Feb 2020 12:39:15 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B149B7800
 for <cocci@systeme.lip6.fr>; Fri, 28 Feb 2020 12:39:13 +0100 (CET)
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:341])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01SBdCTN014780
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 28 Feb 2020 12:39:12 +0100 (CET)
Received: by mail-wm1-x341.google.com with SMTP id f15so2847940wml.3
 for <cocci@systeme.lip6.fr>; Fri, 28 Feb 2020 03:39:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=yaerobi-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=QEHmOI1GgmvVd1u5RQi0DLNByP0ZqDZD2bcwo2VWHNY=;
 b=ZOVYiME8mpdZq6MBLZOA9dvbaHpfuEvYpN6CG+gbcDVWKcQlBFrGVMacJ9kxonBhXj
 v5tzgDXiR9SJWZ4FMOId8VAYmfMRsxBcbucGWg6EwVAzwLgrDmmUsdLgFJz0RrguccNk
 QhQwqnvGf/GG7nuHla3qXuuo4ZOdl0WZFWGgL7TOAaj49GNFgs20h1ASaqIysXifEBx9
 G/okb5OYl8bhkCqkW0mo+ZpJOefu9C9NAPcli0ypOuZUwmOg9L4m4osRYQ17QXa298pt
 VfgO2+Dk4O0kQGpE9phm7f+bcKnskUFPF1XwGKMgDDAVQKp7dIiV0f/c6mhgqLmxPbkN
 MZdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=QEHmOI1GgmvVd1u5RQi0DLNByP0ZqDZD2bcwo2VWHNY=;
 b=T/g30mtn6CEAVf6P8DRHPaGcg8Heim491QqZiJYfXRdSvzqFjXV5WGECNtMnKUn7Kz
 ZAwnzTyrGNWkljjQhWJ9viJtVlaHI5eKEQkbxqYqWVBxVoK63mSnqEQ3dpCEwNHhZ6Zu
 cPJldgWof8Mk18k1fTkY2TZZ+du6jiM/Bi7Rg2FCOVhjmyyjXbZ6JETKGUjX5jC95wdp
 bACa8ebBONF2eLF9xx4j+g8Z0bIBQpzKjrygakZbTVcZdBlh6vtwFAUOYKJUXxoZnNYq
 lA+aHJV1TQ4cHa/6GCPKby3zBzOMwGerNTtfvX6ISSupVLJUu1figq1gRJkqabSzAQ+H
 NNCA==
X-Gm-Message-State: APjAAAV7UgwWtrhnRNzD0ysWr3go3KcANERAwqSwThBqIz+FyW3i1nK6
 5gmspFWsKsDeCTYegK2Jlq7QV0Iw95lW0/tslz5ppg==
X-Google-Smtp-Source: APXvYqzmwKAxfLHdW9Mtug/8QOBEA/A5zhQIuqhWJxn7jcSXhUNuwm0OTurhDV51PR8GgoblzrQ7HtnvImnHNUF+d2I=
X-Received: by 2002:a05:600c:218a:: with SMTP id
 e10mr4438990wme.6.1582889951814; 
 Fri, 28 Feb 2020 03:39:11 -0800 (PST)
MIME-Version: 1.0
References: <786d2ea9-621f-bcc4-b626-aed6454784e2@yaerobi.com>
 <alpine.DEB.2.21.2002041556540.3345@hadrien>
 <909d202d-9a8a-d010-107b-80c07febcb0f@yaerobi.com>
 <65ec26be-3b40-4248-4fc6-e30f6785f9b1@univ-grenoble-alpes.fr>
 <alpine.DEB.2.21.2002271044550.4309@hadrien>
 <1183e7d0-b6e4-834d-5b27-47c43661bae6@univ-grenoble-alpes.fr>
 <alpine.DEB.2.21.2002271102350.2973@hadrien>
In-Reply-To: <alpine.DEB.2.21.2002271102350.2973@hadrien>
From: Emmanuel Arias <eamanu@yaerobi.com>
Date: Fri, 28 Feb 2020 08:39:00 -0300
Message-ID: <CAFNO5of+YgGHTkdidk-fu8U95zEtmPhPPZdNW30Q12Df1j2cbw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 28 Feb 2020 12:39:16 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 28 Feb 2020 12:39:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] coccinelle depends on unmaintained pygtk
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
Content-Type: multipart/mixed; boundary="===============0867777026=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0867777026==
Content-Type: multipart/alternative; boundary="0000000000004bfbf2059fa149f9"

--0000000000004bfbf2059fa149f9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Nicolas,

It seems that PyGTKCompat is not in Debian, so IMHO I would not consider
that option.

The files with pygtk are:

docs/manual/cocci-python.txt:The latter depends on pygtk2, and the
dependency will not be evaluated until runtime.
python/coccilib/coccigui/coccigui.py:import pygtk
python/coccilib/coccigui/coccigui.py:pygtk.require("2.0")
python/coccilib/coccigui/pycoccimodel.py:import pygtk

So according with Julia, removing that files will not affect to coccinelle.



On Thu, Feb 27, 2020 at 7:04 AM Julia Lawall <julia.lawall@inria.fr> wrote:

>
>
> On Thu, 27 Feb 2020, Nicolas Palix wrote:
>
> > Le 27/02/2020 =C3=A0 10:45, Julia Lawall a =C3=A9crit :
> > >
> > >
> > > On Thu, 27 Feb 2020, Nicolas Palix wrote:
> > >
> > > > Hi Emmanuel,
> > > >
> > > > Instead of porting to GObject directly,
> > > > can we use PyGTKCompat ?
> > > >
> > > > https://wiki.gnome.org/Projects/PyGObject/PyGTKCompat
> > >
> > > The problem is resolved by removing the python file that relied on th=
e
> > > unavailable library.  I don't think that that python file is useful.
> >
> > It looks like python/coccilib/coccigui contains the offending files:
> > coccigui.py, pygui.glade and pygui.gradep.
> > But according to vimcom.py and vimembed.py, these laters also depend of
> GTK.
> >
> > Should the coccigui folder be entirely removed ?
>
> Yes, they have already been removed on github.
>
> julia
>
>
> >
> > >
> > > julia
> > >
> > > >
> > > > Regards,
> > > >
> > > > Le 04/02/2020 =C3=A0 16:25, eamanu a =C3=A9crit :
> > > > > Hi!
> > > > >
> > > > > On 04/02/2020 11:59, Julia Lawall wrote:
> > > > > > On Tue, 4 Feb 2020, eamanu wrote:
> > > > > >
> > > > > > > Hi everybody,
> > > > > > >
> > > > > > > Sorry if this issues is duplicated, I am new in the mailing
> list
> > > > > > > and in a very quickly searching I didn't found about this
> issue.
> > > > > > >
> > > > > > > I am working on Coccinelle package on Debian
> > > > > > Thanks!
> > > > > >
> > > > > > > and currently
> > > > > > > exist the next bug [1].
> > > > > > >
> > > > > > > There is any plan to port to use GObject Instrospection?
> > > > > > >
> > > > > > > [1] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D88526=
7
> > > > > > I think we should just drop the code that depends on it.  It wa=
s
> added
> > > > > > for
> > > > > > a MS thesis more than 10 years ago, and I don't think anyone ha=
s
> used
> > > > > > it
> > > > > > since.
> > > > > >
> > > > > > I will look into it.
> > > > >
> > > > > Great, if you need help, I can help :-)
> > > > >
> > > > > I will wait for any news. Thanks
> > > > >
> > > > > eamanu
> > > > > >
> > > > > > julia
> > > > >
> > > > > _______________________________________________
> > > > > Cocci mailing list
> > > > > Cocci@systeme.lip6.fr
> > > > > https://systeme.lip6.fr/mailman/listinfo/cocci
> > > > >
> > > >
> > > >
> > > > --
> > > > Nicolas Palix
> > > > http://lig-membres.imag.fr/palix/
> > > >
> > >
> >
> >
> > --
> > Nicolas Palix
> > http://lig-membres.imag.fr/palix/
> >

--0000000000004bfbf2059fa149f9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Nicolas,</div><div><br></div><div>It seems that Py=
GTKCompat is not in Debian, so IMHO I would not consider that option.</div>=
<div><br></div><div>The files with pygtk are:</div><div><br></div><div>docs=
/manual/cocci-python.txt:The latter depends on pygtk2, and the dependency w=
ill not be evaluated until runtime.<br>python/coccilib/coccigui/coccigui.py=
:import pygtk<br>python/coccilib/coccigui/coccigui.py:pygtk.require(&quot;2=
.0&quot;)<br>python/coccilib/coccigui/pycoccimodel.py:import pygtk</div><di=
v><br></div><div>So according with Julia, removing that files will not affe=
ct to coccinelle.</div><div><br></div><div><br></div></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Feb 27, 2020=
 at 7:04 AM Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr">julia=
.lawall@inria.fr</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);pa=
dding-left:1ex"><br>
<br>
On Thu, 27 Feb 2020, Nicolas Palix wrote:<br>
<br>
&gt; Le 27/02/2020 =C3=A0 10:45, Julia Lawall a =C3=A9crit=C2=A0:<br>
&gt; &gt;<br>
&gt; &gt;<br>
&gt; &gt; On Thu, 27 Feb 2020, Nicolas Palix wrote:<br>
&gt; &gt;<br>
&gt; &gt; &gt; Hi Emmanuel,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Instead of porting to GObject directly,<br>
&gt; &gt; &gt; can we use PyGTKCompat ?<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; <a href=3D"https://wiki.gnome.org/Projects/PyGObject/PyGTKCo=
mpat" rel=3D"noreferrer" target=3D"_blank">https://wiki.gnome.org/Projects/=
PyGObject/PyGTKCompat</a><br>
&gt; &gt;<br>
&gt; &gt; The problem is resolved by removing the python file that relied o=
n the<br>
&gt; &gt; unavailable library.=C2=A0 I don&#39;t think that that python fil=
e is useful.<br>
&gt;<br>
&gt; It looks like python/coccilib/coccigui contains the offending files:<b=
r>
&gt; coccigui.py, pygui.glade and pygui.gradep.<br>
&gt; But according to vimcom.py and vimembed.py, these laters also depend o=
f GTK.<br>
&gt;<br>
&gt; Should the coccigui folder be entirely removed ?<br>
<br>
Yes, they have already been removed on github.<br>
<br>
julia<br>
<br>
<br>
&gt;<br>
&gt; &gt;<br>
&gt; &gt; julia<br>
&gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Regards,<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; Le 04/02/2020 =C3=A0 16:25, eamanu a =C3=A9crit=C2=A0:<br>
&gt; &gt; &gt; &gt; Hi!<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; On 04/02/2020 11:59, Julia Lawall wrote:<br>
&gt; &gt; &gt; &gt; &gt; On Tue, 4 Feb 2020, eamanu wrote:<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Hi everybody,<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; Sorry if this issues is duplicated, I am new =
in the mailing list<br>
&gt; &gt; &gt; &gt; &gt; &gt; and in a very quickly searching I didn&#39;t =
found about this issue.<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; I am working on Coccinelle package on Debian<=
br>
&gt; &gt; &gt; &gt; &gt; Thanks!<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; and currently<br>
&gt; &gt; &gt; &gt; &gt; &gt; exist the next bug [1].<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; There is any plan to port to use GObject Inst=
rospection?<br>
&gt; &gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; &gt; [1] <a href=3D"https://bugs.debian.org/cgi-bi=
n/bugreport.cgi?bug=3D885267" rel=3D"noreferrer" target=3D"_blank">https://=
bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D885267</a><br>
&gt; &gt; &gt; &gt; &gt; I think we should just drop the code that depends =
on it.=C2=A0 It was added<br>
&gt; &gt; &gt; &gt; &gt; for<br>
&gt; &gt; &gt; &gt; &gt; a MS thesis more than 10 years ago, and I don&#39;=
t think anyone has used<br>
&gt; &gt; &gt; &gt; &gt; it<br>
&gt; &gt; &gt; &gt; &gt; since.<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; I will look into it.<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; Great, if you need help, I can help :-)<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; I will wait for any news. Thanks<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; eamanu<br>
&gt; &gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; &gt; julia<br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt; &gt; _______________________________________________<br>
&gt; &gt; &gt; &gt; Cocci mailing list<br>
&gt; &gt; &gt; &gt; <a href=3D"mailto:Cocci@systeme.lip6.fr" target=3D"_bla=
nk">Cocci@systeme.lip6.fr</a><br>
&gt; &gt; &gt; &gt; <a href=3D"https://systeme.lip6.fr/mailman/listinfo/coc=
ci" rel=3D"noreferrer" target=3D"_blank">https://systeme.lip6.fr/mailman/li=
stinfo/cocci</a><br>
&gt; &gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; --<br>
&gt; &gt; &gt; Nicolas Palix<br>
&gt; &gt; &gt; <a href=3D"http://lig-membres.imag.fr/palix/" rel=3D"norefer=
rer" target=3D"_blank">http://lig-membres.imag.fr/palix/</a><br>
&gt; &gt; &gt;<br>
&gt; &gt;<br>
&gt;<br>
&gt;<br>
&gt; --<br>
&gt; Nicolas Palix<br>
&gt; <a href=3D"http://lig-membres.imag.fr/palix/" rel=3D"noreferrer" targe=
t=3D"_blank">http://lig-membres.imag.fr/palix/</a><br>
&gt;</blockquote></div>

--0000000000004bfbf2059fa149f9--

--===============0867777026==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0867777026==--
