Return-Path: <SRS0=z6Nh=ZZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B882EC432C0
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 05:18:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5D5820684
	for <cocci@archiver.kernel.org>; Tue,  3 Dec 2019 05:18:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5D5820684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB35IL1k025455;
	Tue, 3 Dec 2019 06:18:21 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 40CD977D7;
	Tue,  3 Dec 2019 06:18:21 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C09294386
 for <cocci@systeme.lip6.fr>; Tue,  3 Dec 2019 06:18:19 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB35IIg0020074
 for <cocci@systeme.lip6.fr>; Tue, 3 Dec 2019 06:18:18 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.69,271,1571695200"; 
 d="scan'208,217";a="417003468"
X-MGA-submission: =?us-ascii?q?MDFlrqoZ8lDmR53xlw0CvzoKAPBBjWkepJb/Q+?=
 =?us-ascii?q?evQLN+n6Mi8zehck6q4VHIlMwFht+zIknls1/RWjdnNmkyjTLAa4UQO8?=
 =?us-ascii?q?hTGIk4YplioHa+Zx7AlVR2xYbOBVR+YnGOCNfmBUNymGNYg+Nv+VByos?=
 =?us-ascii?q?XvMf34hC17TmSo8uF0fv+IYw=3D=3D?=
Received: from zcs-store9.inria.fr ([128.93.142.36])
 by mail2-relais-roc.national.inria.fr with ESMTP; 03 Dec 2019 06:18:18 +0100
Date: Tue, 3 Dec 2019 06:18:18 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Strace Labs <stracelabs@gmail.com>
Message-ID: <1865799483.10870980.1575350298758.JavaMail.zimbra@inria.fr>
In-Reply-To: <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
 <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
 <CABvP5W3E3zP28kUsmrvUOqv-Tu1YT3zvi6c=mqx+ahbMTycqAQ@mail.gmail.com>
MIME-Version: 1.0
X-Originating-IP: [202.161.33.40]
X-Mailer: Zimbra 8.7.11_GA_3800 (ZimbraWebClient - FF70 (Linux)/8.7.11_GA_3800)
Thread-Topic: Changing format string usage with SmPL?
Thread-Index: Xp4ZS++GdF9MAmOVpKB08lBFzr2gPw==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 06:18:21 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 03 Dec 2019 06:18:18 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@systeme.lip6.fr
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
Content-Type: multipart/mixed; boundary="===============0365435628=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0365435628==
Content-Type: multipart/alternative; 
	boundary="=_f8515e88-f279-4f3d-83a1-354a69c53274"

--=_f8515e88-f279-4f3d-83a1-354a69c53274
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

> De: "Strace Labs" <stracelabs@gmail.com>
> =C0: "Markus Elfring" <Markus.Elfring@web.de>
> Cc: "Julia Lawall" <julia.lawall@inria.fr>, cocci@systeme.lip6.fr
> Envoy=E9: Mardi 3 D=E9cembre 2019 11:30:14
> Objet: Re: [Cocci] Changing format string usage with SmPL?

> On Sun, Dec 1, 2019 at 6:00 AM Markus Elfring < [ mailto:Markus.Elfring@w=
eb.de |
> Markus.Elfring@web.de ] > wrote:

>>> Basically, I intend to replace alls "%s" called with "mydata->name" by =
"%m" with
>> > "mydata" or "&mydata"

>> How far would you get the desired source code transformation based on
>> software extensions around a search pattern like the following.
>> ..........
>> Which algorithm will become sufficient for your data processing needs
>> around the usage of functions with variadic arguments because of format =
strings?

> Actually, I really didn't get why you're asking about that. because we ar=
e
> talking about X and you're asking for Y. but, either way. that is not the
> point. the point is because I am studying about the Coccinelle and I am j=
ust
> trying to figure out if the tool could detect "%s" called with "mydata->n=
ame"
> and then replace by "%m" and remove the "->name"

> e.g: Once if we have:

> int foo() {
> int id;
> struct mydata h1, *h2, s1, *s2;
> char *city =3D "Hello";
> my_printf("%s", s2->name);
> my_printf("hi hi %s gggg", [ http://h1.name/ | h1.name ] );
> my_printf("1234 %d %s @ %d %s | %s -> city=3D%s", id, [ http://s1.name/ |=
 s1.name
> ] , 12, (*h2).name , h2->name , city);
> my_printf("aaaa %s hhhhh", h2->name);
> my_printf("%s", city);
> }

> Then, replace by:

> int foo() {
> int id;
> struct mydata h1, *h2, s1, *s2;
> char *city =3D "Hello";
> my_printf("%m", s2);
> my_printf("hi hi %s gggg", &h1);
> my_printf("1234 %d %m @ %d %m | %m -> city=3D%s", id, [ http://s1.name/ |=
 s1.name
> ] , 12, (*h2).name , h2->name , city);
> my_printf("aaaa %s hhhhh", h2);
> my_printf("%s", city);
> }

> But, I've read again the other samples and the documentation. therefore, =
I
> didn't figure out how it should be. btw, thank you Julia for the suggesti=
on
> performing the Ocalm/make_expr/replace . (Due to something wrong with the
> Coccinelle distributed by Brew/Osx. I just rewrote your sample using Pyth=
on and
> the result was the same. But, I can't just replace all "%s" by "%m". As I=
 said,
> it should be only if the "%s" was declared to use "mydata->name".

> so, I still fighting yet. thanks in Advance.

OK, if you may have more than one argument to your print, then you can find=
 the offset using an expression list metavariable:=20

@r@=20
expression list[n] between;=20
@@=20

print(s,between,h2->name,...)=20

Then you can use r.n in your python rule to figure out where is the %s to c=
hange. Unfortunately, this will not work well if there are multiple name re=
ferences in the argument list. Because you will be trying to change the for=
mat string in multiple ways, eg once where between has length 2 and once wh=
ere between has length 4. Substantial hacks would be required to deal with =
this.=20

It would be nice if you could do=20

@r@=20
expression list[bn] between;=20
expression list[an] after;=20
position p;=20
@@=20
print@p(s,between,name,after)=20

@@=20
format list[r.bn] f1;=20
format list[r.an] f2;=20
position r.p;=20
@@=20
print@p(=20
- "%@f1@%s%@f2@"=20
+ "%@f1@%m%@f2@"=20
, l)=20

I don't know if that would work, though.=20

julia=20

>> Regards,
>> Markus

--=_f8515e88-f279-4f3d-83a1-354a69c53274
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"font-family: arial, helvetica, sans-serif; font-s=
ize: 12pt; color: #000000"><div><br></div><div><br></div><hr id=3D"zwchr" d=
ata-marker=3D"__DIVIDER__"><div data-marker=3D"__HEADERS__"><blockquote sty=
le=3D"border-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:=
#000;font-weight:normal;font-style:normal;text-decoration:none;font-family:=
Helvetica,Arial,sans-serif;font-size:12pt;"><b>De: </b>"Strace Labs" &lt;st=
racelabs@gmail.com&gt;<br><b>=C0: </b>"Markus Elfring" &lt;Markus.Elfring@w=
eb.de&gt;<br><b>Cc: </b>"Julia Lawall" &lt;julia.lawall@inria.fr&gt;, cocci=
@systeme.lip6.fr<br><b>Envoy=E9: </b>Mardi 3 D=E9cembre 2019 11:30:14<br><b=
>Objet: </b>Re: [Cocci] Changing format string usage with SmPL?<br></blockq=
uote></div><div data-marker=3D"__QUOTED_TEXT__"><blockquote style=3D"border=
-left:2px solid #1010FF;margin-left:5px;padding-left:5px;color:#000;font-we=
ight:normal;font-style:normal;text-decoration:none;font-family:Helvetica,Ar=
ial,sans-serif;font-size:12pt;"><div dir=3D"ltr"><div dir=3D"ltr">On Sun, D=
ec 1, 2019 at 6:00 AM Markus Elfring &lt;<a href=3D"mailto:Markus.Elfring@w=
eb.de" target=3D"_blank">Markus.Elfring@web.de</a>&gt; wrote:<br></div><div=
 class=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&g=
t; Basically, I intend to replace alls "%s" called with "mydata-&gt;name" b=
y "%m" with "mydata" or "&amp;mydata"<br><br>
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
div><div><br data-mce-bogus=3D"1"></div><div>@r@<br data-mce-bogus=3D"1"></=
div><div>expression list[n] between;<br data-mce-bogus=3D"1"></div><div>@@<=
br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>prin=
t(s,between,h2-&gt;name,...)<br data-mce-bogus=3D"1"></div><div><br data-mc=
e-bogus=3D"1"></div><div>Then you can use r.n in your python rule to figure=
 out where is the %s to change.&nbsp; Unfortunately, this will not work wel=
l if there are multiple name references in the argument list.&nbsp; Because=
 you will be trying to change the format string in multiple ways, eg once w=
here between has length 2 and once where between has length 4.&nbsp; Substa=
ntial hacks would be required to deal with this.<br data-mce-bogus=3D"1"></=
div><div><br data-mce-bogus=3D"1"></div><div>It would be nice if you could =
do<br data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>@=
r@<br data-mce-bogus=3D"1"></div><div>expression list[bn] between;<br data-=
mce-bogus=3D"1"></div><div>expression list[an] after;<br data-mce-bogus=3D"=
1"></div><div>position p;<br data-mce-bogus=3D"1"></div><div>@@<br data-mce=
-bogus=3D"1"></div><div>print@p(s,between,name,after)<br data-mce-bogus=3D"=
1"></div><div><br data-mce-bogus=3D"1"></div><div>@@<br data-mce-bogus=3D"1=
"></div><div>format list[r.bn] f1;<br data-mce-bogus=3D"1"></div><div>forma=
t list[r.an] f2;<br data-mce-bogus=3D"1"></div><div>position r.p;<br data-m=
ce-bogus=3D"1"></div><div>@@<br data-mce-bogus=3D"1"></div><div>print@p(</d=
iv><div>-&nbsp;&nbsp;&nbsp; "%@f1@%s%@f2@"<br data-mce-bogus=3D"1"></div><d=
iv>+&nbsp;&nbsp; "%@f1@%m%@f2@"<br data-mce-bogus=3D"1"></div><div>, l)<br =
data-mce-bogus=3D"1"></div><div><br data-mce-bogus=3D"1"></div><div>I don't=
 know if that would work, though.<br data-mce-bogus=3D"1"></div><div><br da=
ta-mce-bogus=3D"1"></div><div>julia<br data-mce-bogus=3D"1"></div><div><br =
data-mce-bogus=3D"1"></div><blockquote style=3D"border-left:2px solid #1010=
FF;margin-left:5px;padding-left:5px;color:#000;font-weight:normal;font-styl=
e:normal;text-decoration:none;font-family:Helvetica,Arial,sans-serif;font-s=
ize:12pt;"><div dir=3D"ltr"><div class=3D"gmail_quote"><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">
Regards,<br>
Markus<br></blockquote></div></div><br></blockquote></div></div></body></ht=
ml>
--=_f8515e88-f279-4f3d-83a1-354a69c53274--

--===============0365435628==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0365435628==--
