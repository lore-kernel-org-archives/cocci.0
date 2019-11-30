Return-Path: <SRS0=GrYw=ZW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74307C432C0
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2019 02:26:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 944FE215E5
	for <cocci@archiver.kernel.org>; Sat, 30 Nov 2019 02:26:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fUuS1/EC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 944FE215E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAU2QNdX003547;
	Sat, 30 Nov 2019 03:26:23 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1315277D4;
	Sat, 30 Nov 2019 03:26:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3F94977D2
 for <cocci@systeme.lip6.fr>; Sat, 30 Nov 2019 03:26:21 +0100 (CET)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:42b] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAU2QKwG015780
 for <cocci@systeme.lip6.fr>; Sat, 30 Nov 2019 03:26:20 +0100 (CET)
Received: by mail-wr1-x42b.google.com with SMTP id j42so11392752wrj.12
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 18:26:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=R90/7MOyvm0oi8E4WZwGNNvxdzVG1vKkH8Hp4rKG+K4=;
 b=fUuS1/ECtuKA8ZkLXP5gNzq7B+7GpNcDUgD5LXPPNGRIpxvOf7iVRVprXxWM/EJdud
 DgJZEv509hf7G+vmgseoc2kIa/IEifonJDIY+G3TDwZ2VMF1YDvAlJuaYTbkZb5F80iS
 x4u9T82xthvktU+vIfIw50ctVHsq++60GdgpQYW+ZQLRtnSySna58M6WK257fVHauXl/
 5YkxTb/JS9QrK3nJbITc4fhmE5eMnMiCCJWK1O3qwdxnGxdboXpjfNN6Ew3hjGdxKcvl
 F0M3x5HPjzbFbXnCnyx1lQoI2MSaEE2BT46miJFXflxfDTJJPEzIwpuR8LZrStZbszqx
 tc+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=R90/7MOyvm0oi8E4WZwGNNvxdzVG1vKkH8Hp4rKG+K4=;
 b=VmVYtkRm/tuwpKz03qgHVgvY5Q/ajZ+5WnuUJAztNOMAukZERNYZWQBJe0AdvMCpwh
 QHNpEsH7BnBqamxCUzA7yU35+IZjJR8KZYOpKDZtq67WhzerOKJOKsDBmE55nYc+BgVH
 v1CsxS2JvzV+7cPX6INMMBkXf3vSRR9vfXpVHVsjnwYsk91MDXcAe49BPfiyT4tVELcH
 1jy+HjRUrpWhYfAnpAOyMuvwQWf6VRBOlZAJUz9Vnn1F9Vv3tlt0L15HwfZHTZPZhOqZ
 uLo2hh24q5IDpz0+gi+vKWh1briYPIzXjfRs7znWsppgyVFThGD1CjAhsGBs3sZKg0df
 pLzw==
X-Gm-Message-State: APjAAAW42CiqPJ7QEpy9F4FCzOeGf30ym4LWYuqdfN8+0M65ijIlxET/
 G+dSX5BDi5cZ1QEfsny8BMscrarijVDzyjZn5mE=
X-Google-Smtp-Source: APXvYqxwKlM7Ok888VnmYxmCgmKAVlQzxVuKEvv/hvEgmGkdnv8JCK+nIFlo2LKgzbbvqXZE1LLTci5wMcrj5+sFj2Y=
X-Received: by 2002:a05:6000:1241:: with SMTP id
 j1mr10449214wrx.26.1575080779964; 
 Fri, 29 Nov 2019 18:26:19 -0800 (PST)
MIME-Version: 1.0
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
In-Reply-To: <alpine.DEB.2.21.1911292154450.3140@hadrien>
From: Strace Labs <stracelabs@gmail.com>
Date: Sat, 30 Nov 2019 00:25:43 -0200
Message-ID: <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 Nov 2019 03:26:23 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 30 Nov 2019 03:26:20 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr
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
Content-Type: multipart/mixed; boundary="===============0228145261=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0228145261==
Content-Type: multipart/alternative; boundary="00000000000061e42805988712de"

--00000000000061e42805988712de
Content-Type: text/plain; charset="UTF-8"

Hi Julia,

Thanks for the suggestion. But, It is working partially... I am not sure if
Coccinelle is able to filter the %fmt e.g: %s only called with a parameter
of specific data-type. In my case, *{struct mydata }.name* and *{ struct
mydata *}->name*.

##### * Cocci*
@r1@
format list d;
identifier fn;
@@

fn("%@d@", ...)

@script:ocaml s1@
d << r1.d;
res;
@@
res := make_expr ("\""^(String.concat "%m"
(Str.split_delim(Str.regexp_string "%s") d))^"\"")

