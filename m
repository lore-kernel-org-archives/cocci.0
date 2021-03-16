Return-Path: <SRS0=OVN8=IO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A352CC433E6
	for <cocci@archiver.kernel.org>; Tue, 16 Mar 2021 02:48:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04A3864DFB
	for <cocci@archiver.kernel.org>; Tue, 16 Mar 2021 02:48:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04A3864DFB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12G2mZMY007115;
	Tue, 16 Mar 2021 03:48:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D04447610;
	Tue, 16 Mar 2021 03:48:35 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E613C5DC3
 for <cocci@systeme.lip6.fr>; Tue, 16 Mar 2021 03:48:33 +0100 (CET)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:631])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12G2mVZc022897
 for <cocci@systeme.lip6.fr>; Tue, 16 Mar 2021 03:48:31 +0100 (CET)
Received: by mail-ej1-x631.google.com with SMTP id si25so13981524ejb.1
 for <cocci@systeme.lip6.fr>; Mon, 15 Mar 2021 19:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BB/D1wbqOaLOGT/WWDwAGi9mUwHphSeD5uYRGsEPkFA=;
 b=m2/CLxbfz9XwLZQUCvx56DVNSXdkj3KQPJHip9pP2bZqhJR8vNJk1Ifag3hniJSFMK
 OZwLT8vEx74VJjH2VY/FLwSclOf/RnnG75bjxhJOWeApyVhN8VRy7E+si04JcC+pcmQr
 EqNIpPpZGUwtmc5+YDyhhWbXoFvfTpxlSHToQv1dmXC37w+TRWTSAiTwA1gNKM4hk5t1
 yNtxtmRALBdq+XYBV49YIemXSo9QJlyshkjwkzKuv4yqKhutdWF7/BJJKACy1NhUwAXy
 4leYpOU1SN2XY3sjgDekHkBrEHDBWDWjlGB2r7nlwbqB45v0bS+lyKrONFOf4xN+4Rgp
 z5QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BB/D1wbqOaLOGT/WWDwAGi9mUwHphSeD5uYRGsEPkFA=;
 b=bVAd+ZqmjLjmEvzOsSjT+fftywA3eTn8cp0F1Jehv+iL4PyL5AgE0xAuwPLYTU0pxg
 Q6vEa542rhq/wBZE09Kn9WYweMkdlaYq9OdzjY/QAcdYhc5uGHnCRB1CP9/nI86bVhyA
 znJaQOoLfJ8EsmQIfL3AS0cGR/MNbUdaatRMqquTbeE7DeisQDw6IH6dOWMsorexdIx+
 38gddCQUHKLrnyimxeYBfZ6DpC6wTLqq+2Qtz4mMOSXYv625A4ypRhUMkEvtx77xhvbT
 pVM6TXTpOphhymNtwUcu03oTdE0cVKy8HZvKqrPTcLnznrQPC8EETWOOe4PgELSYKrkN
 F66A==
X-Gm-Message-State: AOAM532tDgvxWoGWRfkGwFt4wq4Dex6gRJ6hyZliRb0j8Txc8drug376
 3ay0MofckfiGyYnMNBlWz3cYg0y1iZ1RQ8pKph8c28gs
X-Google-Smtp-Source: ABdhPJx+9Gbpf29JmMTqMDWI1CgYrcW7i+7OmSK/IQYOIkjXpiVe0V40kUkVsEPPuyq19d8n1j1FA5CvSCQwZRsxk8w=
X-Received: by 2002:a17:906:a248:: with SMTP id
 bi8mr26939284ejb.260.1615862911712; 
 Mon, 15 Mar 2021 19:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAOhcEPbTH-oTTn1OUkgoYf2GaBKaCYjwpWuhrdNRkNQ0uZ_r4A@mail.gmail.com>
 <20210314061001.GA993@kunai> <alpine.DEB.2.22.394.2103141016010.2986@hadrien>
 <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
