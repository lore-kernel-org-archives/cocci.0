Return-Path: <SRS0=DzZf=VV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F54BC76186
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 22:54:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC6B12190F
	for <cocci@archiver.kernel.org>; Wed, 24 Jul 2019 22:54:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uber.com header.i=@uber.com header.b="UAbhunpf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC6B12190F
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=uber.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6OMsEP3007913;
	Thu, 25 Jul 2019 00:54:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 02E867796;
	Thu, 25 Jul 2019 00:54:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A6922420D
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 00:25:11 +0200 (CEST)
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:22f] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6OMPA9R018927
 for <cocci@systeme.lip6.fr>; Thu, 25 Jul 2019 00:25:10 +0200 (CEST)
Received: by mail-oi1-x22f.google.com with SMTP id g7so36197706oia.8
 for <cocci@systeme.lip6.fr>; Wed, 24 Jul 2019 15:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uber.com; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=g4Of9jFze4CXv9jAMXj/QSd+ilvWcX5iPoEy+g1/7eg=;
 b=UAbhunpfib0d2dFSNuxX1kbi0M+0/IJQFqV+nZs/rPDHhg/z3c+IJi83BrOAf9Xi6R
 YQyaiRMB/ukPDbIHYGvIk25b9AP49MoxAtE11JCcoq/lXwFSZvxtW3e7JJgEU0rEG+FL
 vfO6fdORZsg6YahT23crPngxkeZ998nPaWk7o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=g4Of9jFze4CXv9jAMXj/QSd+ilvWcX5iPoEy+g1/7eg=;
 b=pIuhmN3Q0qZ9RyzD3JdOdfKiGFh3O210n07WwuIjk6r0h389gQm+CT+v1+1VE6ezr3
 cq68asJJlHYKKxnOlfG60duGLNZZpEoZl6WRCZKtkvfZHNvKfOVztJ4un7zYoeh29uAG
 OjPW+tgxp0YGf1O23QgKldDriLakwLWtiAVP1ZCmjAwFrAIXRr/k/z+VP9Oqbh6Via6X
 8+p/maQpveeHDuvGzi6NifsyvQPuAvSJwUaZmZkVQXw5XpyQDL6WtqEd0rm3tLmoc7fY
 0c5tz80Q0Y2++/AbMOYGWwuOpyypO+9b4GHdl5TN/l/pZFGg5P+CLRXzhm72T3sYGdTv
 uAwQ==
X-Gm-Message-State: APjAAAV4OgrbcZ7NIo/X1VdgCbJj4NWw9ORaEMCFEdH/Ns60DVHQMTD4
 rPX8rOkxcom0PeSiMv5MbedpVabtG4ylxfH4UM721A==
X-Google-Smtp-Source: APXvYqwYwwePiFeGYM4P+4nIHESD0ADeN/y83uqezXYGJma11clbvQ+W3wVgP1o/HSmkuirNe1a2pm1PfB0wUwQp9u0=
X-Received: by 2002:aca:ac48:: with SMTP id v69mr40547897oie.48.1564007109911; 
 Wed, 24 Jul 2019 15:25:09 -0700 (PDT)
MIME-Version: 1.0
References: <CAEgVsn4+aMn_3pXo1fex6_3oWmHbQERhmr42dO0igdFT1u67nA@mail.gmail.com>
 <8d566cd5-d693-1d66-3f14-e3a6291f7922@web.de>
In-Reply-To: <8d566cd5-d693-1d66-3f14-e3a6291f7922@web.de>
From: Raghavan Raman <ragr@uber.com>
Date: Wed, 24 Jul 2019 15:24:59 -0700
Message-ID: <CAEgVsn58__xt3zzU0Mz8KCgZD2CHp2aZRnaEN7KL6+VjraNC4w@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 25 Jul 2019 00:54:14 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 25 Jul 2019 00:25:10 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Thu, 25 Jul 2019 00:54:12 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Coccinelle for Go
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
Content-Type: multipart/mixed; boundary="===============0500994641=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0500994641==
Content-Type: multipart/alternative; boundary="00000000000036f49a058e74c875"

--00000000000036f49a058e74c875
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Markus,

Thanks for the reply and the pointers. Those are very helpful.

We are trying to evaluate different approaches in this space and trying to
choose one that would work the best for us. If we decide to go down this
route, we will work with your team to figure out how we can contribute.

Best,
Raghavan



On Sun, Jul 21, 2019 at 4:45 AM Markus Elfring <Markus.Elfring@web.de>
wrote:

