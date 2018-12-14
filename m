Return-Path: <SRS0=WLW8=OX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,
	MAILING_LIST_MULTI,MIME_HTML_MOSTLY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0832C67839
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 07:35:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F143E2054F
	for <cocci@archiver.kernel.org>; Fri, 14 Dec 2018 07:35:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hozixD7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F143E2054F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBE7Z6S8026118
          ; Fri, 14 Dec 2018 08:35:06 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F269E76D8;
	Fri, 14 Dec 2018 08:35:05 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3D3F60D7
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 08:35:03 +0100 (CET)
Received: from mail-it1-x12d.google.com (mail-it1-x12d.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:12d] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wBE7Z2co023776
 for <cocci@systeme.lip6.fr>; Fri, 14 Dec 2018 08:35:02 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-it1-x12d.google.com with SMTP id a6so7973815itl.4
 for <cocci@systeme.lip6.fr>; Thu, 13 Dec 2018 23:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=BttZy2gE+5mLUUvgeJwE1j1+247GiVr1qITHEkL0NK8=;
 b=hozixD7/wOwr3NTqOYsZ1SrMQ5iQHdzU3M9VsS5Za8LrkDk1SLqB9hFkrWeP9GUh8K
 CdJ04LDkjkeGWzy3i7SI6TF8N5EdiCavDRw6xn9i5jkPReNa/qhSSkFPljr76K0KUXv7
 ITYbUiG1iLTEuWSBjR7Z78lXQy9JnIWEJeKHaVDP7N2V03T4SUv62psjm/QAuhR3tuC7
 5YrSUSN2ZdgoA0exoK7uAdApDpS813bV73DFLfRMKA21mH9GvFKOyxEmGwJ26Q5utp7M
 sy41XRwgyWuHA/iU/Gur5/nw52Wy8ip5zi1O38zfTlDQTqQmtE60ay8qttMLEP0cD1HW
 WeqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=BttZy2gE+5mLUUvgeJwE1j1+247GiVr1qITHEkL0NK8=;
 b=VDT8iBrNt8vJZpJZGEoxQY1eHC4RiejiDJUwXuwrWJOkS78mYvA1Vd1r0ysho7cQws
 vaf/A2djVMG/kcb9hmyH7GxAu2bQqamJrTolN8OZB0AreiDPdtFI5F2OSlQedHWclcpV
 2Bs+cY69IGZpZTwMKelpO0Nl6vE9kb2Nc+Bb7oih5DtgltTghbQupc/o0T59fFDx33YJ
 Tp0BDaUsABVusvlSWahzqzZ6ERFKB05UfNKkvpZTlCuhp324bAGqT7AJm8dVQ9CmeFhV
 7noNoX5Ln2SjKgzEkIZG/SQNrJZ3ApNlQY3CYiWzbq8yQaDjNoibKsSHCIgjIRe4mZ0s
 iT6A==
X-Gm-Message-State: AA+aEWYZ3JqT0wYxsqLyobOMRsEOlBCPHLcw3dOqXro1hu5EK3k+A+gh
 ray/8zPveyFfr15MmCifqbh9f1ORDRm6TiD2UmQPivnC
X-Google-Smtp-Source: AFSGD/VZZyvTfp/dnQsv72N1bntp6wHgRxdIZJGkFZmYPKg/k428YJK2e+iD20n1v23eG7E8kAuLdfL/RGAHG4YpOaw=
X-Received: by 2002:a24:ac62:: with SMTP id m34mr2133201iti.129.1544772901909; 
 Thu, 13 Dec 2018 23:35:01 -0800 (PST)
MIME-Version: 1.0
From: =?UTF-8?B?6Jek5pys5aSq5biM?= <fjtkut@gmail.com>
Date: Fri, 14 Dec 2018 16:34:55 +0900
Message-ID: <CADa4oMViD=7G5=54L9n2fK=2AdPQs14bBRMNRXxJjUWiZV6iLg@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Dec 2018 08:35:06 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 14 Dec 2018 08:35:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] how to use Coccinelle
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
Content-Type: multipart/mixed; boundary="===============1608859821=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1608859821==
Content-Type: multipart/alternative; boundary="00000000000013b7a4057cf67802"

