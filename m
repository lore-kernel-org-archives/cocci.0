Return-Path: <SRS0=z6Nh=ZZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC551C432C0
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 17:29:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E8D92073C
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 17:29:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knqS1NLY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E8D92073C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3HT1BV023649;
	Tue, 3 Dec 2019 18:29:02 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AE20F77D7;
	Tue,  3 Dec 2019 18:29:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3551C4386
 for <cocci@systeme.lip6.fr>; Tue,  3 Dec 2019 18:29:00 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42d] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB3HSxGQ013992
 for <cocci@systeme.lip6.fr>; Tue, 3 Dec 2019 18:28:59 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id w15so4734672wru.4
 for <cocci@systeme.lip6.fr>; Tue, 03 Dec 2019 09:28:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GpqYcNI46CBJx+2Kv0Sq5xfRzTSQSo8gHFOn1y7GqAM=;
 b=knqS1NLYUpak86PYSQilX5H7a1nzhOwIPeAD4wptJ2e4xES2w9Q4HmyY+ldRieCad/
 1GdLaiA+JNDgEDaFEIG5/lBPT0Y80ipFdZ3cNG0YulhEJUwuH16TnHfgBcrQ58WDanGx
 r/Qk8I8hX9FJxi1ZDChmRrdt6rv8YHcjAgldF5xhkGdnan+nOBp6dMEciDqDw2+pbRTG
 MzJUznCZKwpZB/mmP7tIPTwFLXaAgKqaybAlGQPFpCeJuRiOYpeO+3tFi95vuwJW1LnU
 LoirpMsstZeYgn+kO+9pY06Q/DXaGHuXw50Thkdr2ndRKYpwARbs4T3fEolkrQiccb27
 43uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GpqYcNI46CBJx+2Kv0Sq5xfRzTSQSo8gHFOn1y7GqAM=;
 b=MAR/PGYfWZgtwR4ZruwXecgjKB7YxIF6FhGXzmJjoR2JbimtAPGNOqgKhPYSG3aWUJ
 8ApyAC6K7F3Ui7iix7nlm6uW55eutG34NEMqC9K+x9QXbwe/BgFy8jdnJ5d10oOKB0jG
 TeSlz06qDK1+O+ZvGTuoRGRJppLOVI7psCVm3Aqbw9AbYCFPIHyPO2DnRzkHGNiOc98O
 kfCcfHaiaJC2P67cTWNot0bBe3K51YNsg/eukjEadz+yz1dLxdR9SeCLDOWXCBY/6cC9
 xMS+mE8ZYGj9GUJTZFOjCl5z+deXQXpFXcZrrH8Epj7PyHr4G8o/iCb1NYwlryMQ05Yb
 w5VQ==
X-Gm-Message-State: APjAAAXJozrcLBjQiEhqSD8//jKL+H9SDtXcBp7oap1YDGKS9oghbLbm
 2N5ZeEFGEdsfk4qr0uo7/jCO+5Vvj3DPx5fMUAk=
X-Google-Smtp-Source: APXvYqxeZfMCfj2qPtNI82UFuTSjUVcGnKcI6gwgy7zQjWx6ReoBgmyENPpttSFFe8IJUbn3WuNK+WS8eBD1mjcQDVA=
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr6885299wrx.26.1575394138819; 
 Tue, 03 Dec 2019 09:28:58 -0800 (PST)
MIME-Version: 1.0
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
 <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
 <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
In-Reply-To: <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
From: Strace Labs <stracelabs@gmail.com>
Date: Tue, 3 Dec 2019 15:28:22 -0200
Message-ID: <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 18:29:02 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 03 Dec 2019 18:28:59 +0100 (CET)
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
Content-Type: multipart/mixed; boundary="===============0896038969=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0896038969==
Content-Type: multipart/alternative; boundary="0000000000000693800598d008a0"

--0000000000000693800598d008a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Unfortunately, it doesn't work. But, I am working on some solutions using
Python.

therefore, once we have something like:

...
@r1@
format list fl;
identifier fn;
expression list e;
position p;
@@

fn("%@fl@", e@p)
....