> > We are looking into
>  using Coccinelle for refactoring in Go
>
> Thanks for your interest.
>
>
> > Does Coccinelle include support for Go?
>
> Not yet.
>
>
> >  * Is there any plan to add support for the same?
>
> Would you like to contribute significant development resources for
> corresponding software extensions?
>
>
> >  * What would it take to add this support?
>
> Remarkable desire for collateral evolution.
>
>
> > Any documentation regarding
>  this?
>
>
> Yes, of course.
>
> Did you notice information sources like the following already?
>
> * Paper =E2=80=9CComputation tree logic with variables and witnesses=E2=
=80=9D
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__coccinelle.lip6.fr_=
papers_popl09.pdf&d=3DDwIFaQ&c=3Dr2dcLCtU9q6n0vrtnDw9vg&r=3DTMoJUATrFJ-DanW=
KiyV4vg&m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&s=3DyQPALN3aGqQYDRq=
4eKwTN_P_UtFEwpIn-VevK9QGluc&e=3D
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__doi.org_10.1145_14=
80881.1480897&d=3DDwIFaQ&c=3Dr2dcLCtU9q6n0vrtnDw9vg&r=3DTMoJUATrFJ-DanWKiyV=
4vg&m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&s=3DzQVXV_GZVkPhV3r_Co5=
kGFTAjO2VMkhu5NWVW78BkeI&e=3D
>
> * Manual for the semantic patch language
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__github.com_coccine=
lle_coccinelle_blob_ed1eb8e06f800739d3992158d36945c0c4c6f0c7_docs_manual_co=
cci-5Fsyntax.tex-23L50&d=3DDwIFaQ&c=3Dr2dcLCtU9q6n0vrtnDw9vg&r=3DTMoJUATrFJ=
-DanWKiyV4vg&m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&s=3DfjSfzgpZ0V=
lHVBEX9BbF17Xj0Co6DpQUNoTyspB9lO0&e=3D
>
> * Clarification request: Support for more programming languages?
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__systeme.lip6.fr_pi=
permail_cocci_2016-2DJuly_003445.html&d=3DDwIFaQ&c=3Dr2dcLCtU9q6n0vrtnDw9vg=
&r=3DTMoJUATrFJ-DanWKiyV4vg&m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE=
&s=3Dh-OnZQhuthCctxsfOfpC5LhuamwKTEfRoIfG09Dd7Go&e=3D
>
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lore.kernel.org_co=
cci_76bf1017-2Dd629-2Dd44a-2D5493-2D0dcccbbfa65b-40users.sourceforge.net_&d=
=3DDwIFaQ&c=3Dr2dcLCtU9q6n0vrtnDw9vg&r=3DTMoJUATrFJ-DanWKiyV4vg&m=3DPHMByyX=
5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&s=3Dw4Riw44aVfsTNqmkc_okL7dRKVK0kZHsHp=
YBIHRQi_0&e=3D
>
>
> How do you think about to improve related technologies?
>
> Regards,
> Markus
>

--00000000000036f49a058e74c875
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Markus,<div><br></div><div>Thanks for the reply and the=
 pointers. Those are very helpful.</div><div><br></div><div><div>We are try=
ing to evaluate different approaches in this space and trying to choose one=
 that would work the best for us. If we decide to go down this route, we wi=
