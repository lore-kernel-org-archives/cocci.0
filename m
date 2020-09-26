Return-Path: <SRS0=rIg9=DD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6072CC2D0A8
	for <cocci@archiver.kernel.org>; Sat, 26 Sep 2020 19:40:28 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8769521D7F
	for <cocci@archiver.kernel.org>; Sat, 26 Sep 2020 19:40:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=vt-edu.20150623.gappssmtp.com header.i=@vt-edu.20150623.gappssmtp.com header.b="qvuhbvpu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8769521D7F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=vt.edu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08QJdxHt006645;
	Sat, 26 Sep 2020 21:39:59 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8236F778D;
	Sat, 26 Sep 2020 21:39:59 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id EA27D5F8F
 for <cocci@systeme.lip6.fr>; Sat, 26 Sep 2020 21:11:49 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:843])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08QJBm2n023864
 for <cocci@systeme.lip6.fr>; Sat, 26 Sep 2020 21:11:48 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id 19so5175476qtp.1
 for <cocci@systeme.lip6.fr>; Sat, 26 Sep 2020 12:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vt-edu.20150623.gappssmtp.com; s=20150623;
 h=sender:from:to:cc:subject:in-reply-to:references:mime-version
 :content-transfer-encoding:date:message-id;
 bh=HXHwAmJqtzhy0GaltRSGEDCBQtRzzJDllTi8cJUt2Wo=;
 b=qvuhbvpu5AO68fMeveIuWfGTN+D0nmcZlJkX1mjHMmoXPPkHmZPS5g/D/RaJ3UJi1t
 9EyczrTwihu910bMwqhL94H4xZp9d//UhjyTRIFCMDEbx6vKWG2pg6CTW+r9DFOMfRFA
 JrI9tnamwDhUeSGwOIgIwmg2tK13YK2+lX8OcWcBLZVPDmgOX3HULpBK9ufXJQLNLWVA
 lOkHZuZvkIM7U5Z2RY3DKa6qZDfBtC+alVW5PlXgULgh+pSo5vkWeVupF9UPKtxmaGnh
 W7C+FP9o6fS4a8TGvzzgsI1siljTwM0CN5LokWDdHCVq597qzdlgE6zw1OMUfrEAlIzb
 qTGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:in-reply-to:references
 :mime-version:content-transfer-encoding:date:message-id;
 bh=HXHwAmJqtzhy0GaltRSGEDCBQtRzzJDllTi8cJUt2Wo=;
 b=jr/rCCDFoV4ay0aby22Z4pWeRJ3u6rKgRmbgkai0EEDRSCe5hV10RbPSF7XEB6q5lK
 P5GixSSQQXxkdE2Qvr7yVh/HJWmH05Z1jorq3OstsgfsdjsNq83B4+hvyW0u1/KS5Lv4
 DY0dOfRBjnZGEILJn0bofBpfCco9hqLK2eKhmEZedva4VAZ5QVZAz306M1bdgBiopLfI
 BWZr1r6ZcQ8t53Gilmk7eS2OLRsXABY/UUmnXCDxEYq2hsJnbCNHnRN3BNPO7pbWB0XK
 A6vhLTxkDkOo9vAXkdmM8tVh5556Bx4k8oYYUcevVP1JP87AUrBRiRc9EKrinceh6M9h
 Cw6Q==
X-Gm-Message-State: AOAM533rfHBSd+0UjeFxBJ5AqJJ9/jFLDY7aEIiaCxGKySHYtApio9TS
 vpQzpJAGGv2fHcnEWCOdrT5VRA==
X-Google-Smtp-Source: ABdhPJwR2g/ncpm2C/nXgazviM7lxAwgSV7qyq+RWN6LOPygiZjfv1mzPGO8S8L1GCjJk/lx6rhT2g==
X-Received: by 2002:ac8:6f3b:: with SMTP id i27mr5793438qtv.299.1601147507604; 
 Sat, 26 Sep 2020 12:11:47 -0700 (PDT)
Received: from turing-police ([2601:5c0:c000:a8c1::359])
 by smtp.gmail.com with ESMTPSA id b13sm4477025qkl.46.2020.09.26.12.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 26 Sep 2020 12:11:46 -0700 (PDT)
From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks" <valdis.kletnieks@vt.edu>
X-Google-Original-From: "Valdis Kl=?utf-8?Q?=c4=93?=tnieks"
 <Valdis.Kletnieks@vt.edu>
X-Mailer: exmh version 2.9.0 11/07/2018 with nmh-1.7+dev
To: Joe Perches <joe@perches.com>
In-Reply-To: <58673398c6b836ebd7509f787e6f0d10bfd751bc.camel@perches.com>
References: <87r1qqvo2d.fsf@nanos.tec.linutronix.de>
 <a53048f738dacc1c58654eb94e229de79d4f94c2.camel@perches.com>
 <alpine.DEB.2.22.394.2009251904540.2772@hadrien>
 <58673398c6b836ebd7509f787e6f0d10bfd751bc.camel@perches.com>
