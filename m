Return-Path: <SRS0=sp25=ZU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE985C432C0
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2019 17:46:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B6121781
	for <cocci@archiver.kernel.org>; Thu, 28 Nov 2019 17:46:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WL1BxHxP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B6121781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xASHkDOi007691;
	Thu, 28 Nov 2019 18:46:13 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 80E2577D4;
	Thu, 28 Nov 2019 18:46:13 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E91F077CC
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 18:46:11 +0100 (CET)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:441] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xASHkBSD013275
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 18:46:11 +0100 (CET)
Received: by mail-wr1-x441.google.com with SMTP id z3so32094261wru.3
 for <cocci@systeme.lip6.fr>; Thu, 28 Nov 2019 09:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=HdQHTGhhU6guj9n7LjiqqKBCxM2+/lClIU7syg0+fRE=;
 b=WL1BxHxPOGdWHuFnpe6dUapej4B4KbYWgB55p4WMavebkuz2P2AGKbBz3o77cN7Z9M
 9Hc1j9UP9kG6O2i+yM/7vHMnrkPIF1QU4oJsTi1rfYUYyVqKE3FULz/jFrghdSjcj6yb
 s5esaODtCA/siX8M+0nSMkidVBd0Ce8Sd9M8A+FLRsWZutzy1FkF61grb/ZzPhEpMhBb
 UmenuOnrMGIJfL5ToCo6uSW+qIE9KqKEM+JIzmfIGfOKVZ6yVk45Mt+yV+rWRMaqnIqq
 Dk0FZPmEQFNcbE2ONYOy/rwsEIiLKouGx0Tmw9o5y5ydDULJj7dFw4fYo8pqlGKaiV3P
 T/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=HdQHTGhhU6guj9n7LjiqqKBCxM2+/lClIU7syg0+fRE=;
 b=dBa/BCxpJDoY+Qsyr+BP4q45aa3eKfUbfwID2ZhCbVjy9cS+gId07x6g/UHdSvNRPy
 WFaHg08vSAtvA0UlGNbQFnxyrH5y96khTijsuGdKTqC+nHdXEWMYCqgZ+U8bSQuev7hX
 8DgN6hvV4gdQcCHftOhweX1dfBqeQuQI82TiErlPuX9Os5rT1aGKF9SiEDqh5RzIG3u/
 FKbFwoLKOMIqCB/XPHC+SDEcVnhe+fLRGzt58QZvlzZ2nXNdaCKTC8va9V3vfoVvn1Gd
 /BXIbF+2ZyKHk3BCACYuA+m22UXF4NR/Iwe4b3v5mENUR6uwnqMyunj9H/klikUqa0EN
 74ng==
X-Gm-Message-State: APjAAAW1DFBR+N3LNhF21rxK9BlAWHda4AcX8Me+MLEZmxCx2bgtz04u
 NbLYq62Ll5YWkaoxtMLsiZpUCgggPGCNtGhgb20=
X-Google-Smtp-Source: APXvYqwvrXllXgt7nkY2qzUqxKXhGzTvKENIP+rLOeTGB6Qw50uOY8QDDpr47z7xdgB17XwvQA0DHPTlIwsfApD0Tzc=
X-Received: by 2002:adf:da52:: with SMTP id r18mr49664129wrl.167.1574963170741; 
 Thu, 28 Nov 2019 09:46:10 -0800 (PST)
MIME-Version: 1.0
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <alpine.DEB.2.21.1911280807030.3704@hadrien>
In-Reply-To: <alpine.DEB.2.21.1911280807030.3704@hadrien>
From: Strace Labs <stracelabs@gmail.com>
Date: Thu, 28 Nov 2019 15:45:34 -0200
Message-ID: <CABvP5W0oeXsxhe3aOzGaVOeNHnMogk+pROVAvEiL53w+wdA04g@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 28 Nov 2019 18:46:13 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 28 Nov 2019 18:46:11 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf/format calls based on the data-type
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
Content-Type: multipart/mixed; boundary="===============0879714431=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0879714431==
Content-Type: multipart/alternative; boundary="00000000000053931005986bb039"

--00000000000053931005986bb039
Content-Type: text/plain; charset="UTF-8"

Hi Julia,

I am not sure if I was clear. but, let me try to explain again.

1. I have the code.

$ cat sample.c
int foo() {
int id;
struct mydata h1, *h2, s1, *s2;

// works fine
  my_printf("%s", h1.name);
  my_printf("%s", h2->name);

// don't work
my_printf("%d it would work but dunno mydata=%m\n", id, h2);
my_printf("%d here also, tt=%s and %m\n", id, h2->name, s2);
}
$

2. My fix-format.cocci

$ cat fix-format.cocci
@r1_heap@
struct mydata *SMD;
format F =~ "s";
expression f;
@@
-f("%@F@", SMD->name);
+f("%m", SMD);

@r1_stack@
struct mydata SMD;
format F =~ "s";
expression f;
@@
-f("%@F@", SMD.name);
+f("%m", &SMD);

$