--00000000000013b7a4057cf67802
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello.

I am a student of Kochi University of Technology in Japan.

I have asked a question before.

Thank you for all your help on that occasion.

This time I have two questions about how to use Coccinelle.



This is the first question.

Identifiers can be declared in scripts.

Can you declare the type in same way?

For example, there are the following programs.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94

@script:python pre@

alloc;

@@

coccinelle.alloc =3D =E2=80=9Cmalloc=E2=80=9D


@ rule1 @

type T=3D{int, double};

identifier v, pre.alloc;

@@

T v;

=E2=80=A6

alloc(...)


@ rule2 @

type T=3D{int, double};

identifier v, pre.alloc;

@@

T v;

=E2=80=A6 when !=3D alloc(=E2=80=A6)

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94

In these two rules there is T of type with the same restriction.

Can you declare this like alloc?

Do you have to declare in each rule?



Next is the second question.

In the previous answer you said

=E2=80=9CCoccinelle rather focuses on the case where variables are all defi=
ned at
the top of a function=E2=80=9D.

Do you mean that we can not distinguish between the same name variables?

For example, there are the following programs.

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94

=E2=80=94c-program=E2=80=94

void foo() {

  int a;

  {

    int a;

    hoge(a);

  }

}


=E2=80=94cocci=E2=80=94

@rule@

identifier v;

type T;

@@

T v;

=E2=80=A6

hoge(v);

=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94=E2=80=94

matched first a and second a=EF=BC=8E

--00000000000013b7a4057cf67802
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Hello.=C2=
=A0</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">I am a stu=
dent of Kochi University of Technology in Japan.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">I have ask=
ed a question before.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Thank you =
for all your help on that occasion.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">This time =
I have two questions about how to use Coccinelle.</p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">This is th=
e first question.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Identifier=
s can be declared in scripts.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Can you de=
clare the type in same way?</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">For exampl=
e<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant=
-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&quot=
;.Hiragino Kaku Gothic Interface&quot;">,</span> there are the following pr=
ograms.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@script:py=
thon pre@</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">alloc<span=
 class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-=
