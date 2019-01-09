Return-Path: <SRS0=lWl4=PR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E56D5C43387
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:02:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 326522075C
	for <cocci@archiver.kernel.org>; Wed,  9 Jan 2019 08:02:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KlI/6L6H"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 326522075C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0982Pno027244
          ; Wed, 9 Jan 2019 09:02:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 40C1476F2;
	Wed,  9 Jan 2019 09:02:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 76DCB76E6
 for <cocci@systeme.lip6.fr>; Wed,  9 Jan 2019 09:02:23 +0100 (CET)
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:22c] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0982Ma4009554
 for <cocci@systeme.lip6.fr>; Wed, 9 Jan 2019 09:02:22 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-oi1-x22c.google.com with SMTP id y23so5608504oia.4
 for <cocci@systeme.lip6.fr>; Wed, 09 Jan 2019 00:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:from:date:message-id:subject:to;
 bh=9hoTxJgsu3loMqXPDgQ0VExKXmmbCipCVSDhIhc3v28=;
 b=KlI/6L6HZAhxkmyvBha2N/6Ak4ZFIGdCXB3WlX5Gwiw7JsVGCyRCgzmRtoI1iqrCgN
 TswqhTaU9DNDU0aOPyy/bWdQhURkSskDZSE1i/JjGkaXBHV/Ya3QpHaUOiKSqnd7UMLY
 7Qh3lSgxccg9Th2FpAHpMfsfJ+/SyNjTElfP5e1/c1tHz7mkcXk2Y0WE7LRvMWaK89in
 K3nXbHuV38buL6XmiS+JIDLraVvaQAsTmKMD8jOnCjckpZS+UbBoaF5r6x1vSxWGCjs3
 LtO1T3QOzpJxCany2W9rFi4RXEKnAeyA9freNpSrFLOsflf6WA3CfmRbsvxON/J+adRo
 gZ3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
 bh=9hoTxJgsu3loMqXPDgQ0VExKXmmbCipCVSDhIhc3v28=;
 b=ETaNMVfzgx39sopLxCdN3+cqwefsFy/4QG2AT5NbOC3QQinYpsfL/SQgCvHEqngIA6
 yglqvv8Ix3C9IHJ1/fO1FiS5YCL9G1I7oWM2TUgHGR35S1bIVINL3PmJudFOeR1qEOPN
 c49UqO2s+Vr5qmviFGR7ubHhSyqaG5S75eCq8sy5HCq97mpzq7MfyiJDiRhmg6aO/CXB
 B5FVBSpiQOU5VS94ZhF/Y9LEesqFzxIJ7/zWWwVRw1V8o/HprDA5UYVCaIOWHUdiE/cr
 UHNUhIwCKpK4lZ4cTHhUqe3+oUSc4l33BEIxAl4G9/ZIpJqy5pMpYjW5RUwHdE6aC+p9
 2MEg==
X-Gm-Message-State: AJcUukdc4XKmVbOaZA3AR+CqznWe91Wp7pd6m2thtqhulCWrTxp/cjEE
 365jjvj4BywLVsqUgnTvCy6PBiK3UspG835IiYQeKu1BZS4=
X-Google-Smtp-Source: ALg8bN5syHqru0JTrsFauvH+sQFsn9o8sL09Vo79/iZkeWE/Ag0qe9OjuJMybK6Wt8RrHzlp1ifpO+76+dNy7GzkKRI=
X-Received: by 2002:aca:e884:: with SMTP id f126mr3341270oih.181.1547020942044; 
 Wed, 09 Jan 2019 00:02:22 -0800 (PST)
MIME-Version: 1.0
From: Evan Zhao <tacingiht@gmail.com>
Date: Wed, 9 Jan 2019 16:02:10 +0800
Message-ID: <CAAGQS2uda32aGO0vfPNUz8WGatfu8i0oM8dkf_aN9tsAUC1YLg@mail.gmail.com>
To: cocci@systeme.lip6.fr
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Jan 2019 09:02:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Jan 2019 09:02:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] A question about a part of a CTL formula
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi there,

I am looking at a CTL formula generated by spatch with "--show-ctl-text",

for example, for a cocci file like
@@
expression e,e1,e2;
@@

if (e)
- GOTO(e1);
-else GOTO(e2);
+ e1;
+else e2;

it corresponding CTL formula is:

CTL =
Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
((_r_0 &
(Ex e1 .
((Ex_ e . (Ex _v . if (e) )) &,
((EX(FalseBranch) &, EX(After)) &,
((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
EX((FalseBranch &,
AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
&, EX((After &, EX((Ex _v . _S1)))))))))
v
(!_r_0 &
(Ex e1 .
((Ex_ e . if (e) ) &,
(EX(FalseBranch) &,
((EX((TrueBranch &, AX((Ex _v . GOTO(e1);)))) &,
EX((FalseBranch &,
AX(((Ex _v . else ) &, AX((Ex e2 . (Ex _v . GOTO(e2);))))))))
&, EX(After)))))))

and I noticed that
Let _r_0 = (EX^((TrueBranch v InLoop)) v EX^(EX^(FalseBranch))) in
is a fixed pattern, and I can track it at somewhere around the function of
do_between_dots in the module Asttoctl2, but I don't what it stands for.

Cloud someone tell me what purpose it serves for?
Thanks in advance.

Best regards,
Evan
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
