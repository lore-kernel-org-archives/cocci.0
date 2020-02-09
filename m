Return-Path: <SRS0=c99d=35=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 871ADC35250
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 07:59:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FA972080C
	for <cocci@archiver.kernel.org>; Sun,  9 Feb 2020 07:59:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UTNRzJZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FA972080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0197wwBE027414;
	Sun, 9 Feb 2020 08:58:58 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 476E5772F;
	Sun,  9 Feb 2020 08:58:58 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CC8227718
 for <cocci@systeme.lip6.fr>; Sun,  9 Feb 2020 08:58:56 +0100 (CET)
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:1044])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0197wtqL023906
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 9 Feb 2020 08:58:56 +0100 (CET)
Received: by mail-pj1-x1044.google.com with SMTP id e9so2812707pjr.4
 for <cocci@systeme.lip6.fr>; Sat, 08 Feb 2020 23:58:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=ZpZfmzGs4r1Dp/eldBJTZ7WssIJu2WG1En28LoOksKA=;
 b=UTNRzJZWLImZhLBgUmVlirc4cNhtpXalSf4ekj5rtnXPabXgQcK0kG3n0uvdzFvEi4
 ydFW9h8TDrlsZywV5lrN0WvE81ywMySaqxC3Vy0/f8vWoq+0Mi6BZoDHflvSondlxHX3
 idY0YQPobVkxS2BKKcTmBqKBC2rg0aG51zcDFcGEKJCzJcPpWfaIyzymdE+v6e5h8h7E
 voCdCS4QRoLCK8LwuImH2oBxfKONDmlCbQOa9nOQ6BdJIA4qXRu5kZqZgjk6Qi0UUQOf
 qPiFxOk0nK7IRkE3iM/qv8qGNF/lXMY/YbjnlDpxzbr4AoR+5IR66jZkpyg8ioYc4NrU
 RdnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=ZpZfmzGs4r1Dp/eldBJTZ7WssIJu2WG1En28LoOksKA=;
 b=dTsuT8aQoJ0K9EK8kAUDJfOmgFjY+Km2DQ7Ewp0vMKfBBEkE2wHU6pFDIvwgPPSpML
 MB3PitxO2ldM8v34wQNgVN84oo1qgqXEIF8/sD24jkvFsHC25fH0flAxZOXUR0XiWPtg
 t1VihdSyUxW4AgI9yoTQ9EQbYNVpv7mgZE1X24GhBeVnkUrZjNk7QOU6JGUGaXL/wOq3
 Smw1wSTLEr3kvjDp/b9clYjYn3Fbz8MRWg1T8OahemzObT2gbOH0VRq9k/UQj8Q/fTqh
 yt7JCYDyH/QgkK9VTC+6PHBbz1k4rK2GedLQSIOfIWYzgWdkmn+Ba+sASSOFCcvrglqC
 yR0A==
X-Gm-Message-State: APjAAAWKQ5k3Dyh3cbhAZ6puZ0MHTsweD2Mu9NHV7MBksSCEMoI1ss0b
 WdheOeKL80Cr85kZyvD6k40=
X-Google-Smtp-Source: APXvYqwmqqvMGvawpvU3dieaQjBeXEB+6c6mbhN2A5Ocn5kunxP2vN8yTeexzgJRf/i7u/Z/Ui3HBg==
X-Received: by 2002:a17:90a:3603:: with SMTP id
 s3mr14261282pjb.61.1581235134319; 
 Sat, 08 Feb 2020 23:58:54 -0800 (PST)
Received: from localhost.localdomain
 ([2402:3a80:166e:dca2:8d98:ad42:3c3b:8544])
 by smtp.gmail.com with ESMTPSA id l10sm7822973pjy.5.2020.02.08.23.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 08 Feb 2020 23:58:53 -0800 (PST)
