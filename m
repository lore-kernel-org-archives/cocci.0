Return-Path: <SRS0=12Zs=Z2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D78C432C0
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2019 00:22:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0525B206E4
	for <cocci@archiver.kernel.org>; Wed,  4 Dec 2019 00:22:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yo4r9L1v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0525B206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB40Lf7V002900;
	Wed, 4 Dec 2019 01:21:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0444777D7;
	Wed,  4 Dec 2019 01:21:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 00B0D4386
 for <cocci@systeme.lip6.fr>; Wed,  4 Dec 2019 01:21:38 +0100 (CET)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:431] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB40LbRw004843
 for <cocci@systeme.lip6.fr>; Wed, 4 Dec 2019 01:21:37 +0100 (CET)
Received: by mail-wr1-x431.google.com with SMTP id q10so6291721wrm.11
 for <cocci@systeme.lip6.fr>; Tue, 03 Dec 2019 16:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=azjRNxPeF1Gh89sSJbtticYsm09tsWDZ6zjFIUp9WVI=;
 b=Yo4r9L1vd+XPKJgBKhdtLPdO+C2Xpk5NxdiL5rI/W6eeQnGUI3qXIxSyFfzjmA7Uzi
 DmUfqjgMOT0lFAlxZYVIh0YuBM5ETVwSYgf5CISubPTR0a3915lYtPw1Z6mDpcUI39lH
 YfF5XFmiOs5ysjkenZ7yzOvFDRyl6mvD3nSlOrYwL+46PiyzMhwfVZOEIl/rhEU9ht94
 vRtmNCY7fWuwtixTRw8sjwzIXoHFvOqN5Tv4od8g3OX4eqcrGe+b8kbIkGZwukrJI49t
 O/nSjS2JFT65E4sZKslW3imio4ujfR/iYCEpLcScnXlVziULzqUmQdciuy8M2QIUjsXG
 bIaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=azjRNxPeF1Gh89sSJbtticYsm09tsWDZ6zjFIUp9WVI=;
 b=LGrO8U7+yyVRdMl20dVTrhfDYfTV4ZQKZ8M5WD6BH8SZdLiRsFaAunmRXFKwvGyjF0
 CTqkLvmHbwlKe2h/6k7Mt5KQH8GFCcH9/xMFF3OOr6l3Yz4inOvALpG5dvScMWNa/G7r
 TaAQzqGt7zMrViTkpz+RBC5AHykE7uAkd4DwoEfEdwAQ0AwRvN8MsIMU0W3jgYUZ3GKT
 dFj5/zDY79qGl4DDlzb/e5obWgVmPzMLYAotbjeEZIpC3Ts2VOXpYQkfqZzdS1/4T0Rj
 sjsF4uP8NaNEngt9vqWH7uv574/g42/YJum05mmHZjLeFTPQkNQfLEs6sHA55nPJndgP
 tsaA==
X-Gm-Message-State: APjAAAX7L5ME6S3SeNPyxwxAXCV8lM09SxpJ0f6bk39b62puOPjXDbsj
 7vEgLfyrya1/F+BxbtE+68JUQL2U84YdUhxfGuY=
X-Google-Smtp-Source: APXvYqxbk0HJLxCPIZY3d8HM69c3AIdf4wFDxiSfMLpcAfO0w5yD16TzOxyP60x12VqRENtLZsK4j3FjMWufTnWAyuY=
X-Received: by 2002:adf:da52:: with SMTP id r18mr763707wrl.167.1575418896912; 
 Tue, 03 Dec 2019 16:21:36 -0800 (PST)
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
 <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
In-Reply-To: <CABvP5W2+fUip+jEAO-G+ZyUPJhx5iCHcTRxkiYsiok_a3zTuRw@mail.gmail.com>
From: Strace Labs <stracelabs@gmail.com>
Date: Tue, 3 Dec 2019 22:21:01 -0200
Message-ID: <CABvP5W0QkSgJRZRL4xu-DdtQ0RKkQuR-5wVn2QhvjUZCZVooUA@mail.gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 04 Dec 2019 01:21:41 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 04 Dec 2019 01:21:37 +0100 (CET)
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
Content-Type: multipart/mixed; boundary="===============1989351233=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1989351233==
Content-Type: multipart/alternative; boundary="000000000000b914140598d5cbb7"

--000000000000b914140598d5cbb7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

After some research, I could create a Python function called
fmt_replace_by_pos() to replace the %fmt by the Indice position.

*1. Input test*

int foo() {
   int id;
   struct mydata h1, *h2, s1, *s2;
   char *city =3D "Hello";
   my_printf("test: char*=3D%s mydata=3D%s int=3D%d mydata*=3D%s (*mydata)=
=3D%s",
city, h1.name, id, s2->name, (*h2)->name);
}