In-Reply-To: <CAOhcEPZx4tNocG4TJvQKg_6e6kyJPbWGtj52TaGhJqHD36ZfYw@mail.gmail.com>
From: Mansour Moufid <mansourmoufid@gmail.com>
Date: Mon, 15 Mar 2021 22:48:19 -0400
Message-ID: <CALogXGW1-EbJo4_8HhtWbv02aYWgKpMwJeXuDasrsZ2HPDVJhg@mail.gmail.com>
To: Thomas Adam <thomas@xteddy.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 16 Mar 2021 03:48:36 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 16 Mar 2021 03:48:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a struct member with a function call
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
Content-Type: multipart/mixed; boundary="===============1146530746=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1146530746==
Content-Type: multipart/alternative; boundary="000000000000dbbece05bd9e66fa"

--000000000000dbbece05bd9e66fa
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 14, 2021, 20:43 Thomas Adam <thomas@xteddy.org> wrote:

> Hello,
>
> I can see I was as clear as mud with my explanation -- apologies for
> that, so let me try again.
>
> In my original example:
>
> struct monitor {
>     struct {
>         int width;
>         int height
>     } virtual;
> };
>
> ... the members width and height aren't required any more, as they're
> actually computable generically, and don't belong in that struct.
> Instead, I have separate functions which can provide those values.
>
> So where I have in code, statements such as:
>
> struct monitor *m = this_monitor();
> int foo = m->virutal.width;
>
> I want to be able to substitute "m->virtual.width" with a function
> call "get_width()" -- which does not involve "struct monitor" at all.
> Indeed, the semantic patch I'm trying to apply now looks like this:
>
> @@
> struct monitor *m;
> @@
>
> - m->virtual.width;
> + get_width();
>
> ... and although spatch doesn't tell me of any errors, when I run it
> over my codebase, no modifications are made.  So clearly I'm still
> doing something wrong.


Remove the semi-colons. ;)

--000000000000dbbece05bd9e66fa
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div>On Sun, Mar 14, 2021, 20:43 Thomas Adam &lt;<a href=
=3D"mailto:thomas@xteddy.org">thomas@xteddy.org</a>&gt; wrote:<br><div clas=
s=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .=
8ex;border-left:1px #ccc solid;padding-left:1ex">Hello,<br>
<br>
I can see I was as clear as mud with my explanation -- apologies for<br>
that, so let me try again.<br>
<br>
In my original example:<br>
<br>
struct monitor {<br>
=C2=A0 =C2=A0 struct {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int width;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 int height<br>
=C2=A0 =C2=A0 } virtual;<br>
};<br>
<br>
... the members width and height aren&#39;t required any more, as they&#39;=
re<br>
actually computable generically, and don&#39;t belong in that struct.<br>
Instead, I have separate functions which can provide those values.<br>
<br>
So where I have in code, statements such as:<br>
<br>
struct monitor *m =3D this_monitor();<br>
int foo =3D m-&gt;virutal.width;<br>
<br>
I want to be able to substitute &quot;m-&gt;virtual.width&quot; with a func=
tion<br>
call &quot;get_width()&quot; -- which does not involve &quot;struct monitor=
&quot; at all.<br>
Indeed, the semantic patch I&#39;m trying to apply now looks like this:<br>
<br>
@@<br>
struct monitor *m;<br>
@@<br>
<br>
- m-&gt;virtual.width;<br>
+ get_width();<br>
<br>
... and although spatch doesn&#39;t tell me of any errors, when I run it<br=
>
over my codebase, no modifications are made.=C2=A0 So clearly I&#39;m still=
<br>
doing something wrong.</blockquote></div></div><div dir=3D"auto"><br></div>=
<div dir=3D"auto">Remove the semi-colons. ;)</div><div dir=3D"auto"><br></d=
iv></div>

--000000000000dbbece05bd9e66fa--

--===============1146530746==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1146530746==--