ll work with your team to figure out how we can contribute.</div><div><br><=
/div><div>Best,</div><div>Raghavan</div><div><br></div><br class=3D"gmail-A=
pple-interchange-newline"></div></div><br><div class=3D"gmail_quote"><div d=
ir=3D"ltr" class=3D"gmail_attr">On Sun, Jul 21, 2019 at 4:45 AM Markus Elfr=
ing &lt;<a href=3D"mailto:Markus.Elfring@web.de">Markus.Elfring@web.de</a>&=
gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0=
px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&gt; =
We are looking into<br>
=C2=A0using Coccinelle for refactoring in Go<br>
<br>
Thanks for your interest.<br>
<br>
<br>
&gt; Does Coccinelle include support for Go?<br>
<br>
Not yet.<br>
<br>
<br>
&gt;=C2=A0 * Is there any plan to add support for the same?<br>
<br>
Would you like to contribute significant development resources for<br>
corresponding software extensions?<br>
<br>
<br>
&gt;=C2=A0 * What would it take to add this support?<br>
<br>
Remarkable desire for collateral evolution.<br>
<br>
<br>
&gt; Any documentation regarding<br>
=C2=A0this?<br>
<br>
<br>
Yes, of course.<br>
<br>
Did you notice information sources like the following already?<br>
<br>
* Paper =E2=80=9CComputation tree logic with variables and witnesses=E2=80=
=9D<br>
=C2=A0 <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__coc=
cinelle.lip6.fr_papers_popl09.pdf&amp;d=3DDwIFaQ&amp;c=3Dr2dcLCtU9q6n0vrtnD=
w9vg&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XP=
s818jx0L9aYE&amp;s=3DyQPALN3aGqQYDRq4eKwTN_P_UtFEwpIn-VevK9QGluc&amp;e=3D" =
rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com/v2/u=
rl?u=3Dhttp-3A__coccinelle.lip6.fr_papers_popl09.pdf&amp;d=3DDwIFaQ&amp;c=
=3Dr2dcLCtU9q6n0vrtnDw9vg&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UX=
MVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&amp;s=3DyQPALN3aGqQYDRq4eKwTN_P_UtFEwpIn-=
VevK9QGluc&amp;e=3D</a> <br>
=C2=A0 <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__do=
i.org_10.1145_1480881.1480897&amp;d=3DDwIFaQ&amp;c=3Dr2dcLCtU9q6n0vrtnDw9vg=
&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818=
jx0L9aYE&amp;s=3DzQVXV_GZVkPhV3r_Co5kGFTAjO2VMkhu5NWVW78BkeI&amp;e=3D" rel=
=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com/v2/url?=
u=3Dhttps-3A__doi.org_10.1145_1480881.1480897&amp;d=3DDwIFaQ&amp;c=3Dr2dcLC=
tU9q6n0vrtnDw9vg&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHla=
IacBrUqKn4XPs818jx0L9aYE&amp;s=3DzQVXV_GZVkPhV3r_Co5kGFTAjO2VMkhu5NWVW78Bke=
I&amp;e=3D</a> <br>
<br>
* Manual for the semantic patch language<br>
=C2=A0 <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_coccinelle_coccinelle_blob_ed1eb8e06f800739d3992158d36945c0c4c6f0c=
7_docs_manual_cocci-5Fsyntax.tex-23L50&amp;d=3DDwIFaQ&amp;c=3Dr2dcLCtU9q6n0=
vrtnDw9vg&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHlaIacBrUq=
Kn4XPs818jx0L9aYE&amp;s=3DfjSfzgpZ0VlHVBEX9BbF17Xj0Co6DpQUNoTyspB9lO0&amp;e=
=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefense.proofpoint.com=
/v2/url?u=3Dhttps-3A__github.com_coccinelle_coccinelle_blob_ed1eb8e06f80073=
9d3992158d36945c0c4c6f0c7_docs_manual_cocci-5Fsyntax.tex-23L50&amp;d=3DDwIF=
aQ&amp;c=3Dr2dcLCtU9q6n0vrtnDw9vg&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPH=
MByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&amp;s=3DfjSfzgpZ0VlHVBEX9BbF17Xj0=
Co6DpQUNoTyspB9lO0&amp;e=3D</a> <br>
<br>
* Clarification request: Support for more programming languages?<br>
=C2=A0 <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__sy=
steme.lip6.fr_pipermail_cocci_2016-2DJuly_003445.html&amp;d=3DDwIFaQ&amp;c=
=3Dr2dcLCtU9q6n0vrtnDw9vg&amp;r=3DTMoJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UX=
MVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&amp;s=3Dh-OnZQhuthCctxsfOfpC5LhuamwKTEfRo=
IfG09Dd7Go&amp;e=3D" rel=3D"noreferrer" target=3D"_blank">https://urldefens=
e.proofpoint.com/v2/url?u=3Dhttps-3A__systeme.lip6.fr_pipermail_cocci_2016-=
2DJuly_003445.html&amp;d=3DDwIFaQ&amp;c=3Dr2dcLCtU9q6n0vrtnDw9vg&amp;r=3DTM=
oJUATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&am=
p;s=3Dh-OnZQhuthCctxsfOfpC5LhuamwKTEfRoIfG09Dd7Go&amp;e=3D</a> <br>
=C2=A0 <a href=3D"https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__lo=
re.kernel.org_cocci_76bf1017-2Dd629-2Dd44a-2D5493-2D0dcccbbfa65b-40users.so=
urceforge.net_&amp;d=3DDwIFaQ&amp;c=3Dr2dcLCtU9q6n0vrtnDw9vg&amp;r=3DTMoJUA=
TrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&amp;s=
=3Dw4Riw44aVfsTNqmkc_okL7dRKVK0kZHsHpYBIHRQi_0&amp;e=3D" rel=3D"noreferrer"=
 target=3D"_blank">https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__l=
ore.kernel.org_cocci_76bf1017-2Dd629-2Dd44a-2D5493-2D0dcccbbfa65b-40users.s=
ourceforge.net_&amp;d=3DDwIFaQ&amp;c=3Dr2dcLCtU9q6n0vrtnDw9vg&amp;r=3DTMoJU=
ATrFJ-DanWKiyV4vg&amp;m=3DPHMByyX5UXMVrzhrHlaIacBrUqKn4XPs818jx0L9aYE&amp;s=
=3Dw4Riw44aVfsTNqmkc_okL7dRKVK0kZHsHpYBIHRQi_0&amp;e=3D</a> <br>
<br>
<br>
How do you think about to improve related technologies?<br>
<br>
Regards,<br>
Markus<br>
</blockquote></div>

--00000000000036f49a058e74c875--

--===============0500994641==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0500994641==--