*2. My *.cocci* (~> https://pastebin.com/a6Tfav4x )

@initialize:python@
@@
import re

def fmt_parser(_st):
# a bunch of (non-% or %%), and then (% followed by non-%).
REG =3D re.compile('([^%]|%%)*(%[^%])')
retval =3D {}
pos =3D 0  # where to start searching for next time
i =3D 0
while True:
match =3D REG.match(_st, pos)
if match is None:
return retval
fmt =3D match.group(2)
pos =3D match.end()
idx =3D pos - len(fmt)
retval[i] =3D { 'idx': idx, 'fmt': fmt }
i +=3D 1

def fmt_replace_by_pos(_str, _idx, _fmt):
try:
fmts  =3D fmt_parser(_str)
new   =3D _str

if _idx =3D=3D -1:
_idx =3D [item for item in range(0, len(fmts))]

for _i in _idx:
f     =3D fmts[_i]
idx   =3D f['idx']
fmt   =3D f['fmt']
fmt_l =3D len(fmt)
new   =3D new[:idx] + _fmt + new[idx + fmt_l:]

return ''.join(new)
except Exception as e:
print("** ERROR: Something wrong in fmt_replace_by_pos():\n
{}\n".format(str(e)))

@r1@
format list fl;
identifier fn;
expression list e;
position p;
@@

fn("%@fl@", e@p)

@script:python s1@
fl << r1.fl;
fn << r1.fn;
e << r1.e;
p << r1.p;
new_fmt;
to_e;
@@
// Update the %fmt by the position (Position currently hardcode)
new_fmt =3D fmt_replace_by_pos(coccinelle.fl, { 1, 3, 4 }, "%m")
coccinelle.new_fmt =3D cocci.make_expr("\"{}\"".format(new_fmt))

@main depends on s1 && r1@
format list r1.fl;
expression s1.new_fmt;
identifier r1.fn;
expression list r1.e;
expression list s1.to_e;
position r1.p;
//struct mydata SMD;
//struct mydata* SMDP;
@@

 fn(
-"%@fl@"
+new_fmt
,
e@p
 );

*3. Execution*

# spatch --sp-file fix-format.cocci sample.c
init_defs_builtins:
/usr/local/Cellar/coccinelle/1.0.9/bin/../lib/coccinelle/standard.h
warning: main: inherited metavariable to_e not used in the -, +, or context
code
HANDLING: sample.c
diff =3D
--- sample.c
+++ /tmp/cocci-output-17883-e8cce6-sample.c
@@ -4,7 +4,8 @@ int foo() {
  struct mydata h1, *h2, s1, *s2;
  char *city =3D "Hello";

- my_printf("test: char*=3D%s mydata=3D%s int=3D%d mydata*=3D%s (*mydata)=
=3D%s",
city, h1.name, id, s2->name, (*h2)->name);
+ my_printf("test: char*=3D%s mydata=3D*%m* int=3D%d mydata*=3D*%m* (*mydat=
a)=3D*%m*",
+  city, h1.name, id, s2->name, (*h2)->name);
 }

#

Therefore, I could find the %fmt and replace by whatever I want based on
the *expression-list. *currently struggled on that.







On Tue, Dec 3, 2019 at 3:28 PM Strace Labs <stracelabs@gmail.com> wrote:

> Unfortunately, it doesn't work. But, I am working on some solutions using
> Python.
>
> therefore, once we have something like:
>
> ...
> @r1@
> format list fl;
> identifier fn;
> expression list e;
> position p;
> @@
>
> fn("%@fl@", e@p)
> ....
>
> Then, I could handle the *format list* using *make_expr()* as well. But,
> Is it possible to rename/handle the *expression list?*
>
>
> On Tue, Dec 3, 2019 at 3:18 AM Julia Lawall <julia.lawall@inria.fr> wrote=
:
>
>> ------------------------------
>>
>> *De: *"Strace Labs" <stracelabs@gmail.com>
>> *=C3=80: *"Markus Elfring" <Markus.Elfring@web.de>
>> *Cc: *"Julia Lawall" <julia.lawall@inria.fr>, cocci@systeme.lip6.fr
>> *Envoy=C3=A9: *Mardi 3 D=C3=A9cembre 2019 11:30:14
>> *Objet: *Re: [Cocci] Changing format string usage with SmPL?
>>
>> On Sun, Dec 1, 2019 at 6:00 AM Markus Elfring <Markus.Elfring@web.de>
>> wrote:
>>
>>> > Basically, I intend to replace alls "%s" called with "mydata->name" b=
y
>>> "%m" with "mydata" or "&mydata"
>>>
>>> How far would you get the desired source code transformation based on
>>> software extensions around a search pattern like the following.
>>> ..........
>>> Which algorithm will become sufficient for your data processing needs
>>> around the usage of functions with variadic arguments because of format
>>> strings?
>>>
>>>
>> Actually, I really didn't get why you're asking about that. because we
>> are talking about X and you're asking for Y. but, either way. that is no=
t
>> the point. the point is because I am studying about the Coccinelle and I=
 am
>> just trying to figure out if the tool could detect "%s" called with
>> "mydata->name" and then replace by "%m" and remove the "->name"
>>
>> e.g: Once if we have:
>>
>> int foo() {
>>   int id;
>>   struct mydata h1, *h2, s1, *s2;
>>   char *city =3D "Hello";
>>   my_printf("%s", s2->name);
>>   my_printf("hi hi %s gggg", h1.name);
>>   my_printf("1234 %d *%s* @ %d *%s* | *%s* -> city=3D%s", id, *s1.name
>> <http://s1.name>*, 12, *(*h2).name*, *h2->name*, city);
>>   my_printf("aaaa %s hhhhh", h2->name);
>>   my_printf("%s", city);
>> }
>>
>> Then, replace by:
>>
>> int foo() {
>>   int id;
>>   struct mydata h1, *h2, s1, *s2;
>>   char *city =3D "Hello";
>> *my_printf("%m", s2);*
>> *my_printf("hi hi %s gggg", &h1);*
>>   my_printf("1234 %d *%m* @ %d *%m* | *%m* -> city=3D%s", id, *s1.name
>> <http://s1.name>*, 12, *(*h2).name*, *h2->name*, city);
>> *  my_printf("aaaa %s hhhhh", h2);*
>>   my_printf("%s", city);
>> }
>>
>> But, I've read again the other samples and the documentation. therefore,
>> I didn't figure out how it should be. btw, thank you Julia for the
>> suggestion performing the *Ocalm/make_expr/replace*. (Due to something
>> wrong with the Coccinelle distributed by Brew/Osx. I just rewrote your
>> sample using Python and the result was the same. But, I can't just repla=
ce
>> all "%s" by "%m". As I said, it should be only if the "%s" was declared =
to
>> use "mydata->name".
>>
>> so, I still fighting yet. thanks in Advance.
>>
>> OK, if you may have more than one argument to your print, then you can
>> find the offset using an expression list metavariable:
>>
>> @r@
>> expression list[n] between;
>> @@
>>
>> print(s,between,h2->name,...)
>>
>> Then you can use r.n in your python rule to figure out where is the %s t=
o
>> change.  Unfortunately, this will not work well if there are multiple na=
me
>> references in the argument list.  Because you will be trying to change t=
he
>> format string in multiple ways, eg once where between has length 2 and o=
nce
>> where between has length 4.  Substantial hacks would be required to deal
>> with this.
>>
>> It would be nice if you could do
>>
>> @r@
>> expression list[bn] between;
>> expression list[an] after;
>> position p;
>> @@
>> print@p(s,between,name,after)
>>
>> @@
>> format list[r.bn] f1;
>> format list[r.an] f2;
>> position r.p;
>> @@
>> print@p(
>> -    "%@f1@%s%@f2@"
>> +   "%@f1@%m%@f2@"
>> , l)
>>
>> I don't know if that would work, though.
>>
>> julia
>>
>> Regards,
>>> Markus
>>>
>>
>>

--000000000000b914140598d5cbb7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">After some=C2=A0research, I could create =
a Python function called fmt_replace_by_pos() to replace the %fmt by the In=
dice position.<div><br></div><div><b>1. Input test</b></div><div><br></div>=
<div>int foo() {<br>=C2=A0 =C2=A0int id;<br>=C2=A0 =C2=A0struct mydata h1, =
*h2, s1, *s2;<br>=C2=A0 =C2=A0char *city =3D &quot;Hello&quot;;<br>=C2=A0 =
=C2=A0my_printf(&quot;test: char*=3D%s mydata=3D%s int=3D%d mydata*=3D%s (*=
mydata)=3D%s&quot;, city, <a href=3D"http://h1.name" target=3D"_blank">h1.n=
ame</a>, id, s2-&gt;name, (*h2)-&gt;name);<br>}<br></div><div><br></div><di=
v><b>2. My *.cocci</b> (~&gt;=C2=A0<a href=3D"https://pastebin.com/a6Tfav4x=
" target=3D"_blank">https://pastebin.com/a6Tfav4x</a>=C2=A0)</div><div><br>=
</div><font face=3D"monospace">@initialize:python@<br>@@<br>import re<br><b=
r>def fmt_parser(_st):<br>	# a bunch of (non-% or %%), and then (% followed=
 by non-%).<br>	REG =3D re.compile(&#39;([^%]|%%)*(%[^%])&#39;)<br>	retval =
=3D {}<br>	pos =3D 0 =C2=A0# where to start searching for next time<br>	i =
=3D 0<br>	while True:<br>		match =3D REG.match(_st, pos)<br>		if match is N=
one:<br>			return retval<br>		fmt =3D match.group(2)<br>		pos =3D match.end=
()<br>		idx =3D pos - len(fmt)<br>		retval[i] =3D { &#39;idx&#39;: idx, &#3=
9;fmt&#39;: fmt }<br>		i +=3D 1<br><br>def fmt_replace_by_pos(_str, _idx, _=
fmt):<br>	try:<br>		fmts =C2=A0=3D fmt_parser(_str)<br>		new =C2=A0 =3D _st=
r<br><br>		if _idx =3D=3D -1:<br>			_idx =3D [item for item in range(0, len=
(fmts))]<br><br>		for _i in _idx:<br>			f =C2=A0 =C2=A0 =3D fmts[_i]<br>			=
idx =C2=A0 =3D f[&#39;idx&#39;]<br>			fmt =C2=A0 =3D f[&#39;fmt&#39;]<br>		=
	fmt_l =3D len(fmt)<br>			new =C2=A0 =3D new[:idx] + _fmt + new[idx + fmt_l=
:]<br>		<br>		return &#39;&#39;.join(new)<br>	except Exception as e:<br>		p=
rint(&quot;** ERROR: Something wrong in fmt_replace_by_pos():\n {}\n&quot;.=
format(str(e)))<br><br>@r1@<br>format list fl;<br>identifier fn;<br>express=
ion list e;<br>position p;<br>@@<br><br>fn(&quot;%@fl@&quot;, e@p)<br><br>@=
script:python s1@<br>fl &lt;&lt; r1.fl;<br>fn &lt;&lt; r1.fn;<br>e &lt;&lt;=
 r1.e;<br>p &lt;&lt; r1.p;<br>new_fmt;<br>to_e;<br>@@<br>// Update the %fmt=
 by the position (Position currently hardcode)<br>new_fmt =3D fmt_replace_b=
y_pos(coccinelle.fl, { 1, 3, 4 }, &quot;%m&quot;)<br>coccinelle.new_fmt =3D=
 cocci.make_expr(&quot;\&quot;{}\&quot;&quot;.format(new_fmt))</font></div>=
<div dir=3D"ltr"><font face=3D"monospace"><br>@main depends on s1 &amp;&amp=
; r1@<br>format list r1.fl;<br>expression s1.new_fmt;<br>identifier r1.fn;<=
br>expression list r1.e;<br>expression list s1.to_e;<br>position r1.p;<br>/=
/struct mydata SMD;<br>//struct mydata* SMDP;<br>@@<br><br>=C2=A0fn(<br>-&q=
uot;%@fl@&quot;<br>+new_fmt<br>,<br>e@p<br></font><div><font face=3D"monosp=
ace">=C2=A0);=C2=A0</font></div></div><div><br></div><b>3. Execution</b><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr"><br></div=
><div dir=3D"ltr" class=3D"gmail_attr"># spatch --sp-file fix-format.cocci =
sample.c<br>init_defs_builtins: /usr/local/Cellar/coccinelle/1.0.9/bin/../l=
ib/coccinelle/standard.h<br>warning: main: inherited metavariable to_e not =
used in the -, +, or context code<br>HANDLING: sample.c<br>diff =3D<br>--- =
sample.c<br>+++ /tmp/cocci-output-17883-e8cce6-sample.c<br>@@ -4,7 +4,8 @@ =
int foo() {<br>=C2=A0	struct mydata h1, *h2, s1, *s2;<br>=C2=A0	char *city =
=3D &quot;Hello&quot;;<br><br>-	my_printf(&quot;test: char*=3D%s mydata=3D%=
s int=3D%d mydata*=3D%s (*mydata)=3D%s&quot;, city, <a href=3D"http://h1.na=
me" target=3D"_blank">h1.name</a>, id, s2-&gt;name, (*h2)-&gt;name);<br>+	m=
y_printf(&quot;test: char*=3D%s mydata=3D<b>%m</b> int=3D%d mydata*=3D<b>%m=
</b> (*mydata)=3D<b>%m</b>&quot;,<br>+		 =C2=A0city, <a href=3D"http://h1.n=
ame" target=3D"_blank">h1.name</a>, id, s2-&gt;name, (*h2)-&gt;name);<br>=
=C2=A0}<br></div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div dir=
=3D"ltr" class=3D"gmail_attr">#</div><div dir=3D"ltr" class=3D"gmail_attr">=
<br></div><div class=3D"gmail_attr">Therefore, I could find the %fmt and re=
place by whatever I want based on the <i><b>expression-list</b>. </i>curren=
tly struggled on that.</div><div class=3D"gmail_attr"><br></div><div class=
=3D"gmail_attr"><br></div><div class=3D"gmail_attr"><br></div><div class=3D=
"gmail_attr"><br></div><div class=3D"gmail_attr"><br></div><div class=3D"gm=
ail_attr"><br></div><div dir=3D"ltr" class=3D"gmail_attr"><br></div><div di=
r=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 2019 at 3:28 PM Strace Labs &=
lt;<a href=3D"mailto:stracelabs@gmail.com" target=3D"_blank">stracelabs@gma=
il.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex"><div dir=3D"ltr"><div dir=3D"ltr">Unfortunately, it doesn&#39;t work.=
 But, I am working on some solutions using Python.=C2=A0</div><div dir=3D"l=
tr"><br></div><div>therefore, once we have something like:</div><div><br></=
div><div>...</div><div>@r1@<br>format list fl;<br>identifier fn;<br>express=
ion list e;<br>position p;<br>@@<br><br>fn(&quot;%@fl@&quot;, e@p)<br></div=
><div>....</div><div><br></div><div>Then, I could handle the <b>format list=
</b>=C2=A0using=C2=A0<b>make_expr()</b>=C2=A0as well. But, Is it possible t=
o rename/handle the <b>expression list?</b></div><div><br></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Dec 3, 20=
19 at 3:18 AM Julia Lawall &lt;<a href=3D"mailto:julia.lawall@inria.fr" tar=
get=3D"_blank">julia.lawall@inria.fr</a>&gt; wrote:</div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex"><div><div style=3D"font-family:arial,helve=
tica,sans-serif;font-size:12pt;color:rgb(0,0,0)"><hr id=3D"m_81556052815215=
84323gmail-m_-6728304308782957728gmail-m_5206298212494274740zwchr"><div><bl=
ockquote style=3D"border-left:2px solid rgb(16,16,255);margin-left:5px;padd=
ing-left:5px;color:rgb(0,0,0);font-weight:normal;font-style:normal;text-dec=
oration:none;font-family:Helvetica,Arial,sans-serif;font-size:12pt"><b>De: =
</b>&quot;Strace Labs&quot; &lt;<a href=3D"mailto:stracelabs@gmail.com" tar=
get=3D"_blank">stracelabs@gmail.com</a>&gt;<br><b>=C3=80: </b>&quot;Markus =
Elfring&quot; &lt;<a href=3D"mailto:Markus.Elfring@web.de" target=3D"_blank=
">Markus.Elfring@web.de</a>&gt;<br><b>Cc: </b>&quot;Julia Lawall&quot; &lt;=
<a href=3D"mailto:julia.lawall@inria.fr" target=3D"_blank">julia.lawall@inr=
ia.fr</a>&gt;, <a href=3D"mailto:cocci@systeme.lip6.fr" target=3D"_blank">c=
occi@systeme.lip6.fr</a><br><b>Envoy=C3=A9: </b>Mardi 3 D=C3=A9cembre 2019 =
11:30:14<br><b>Objet: </b>Re: [Cocci] Changing format string usage with SmP=
L?<br></blockquote></div><div><blockquote style=3D"border-left:2px solid rg=
b(16,16,255);margin-left:5px;padding-left:5px;color:rgb(0,0,0);font-weight:=
normal;font-style:normal;text-decoration:none;font-family:Helvetica,Arial,s=
ans-serif;font-size:12pt"><div dir=3D"ltr"><div dir=3D"ltr">On Sun, Dec 1, =
2019 at 6:00 AM Markus Elfring &lt;<a href=3D"mailto:Markus.Elfring@web.de"=
 target=3D"_blank">Markus.Elfring@web.de</a>&gt; wrote:<br></div><div class=
=3D"gmail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; Bas=
ically, I intend to replace alls &quot;%s&quot; called with &quot;mydata-&g=
t;name&quot; by &quot;%m&quot; with &quot;mydata&quot; or &quot;&amp;mydata=
&quot;<br><br>
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
</blockquote></div></div>

--000000000000b914140598d5cbb7--

--===============1989351233==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1989351233==--