3. therefore, It is not matching with *my_printf("%d it would work but
dunno mydata=%m\n", id, h2);*

e.g:

$ spatch --sp-file fix-format.cocci sample.c
HANDLING: /tmp/sample.c
diff =
--- /tmp/sample.c
+++ /tmp/T/cocci-output-92962-556a08-sample.c
@@ -4,8 +4,8 @@ int foo() {
  struct mydata h1, *h2, s1, *s2;

  // works fine
- my_printf("%s", h1.name);
- my_printf("%s", h2->name);
+ my_printf("%m", &h1);
+ my_printf("%m", h2);

  // don't work
  my_printf("%d it would work but dunno mydata=%m\n", id, h2);
$

so, is it possible to fix my format-string?

On Thu, Nov 28, 2019 at 5:08 AM Julia Lawall <julia.lawall@inria.fr> wrote:

>
>
> --- Please note the new email address ---
>
>
> On Thu, 28 Nov 2019, Strace Labs wrote:
>
> > Hi,
> > I am working on a semantic patch for replacing specific format string
> token based on the used data-type.
> > so, I have several calls of my_printf() and some special macros pointing
> to them around my code.
> >
> > e.g: part of my code.
> > .....
> > struct mydata *m;
> > struct mydata h;
> > .....
> > my_printf("%s", m->name);
> > .....
> > my_printf("%s", h.name);
> > .....
> > my_printf("whatever id %d following the string %s\n", id, m->name);
> > ....
> > Macro_to_my_printf("Hey id %d, let's see %s\n", id, h.name);
> > .....
> > Macro2_to_my_printf(fd, "Hey id %d, let's see %s\n", id, m->name);
> > .....
> >
> > My current humble *.cocci
> >
> > $ cat fix-my_printf.cocci
> > @r1_heap@
> > struct mydata *SMD;
> > format F =~ "s";
> > @@
> > -my_printf("%@F@", SMD->name);
> > +my_printf("%m", SMD);
> >
> > @r1_stack@
> > struct mydata SMD;
> > format F =~ "s";
> > @@
> > -my_printf("%@F@", SMD.name);
> > +my_printf("%m", &SMD);
> > $
> >
> > But, I can match only with partial content as can be seen below.
> >
> > $ spatch --partial-match --sp-file fix-my_printf.cocci
> sample-format-string.c | egrep "^(\+|-)"
> > HANDLING: sample-format-string.c
> > diff =
> > HANDLING: /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c
> > diff =
> > --- /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c
> > +++
> /var/folders/ld/6tg9c6qj4fx4c85q26mcqrsh0000gn/T/cocci-output-24659-130f86-sample-format-string.c
> > - my_printf("%s", m->name);
> > + my_printf("%m", m);
> > - my_printf("%s", h.name);
> > + my_printf("%m", &h);
> > $
> >
> > Anyone could give me a light about how to proceed to match the entire
> ".....string format..." ?
>
> I think that what you are asking is why you can't write a pattern like:
>
> foo("...
> -%@d@
> +%x
>   ...")
>
> At the moment, there seems to be a bug.  I will check on that.
>
> julia

--00000000000053931005986bb039
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Hi Julia,<div><br></div><div>I am not sur=
e if I was clear. but, let me try to explain again.</div><div><br></div><di=
v>1. I have the code.</div><div><br></div><div>$ cat sample.c<br>int foo() =
{<br>	int id;<br>	struct mydata h1, *h2, s1, *s2;<br><br>	// works fine<br>=
=C2=A0	my_printf(&quot;%s&quot;, <a href=3D"http://h1.name">h1.name</a>);<b=
r>=C2=A0	my_printf(&quot;%s&quot;, h2-&gt;name);<br><br>	// don&#39;t work<=
br>	my_printf(&quot;%d it would work but dunno mydata=3D%m\n&quot;, id, h2)=
;<br>	my_printf(&quot;%d here also, tt=3D%s and %m\n&quot;, id, h2-&gt;name=
, s2);<br>}<br>$<br></div><div><br></div><div>2. My fix-format.cocci</div><=
div><br></div><div>$ cat fix-format.cocci<br>@r1_heap@<br>struct mydata *SM=
D;<br>format F =3D~ &quot;s&quot;;<br>expression f;<br>@@<br>-f(&quot;%@F@&=
quot;, SMD-&gt;name);<br>+f(&quot;%m&quot;, SMD);<br><br>@r1_stack@<br>stru=
ct mydata SMD;<br>format F =3D~ &quot;s&quot;;<br>expression f;<br>@@<br>-f=
(&quot;%@F@&quot;, SMD.name);<br>+f(&quot;%m&quot;, &amp;SMD);<br><br>$<br>=
</div><div><br></div><div>3. therefore, It is not matching with <b>my_print=
f(&quot;%d it would work but dunno mydata=3D%m\n&quot;, id, h2);</b></div><=
div><br></div><div>e.g:</div><div><br></div><div>$ spatch --sp-file fix-for=
mat.cocci sample.c<br>HANDLING: /tmp/sample.c<br>diff =3D<br>--- /tmp/sampl=
e.c<br>+++ /tmp/T/cocci-output-92962-556a08-sample.c<br>@@ -4,8 +4,8 @@ int=
 foo() {<br>=C2=A0	struct mydata h1, *h2, s1, *s2;<br><br>=C2=A0	// works f=
ine<br>- 	my_printf(&quot;%s&quot;, <a href=3D"http://h1.name">h1.name</a>)=
;<br>- 	my_printf(&quot;%s&quot;, h2-&gt;name);<br>+ 	my_printf(&quot;%m&qu=
ot;, &amp;h1);<br>+ 	my_printf(&quot;%m&quot;, h2);<br><br>=C2=A0	// don&#3=
9;t work<br>=C2=A0	my_printf(&quot;%d it would work but dunno mydata=3D%m\n=
&quot;, id, h2);<br>$<br></div><div><br></div><div>so, is it possible to fi=
x my format-string?</div></div><br><div class=3D"gmail_quote"><div dir=3D"l=
tr" class=3D"gmail_attr">On Thu, Nov 28, 2019 at 5:08 AM Julia Lawall &lt;<=
a href=3D"mailto:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
--- Please note the new email address ---<br>
<br>
<br>
On Thu, 28 Nov 2019, Strace Labs wrote:<br>
<br>
&gt; Hi,<br>
&gt; I am working on a semantic patch for replacing specific format string =
token based on the used data-type.<br>
&gt; so, I have several calls of my_printf() and some special macros pointi=
ng to them around my code.<br>
&gt;<br>
&gt; e.g: part of my code.<br>
&gt; .....<br>
&gt; struct mydata *m;<br>
&gt; struct mydata h;<br>
&gt; .....<br>
&gt; my_printf(&quot;%s&quot;, m-&gt;name);<br>
&gt; .....<br>
&gt; my_printf(&quot;%s&quot;, <a href=3D"http://h.name" rel=3D"noreferrer"=
 target=3D"_blank">h.name</a>);<br>
&gt; .....<br>
&gt; my_printf(&quot;whatever id %d following the string %s\n&quot;, id, m-=
&gt;name);<br>
&gt; ....<br>
&gt; Macro_to_my_printf(&quot;Hey id %d, let&#39;s see %s\n&quot;, id, <a h=
ref=3D"http://h.name" rel=3D"noreferrer" target=3D"_blank">h.name</a>);<br>
&gt; .....<br>
&gt; Macro2_to_my_printf(fd, &quot;Hey id %d, let&#39;s see %s\n&quot;, id,=
 m-&gt;name);<br>
&gt; .....<br>
&gt;<br>
&gt; My current humble *.cocci<br>
&gt;<br>
&gt; $ cat fix-my_printf.cocci<br>
&gt; @r1_heap@<br>
&gt; struct mydata *SMD;<br>
&gt; format F =3D~ &quot;s&quot;;<br>
&gt; @@<br>
&gt; -my_printf(&quot;%@F@&quot;, SMD-&gt;name);<br>
&gt; +my_printf(&quot;%m&quot;, SMD);<br>
&gt;<br>
&gt; @r1_stack@<br>
&gt; struct mydata SMD;<br>
&gt; format F =3D~ &quot;s&quot;;<br>
&gt; @@<br>
&gt; -my_printf(&quot;%@F@&quot;, SMD.name);<br>
&gt; +my_printf(&quot;%m&quot;, &amp;SMD);<br>
&gt; $<br>
&gt;<br>
&gt; But, I can match only with partial content as can be seen below.<br>
&gt;<br>
&gt; $ spatch --partial-match --sp-file fix-my_printf.cocci sample-format-s=
tring.c=C2=A0| egrep &quot;^(\+|-)&quot;<br>
&gt; HANDLING: sample-format-string.c<br>
&gt; diff =3D<br>
&gt; HANDLING: /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c=
<br>
&gt; diff =3D<br>
&gt; --- /Volumes/Users/jpereira/Devel/Sandbox/sample-format-string.c<br>
&gt; +++ /var/folders/ld/6tg9c6qj4fx4c85q26mcqrsh0000gn/T/cocci-output-2465=
9-130f86-sample-format-string.c<br>
&gt; - my_printf(&quot;%s&quot;, m-&gt;name);<br>
&gt; + my_printf(&quot;%m&quot;, m);<br>
&gt; - my_printf(&quot;%s&quot;, <a href=3D"http://h.name" rel=3D"noreferre=
r" target=3D"_blank">h.name</a>);<br>
&gt; + my_printf(&quot;%m&quot;, &amp;h);<br>
&gt; $<br>
&gt;<br>
&gt; Anyone could give me a light about how to proceed to match the entire =
&quot;.....string format...&quot; ?<br>
<br>
I think that what you are asking is why you can&#39;t write a pattern like:=
<br>
<br>
foo(&quot;...<br>
-%@d@<br>
+%x<br>
=C2=A0 ...&quot;)<br>
<br>
At the moment, there seems to be a bug.=C2=A0 I will check on that.<br>
<br>
julia</blockquote></div></div>

--00000000000053931005986bb039--

--===============0879714431==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0879714431==--