Mime-Version: 1.0
Date: Sat, 26 Sep 2020 15:11:44 -0400
Message-ID: <173999.1601147504@turing-police>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 26 Sep 2020 21:40:00 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 26 Sep 2020 21:11:48 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Sat, 26 Sep 2020 21:39:57 +0200
Cc: Giuseppe Scrivano <gscrivan@redhat.com>,
        kernelnewbies <kernelnewbies@kernelnewbies.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, cocci <cocci@systeme.lip6.fr>,
        Andy Whitcroft <apw@shadowen.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [Cocci] coccinelle: Convert comma to semicolons (was Re:
	[PATCH] checkpatch: Add test for comma use that should be semicolon)
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
Content-Type: multipart/mixed; boundary="===============0390099188=="
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

--===============0390099188==
Content-Type: multipart/signed; boundary="==_Exmh_1601147504_3912P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit

--==_Exmh_1601147504_3912P
Content-Type: text/plain; charset=us-ascii

On Fri, 25 Sep 2020 10:26:27 -0700, Joe Perches said:
> And the generic individual maintainer apply rate for
> each specific patch is always less than 50%.
>
> For instance the patches that converted the comma uses
> in if/do/while statements to use braces and semicolons
> from a month ago:

> 29 patches, 13 applied.

To be fair, it's *always* been hard to get pure style patches applied, because
they usually hit one of two types of code, with different results:

Some of them hit code that's been stable for a long time - and those patches
don't get applied because of the (admittedly small) risk that a "style" patch
may actually break something - yes, that *does* happen often enough to worry a
risk-adverse subtree maintainer.

Some of them hit code that's actively being worked on - and those patches don't
get applied because they can cause merge conflicts.

This is a hard problem to fix, because it's difficult to say that either of
those viewpoints is *totally* wrong. At best, you can make the case that some
maintainers are a tad over-zealous on their attitude. And since its *hard* to
find good maintainers, it's not possible to fix the problem by just putting
somebody else in charge of a subtree. It's theoretically possible to bypass a
problematic maintainer by sending the patch to the person one level up, or
directly to Linus - but although that usually works if you have an urgent patch
and the maintainer is on vacation or stubborn or whatever, that's got
essentially zero chance of succeeding for a mere style patch.

Unfortunately, although I understand the problem, I don't have a solution. It's
easy to tactfully say "this code is wrong, and here is the fix".  It's a lot
harder to find a tactful way to say "This person is wrong and should do it this
way", because code doesn't fight back when you offer constructive criticism....



--==_Exmh_1601147504_3912P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.9.0 11/07/2018

iQIVAwUBX2+ScAdmEQWDXROgAQI8Ag//YKel+oxk8JlWyUFEbQz41v44EhWHlykN
LLlOnRINghANJbunFpoUgD+KW9I9mPy8MmbdF+SeQq8fT+g5qfIwsYNsTeJI/Bu8
K3ksbdy6qcuqO5ZmfqS9d1VYykaAXbIi1OqTa6gkX60EU+c1zLuCo78gFyO0c27T
193bWbUG7iCkEXN3261e+a8p1XvQOUtRULuedBbyUQ9GmIEv8oLOMErq4YSBVx5t
k/FKSrRfu5ZesBbxOOzGpPQXMpq64vwatpcZlNs6fKZjnzgmCYtnSzMCZ13bhkGE
zPQQs1Ak0c1GmBVTlZVYHUNNLG4SKdHchF9yKZ5gooqLu1eWEg6O5WxeMWAjIQ1d
qbxKveWY0E8xj0PM//BgyZraCRrAT8KGcpXjFEWtsw07dKD3hnpdXg2PlrX972v2
BPk+M7pGEe/qZJPdGiptefli6zxtuv+hQI9sVif99+FRQ3RlKx4/xte1O7iKn3/N
wzXNZ7pFG0UPGIkM5pEzUWv1VmBXoZqDT9qqanHNZDkRjYuv0IouI0QWaZ5v363E
SOK0YBnHPUHA+bMOek59eof91yAwzgCqUrmAlZ3T/AKKHY1jUIujKbr/zVhAfa9b
x0mn/NSmOmLc86BSgNKrAhxkbfoOzPnwnMVx1AHMhzZ43mlsaNyDz09SomWDWkzX
GcnpFZnyRSo=
=Cdbo
-----END PGP SIGNATURE-----

--==_Exmh_1601147504_3912P--

--===============0390099188==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci

--===============0390099188==--
