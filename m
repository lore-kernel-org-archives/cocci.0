Return-Path: <SRS0=ZWNV=TY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A188C072B5
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 20:08:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A62B2217F9
	for <cocci@archiver.kernel.org>; Fri, 24 May 2019 20:08:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="FXbKMWsv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A62B2217F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OK7lMW007137;
	Fri, 24 May 2019 22:07:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 102D77752;
	Fri, 24 May 2019 22:07:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D3EAB7747
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 22:07:44 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4OK7gQp019069
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 22:07:43 +0200 (CEST)
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com
 [209.85.210.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6BCCA21850
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 20:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1558728462;
 bh=H8DNOmd73AUiHawtE/HXpEsUW6pCUccrOMeWe+aUS90=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=FXbKMWsvyEGBzkHEcvyLFxIGfwLOwn1ZuULytIXPE0CtM9V4TRqJR6lbXq793DiOz
 WSJuOU0tduh3SrHbW0tTqfK/7FFr2dmLq6FDCAbEMkb0qGeBKz++/jcVeGdOPPNNKK
 Vi8woLHVe2JAH4zC23wHiydxl9Wa2eYemLSaLDAg=
Received: by mail-ot1-f49.google.com with SMTP id l25so9778637otp.8
 for <cocci@systeme.lip6.fr>; Fri, 24 May 2019 13:07:42 -0700 (PDT)
X-Gm-Message-State: APjAAAU2evNfGUXc3X6MqRHXRye56OTRfIHvG8ATcbyt5yGP7Fgx1cNe
 0vVhTWKPO95Omum41TxTuImpY1cGGGeZRea0fZA=
X-Google-Smtp-Source: APXvYqzbKdLZA2nNw8zRxSM6EbhJ8esUkTTzTx/sa3Q001V8jEjyJUh/pDzXc6LOtfBzNfwic8WzN7RIO2JHJ317v20=
X-Received: by 2002:a05:6830:164e:: with SMTP id
 h14mr2048824otr.321.1558728461815; 
 Fri, 24 May 2019 13:07:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXUYqKX6KEwzXqMR-Wq-gsdHOZzHu9O--5HD2gmb56O36g@mail.gmail.com>
 <alpine.DEB.2.21.1905242147210.2514@hadrien>
In-Reply-To: <alpine.DEB.2.21.1905242147210.2514@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Fri, 24 May 2019 15:07:05 -0500
X-Gmail-Original-Message-ID: <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
Message-ID: <CAOZdJXXV0a7VgRvLcYvzLZrPzVNsr6+WAxf4e6HDsE+U59zShA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 22:07:47 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 24 May 2019 22:07:43 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Checking if a line of code *does not* exist
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

On Fri, May 24, 2019 at 2:48 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Fri, 24 May 2019, Timur Tabi wrote:
>
> > I'm working on a new script that needs to add a NULL-pointer check if
> > one does not already exist.  For example:
> >
> > x = (MYTYPE)MACRO(params);
> >
> > should become
> >
> > x = (MYTYPE)MACRO(params);
> > if (!x) {
> >     do_something;
> > }
> >
> > My problem is that I want coccinelle to add the if-check only if it
> > doesn't already exist.  So currently I have this:
> >
> > @@
> > type T;
> > expression x;
> > @@
> > x = (T)MACRO(...);
> > +if (x == NULL)
> > +{
> > +    status = ERROR;
> > +    goto exit;
> > +}
> >
> > How do I make sure that these lines are not added if they already
> > exist?  I need to check for "if (x == NULL)" and "if (!x)" variants.
>
> (
> A
> B
> |
> A
> +B
> )

I can't quite get this to work:

func(...) {
<+...
 x = (T)MACRO(...);
(
 if (x == NULL)
|
+if (x == NULL)
+{
+    goto label;
+}
)
...+>
}

This gives me:
minus: parse error:
  File "/home/ttabi/boardobj.cocci", line 12, column 0, charpos = 157
  around = '|',
  whole content = |

Line 12 is the |



>
> Just put the == NULL variant.  An isomorphism will take care of the !x
> case.
>
> julia
>
>
>
>
> > _______________________________________________
> > Cocci mailing list
> > Cocci@systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
