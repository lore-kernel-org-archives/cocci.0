Return-Path: <SRS0=PsQ7=3C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B050CC33CA9
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2020 22:22:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29573207FF
	for <cocci@archiver.kernel.org>; Mon, 13 Jan 2020 22:22:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TQ6jcm1b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29573207FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00DMLtBm020486;
	Mon, 13 Jan 2020 23:21:55 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7D05177E3;
	Mon, 13 Jan 2020 23:21:55 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4F745771F
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 23:21:53 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00DMLp4P019719
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 23:21:52 +0100 (CET)
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com
 [209.85.222.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2C9C6207FF
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 22:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1578954110;
 bh=OKPUFeQG7JoY6aP09/DKzGAAvfkeEtLzhG07SDyqt7I=;
 h=From:Date:Subject:To:From;
 b=TQ6jcm1btRPt8Fqf7AfecxS0NeAcesgYNYryGB+dCciRVsZ4psjRFl5kMF1gw1kCN
 QU7Be131gSokY6bSJAbl82bZvm2gDBMwpzDYnZJvP7KMY1pgx9RQyNKjJxITgyHj3+
 98IRbkzH8kJY91apjvysDY1qbrBMwCBdLbiJ1i8Q=
Received: by mail-qk1-f176.google.com with SMTP id a203so10315599qkc.3
 for <cocci@systeme.lip6.fr>; Mon, 13 Jan 2020 14:21:50 -0800 (PST)
X-Gm-Message-State: APjAAAVd/tccILysDTLSxKYac5LJ94LY/1QLDw1zpYVEO63Y9z0WbCaJ
 ZxqfYgjHxaiiRClSqbH8aHQXtX+SrNicmnMBoCo=
X-Google-Smtp-Source: APXvYqxxH56MyrMUa+zknpA5X0iunHvpQrbXuoDhKx3nnmDI7OLlowekfShdDFarOaz2ptJVXpFFgRKKsZ3+cPePUVQ=
X-Received: by 2002:a37:274a:: with SMTP id n71mr17716510qkn.302.1578954109291; 
 Mon, 13 Jan 2020 14:21:49 -0800 (PST)
MIME-Version: 1.0
From: Timur Tabi <timur@kernel.org>
Date: Mon, 13 Jan 2020 16:21:12 -0600
X-Gmail-Original-Message-ID: <CAOZdJXU4vhqzot5EEMZ_9jAdp-Be0TTyDS-uXJVPrGs2k=c7nA@mail.gmail.com>
Message-ID: <CAOZdJXU4vhqzot5EEMZ_9jAdp-Be0TTyDS-uXJVPrGs2k=c7nA@mail.gmail.com>
To: cocci <cocci@systeme.lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 13 Jan 2020 23:21:56 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 13 Jan 2020 23:21:52 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Concatenating parameters into a string
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

I don't know how to properly describe what I'm trying to do, so I'll
just show an example.

The code I'm working on has dozens of annoying macros that concatenate
parameters into strings.  For example,

#define DRF_DEF(d,r,f,c)  \
       (((NvU32)(NV ## d ## r ## f ## c))<<DRF_SHIFT(NV ## d ## r ## f))

So given DRF_DEF(one, two, three, four), it will generated:

(((NvU32)(NV_one_two_three_four))<<DRF_SHIFT(NV_one_two_three))

I'm trying to create a cocci rule that will replace all of these
macros with their expanded equivalents, but I don't know how to handle
the ## feature of macros.  So far I have this:

@@
expression d, r, f, n, v;
@@
-FLD_SET_DRF_NUM(d, r, f, n, v)
+((v) & ~DRF_SHIFTMASK(NV d r f)) | DRF_NUM(d, r, f, n)

But this gives an error because "NV d r f" is not valid C.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
