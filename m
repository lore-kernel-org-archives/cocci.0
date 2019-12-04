Return-Path: <SRS0=12Zs=Z2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5569AC43603
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2019 06:49:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6591A20661
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2019 06:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6591A20661
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB46lkLo022124;
	Wed, 4 Dec 2019 07:47:46 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 31C2877D7;
	Wed,  4 Dec 2019 07:47:46 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A60A77708
 for <cocci@systeme.lip6.fr>; Wed,  4 Dec 2019 07:47:44 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB46lhuO013414
 for <cocci@systeme.lip6.fr>; Wed, 4 Dec 2019 07:47:43 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,276,1571695200"; 
 d="scan'208,217";a="417586219"
X-MGA-submission: =?us-ascii?q?MDFZUn4RnCCft3xaCQV3XSEbDyuIklAKZZhHUl?=
 =?us-ascii?q?hV9zJ6DkVm82xkTotITnytbqVfmXZ/ZvG6fC3yFx06dkuYJ4/GomXq+7?=
 =?us-ascii?q?UWUXZeYXdJkQoDbwu3C97yJMPN8JcMXRRfrk0STnvwR08QRtI1H5O0jY?=
 =?us-ascii?q?cdqw70yEYofLGA33iLWaRA+A=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
 by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2019 07:47:43 +0100
Date: Wed, 4 Dec 2019 07:47:43 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Strace Labs <stracelabs@gmail.com>
Message-ID: <1624931283.11188831.1575442063589.JavaMail.zimbra@inria.fr>
In-Reply-To: <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
 <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
 <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
 <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [202.161.33.40]
X-Mailer: Zimbra 8.7.11_GA_3800 (ZimbraWebClient - FF70 (Linux)/8.7.11_GA_3800)
Thread-Topic: Changing format string usage with SmPL?
Thread-Index: 75yuBvJhUIXp1YzZ9OGJI38KC6y1RQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 04 Dec 2019 07:47:46 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 04 Dec 2019 07:47:43 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
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
Content-Type: multipart/mixed; boundary="===============0225182260=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0225182260==
Content-Type: multipart/alternative; 
	boundary="=_2ec7c5fa-703b-471e-86e6-aae00c4996de"

--=_2ec7c5fa-703b-471e-86e6-aae00c4996de
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> De: "Strace Labs" <stracelabs@gmail.com>
> =C0: "Julia Lawall" <julia.lawall@inria.fr>
> Cc: "cocci" <cocci@systeme.lip6.fr>
> Envoy=E9: Mercredi 4 D=E9cembre 2019 01:28:22
> Objet: Re: [Cocci] Changing format string usage with SmPL?

> Unfortunately, it doesn't work. But, I am working on some solutions using
> Python.

> therefore, once we have something like:

> ...
> @r1@
> format list fl;
> identifier fn;
> expression list e;
> position p;
> @@

> fn("%@fl@", e@p)
> ....

> Then, I could handle the format list using make_expr() as well. But, Is i=
t
> possible to rename/handle the expression list?

Could you fix up the expression list first? Then you can write a rule like=
=20

char[] s;=20

fn(s, ...,=20
- oldcode=20
+ newcode=20
,...)=20

julia=20

> On Tue, Dec 3, 2019 at 3:18 AM Julia Lawall < [ mailto:julia.lawall@inria=
.fr |
> julia.lawall@inria.fr ] > wrote:

>>> De: "Strace Labs" < [ mailto:stracelabs@gmail.com | stracelabs@gmail.co=
m ] >
>>> =C0: "Markus Elfring" < [ mailto:Markus.Elfring@web.de | Markus.Elfring=
@web.de ] >
>>> Cc: "Julia Lawall" < [ mailto:julia.lawall@inria.fr | julia.lawall@inri=
a.fr ] >,
>>> [ mailto:cocci@systeme.lip6.fr | cocci@systeme.lip6.fr ]
>>> Envoy=E9: Mardi 3 D=E9cembre 2019 11:30:14
>>> Objet: Re: [Cocci] Changing format string usage with SmPL?

>>> On Sun, Dec 1, 2019 at 6:00 AM Markus Elfring < [ mailto:Markus.Elfring=
@web.de |
>>> Markus.Elfring@web.de ] > wrote:

>>>>> Basically, I intend to replace alls "%s" called with "mydata->name" b=
y "%m" with
>>>> > "mydata" or "&mydata"