asian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hira=
gino Kaku Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@@</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">coccinelle=
.alloc =3D <span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;fo=
nt-variant-east-asian:normal;font-stretch:normal;line-height:normal;font-fa=
mily:&quot;.Hiragino Kaku Gothic Interface&quot;">=E2=80=9C</span>malloc<sp=
an class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-eas=
t-asian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hi=
ragino Kaku Gothic Interface&quot;">=E2=80=9D</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@ rule1 @<=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">type T=3D{=
int<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&qu=
ot;.Hiragino Kaku Gothic Interface&quot;">,</span> double}<span class=3D"gm=
ail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:normal=
;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku Go=
thic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">identifier=
 v<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&quo=
t;.Hiragino Kaku Gothic Interface&quot;">,</span> pre.alloc<span class=3D"g=
mail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku G=
othic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@@</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">T v<span c=
lass=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragi=
no Kaku Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=A6<=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">alloc<span=
 class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-=
asian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hira=
gino Kaku Gothic Interface&quot;">(</span>...<span class=3D"gmail-s1" style=
=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch=
:normal;line-height:normal;font-family:&quot;.Hiragino Kaku Gothic Interfac=
e&quot;">)</span></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@ rule2 @<=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">type T=3D{=
int<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-varia=
nt-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&qu=
ot;.Hiragino Kaku Gothic Interface&quot;">,</span> double}<span class=3D"gm=
ail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:normal=
;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku Go=
thic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">identifier=
 v<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&quo=
t;.Hiragino Kaku Gothic Interface&quot;">,</span> pre.alloc<span class=3D"g=
mail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku G=
othic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@@</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">T v<span c=
lass=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragi=
no Kaku Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=A6 =
when !=3D alloc<span class=3D"gmail-s1" style=3D"font-variant-numeric:norma=
l;font-variant-east-asian:normal;font-stretch:normal;line-height:normal;fon=
t-family:&quot;.Hiragino Kaku Gothic Interface&quot;">(</span>=E2=80=A6<spa=
n class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east=
-asian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hir=
agino Kaku Gothic Interface&quot;">)</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">In these t=
wo rules there is T of type with the same restriction.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Can you de=
clare this like alloc?</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Do you hav=
e to declare in each rule?</p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Next is th=
e second question.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">In the pre=
vious answer you said</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)"><span clas=
s=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian=
:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino =
Kaku Gothic Interface&quot;">=E2=80=9C</span>Coccinelle rather focuses on t=
he case where variables are all defined at the top of a function<span class=
=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:=
normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino K=
aku Gothic Interface&quot;">=E2=80=9D</span>.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">Do you mea=
n that we can not distinguish between the same name variables?</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">For exampl=
e<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant=
-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&quot=
;.Hiragino Kaku Gothic Interface&quot;">,</span> there are the following pr=
ograms.</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=94c=
-program=E2=80=94</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">void foo<s=
pan class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-ea=
st-asian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.H=
iragino Kaku Gothic Interface&quot;">()</span> {</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)"><span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 </span>int a<span class=3D"gmail-s=
1" style=3D"font-variant-numeric:normal;font-variant-east-asian:normal;font=
-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku Gothic =
Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)"><span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 </span>{</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)"><span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>int a<span class=3D"=
gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:norm=
al;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku =
Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)"><span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 =C2=A0 </span>hoge<span class=3D"g=
mail-s1" style=3D"font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragino Kaku G=
othic Interface&quot;">(</span>a<span class=3D"gmail-s1" style=3D"font-vari=
ant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;line-=
height:normal;font-family:&quot;.Hiragino Kaku Gothic Interface&quot;">);</=
span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)"><span clas=
s=3D"gmail-Apple-converted-space">=C2=A0 </span>}</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">}</p>
<p class=3D"gmail-p2" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69);min-height:=
14px"><br></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=94c=
occi=E2=80=94</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@rule@</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">identifier=
 v<span class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-varian=
t-east-asian:normal;font-stretch:normal;line-height:normal;font-family:&quo=
t;.Hiragino Kaku Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">type T<spa=
n class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east=
-asian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hir=
agino Kaku Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">@@</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">T v<span c=
lass=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-as=
ian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hiragi=
no Kaku Gothic Interface&quot;">;</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=A6<=
/p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">hoge<span =
class=3D"gmail-s1" style=3D"font-variant-numeric:normal;font-variant-east-a=
sian:normal;font-stretch:normal;line-height:normal;font-family:&quot;.Hirag=
ino Kaku Gothic Interface&quot;">(</span>v<span class=3D"gmail-s1" style=3D=
"font-variant-numeric:normal;font-variant-east-asian:normal;font-stretch:no=
rmal;line-height:normal;font-family:&quot;.Hiragino Kaku Gothic Interface&q=
uot;">);</span></p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">=E2=80=94=
=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=
=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=94=E2=80=
=94=E2=80=94</p>
<p class=3D"gmail-p1" style=3D"margin:0px;font-variant-numeric:normal;font-=
variant-east-asian:normal;font-stretch:normal;font-size:12px;line-height:no=
rmal;font-family:&quot;Helvetica Neue&quot;;color:rgb(69,69,69)">matched fi=
rst a and second a<span class=3D"gmail-s1" style=3D"font-variant-numeric:no=
rmal;font-variant-east-asian:normal;font-stretch:normal;line-height:normal;=
font-family:&quot;.Hiragino Kaku Gothic Interface&quot;">=EF=BC=8E</span></=
p></div>

--00000000000013b7a4057cf67802--

--===============1608859821==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1608859821==--