Then, I could handle the *format list* using *make_expr()* as well. But, Is
it possible to rename/handle the *expression list?*


On Tue, Dec 3, 2019 at 3:18 AM Julia Lawall <julia.lawall@inria.fr> wrote:

> ------------------------------
>
> *De: *"Strace Labs" <stracelabs@gmail.com>
> *=C3=80: *"Markus Elfring" <Markus.Elfring@web.de>
> *Cc: *"Julia Lawall" <julia.lawall@inria.fr>, cocci@systeme.lip6.fr
> *Envoy=C3=A9: *Mardi 3 D=C3=A9cembre 2019 11:30:14
> *Objet: *Re: [Cocci] Changing format string usage with SmPL?
>
> On Sun, Dec 1, 2019 at 6:00 AM Markus Elfring <Markus.Elfring@web.de>
> wrote:
>
>> > Basically, I intend to replace alls "%s" called with "mydata->name" by
>> "%m" with "mydata" or "&mydata"
>>
>> How far would you get the desired source code transformation based on
>> software extensions around a search pattern like the following.
>> ..........
>> Which algorithm will become sufficient for your data processing needs
>> around the usage of functions with variadic arguments because of format
>> strings?
>>
>>
> Actually, I really didn't get why you're asking about that. because we ar=
e
> talking about X and you're asking for Y. but, either way. that is not the
> point. the point is because I am studying about the Coccinelle and I am
> just trying to figure out if the tool could detect "%s" called with
> "mydata->name" and then replace by "%m" and remove the "->name"
>
> e.g: Once if we have:
>
> int foo() {
>   int id;
>   struct mydata h1, *h2, s1, *s2;
>   char *city =3D "Hello";
>   my_printf("%s", s2->name);
>   my_printf("hi hi %s gggg", h1.name);
>   my_printf("1234 %d *%s* @ %d *%s* | *%s* -> city=3D%s", id, *s1.name
> <http://s1.name>*, 12, *(*h2).name*, *h2->name*, city);
>   my_printf("aaaa %s hhhhh", h2->name);
>   my_printf("%s", city);
> }
>
> Then, replace by:
>
> int foo() {
>   int id;
>   struct mydata h1, *h2, s1, *s2;
>   char *city =3D "Hello";
> *my_printf("%m", s2);*
> *my_printf("hi hi %s gggg", &h1);*
>   my_printf("1234 %d *%m* @ %d *%m* | *%m* -> city=3D%s", id, *s1.name
> <http://s1.name>*, 12, *(*h2).name*, *h2->name*, city);
> *  my_printf("aaaa %s hhhhh", h2);*
>   my_printf("%s", city);
> }
>
> But, I've read again the other samples and the documentation. therefore, =
I
> didn't figure out how it should be. btw, thank you Julia for the suggesti=
on
> performing the *Ocalm/make_expr/replace*. (Due to something wrong with
> the Coccinelle distributed by Brew/Osx. I just rewrote your sample using
> Python and the result was the same. But, I can't just replace all "%s" by
> "%m". As I said, it should be only if the "%s" was declared to use
> "mydata->name".
>
> so, I still fighting yet. thanks in Advance.
>
> OK, if you may have more than one argument to your print, then you can
> find the offset using an expression list metavariable:
>
> @r@
> expression list[n] between;
> @@
>
> print(s,between,h2->name,...)
>
> Then you can use r.n in your python rule to figure out where is the %s to
> change.  Unfortunately, this will not work well if there are multiple nam=
e
> references in the argument list.  Because you will be trying to change th=
e
> format string in multiple ways, eg once where between has length 2 and on=
ce
> where between has length 4.  Substantial hacks would be required to deal
> with this.
>
> It would be nice if you could do
>
> @r@
> expression list[bn] between;
> expression list[an] after;
> position p;
> @@
> print@p(s,between,name,after)
>
> @@
> format list[r.bn] f1;
> format list[r.an] f2;
> position r.p;
> @@
> print@p(
> -    "%@f1@%s%@f2@"
> +   "%@f1@%m%@f2@"
> , l)
>
> I don't know if that would work, though.
>
> julia
>
> Regards,
>> Markus
>>
>
>

--0000000000000693800598d008a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Unfortunately, it doesn&#39;t work. But, =
I am working on some solutions using Python.=C2=A0</div><div dir=3D"ltr"><b=
r></div><div>therefore, once we have something like:</div><div><br></div><d=
iv>...</div><div>@r1@<br>format list fl;<br>identifier fn;<br>expression li=
st e;<br>position p;<br>@@<br><br>fn(&quot;%@fl@&quot;, e@p)<br></div><div>=
....</div><div><br></div><div>Then, I could handle the <b>format list</b>=
=C2=A0using=C2=A0<b>make_expr()</b>=C2=A0as well. But, Is it possible to re=
name/handle the <b>expression list?</b></div><div><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 =
at 3:18 AM Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr">julia.=
lawall@inria.fr</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;font-s=
ize:12pt;color:rgb(0,0,0)"><hr id=3D"gmail-m_5206298212494274740zwchr"><div=
><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;=
padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text=
-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><b>=
De: </b>&quot;Strace Labs&quot; &lt;<a href=3D"mailto:stracelabs@gmail.com"=
 target=3D"_blank">stracelabs@gmail.com</a>&gt;<br><b>=C3=80: </b>&quot;Mar=
kus Elfring&quot; &lt;<a href=3D"mailto:Markus.Elfring@web.de" target=3D"_b=
lank">Markus.Elfring@web.de</a>&gt;<br><b>Cc: </b>&quot;Julia Lawall&quot; =
&lt;<a href=3D"mailto:julia.lawall@inria.fr" target=3D"_blank">julia.lawall=
@inria.fr</a>&gt;, <a href=3D"mailto:cocci@systeme.lip6.fr" target=3D"_blan=
k">cocci@systeme.lip6.fr</a><br><b>Envoy=C3=A9: </b>Mardi 3 D=C3=A9cembre 2=
019 11:30:14<br><b>Objet: </b>Re: [Cocci] Changing format string usage with=
 SmPL?<br></blockquote></div><div><blockquote style=3D"border-left:2px soli=
d rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-wei=
ght:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ari=
al,sans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr">On Sun, Dec=
 1, 2019 at 6:00 AM Markus Elfring &lt;<a href=3D"mailto:Markus.Elfring@web=
.de" target=3D"_blank">Markus.Elfring@web.de</a>&gt; wrote:<br></div><div c=
lass=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt;=
 Basically, I intend to replace alls &quot;%s&quot; called with &quot;mydat=
a-&gt;name&quot; by &quot;%m&quot; with &quot;mydata&quot; or &quot;&amp;my=
data&quot;<br><br>
How far would you get the desired source code transformation based on<br>
software extensions around a search pattern like the following.<br>........=
..<br>
Which algorithm will become sufficient for your data processing needs<br>
around the usage of functions with variadic arguments because of format str=
ings?<br><br></blockquote><br><div>Actually, I really didn&#39;t get why yo=
u&#39;re asking about that. because we are talking about X and you&#39;re a=
sking for Y. but, either way. that is not the point. the point is because I=
 am studying about the Coccinelle and I am just trying to figure out if the=
 tool could detect &quot;%s&quot; called with &quot;mydata-&gt;name&quot; a=
nd then replace by &quot;%m&quot; and remove the &quot;-&gt;name&quot;</div=
><br><div>e.g: Once if we have:</div><br><div>int foo() {<br>=C2=A0 int id;=
<br>=C2=A0 struct mydata h1, *h2, s1, *s2;<br>=C2=A0 char *city =3D &quot;H=
ello&quot;;<br>=C2=A0 my_printf(&quot;%s&quot;, s2-&gt;name);<br>=C2=A0 my_=
printf(&quot;hi hi %s gggg&quot;, <a href=3D"http://h1.name" target=3D"_bla=
nk">h1.name</a>);<br>=C2=A0 my_printf(&quot;1234 %d <b>%s</b> @ %d <b>%s</b=
>=C2=A0| <b>%s</b> -&gt; city=3D%s&quot;, id, <b><a href=3D"http://s1.name"=
 target=3D"_blank">s1.name</a></b>, 12, <b>(*h2).name</b>, <b>h2-&gt;name</=
b>, city);<br>=C2=A0 my_printf(&quot;aaaa %s hhhhh&quot;, h2-&gt;name);<br>=
=C2=A0 my_printf(&quot;%s&quot;, city);<br></div><div>}</div><br><div>Then,=
 replace by:</div><br><div><div>int foo() {<br>=C2=A0 int id;<br>=C2=A0 str=
uct mydata h1, *h2, s1, *s2;<br>=C2=A0 char *city =3D &quot;Hello&quot;;<br=
><b>my_printf(&quot;%m&quot;, s2);</b><br><b>my_printf(&quot;hi hi %s gggg&=
quot;, &amp;h1);</b><br>=C2=A0 my_printf(&quot;1234 %d <b>%m</b>=C2=A0@ %d =
<b>%m</b>=C2=A0| <b>%m</b>=C2=A0-&gt; city=3D%s&quot;, id, <b><a href=3D"ht=
tp://s1.name" target=3D"_blank">s1.name</a></b>, 12, <b>(*h2).name</b>, <b>=
h2-&gt;name</b>, city);<br><b>=C2=A0 my_printf(&quot;aaaa %s hhhhh&quot;, h=
2);</b><br>=C2=A0 my_printf(&quot;%s&quot;, city);<br></div><div>}</div></d=
iv><br><div>But, I&#39;ve read again the other samples and the documentatio=
n. therefore, I didn&#39;t figure out how it should be. btw, thank you Juli=
a for the suggestion performing the <i>Ocalm/make_expr/replace</i>. (Due to=
 something wrong with the Coccinelle distributed by Brew/Osx. I just rewrot=
e your sample using Python and the result was the same. But, I can&#39;t ju=
st replace all &quot;%s&quot; by &quot;%m&quot;. As I said, it should be on=
ly if the &quot;%s&quot; was declared to use &quot;mydata-&gt;name&quot;.</=
div><br><div>so, I still fighting yet. thanks in Advance.</div></div></div>=
</blockquote><div>OK, if you may have more than one argument to your print,=
 then you can find the offset using an expression list metavariable:<br></d=
iv><div><br></div><div>@r@<br></div><div>expression list[n] between;<br></d=
iv><div>@@<br></div><div><br></div><div>print(s,between,h2-&gt;name,...)<br=
></div><div><br></div><div>Then you can use r.n in your python rule to figu=
re out where is the %s to change.=C2=A0 Unfortunately, this will not work w=
ell if there are multiple name references in the argument list.=C2=A0 Becau=
se you will be trying to change the format string in multiple ways, eg once=
 where between has length 2 and once where between has length 4.=C2=A0 Subs=
tantial hacks would be required to deal with this.<br></div><div><br></div>=
<div>It would be nice if you could do<br></div><div><br></div><div>@r@<br><=
/div><div>expression list[bn] between;<br></div><div>expression list[an] af=
ter;<br></div><div>position p;<br></div><div>@@<br></div><div>print@p(s,bet=
ween,name,after)<br></div><div><br></div><div>@@<br></div><div>format list[=
<a href=3D"http://r.bn" target=3D"_blank">r.bn</a>] f1;<br></div><div>forma=
t list[<a href=3D"http://r.an" target=3D"_blank">r.an</a>] f2;<br></div><di=
v>position r.p;<br></div><div>@@<br></div><div>print@p(</div><div>-=C2=A0=
=C2=A0=C2=A0 &quot;%@f1@%s%@f2@&quot;<br></div><div>+=C2=A0=C2=A0 &quot;%@f=
1@%m%@f2@&quot;<br></div><div>, l)<br></div><div><br></div><div>I don&#39;t=
 know if that would work, though.<br></div><div><br></div><div>julia<br></d=
iv><div><br></div><blockquote style=3D"border-left:2px solid rgb(16,16,255)=
;margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-=
style:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;fo=
nt-size:12pt"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
Regards,<br>
Markus<br></blockquote></div></div><br></blockquote></div></div></div></blo=
ckquote></div></div>

--0000000000000693800598d008a0--

--===============0896038969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0896038969==--
