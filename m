Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80726C43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 23:23:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A092073B
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 23:23:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivt7Gp5y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A092073B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RNNIkC013801;
	Sat, 28 Mar 2020 00:23:18 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6CBF67812;
	Sat, 28 Mar 2020 00:23:18 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3071F780C
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 00:23:17 +0100 (CET)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:231])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RNNF1B019103
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 28 Mar 2020 00:23:16 +0100 (CET)
Received: by mail-oi1-x231.google.com with SMTP id k9so10329972oia.8
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 16:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=1BJPLw4eGQIzVOqQHwU5bOjp7JJs5RW1QZRo0qgvFsE=;
 b=Ivt7Gp5yL/50bCMzH9ZkCIW9Dj4EDTza++RKYMhHswQ2SjSM33iA1165jrNzwcE+iC
 gOe2MgUSL+rzTgW/YPA1N1/px7awZAHIdqMeaN1W0JB1NSo+TzYZQ7WS192ZWHL0MJNI
 AnnX6J3xy5JJjbBmGZW76Gd7mNqdYjwlxQgGRYJSzDKoSmwAKyB04f0up1ddZbgyLGa+
 ERMuJNj5w4No3S186H0+GVEPTE6rO6MbqXvqkDtcycE/HwxSaK2inKLCqaY/xjrcH/br
 yeNuBTxHCQ9MCiV6LpFtQzJoR817zImwRwhBrb4Jfv0gLJNSoQN4gmIdK1jhQcbVNIw5
 PPww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=1BJPLw4eGQIzVOqQHwU5bOjp7JJs5RW1QZRo0qgvFsE=;
 b=cdlDx1JRvJjzHTqL3df1KlJ6b0/e9GofPMoSyMF8LfeDtxZzm02n2zwgrRdLasL1Lq
 vlsRQOgeu8YxL3E7zfhFtfBLC5I+g0aakbbwxrORhSuNzvsEXP5KIwu599si20y8FKil
 4O+A2NW2NhQ6E+XlRO69JtV+hFxFKtK4vKcT1Ac0cC+4oo6XnGL+GgG7cHmFhQXivKKV
 TfVN2QyF2ncZ3bG5rJwWOtvWHA3O6+mPBTXE0tWcbS8+lCCJbuCaGPogSe2eZKrQqgWM
 jsnTPNxp7CVHT6NGH884iaWasu6gvYO0WiWTeUKC8vc/BL2wcV9eLYfn2BzmH6LOkF8h
 HUsw==
X-Gm-Message-State: ANhLgQ2NgZ9NNBG0hXyr2L0nK0cK8NYlsS0wOKaTbnjW3zNVxorAM0uH
 mXmAtYqL6lisiPLcOEbyKKVuvrQY0fEVj5EZ/CVBQDOOpw==
X-Google-Smtp-Source: ADFU+vvDEci/WoO5V2OFKOFCEaYvP7D239uOs5/cCm/pIQ4qQdFM4LSvr+bMH/3ub2LizlvBeZJmX0MUfQx+0O686+g=
X-Received: by 2002:a54:4519:: with SMTP id l25mr998906oil.92.1585351394673;
 Fri, 27 Mar 2020 16:23:14 -0700 (PDT)
MIME-Version: 1.0
From: George McCollister <george.mccollister@gmail.com>
Date: Fri, 27 Mar 2020 18:23:03 -0500
Message-ID: <CAFSKS=OcAXz61G2u=V2kEd1sre9pmOknguD-VBA1Nge_5qm2rw@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Mar 2020 00:23:18 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 28 Mar 2020 00:23:16 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] C++ Parse error with new in else
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
Content-Type: multipart/mixed; boundary="===============1190636577=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1190636577==
Content-Type: multipart/alternative; boundary="000000000000b94a4c05a1de6215"

--000000000000b94a4c05a1de6215
Content-Type: text/plain; charset="UTF-8"

I know C++ support isn't really finished but thought I'd point out this
strange bug I found just in case some body wanted to fix it.

Simple C++ program:
struct foo
{
    int i;
};

int main(int argc, const char* argv[])
{
    foo * a;

    if (argc == 1) {
        a = new foo;
        a->i = argc;
    } else {
        //a = new foo; // line is marked BAD:!!!!! if uncommented
        a->i = argc + 1;
    }

    delete a;

    return 0;
}

Simple cocci file:
@@

@@

- a
+ b

I run:
spatch -sp_file cocci_broken.cocci cocci_broken.cpp --c++ --debug

It works fine as long as that first line in the else is commented out. If I
uncomment it I get:

Parse error
 = error in cocci_broken.cpp; set verbose_parsing for more info
badcount: 17
bad: };
bad:
bad: int main(int argc, const char* argv[])
bad: {
bad: foo * a;
bad:
bad: if (argc == 1) {
bad: a = new foo;
bad: a->i = argc;
bad: } else {
BAD:!!!!! a = new foo; // line is marked BAD:!!!!! if uncommented
bad: a->i = argc + 1;
bad: }
bad:
bad: delete a;
bad:
bad: return 0;
bad: }