>>>> How far would you get the desired source code transformation based on
>>>> software extensions around a search pattern like the following.
>>>> ..........
>>>> Which algorithm will become sufficient for your data processing needs
>>>> around the usage of functions with variadic arguments because of forma=
t strings?

>>> Actually, I really didn't get why you're asking about that. because we =
are
>>> talking about X and you're asking for Y. but, either way. that is not t=
he
>>> point. the point is because I am studying about the Coccinelle and I am=
 just
>>> trying to figure out if the tool could detect "%s" called with "mydata-=
>name"
>>> and then replace by "%m" and remove the "->name"

>>> e.g: Once if we have:

>>> int foo() {
>>> int id;
>>> struct mydata h1, *h2, s1, *s2;
>>> char *city =3D "Hello";
>>> my_printf("%s", s2->name);
>>> my_printf("hi hi %s gggg", [ http://h1.name/ | h1.name ] );
>>> my_printf("1234 %d %s @ %d %s | %s -> city=3D%s", id, [ http://s1.name/=
 | s1.name
>>> ] , 12, (*h2).name , h2->name , city);
>>> my_printf("aaaa %s hhhhh", h2->name);
>>> my_printf("%s", city);
>>> }

>>> Then, replace by:

>>> int foo() {
>>> int id;
>>> struct mydata h1, *h2, s1, *s2;
>>> char *city =3D "Hello";
>>> my_printf("%m", s2);
>>> my_printf("hi hi %s gggg", &h1);
>>> my_printf("1234 %d %m @ %d %m | %m -> city=3D%s", id, [ http://s1.name/=
 | s1.name
>>> ] , 12, (*h2).name , h2->name , city);
>>> my_printf("aaaa %s hhhhh", h2);
>>> my_printf("%s", city);
>>> }

>>> But, I've read again the other samples and the documentation. therefore=
, I
>>> didn't figure out how it should be. btw, thank you Julia for the sugges=
tion
>>> performing the Ocalm/make_expr/replace . (Due to something wrong with t=
he
>>> Coccinelle distributed by Brew/Osx. I just rewrote your sample using Py=
thon and
>>> the result was the same. But, I can't just replace all "%s" by "%m". As=
 I said,
>>> it should be only if the "%s" was declared to use "mydata->name".

>>> so, I still fighting yet. thanks in Advance.

>> OK, if you may have more than one argument to your print, then you can f=
ind the
>> offset using an expression list metavariable:

>> @r@
>> expression list[n] between;
>> @@

>> print(s,between,h2->name,...)

>> Then you can use r.n in your python rule to figure out where is the %s t=
o
>> change. Unfortunately, this will not work well if there are multiple nam=
e
>> references in the argument list. Because you will be trying to change th=
e
>> format string in multiple ways, eg once where between has length 2 and o=
nce
>> where between has length 4. Substantial hacks would be required to deal =
with
>> this.

>> It would be nice if you could do

>> @r@
>> expression list[bn] between;
>> expression list[an] after;
>> position p;
>> @@
>> print@p(s,between,name,after)

>> @@
>> format list[ [ http://r.bn/ | r.bn ] ] f1;
>> format list[ [ http://r.an/ | r.an ] ] f2;
>> position r.p;
>> @@
>> print@p(
>> - "%@f1@%s%@f2@"
>> + "%@f1@%m%@f2@"
>> , l)

>> I don't know if that would work, though.

>> julia

>>>> Regards,
>>>> Markus

--=_2ec7c5fa-703b-471e-86e6-aae00c4996de
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><hr id=3D"zwchr" d=
ata-marker=3D"__DIVIDER__"><div data-marker=3D"__HEADERS__"><blockquote sty=
le=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt;"><b>De: </b>"Strace Labs" &lt;st=
racelabs@gmail.com&gt;<br><b>=C0: </b>"Julia Lawall" &lt;julia.lawall@inria=
.fr&gt;<br><b>Cc: </b>"cocci" &lt;cocci@systeme.lip6.fr&gt;<br><b>Envoy=E9:=
 </b>Mercredi 4 D=E9cembre 2019 01:28:22<br><b>Objet: </b>Re: [Cocci] Chang=
ing format string usage with SmPL?<br></blockquote></div><div data-marker=
=3D"__QUOTED_TEXT__"><blockquote style=3D"border-left:2px solid #1010FF;mar=
gin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-style:norm=
al;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12=
pt;"><div dir=3D"ltr"><div dir=3D"ltr">Unfortunately, it doesn't work. But,=
 I am working on some solutions using Python.&nbsp;</div><div dir=3D"ltr"><=
br></div><div>therefore, once we have something like:</div><br><div>...</di=
v><div>@r1@<br>format list fl;<br>identifier fn;<br>expression list e;<br>p=
osition p;<br>@@<br><br>fn("%@fl@", e@p)<br></div><div>....</div><br><div>T=
hen, I could handle the <b>format list</b>&nbsp;using&nbsp;<b>make_expr()</=
b>&nbsp;as well. But, Is it possible to rename/handle the <b>expression lis=
t?</b></div></div></blockquote><div><br></div><div>Could you fix up the exp=
ression list first?&nbsp; Then you can write a rule like<br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>char[] s;<br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>fn(s, ...,<br d=
ata-mce-bogus=3D"1"></div><div>- oldcode<br data-mce-bogus=3D"1"></div><div=
>+ newcode<br data-mce-bogus=3D"1"></div><div>&nbsp;&nbsp; ,...)<br data-mc=
e-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>julia<br data-=
mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce=
-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bo=
gus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=
=3D"1"></div><div><br data-mce-bogus=3D"1"></div><blockquote style=3D"borde=
r-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-w=
eight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,A=
rial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div class=3D"gmail_quote=
"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 at 3:18 AM Juli=
a Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr" target=3D"_blank">jul=
ia.lawall@inria.fr</a>&gt; wrote:</div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex"><div><div style=3D"font-family:arial,helvetica,sans-serif;fon=
t-size:12pt;color:rgb(0,0,0)"><hr id=3D"gmail-m_5206298212494274740zwchr"><=
div><blockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5=
px;padding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;t=
ext-decoration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt">=
<b>De: </b>"Strace Labs" &lt;<a href=3D"mailto:stracelabs@gmail.com" target=
=3D"_blank">stracelabs@gmail.com</a>&gt;<br><b>=C0: </b>"Markus Elfring" &l=
t;<a href=3D"mailto:Markus.Elfring@web.de" target=3D"_blank">Markus.Elfring=
@web.de</a>&gt;<br><b>Cc: </b>"Julia Lawall" &lt;<a href=3D"mailto:julia.la=
wall@inria.fr" target=3D"_blank">julia.lawall@inria.fr</a>&gt;, <a href=3D"=
mailto:cocci@systeme.lip6.fr" target=3D"_blank">cocci@systeme.lip6.fr</a><b=
r><b>Envoy=E9: </b>Mardi 3 D=E9cembre 2019 11:30:14<br><b>Objet: </b>Re: [C=
occi] Changing format string usage with SmPL?<br></blockquote></div><div><b=
lockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;pad=
ding-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-de=
coration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><div d=
ir=3D"ltr"><div dir=3D"ltr">On Sun, Dec 1, 2019 at 6:00 AM Markus Elfring &=
lt;<a href=3D"mailto:Markus.Elfring@web.de" target=3D"_blank">Markus.Elfrin=
g@web.de</a>&gt; wrote:<br></div><div class=3D"gmail_quote"><blockquote cla=
ss=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid =
rgb(204,204,204);padding-left:1ex">&gt; Basically, I intend to replace alls=
 "%s" called with "mydata-&gt;name" by "%m" with "mydata" or "&amp;mydata"<=
br><br>
How far would you get the desired source code transformation based on<br>
software extensions around a search pattern like the following.<br>........=
..<br>
Which algorithm will become sufficient for your data processing needs<br>
around the usage of functions with variadic arguments because of format str=
ings?<br><br></blockquote><br><div>Actually, I really didn't get why you're=
 asking about that. because we are talking about X and you're asking for Y.=
 but, either way. that is not the point. the point is because I am studying=
 about the Coccinelle and I am just trying to figure out if the tool could =
detect "%s" called with "mydata-&gt;name" and then replace by "%m" and remo=
ve the "-&gt;name"</div><br><div>e.g: Once if we have:</div><br><div>int fo=
o() {<br>&nbsp; int id;<br>&nbsp; struct mydata h1, *h2, s1, *s2;<br>&nbsp;=
 char *city =3D "Hello";<br>&nbsp; my_printf("%s", s2-&gt;name);<br>&nbsp; =
my_printf("hi hi %s gggg", <a href=3D"http://h1.name" target=3D"_blank">h1.=
name</a>);<br>&nbsp; my_printf("1234 %d <b>%s</b> @ %d <b>%s</b>&nbsp;| <b>=
%s</b> -&gt; city=3D%s", id, <b><a href=3D"http://s1.name" target=3D"_blank=
">s1.name</a></b>, 12, <b>(*h2).name</b>, <b>h2-&gt;name</b>, city);<br>&nb=
sp; my_printf("aaaa %s hhhhh", h2-&gt;name);<br>&nbsp; my_printf("%s", city=
);<br></div><div>}</div><br><div>Then, replace by:</div><br><div><div>int f=
oo() {<br>&nbsp; int id;<br>&nbsp; struct mydata h1, *h2, s1, *s2;<br>&nbsp=
; char *city =3D "Hello";<br><b>my_printf("%m", s2);</b><br><b>my_printf("h=
i hi %s gggg", &amp;h1);</b><br>&nbsp; my_printf("1234 %d <b>%m</b>&nbsp;@ =
%d <b>%m</b>&nbsp;| <b>%m</b>&nbsp;-&gt; city=3D%s", id, <b><a href=3D"http=
://s1.name" target=3D"_blank">s1.name</a></b>, 12, <b>(*h2).name</b>, <b>h2=
-&gt;name</b>, city);<br><b>&nbsp; my_printf("aaaa %s hhhhh", h2);</b><br>&=
nbsp; my_printf("%s", city);<br></div><div>}</div></div><br><div>But, I've =
read again the other samples and the documentation. therefore, I didn't fig=
ure out how it should be. btw, thank you Julia for the suggestion performin=
g the <i>Ocalm/make_expr/replace</i>. (Due to something wrong with the Cocc=
inelle distributed by Brew/Osx. I just rewrote your sample using Python and=
 the result was the same. But, I can't just replace all "%s" by "%m". As I =
said, it should be only if the "%s" was declared to use "mydata-&gt;name".<=
/div><br><div>so, I still fighting yet. thanks in Advance.</div></div></div=
></blockquote><div>OK, if you may have more than one argument to your print=
, then you can find the offset using an expression list metavariable:<br></=
div><br><div>@r@<br></div><div>expression list[n] between;<br></div><div>@@=
<br></div><br><div>print(s,between,h2-&gt;name,...)<br></div><br><div>Then =
you can use r.n in your python rule to figure out where is the %s to change=
.&nbsp; Unfortunately, this will not work well if there are multiple name r=
eferences in the argument list.&nbsp; Because you will be trying to change =
the format string in multiple ways, eg once where between has length 2 and =
once where between has length 4.&nbsp; Substantial hacks would be required =
to deal with this.<br></div><br><div>It would be nice if you could do<br></=
div><br><div>@r@<br></div><div>expression list[bn] between;<br></div><div>e=
xpression list[an] after;<br></div><div>position p;<br></div><div>@@<br></d=
iv><div>print@p(s,between,name,after)<br></div><br><div>@@<br></div><div>fo=
rmat list[<a href=3D"http://r.bn" target=3D"_blank">r.bn</a>] f1;<br></div>=
<div>format list[<a href=3D"http://r.an" target=3D"_blank">r.an</a>] f2;<br=
></div><div>position r.p;<br></div><div>@@<br></div><div>print@p(</div><div=
>-&nbsp;&nbsp;&nbsp; "%@f1@%s%@f2@"<br></div><div>+&nbsp;&nbsp; "%@f1@%m%@f=
2@"<br></div><div>, l)<br></div><br><div>I don't know if that would work, t=
hough.<br></div><br><div>julia<br></div><br><blockquote style=3D"border-lef=
t:2px solid rgb(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0=
);font-weight:normal;font-style:normal;text-decoration:none;font-family:Hel=
vetica,Arial,sans-serif;font-size:12pt"><div dir=3D"ltr"><div class=3D"gmai=
l_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
Regards,<br>
Markus<br></blockquote></div></div></blockquote></div></div></div></blockqu=
ote></div></div><br></blockquote></div></div></body></html>
--=_2ec7c5fa-703b-471e-86e6-aae00c4996de--

--===============0225182260==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0225182260==--
