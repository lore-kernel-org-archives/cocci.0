Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7542FC432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 14:48:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B69217AB
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 14:48:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KR1LSgrN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B69217AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATEmOAg018964;
	Fri, 29 Nov 2019 15:48:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A1D2177E4;
	Fri, 29 Nov 2019 15:48:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BFB9577D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 15:48:22 +0100 (CET)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42a] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATEmL76024151
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 15:48:21 +0100 (CET)
Received: by mail-wr1-x42a.google.com with SMTP id b18so35510828wrj.8
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 06:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=/1IslWXQAzWn2ZfD555bdWvOqItUqH+XDjMeHFUT6Dw=;
 b=KR1LSgrN7lZM8AkKqzvmlMcZyT7v671mwo2EEwyP2Niep+ds8b21uPqdPQ+NOC8WI2
 eGXd9XjhJ84uazwYNwWOxZP+VBqxW05nV4nbwmkaoPk7iBr6XYQO/lZJTttAfprrbad6
 LA6eAiQdAI7xdHv5vA5gT1P/Bfx1PwvAzV7y3DI1cxmX4qpka16HkgS5HVRRzQtYve6U
 rOujvsC07BtVsXvbTG1c9af5r481CMSPZMZDh1agl0ZHs1/9okyHes1n6tV2ihZL5RoL
 WBnF2MNYOqnFNK575yW7GW7XoRw7aJI/qAteMizlOVdpA6CtyKkUm79G0vhiF4KT6/OF
 FmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=/1IslWXQAzWn2ZfD555bdWvOqItUqH+XDjMeHFUT6Dw=;
 b=JlV/hyP+PF4cclgWIVpMyLNW7dlbfYKnHLQXuoOzrun7QyHynxa87c0KW+3NNkzFVR
 wOBNc9mHbTk00lQy0KSHNVdv3eOtXrerrtI9D8V7X89PTcWpqYQT5FJusp22vjvjRQ1G
 YhtixPpAMkOKva0RQv8C/4wlRAvs6/5DAZMC3w2KHf2IkU7Ud/HkmBpKzoHv0GNt3buJ
 TcqcBvBK5i/nu6/J1I4TaQyRjoAj06ODOrk1JMOTRj5w+//W/l6NjKd/vTV5i3lwyeAS
 xwagPaDEr3Lj+8dGUWy5QA4GEy5bb755nhjtOovLq6iEKrAbRLJ9kIdSWP6Uyn8AkFtf
 dhbQ==
X-Gm-Message-State: APjAAAUgru9D9yhOkLKARlM7FEzzmeAlGLcH4jMogWjOdlmdPPjVzu5V
 Ll4zEJXfo7hxRpjrPcgkBA1n29yjfRF0QKgIUQY=
X-Google-Smtp-Source: APXvYqxYHk+2bv3Bq+Ei07HvJKw/9xqgfA4eOQxpQUKKTwtPs+zxCIWMpHYnJiEea93Yzb/pUH8xBKk9SQq3l5X0fdw=
X-Received: by 2002:a5d:6408:: with SMTP id z8mr9287935wru.122.1575038901217; 
 Fri, 29 Nov 2019 06:48:21 -0800 (PST)
MIME-Version: 1.0
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
In-Reply-To: <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
From: Strace Labs <stracelabs@gmail.com>
Date: Fri, 29 Nov 2019 12:47:45 -0200
Message-ID: <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>,
        Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 15:48:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 29 Nov 2019 15:48:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
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
Content-Type: multipart/mixed; boundary="===============0129876294=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0129876294==
Content-Type: multipart/alternative; boundary="00000000000036ef8505987d52d9"

--00000000000036ef8505987d52d9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Markus,

