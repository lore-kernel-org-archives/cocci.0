Return-Path: <SRS0=sEpD=VR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D58CC76195
	for <cocci@archiver.kernel.org>; Sat, 20 Jul 2019 09:55:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 86E9D217F5
	for <cocci@archiver.kernel.org>; Sat, 20 Jul 2019 09:55:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=uber.com header.i=@uber.com header.b="8lEmHclv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86E9D217F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=uber.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6K9tHI0025687;
	Sat, 20 Jul 2019 11:55:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1275677A0;
	Sat, 20 Jul 2019 11:55:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 88E73777C
 for <cocci@systeme.lip6.fr>; Wed, 17 Jul 2019 09:34:26 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:336] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x6H7YPPn005710
 for <cocci@systeme.lip6.fr>; Wed, 17 Jul 2019 09:34:26 +0200 (CEST)
Received: by mail-ot1-x336.google.com with SMTP id j19so23995365otq.2
 for <cocci@systeme.lip6.fr>; Wed, 17 Jul 2019 00:34:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uber.com; s=google;
 h=mime-version:from:date:message-id:subject:to;
 bh=iRCHXc0WjtHlars04sjnhcGsphGrZpOTdp2fzPvM1Zo=;
 b=8lEmHclvHmJf0KmrbBt6jSKXwaKLjPhs0rLAOXLAIo4+WWOLPfM2jC12TpskDyrUbI
 6e4mBqwiJsXF8J3GPKrXAdnNDqIkSKBJFnDyAWK+tWCdgpUsrmFOBc5nLxYRMKLdOyXv
 htCOcwVSiwNVXwQaczFW2hb/l7d5pj4h/w6Yo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=iRCHXc0WjtHlars04sjnhcGsphGrZpOTdp2fzPvM1Zo=;
 b=s6R04YHDorJRZe2JXIJbbFaoHBYdrWoFiC0pyPzb/Qt9l1SD9Bha5l9QciZBwMmHCp
 5gRUaSoEJwxD8ajre3eFlQkU7NktudeOB2lNz5SZ81DPXkbi/toQzF7BwTnCjI3an/Y1
 Vsh853X6DpCGvKQtBD+igjMJFy32NKe7Tf3HKB4qze2ob3rCo5MCQ2584l7pxVHYtw1g
 8qbYE4c3XeCMFweUlOkwlGpgBi+Tt+7j0ZBUbBhbr/6u/5zyDaKJCOvoZCeixm/vMGds
 acqkyeHSVXkC27wXonGoYrA2S9qFloy3yqJEXLp6BdaW4jjDFB+V6tVAN3Oeftq6401h
 eavA==
X-Gm-Message-State: APjAAAWL5VPLPeXuJglTxfUcdErgpLIm9ZE3DVvaQkIXTZgaZH3KrgsG
 XiL6GJBv44GXPGxREHIwH6ov2/oEfCpWm2RxxLeZrw5B
X-Google-Smtp-Source: APXvYqxom0IzH5RukRwv74m2XBto9cIjTPmBSxi+9nU70BWzVaZHPvWCz8ZFXiAuXLs5qg+5tyKSkCxm+XWI7JlxCRw=
X-Received: by 2002:a9d:7c8f:: with SMTP id q15mr2528054otn.24.1563348864915; 
 Wed, 17 Jul 2019 00:34:24 -0700 (PDT)
MIME-Version: 1.0
From: Raghavan Raman <ragr@uber.com>
Date: Wed, 17 Jul 2019 00:34:14 -0700
Message-ID: <CAEgVsn4+aMn_3pXo1fex6_3oWmHbQERhmr42dO0igdFT1u67nA@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 20 Jul 2019 11:55:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 17 Jul 2019 09:34:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 20 Jul 2019 11:55:14 +0200
Subject: [Cocci] Coccinelle for Go
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
Content-Type: multipart/mixed; boundary="===============1164980134=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============1164980134==
Content-Type: multipart/alternative; boundary="000000000000c14a9e058ddb852e"

--000000000000c14a9e058ddb852e
Content-Type: text/plain; charset="UTF-8"

Hi,

I am part of the Programming Systems group
<https://www.uber.com/us/en/about/science/> at Uber. We are looking into
using Coccinelle for refactoring in Go <https://golang.org/>.

Does Coccinelle include support for Go?

If not:
  * Is there any plan to add support for the same?
  * What would it take to add this support? Any documentation regarding
this?

Thanks,
Raghavan

--000000000000c14a9e058ddb852e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<div><br></div><div>I am part of the <a href=3D"https:/=
/www.uber.com/us/en/about/science/">Programming Systems group</a> at Uber. =
We are looking into using Coccinelle for refactoring in <a href=3D"https://=
golang.org/">Go</a>.</div><div><br></div><div>Does Coccinelle include suppo=
rt for Go?=C2=A0</div><div><br></div><div>If not:</div><div>=C2=A0 * Is the=
re any plan to add support for the same?</div><div>=C2=A0 * What would it t=
ake to add this support? Any documentation regarding this?</div><div><br></=
div><div>Thanks,</div><div>Raghavan</div><div><br></div></div>

--000000000000c14a9e058ddb852e--

--===============1164980134==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============1164980134==--