@main depends on s1 && r1@
format list r1.d;
expression s1.res;
identifier r1.fn;
struct mydata SMD;
struct mydata* SMDP;
@@

 fn(
-"%@d@"
+res
,
(
+ &
  SMD
- .name
|
  SMDP
- ->name
)
 );

*#####  .c Code sample*
int foo() {
int id;
struct mydata h1, *h2, s1, *s2;
char *city;

// works fine
my_printf("%s", s2->name);

// works without any criterions about the data type of %fmt
my_printf("sss %s gggg", h1.name);
my_printf("33131231313 %d %s %d %s hhhhh", id, s1.name, (*h2)->name,
h2->name);
my_printf("aaaa %s hhhhh", h2->name);
my_printf("%s", s2->name);

// should do nothing
my_printf("%s");
my_printf("%s", city);

// don't match.
my_printf("a %s %d", h2->name, id);
my_printf("ddddd %s %s %s", h2->name, city, h2->name);
my_printf("%d it would work but dunno mydata=%m\n", id, h2);
my_printf("%d here also, tt=%s | %s and %m\n", id, h2->name, h2->name, s2);
}

*#### Result*
HANDLING: /Volumes/Users/test/Coccinella/sample.c
diff =
--- /Volumes/Users/test/Coccinella/sample.c
+++ /tmp/cocci-output-99329-3a9829-sample.c
@@ -5,13 +5,13 @@ int foo() {
  char *city;

  // works fine
- my_printf("%s", s2->name);
+ my_printf("%m", s2);

  // works without any criterious about the data type of %fmt
- my_printf("sss %s gggg", h1.name);
+ my_printf("sss %m gggg", &h1);
  my_printf("33131231313 %d %s %d %s hhhhh", id, s1.name, (*h2)->name,
h2->name);
- my_printf("aaaa %s hhhhh", h2->name);
- my_printf("%s", s2->name);
+ my_printf("aaaa %m hhhhh", h2);
+ my_printf("%m", s2);

  // should do nothing
  my_printf("%s");


Basically, I intend to replace alls "%s" called with "mydata->name" by "%m"
with "mydata" or "&mydata"





On Fri, Nov 29, 2019 at 6:55 PM Julia Lawall <julia.lawall@inria.fr> wrote:

> Maybe this will help you:
>
> @r@
> format list d;
> @@
>
> "%@d@"
>
> @script:ocaml s@
> d << r.d;
> res;
> @@
> res := make_expr ("\""^(String.concat "%s" (Str.split_delim
> (Str.regexp_string "%d") d))^"\"")
>
>
> @@
> format list r.d;
> expression s.res;
> @@
>
> -"%@d@"
> +res
>
> ---------------
>
> Example:
>
> int main() {
>   printf("some %d more\n", 12);
> }
>
> int main() {
>   printf("%d more\n", 12);
> }
>
> int main() {
>   printf("more %d\n", 12);
> }
>
> int main() {
>   printf("%d more %d\n", 12);
> }
>
> julia
>

--00000000000061e42805988712de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Julia,</div><div><br></div><div>Thanks for the sug=
gestion. But, It is working partially... I am not sure if Coccinelle is abl=
e to filter the %fmt e.g: %s only called with a parameter of specific data-=
type. In my case, <i>{struct mydata }.name</i> and <i>{ struct mydata *}-&g=
t;name</i>.</div><div><br></div><div>#####=C2=A0<b>=C2=A0Cocci</b></div><di=
v>@r1@<br>format list d;<br>identifier fn;<br>@@<br><br>fn(&quot;%@d@&quot;=
, ...)<br><br>@script:ocaml s1@<br>d &lt;&lt; r1.d;<br>res;<br>@@<br>res :=
=3D make_expr (&quot;\&quot;&quot;^(String.concat &quot;%m&quot; (Str.split=
_delim(Str.regexp_string &quot;%s&quot;) d))^&quot;\&quot;&quot;)<br><br>@m=
ain depends on s1 &amp;&amp; r1@<br>format list r1.d;<br>expression s1.res;=
<br>identifier r1.fn;<br>struct mydata SMD;<br>struct mydata* SMDP;<br>@@<b=
r><br>=C2=A0fn(<br>-&quot;%@d@&quot;<br>+res<br>,<br>(<br>+ &amp;<br>=C2=A0=
 SMD<br>- .name<br>|<br>=C2=A0 SMDP<br>- -&gt;name<br>)<br>=C2=A0);<br>=C2=
=A0</div><div><b>#####=C2=A0 .c Code sample</b><br>int foo() {<br>	int id;<=
br>	struct mydata h1, *h2, s1, *s2;<br>	char *city;<br><br>	// works fine<b=
r>	my_printf(&quot;%s&quot;, s2-&gt;name);<br><br>	// works without any cri=
terions about the data type of %fmt<br>	my_printf(&quot;sss %s gggg&quot;, =
<a href=3D"http://h1.name">h1.name</a>);<br>	my_printf(&quot;33131231313 %d=
 %s %d %s hhhhh&quot;, id, <a href=3D"http://s1.name">s1.name</a>, (*h2)-&g=
t;name, h2-&gt;name);<br>	my_printf(&quot;aaaa %s hhhhh&quot;, h2-&gt;name)=
;<br>	my_printf(&quot;%s&quot;, s2-&gt;name);<br>	<br>	// should do nothing=
<br>	my_printf(&quot;%s&quot;);<br>	my_printf(&quot;%s&quot;, city);<br><br=
>	// don&#39;t match.<br>	my_printf(&quot;a %s %d&quot;, h2-&gt;name, id);<=
br>	my_printf(&quot;ddddd %s %s %s&quot;, h2-&gt;name, city, h2-&gt;name);<=
br>	my_printf(&quot;%d it would work but dunno mydata=3D%m\n&quot;, id, h2)=
;<br>	my_printf(&quot;%d here also, tt=3D%s | %s and %m\n&quot;, id, h2-&gt=
;name, h2-&gt;name, s2);<br>}<br></div><div><br></div><div><b>#### Result</=
b></div><div>HANDLING: /Volumes/Users/test/Coccinella/sample.c<br>diff =3D<=
br>--- /Volumes/Users/test/Coccinella/sample.c<br>+++ /tmp/cocci-output-993=
29-3a9829-sample.c<br>@@ -5,13 +5,13 @@ int foo() {<br>=C2=A0	char *city;<b=
r><br>=C2=A0	// works fine<br>-	my_printf(&quot;%s&quot;, s2-&gt;name);<br>=
+	my_printf(&quot;%m&quot;, s2);<br><br>=C2=A0	// works without any criteri=
ous about the data type of %fmt<br>-	my_printf(&quot;sss %s gggg&quot;, <a =
href=3D"http://h1.name">h1.name</a>);<br>+	my_printf(&quot;sss %m gggg&quot=
;, &amp;h1);<br>=C2=A0	my_printf(&quot;33131231313 %d %s %d %s hhhhh&quot;,=
 id, <a href=3D"http://s1.name">s1.name</a>, (*h2)-&gt;name, h2-&gt;name);<=
br>-	my_printf(&quot;aaaa %s hhhhh&quot;, h2-&gt;name);<br>-	my_printf(&quo=
t;%s&quot;, s2-&gt;name);<br>+	my_printf(&quot;aaaa %m hhhhh&quot;, h2);<br=
>+	my_printf(&quot;%m&quot;, s2);<br><br>=C2=A0	// should do nothing<br>=C2=
=A0	my_printf(&quot;%s&quot;);<br></div><div><br></div><div><br></div><div>=
Basically, I intend to replace alls &quot;%s&quot; called with &quot;mydata=
-&gt;name&quot; by &quot;%m&quot; with &quot;mydata&quot; or &quot;&amp;myd=
ata&quot;</div><div><br></div><div><br></div><div><br></div><div><br></div>=
<div><br></div><div><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Fri, Nov 29, 2019 at 6:55 PM Julia Lawall &lt;<a href=3D"mailt=
o:julia.lawall@inria.fr">julia.lawall@inria.fr</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Maybe this will help you:<br>
<br>
@r@<br>
format list d;<br>
@@<br>
<br>
&quot;%@d@&quot;<br>
<br>
@script:ocaml s@<br>
d &lt;&lt; r.d;<br>
res;<br>
@@<br>
res :=3D make_expr (&quot;\&quot;&quot;^(String.concat &quot;%s&quot; (Str.=
split_delim<br>
(Str.regexp_string &quot;%d&quot;) d))^&quot;\&quot;&quot;)<br>
<br>
<br>
@@<br>
format list r.d;<br>
expression s.res;<br>
@@<br>
<br>
-&quot;%@d@&quot;<br>
+res<br>
<br>
---------------<br>
<br>
Example:<br>
<br>
int main() {<br>
=C2=A0 printf(&quot;some %d more\n&quot;, 12);<br>
}<br>
<br>
int main() {<br>
=C2=A0 printf(&quot;%d more\n&quot;, 12);<br>
}<br>
<br>
int main() {<br>
=C2=A0 printf(&quot;more %d\n&quot;, 12);<br>
}<br>
<br>
int main() {<br>
=C2=A0 printf(&quot;%d more %d\n&quot;, 12);<br>
}<br>
<br>
julia<br>
</blockquote></div></div></div>

--00000000000061e42805988712de--

--===============0228145261==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0228145261==--
