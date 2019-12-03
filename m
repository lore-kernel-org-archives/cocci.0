Return-Path: <SRS0=z6Nh=ZZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24CC4C432C0
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 03:31:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CAB020656
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 03:31:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EIMInjSn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CAB020656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB33UsXa015380;
	Tue, 3 Dec 2019 04:30:54 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C94A777D7;
	Tue,  3 Dec 2019 04:30:54 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8D7CD4386
 for <cocci@systeme.lip6.fr>; Tue,  3 Dec 2019 04:30:52 +0100 (CET)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:436] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB33UpDH021704
 for <cocci@systeme.lip6.fr>; Tue, 3 Dec 2019 04:30:51 +0100 (CET)
Received: by mail-wr1-x436.google.com with SMTP id z7so1763053wrl.13
 for <cocci@systeme.lip6.fr>; Mon, 02 Dec 2019 19:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=jHlLBYB0mn75meDeuCa49CKzN9c0YYxUm264H50jka4=;
 b=EIMInjSnnH4C/pvnm7LOZqNXi+E1J8cqCJR8pgJza3ki7sfyO4AKAIQaOeugObj2ki
 zM6XQwHWg7XCXkX9GxJ5QDXQnSJlPQfPhEoByR4poc5Ya8gq+napehonMdeaIxV8ivcE
 Lznp+XeWXyy5LDjDyV+JFImcdpRqEW16cN6iX6t1fhaeKfXXrRDlp318oVHgN+W3IPEU
 iG480uG38pahvMbxiyDWu+GFbTruQWFIHve6l/RoB2F2R+03wXC6+DCuhEJZ41EOw8mG
 i4T7aJFf8bR42EnKvSk5pJe7PKn/zQci8pXCchVXBjjcJ9HZ4qRvMlTZ/C8URU6dwCsN
 e64Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=jHlLBYB0mn75meDeuCa49CKzN9c0YYxUm264H50jka4=;
 b=UWuO6zzmX6s5XmyMs/RYXfLpjodlrFvoymU5YOFyFmRwwPMppBTgqRtNwHoLCrRdId
 iTBrgReV8pKABTO7snh2HEBPnefTYEtG0UTIXb73oZ9u46TsuKMUy8qBOX6ja1Au/xnw
 4VHSRHtvJi/8avxsBNLp7gOQ7gWF2SfoRS5+nU32qItJ88lSsmi7+sMDKCmJzdujM3y8
 fgvu6vyz0kDjadBqK1MDYReBL+PelQxDh75JBz38BsUXD3aBsUoOdnsRmW/MkJ+o6UhJ
 3AqIVxEeJ2a3accEyOuAbyAyhMb1H1RjWQG1dQlSkAHaOy9CENyrANOcgOpLrCVO7gJJ
 ZQIw==
X-Gm-Message-State: APjAAAWWj6WI+vslCn7TRT5R/61MdLFBL71LRdQQwLvudwIvbEs/F0Gy
 dIjx8nXEUGtGR6rWBTDQ347D9Fj5jYZ4tyekTCA=
X-Google-Smtp-Source: APXvYqymmcqwF3FrA+9QYi1MTVO+BluQLhgeZQ4Q5te8EiVjtazVj0mSI1EVzRQIZOVonGXsnS+HgV3zNTLUeiStnXk=
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr2709487wrx.26.1575343850834; 
 Mon, 02 Dec 2019 19:30:50 -0800 (PST)
MIME-Version: 1.0
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
In-Reply-To: <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
From: Strace Labs <stracelabs@gmail.com>
Date: Tue, 3 Dec 2019 01:30:14 -0200
Message-ID: <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 04:30:55 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 03 Dec 2019 04:30:51 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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
Content-Type: multipart/mixed; boundary="===============2076038904=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============2076038904==
Content-Type: multipart/alternative; boundary="000000000000a0ce750598c4527e"

--000000000000a0ce750598c4527e
Content-Type: text/plain; charset="UTF-8"

On Sun, Dec 1, 2019 at 6:00 AM Markus Elfring <Markus.Elfring@web.de> wrote:

> > Basically, I intend to replace alls "%s" called with "mydata->name" by
> "%m" with "mydata" or "&mydata"
>
> How far would you get the desired source code transformation based on
> software extensions around a search pattern like the following.
> ..........
> Which algorithm will become sufficient for your data processing needs
> around the usage of functions with variadic arguments because of format
> strings?
>
>
Actually, I really didn't get why you're asking about that. because we are
talking about X and you're asking for Y. but, either way. that is not the
point. the point is because I am studying about the Coccinelle and I am
just trying to figure out if the tool could detect "%s" called with
"mydata->name" and then replace by "%m" and remove the "->name"

e.g: Once if we have:

int foo() {
  int id;
  struct mydata h1, *h2, s1, *s2;
  char *city = "Hello";
  my_printf("%s", s2->name);
  my_printf("hi hi %s gggg", h1.name);
  my_printf("1234 %d *%s* @ %d *%s* | *%s* -> city=%s", id, *s1.name
<http://s1.name>*, 12, *(*h2).name*, *h2->name*, city);
  my_printf("aaaa %s hhhhh", h2->name);
  my_printf("%s", city);
}

Then, replace by:

int foo() {
  int id;
  struct mydata h1, *h2, s1, *s2;
  char *city = "Hello";
  *my_printf("%m", s2);*
  *my_printf("hi hi %s gggg", &h1);*
  my_printf("1234 %d *%m* @ %d *%m* | *%m* -> city=%s", id, *s1.name
<http://s1.name>*, 12, *(*h2).name*, *h2->name*, city);
*  my_printf("aaaa %s hhhhh", h2);*
  my_printf("%s", city);
}

But, I've read again the other samples and the documentation. therefore, I
didn't figure out how it should be. btw, thank you Julia for the suggestion
performing the *Ocalm/make_expr/replace*. (Due to something wrong with the
Coccinelle distributed by Brew/Osx. I just rewrote your sample using Python
and the result was the same. But, I can't just replace all "%s" by "%m". As
I said, it should be only if the "%s" was declared to use "mydata->name".

so, I still fighting yet. thanks in Advance.

Regards,
> Markus
>

--000000000000a0ce750598c4527e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">On Sun, Dec 1, 2019 at 6:00 AM Markus Elf=
ring &lt;<a href=3D"mailto:Markus.Elfring@web.de">Markus.Elfring@web.de</a>=
&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">&gt; Basically, I intend to replace alls &quot;%s&qu=
ot; called with &quot;mydata-&gt;name&quot; by &quot;%m&quot; with &quot;my=
data&quot; or &quot;&amp;mydata&quot;<br>
<br>
How far would you get the desired source code transformation based on<br>
software extensions around a search pattern like the following.<br>........=
..<br>
Which algorithm will become sufficient for your data processing needs<br>
around the usage of functions with variadic arguments because of format str=
ings?<br>
<br></blockquote><div><br></div><div>Actually, I really didn&#39;t get why =
you&#39;re asking about that. because we are talking about X and you&#39;re=
 asking for Y. but, either way. that is not the point. the point is because=
 I am studying about the Coccinelle and I am just trying to figure out if t=
he tool could detect &quot;%s&quot; called with &quot;mydata-&gt;name&quot;=
 and then replace by &quot;%m&quot; and remove the &quot;-&gt;name&quot;</d=
iv><div><br></div><div>e.g: Once if we have:</div><div><br></div><div>int f=
oo() {<br>=C2=A0 int id;<br>=C2=A0 struct mydata h1, *h2, s1, *s2;<br>=C2=
=A0 char *city =3D &quot;Hello&quot;;<br>=C2=A0 my_printf(&quot;%s&quot;, s=
2-&gt;name);<br>=C2=A0 my_printf(&quot;hi hi %s gggg&quot;, <a href=3D"http=
://h1.name">h1.name</a>);<br>=C2=A0 my_printf(&quot;1234 %d <b>%s</b> @ %d =
<b>%s</b>=C2=A0| <b>%s</b> -&gt; city=3D%s&quot;, id, <b><a href=3D"http://=
s1.name">s1.name</a></b>, 12, <b>(*h2).name</b>, <b>h2-&gt;name</b>, city);=
<br>=C2=A0 my_printf(&quot;aaaa %s hhhhh&quot;, h2-&gt;name);<br>=C2=A0 my_=
printf(&quot;%s&quot;, city);<br></div><div>}</div><div><br></div><div>Then=
, replace by:</div><div><br></div><div><div>int foo() {<br>=C2=A0 int id;<b=
r>=C2=A0 struct mydata h1, *h2, s1, *s2;<br>=C2=A0 char *city =3D &quot;Hel=
lo&quot;;<br>=C2=A0 <b>my_printf(&quot;%m&quot;, s2);</b><br>=C2=A0 <b>my_p=
rintf(&quot;hi hi %s gggg&quot;, &amp;h1);</b><br>=C2=A0 my_printf(&quot;12=
34 %d <b>%m</b>=C2=A0@ %d <b>%m</b>=C2=A0| <b>%m</b>=C2=A0-&gt; city=3D%s&q=
uot;, id, <b><a href=3D"http://s1.name">s1.name</a></b>, 12, <b>(*h2).name<=
/b>, <b>h2-&gt;name</b>, city);<br><b>=C2=A0 my_printf(&quot;aaaa %s hhhhh&=
quot;, h2);</b><br>=C2=A0 my_printf(&quot;%s&quot;, city);<br></div><div>}<=
/div></div><div><br></div><div>But, I&#39;ve read again the other samples a=
nd the documentation. therefore, I didn&#39;t figure out how it should be. =
btw, thank you Julia for the suggestion performing the <i>Ocalm/make_expr/r=
eplace</i>. (Due to something wrong with the Coccinelle distributed by Brew=
/Osx. I just rewrote your sample using Python and the result was the same. =
But, I can&#39;t just replace all &quot;%s&quot; by &quot;%m&quot;. As I sa=
id, it should be only if the &quot;%s&quot; was declared to use &quot;mydat=
a-&gt;name&quot;.</div><div><br></div><div>so, I still fighting yet. thanks=
 in Advance.</div><div><br></div><blockquote class=3D"gmail_quote" style=3D=
"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-le=
ft:1ex">
Regards,<br>
Markus<br>
</blockquote></div></div>

--000000000000a0ce750598c4527e--

--===============2076038904==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============2076038904==--