so, that suggestion works the same as my previous shared statement. but,
only for calls like: *my_printf("%s", h1.name <http://h1.name>);*,
not for *my_printf("%d here also, tt=3D%s | %s and %m\n", id, h2->name,
h2->name, s2);*

e.g:

Code sample

int foo() {
int id;
struct mydata h1, *h2, s1, *s2;

// works fine
my_printf("%s", h1.name);
my_printf("%s", h2->name);
my_printf("%s");

// don't match.
my_printf("%s %d", h2->name, id);
my_printf("%s %s", h2->name, h2->name);
my_printf("%d it would work but dunno mydata=3D%m\n", id, h2);
my_printf("%d here also, tt=3D%s | %s and %m\n", id, h2->name, h2->name, s2=
);
}

so, I am not sure if Coccinelle is able to do that. I've read all samples
available in the Kernel and Coccinelle repo's and I didn't see any similar
case.

I think that if @Julia Lawall <julia.lawall@inria.fr> don't know, No one in
the world knows. =F0=9F=98=82



On Fri, Nov 29, 2019 at 10:33 AM Markus Elfring <Markus.Elfring@web.de>
wrote:

> >>. Did you try out to work with SmPL ellipses and disjunctions for this
> purpose?
> >
> > I didn't it, do you have any suggestions or sample that is it possible
> > to solve my problem? something to based on.
>
> Can you get further development ideas from a transformation approach
> like the following?
>
> @replacement@
> struct mydata SMD;
> struct mydata* SMDP;
> format F =3D~ "s";
> @@
>  my_printf(
> -          "%@F@"
> +          "%m"
>            ,
> (
> +           &
>              SMD
> -               .name
> |
>             SMDP
> -               ->name
> )
>           );
>
>
>
> > I mean, the Coccinelle/Python support.
>
> This programming interface contains also open issues for further
> considerations
> as you can see from a topic like =E2=80=9CPropagating values back from Py=
thon
> script
> to SmPL rule with other metavariable type than =E2=80=9Cidentifier=E2=80=
=9D=E2=80=9D.
> https://github.com/coccinelle/coccinelle/issues/86
>
> Regards,
> Markus
>

--00000000000036ef8505987d52d9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Markus,<div><br></div><div>so, that sugge=
stion works the same as my previous shared statement. but, only for calls l=
ike:=C2=A0<b>my_printf(&quot;%s&quot;, <a href=3D"http://h1.name" target=3D=
"_blank">h1.name</a>);</b>,</div><div>not for=C2=A0<b>my_printf(&quot;%d he=
re also, tt=3D%s | %s and %m\n&quot;, id, h2-&gt;name, h2-&gt;name, s2);</b=
></div></div><div><br></div>e.g:<div><br></div><div>Code sample</div><div><=
br><font face=3D"monospace">int foo() {<br>	int id;<br>	struct mydata h1, *=
h2, s1, *s2;<br><br>	// works fine<br>	my_printf(&quot;%s&quot;, <a href=3D=
"http://h1.name" target=3D"_blank">h1.name</a>);<br>	my_printf(&quot;%s&quo=
t;, h2-&gt;name);<br>	my_printf(&quot;%s&quot;);<br><br>	// don&#39;t match=
.<br>	my_printf(&quot;%s %d&quot;, h2-&gt;name, id);<br>	my_printf(&quot;%s=
 %s&quot;, h2-&gt;name, h2-&gt;name);<br>	my_printf(&quot;%d it would work =
but dunno mydata=3D%m\n&quot;, id, h2);<br>	my_printf(&quot;%d here also, t=
t=3D%s | %s and %m\n&quot;, id, h2-&gt;name, h2-&gt;name, s2);<br>}</font><=
br></div><div><br></div><div>so, I am not sure if Coccinelle is able to do =
that. I&#39;ve read all samples available in the Kernel and Coccinelle repo=
&#39;s and I didn&#39;t see any similar case.</div><div><br></div><div>I th=
ink that if=C2=A0<a class=3D"gmail_plusreply" id=3D"m_1967091305000335020pl=
usReplyChip-0" href=3D"mailto:julia.lawall@inria.fr" target=3D"_blank">@Jul=
ia Lawall</a>=C2=A0don&#39;t know, No one in the world knows.=C2=A0=F0=9F=
=98=82</div><div><br></div><div><br></div><div><br><div class=3D"gmail_quot=
e"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 29, 2019 at 10:33 AM M=
arkus Elfring &lt;<a href=3D"mailto:Markus.Elfring@web.de" target=3D"_blank=
">Markus.Elfring@web.de</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">&gt;&gt;. Did you try out to work with SmPL ellipses=
 and disjunctions for this purpose?=C2=A0<br>
&gt; =C2=A0<br>
&gt; I didn&#39;t it, do you have any suggestions or sample that is it poss=
ible<br>
&gt; to solve my problem? something to based on.<br>
<br>
Can you get further development ideas from a transformation approach<br>
like the following?<br>
<br>
@replacement@<br>
struct mydata SMD;<br>
struct mydata* SMDP;<br>
format F =3D~ &quot;s&quot;;<br>
@@<br>
=C2=A0my_printf(<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%@F@&quot;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;%m&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0,<br>
(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0SMD<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0.name<br>
|<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 SMDP<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0-&gt;name<br>
)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 );<br>
<br>
<br>
<br>
&gt; I mean, the Coccinelle/Python support.<br>
<br>
This programming interface contains also open issues for further considerat=
ions<br>
as you can see from a topic like =E2=80=9CPropagating values back from Pyth=
on script<br>
to SmPL rule with other metavariable type than =E2=80=9Cidentifier=E2=80=9D=
=E2=80=9D.<br>
<a href=3D"https://github.com/coccinelle/coccinelle/issues/86" rel=3D"noref=
errer" target=3D"_blank">https://github.com/coccinelle/coccinelle/issues/86=
</a><br>
<br>
Regards,<br>
Markus<br>
</blockquote></div></div></div>

--00000000000036ef8505987d52d9--

--===============0129876294==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0129876294==--
