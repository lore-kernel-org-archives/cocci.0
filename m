Return-Path: <SRS0=Ssaw=JS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: **
X-Spam-Status: No, score=2.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F7ACC433ED
	for <cocci@archiver.kernel.org>; Wed, 21 Apr 2021 19:00:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F35A6140F
	for <cocci@archiver.kernel.org>; Wed, 21 Apr 2021 19:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F35A6140F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 13LJ0rUw024857;
	Wed, 21 Apr 2021 21:00:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6BE9E77D8;
	Wed, 21 Apr 2021 21:00:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 347C73E3B
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 20:55:47 +0200 (CEST)
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:72e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 13LItjM1003646
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 20:55:46 +0200 (CEST)
Received: by mail-qk1-x72e.google.com with SMTP id t17so15405138qkg.4
 for <cocci@systeme.lip6.fr>; Wed, 21 Apr 2021 11:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=GLwgdC1AQF7JO+QYfyYm0qsK9ekeYqkD+JJA1DCO1/Y=;
 b=obd16Sis+1eNNOPpQdlO2577wpxYEHgZuRiZInNFhtJT3tx44d5jwkOiPp2doFY1XQ
 Phl/XhBxrt4ByVfb95lFgtv6KhYx+tvlOViJCYLbd0ByzD/bmbMv/zXeFXXVtrf+bitf
 8wrM/ALmbevJy6kU77F4s4a7x79S3oVe7zKElR6zXyUttyAVE1GsaAkh45N8ngDQIgut
 tVRBPReziyoj+eHn0Cd0g/UzJ2HkfpocPpG1BcBR2xVrByl2DmeodRdvunU+nlp7QjjV
 dfvuXowoVc3ZyzFfTG+2bxUsnkHFz1WFkDyyAofKMYCTL5tIhX+dx9j/zkGxOqwb9TZ7
 oxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=GLwgdC1AQF7JO+QYfyYm0qsK9ekeYqkD+JJA1DCO1/Y=;
 b=cRv4Eoae5E5LLJY9FHmtltLdG1zS7QL+5keaI1rfI/tHpVsqMIqk1yK14mpJTeve6g
 cbF87lA+OyfM+G0ujd5gHC4y57poOpfLhwwc3PIJLJbixcdpin+rVdRmcC9yGRo2PF6W
 L084cOe4OQ8D+6oQhRIq//a3jkKe22iyNgcAyLtswcpqN2CM2jIt4y4rC0fyUVmnq4lc
 VPzgQFyF42JqPsMkpt4dUHcRWBGkIZ0ZTWHc7J25vlYyQuzHaEiM6Nqh5sggLa1NCAj9
 7LYW8WrXv0FlNptbTgeDT0XhA3jmGnJf79+AHj7WXtmm0JGxHzojZvD2JKQtqTdvxGOS
 rpQA==
X-Gm-Message-State: AOAM532md84932te+mtaWFH+hxbi7swWv/w5DXqCf5mlaHiH1uE7XI0N
 w8wQebW2i3JRJclHudAMjScpQEilTA5xIHzSQP/EQ96HqA==
X-Google-Smtp-Source: ABdhPJxiTi+uQvaogPTlp0ofrTcWHQjP8XhcRbZ16PkvrXemlKgIrYq/sIPGZ7n6mQRzCSQ2+TxYMmUJDkcqY5yc0aQ=
X-Received: by 2002:a37:a90a:: with SMTP id s10mr4228834qke.63.1619031345363; 
 Wed, 21 Apr 2021 11:55:45 -0700 (PDT)
MIME-Version: 1.0
From: Akos Pasztory <akos.pasztory@gmail.com>
Date: Wed, 21 Apr 2021 21:55:34 +0300
Message-ID: <CAJwHcF6jc_NNGeXpPh0z7upKLXSOuprS=SPmiR-x-QdYxZiEyw@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 21 Apr 2021 21:00:54 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 21 Apr 2021 20:55:46 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 21 Apr 2021 21:00:51 +0200
Subject: [Cocci] getting rid of implicit boolean expressions
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
Content-Type: multipart/mixed; boundary="===============1882395586=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1882395586==
Content-Type: multipart/alternative; boundary="000000000000387d6305c0801cce"

--000000000000387d6305c0801cce
Content-Type: text/plain; charset="UTF-8"

Hi,

I'm trying do the following kind of transformations:

 int x, y;
 char *p;
 bool b, c;

-b = x || !y;
+b = (x != 0) || (y == 0);

-c = !p;
+c = (p == NULL);

-if (x & 3)
+if ((x & 3) != 0)
 f();
// etc

That is: trying to eliminate implicit boolean-ness (and add parentheses as
well).

I was thinking along the lines of first finding expressions
that are in "boolean context" (part of a || or && expression,
or an if/for/while condition, maybe something else too?).
Then find sub-expressions of those that are not of the form 'E op F'
where 'op' is a comparison operator (==, !=, <=, ...).
And finally depending on whether they are pointer or integer and
whether they are negated, replace them with the above constructs (x != 0,
etc.)

Is this the right way to think about this?  Meaning does it fit the mental
model
of Coccinelle, or some other approach is needed? (E.g. it crossed my mind to
maybe match all expressions and try to filter out "unwanted" ones via
position p != { ... } constraints but that seemed infeasible.)

Thanks!

--000000000000387d6305c0801cce
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi,</div><div><br></div><div>I&#39;m trying do the fo=
llowing kind of transformations:</div><div><br></div><div>=C2=A0int x, y;</=
div><div>=C2=A0char *p;<br></div><div>=C2=A0bool b, c;</div><div><br></div>=
<div>-b =3D x || !y;</div><div>+b =3D (x !=3D 0) || (y =3D=3D 0);</div><div=
></div><div><br></div><div>-c =3D !p;</div><div>+c =3D (p =3D=3D NULL);</di=
v><div><br></div><div>-if (x &amp; 3) <br></div><div><div>+if ((x &amp; 3) =
!=3D 0)</div>=C2=A0f();</div><div></div><div></div><div>// etc<br></div><di=
v><br></div><div></div><div>That is: trying to eliminate implicit boolean-n=
ess (and add parentheses as well).</div><div></div><div></div><div></div><d=
iv></div><div></div><div><br></div><div>I was thinking along the lines of f=
irst finding expressions <br></div><div>that are in &quot;boolean context&q=
uot; (part of a || or &amp;&amp; expression,</div><div>or an if/for/while c=
ondition, maybe something else too?).</div><div></div><div>Then find sub-ex=
pressions of those that are not of the form &#39;E op F&#39; <br></div><div=
>where &#39;op&#39; is a comparison operator (=3D=3D, !=3D, &lt;=3D, ...).<=
br></div><div>And finally depending on whether they are pointer or integer =
and</div><div> whether they are negated, replace them with the above constr=
ucts (x !=3D 0, etc.)</div><div><br></div><div>Is this the right way to thi=
nk about this?=C2=A0 Meaning does it fit the mental model</div><div>of Cocc=
inelle, or some other approach is needed? (E.g. it crossed my mind to</div>=
<div>maybe match all expressions and try to filter out &quot;unwanted&quot;=
 ones via</div><div> position p !=3D { ... } constraints but that seemed in=
feasible.)<br></div><div></div><div></div><div><br></div><div>Thanks!<br></=
div><div></div></div>

--000000000000387d6305c0801cce--

--===============1882395586==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1882395586==--