I'm using spatch version 1.0.8.

It seems quite odd everything is fine until that line is enabled since it's
the same thing that's in the if clause.

Cheers,
George McCollister

--000000000000b94a4c05a1de6215
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div class=3D"gmail_default" style=3D"font-family:mon=
ospace,monospace">I know C++ support isn&#39;t really finished but thought =
I&#39;d point out this strange bug I found just in case some body wanted to=
 fix it.</div></div><div class=3D"gmail_default" style=3D"font-family:monos=
pace,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family=
:monospace,monospace">Simple C++ program:</div>struct foo<br>{<br>	<span cl=
ass=3D"gmail_default" style=3D"font-family:monospace,monospace">=C2=A0 =C2=
=A0 </span>int i;<br>};<br><br>int main(int argc, const char* argv[])<br>{<=
br>	<span class=3D"gmail_default" style=3D"font-family:monospace,monospace"=
>=C2=A0 =C2=A0 </span>foo * a;<br><br>	<span class=3D"gmail_default" style=
=3D"font-family:monospace,monospace">=C2=A0 =C2=A0 </span>i<span class=3D"g=
mail_default" style=3D"font-family:monospace,monospace"></span><span class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"></span>f (argc=
 =3D=3D 1) {<br>		<span class=3D"gmail_default" style=3D"font-family:monosp=
ace,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>a =3D new foo;<br>		<span=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace">=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 </span>a-&gt;i =3D argc;<br>	<span class=3D"gmail_defa=
ult" style=3D"font-family:monospace,monospace">=C2=A0 =C2=A0 </span>} else =
{<br>		<span class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>//a =3D new foo; // line is marked B=
AD:!!!!! if uncommented<br>		<span class=3D"gmail_default" style=3D"font-fa=
mily:monospace,monospace">=C2=A0 =C2=A0 =C2=A0 =C2=A0 </span>a-&gt;i =3D ar=
gc + 1;<br>	<span class=3D"gmail_default" style=3D"font-family:monospace,mo=
nospace">=C2=A0 =C2=A0 </span>} <br><br>	<span class=3D"gmail_default" styl=
e=3D"font-family:monospace,monospace">=C2=A0 =C2=A0 </span>delete a;<br><br=
>	<span class=3D"gmail_default" style=3D"font-family:monospace,monospace">=
=C2=A0 =C2=A0 </span>return 0;<br>}<div><br></div><div><div class=3D"gmail_=
default" style=3D"font-family:monospace,monospace">Simple cocci file:</div>=
<div class=3D"gmail_default" style=3D"font-family:monospace,monospace">@@<b=
r></div><div class=3D"gmail_default" style=3D"font-family:monospace,monospa=
ce"><br>@@<br><br>- a<br>+ b<br></div><br></div><div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace">I run:</div></div><div><di=
v class=3D"gmail_default" style=3D"font-family:monospace,monospace">spatch =
-sp_file cocci_broken.cocci cocci_broken.cpp --c++ --debug</div><div class=
=3D"gmail_default" style=3D"font-family:monospace,monospace"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:monospace,monospace">It works=
 fine as long as that first line in the else is commented out. If I uncomme=
nt it I get:</div><div class=3D"gmail_default" style=3D"font-family:monospa=
ce,monospace"><br></div><div class=3D"gmail_default" style=3D"font-family:m=
onospace,monospace">Parse error <br>=C2=A0=3D error in cocci_broken.cpp; se=
t verbose_parsing for more info<br>badcount: 17<br>bad: };<br>bad: <br>bad:=
 int main(int argc, const char* argv[])<br>bad: {<br>bad: 	foo * a;<br>bad:=
 <br>bad: 	if (argc =3D=3D 1) {<br>bad: 		a =3D new foo;<br>bad: 		a-&gt;i =
=3D argc;<br>bad: 	} else {<br>BAD:!!!!! 		a =3D new foo; // line is marked=
 BAD:!!!!! if uncommented<br>bad: 		a-&gt;i =3D argc + 1;<br>bad: 	} <br>ba=
d: <br>bad: 	delete a;<br>bad: <br>bad: 	return 0;<br>bad: }<br></div><br><=
/div><div><div class=3D"gmail_default" style=3D"font-family:monospace,monos=
pace">I&#39;m using spatch version 1.0.8.</div><div class=3D"gmail_default"=
 style=3D"font-family:monospace,monospace"><br></div><div class=3D"gmail_de=
fault" style=3D"font-family:monospace,monospace">It seems quite odd everyth=
ing is fine until that line is enabled since it&#39;s the same thing that&#=
39;s in the if clause.</div><div class=3D"gmail_default" style=3D"font-fami=
ly:monospace,monospace"><br></div><div class=3D"gmail_default" style=3D"fon=
t-family:monospace,monospace">Cheers,</div><div class=3D"gmail_default" sty=
le=3D"font-family:monospace,monospace">George McCollister</div><br></div></=
div>

--000000000000b94a4c05a1de6215--

--===============1190636577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1190636577==--