Message-ID: <c97f4e5641f8c68e35ae6f0e00940762c84dc2ac.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Julia Lawall <julia.lawall@inria.fr>
Date: Sun, 09 Feb 2020 13:28:49 +0530
In-Reply-To: <alpine.DEB.2.21.2002090817580.3430@hadrien>
References: <20200205130327.6812-1-jaskaransingh7654321@gmail.com>
 <20200207060938.9531-1-jaskaransingh7654321@gmail.com>
 <20200207060938.9531-3-jaskaransingh7654321@gmail.com>
 <alpine.DEB.2.21.2002090817580.3430@hadrien>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 09 Feb 2020 08:58:58 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 09 Feb 2020 08:58:56 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: "linux-kernel-mentees@lists.linuxfoundation.org"
 <linux-kernel-mentees@lists.linuxfoundation.org>,
        "cocci@systeme.lip6.fr" <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH v2 2/2] tests: Add test case to match const
 pointer variants
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

On Sun, 2020-02-09 at 08:20 +0100, Julia Lawall wrote:
> On Fri, 7 Feb 2020, Jaskaran Singh wrote:
> 
> > Pointer to const pointer and its variants would not match
> > previously.
> > Add a test case for matching these types.
> 
> I don't get any matches for this test.  If I split the semantic patch
> into
> four separate rules, then I get the change for id2 and id4, but not
> for
> the other two.
> 

That's weird, it works fine for me. I get this on both bytecode and
native builds.

--- tests/constptr.c
+++ /tmp/cocci-output-31326-084eed-constptr.c
@@ -1,7 +1,7 @@
 int main()
 {
-	const char * const * id;
-	const char * * const * id;
-	const char * const * * id;
-	const char * const id;
+	const char * const * id1;
+	const char * * const * id2;
+	const char * const * * id3;
+	const char * const id4;
 }


On the other hand, I get the id2 and id4 result with upstream.

--- tests/constptr.c
+++ /tmp/cocci-output-5387-a9b63b-constptr.c
@@ -1,7 +1,7 @@
 int main()
 {
 	const char * const * id;
-	const char * * const * id;
+	const char * * const * id2;
 	const char * const * * id;
-	const char * const id;
+	const char * const id4;
 }

Could you check if you've applied 1/2 first?

Cheers,
Jaskaran.

> julia
> 
> > Signed-off-by: Jaskaran Singh <jaskaransingh7654321@gmail.com>
> > ---
> >  tests/constptr.c     |  7 +++++++
> >  tests/constptr.cocci | 19 +++++++++++++++++++
> >  tests/constptr.res   |  7 +++++++
> >  3 files changed, 33 insertions(+)
> >  create mode 100644 tests/constptr.c
> >  create mode 100644 tests/constptr.cocci
> >  create mode 100644 tests/constptr.res
> > 
> > diff --git a/tests/constptr.c b/tests/constptr.c
> > new file mode 100644
> > index 00000000..13fe064c
> > --- /dev/null
> > +++ b/tests/constptr.c
> > @@ -0,0 +1,7 @@
> > +int main()
> > +{
> > +	const char * const * id;
> > +	const char * * const * id;
> > +	const char * const * * id;
> > +	const char * const id;
> > +}
> > diff --git a/tests/constptr.cocci b/tests/constptr.cocci
> > new file mode 100644
> > index 00000000..29f0aa96
> > --- /dev/null
> > +++ b/tests/constptr.cocci
> > @@ -0,0 +1,19 @@
> > +@ r0 @
> > +identifier id;
> > +@@
> > +const char * const *
> > +- id
> > ++ id1
> > +;
> > +const char * * const *
> > +- id
> > ++ id2
> > +;
> > +const char * const * *
> > +- id
> > ++ id3
> > +;
> > +const char * const
> > +- id
> > ++ id4
> > +;
> > diff --git a/tests/constptr.res b/tests/constptr.res
> > new file mode 100644
> > index 00000000..0af4de9a
> > --- /dev/null
> > +++ b/tests/constptr.res
> > @@ -0,0 +1,7 @@
> > +int main()
> > +{
> > +	const char * const * id1;
> > +	const char * * const * id2;
> > +	const char * const * * id3;
> > +	const char * const id4;
> > +}
> > --
> > 2.21.1
> > 
> > 

_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
