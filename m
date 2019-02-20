Return-Path: <SRS0=FowQ=Q3=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B24C43381
	for <cocci@archiver.kernel.org>; Wed, 20 Feb 2019 09:08:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4492208E4
	for <cocci@archiver.kernel.org>; Wed, 20 Feb 2019 09:08:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ibsgaard-io.20150623.gappssmtp.com header.i=@ibsgaard-io.20150623.gappssmtp.com header.b="qTpxLQeM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4492208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ibsgaard.io
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1K986vF014275
          ; Wed, 20 Feb 2019 10:08:07 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 623C476FF;
	Wed, 20 Feb 2019 10:08:06 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7631F764A
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 10:08:04 +0100 (CET)
Received: from mail-it1-x130.google.com (mail-it1-x130.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:130] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x1K983jv002652
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 10:08:03 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-it1-x130.google.com with SMTP id l66so13790214itg.3
 for <cocci@systeme.lip6.fr>; Wed, 20 Feb 2019 01:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ibsgaard-io.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Qy5DuFYMvhpOq93VpqnfxPSBmLbijMIpk933/4STJuw=;
 b=qTpxLQeMb6mRvnv/ks+PZ1y8O3gsM5TlLCS6O65RGhJt2Qa8JGGKQT70bU17M3Edrv
 AXv0eTss+KOEYW0GB5ufiWcSdtCpOo5Q0D02TVru02uW22BYGcTJb96pjybvTtXEzTwC
 VaTGbOe/8URWztYPITSF5TBI0e8Bgmipa/V0jSMEB9HGHKBmRwKIJ/Vl5f39RKZwOQv7
 UcXeIzRiE1XYJrgUuGfN4B3t/aDdvvK3Mahtdxt5SQ1w/YICDcbZa78XBELVZYBqZ3dY
 5waLkyd/wY4zgPmCkwGG2bVouSrLmgi2KBnpJDCBXDC0CfwuzNw+hTCZMY/X3RvZVlgS
 qIzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Qy5DuFYMvhpOq93VpqnfxPSBmLbijMIpk933/4STJuw=;
 b=PPEwzjj/NIqswfwMwyHyEp+EnOTInUJBE/HnjmTEtX6fBmiumd9x5t/dPN/OdrJOsP
 21ad1KJZwK857wlkZK3no1u+HpptJcrIOm8zyrOpal2+KiEk+I5n7l/WlmW1O1PqLe9I
 UXasaMQLhTPsNidb0TvXlF1xBUTcgt3Jq+j/RjS0rHG3ujW6lCjnmdxGSqVbE3+cHANy
 dbQFq4chEnqypBjdlsB22lbttqwIPUbXgb3FWK5iNsvDSXJd8wySWmC6WVz8w7FEFP7v
 MXSIpDX8u00/zknP+tH59bY1daLQ1xAirAejOk03gyha4aQzwwnuk2yRuHhBYe2tl7nZ
 UVOg==
X-Gm-Message-State: AHQUAuZBmYW+o1EUpgfdo1ZZwVnuGCERtg/3AeMZZHU2TgPnYaEydatf
 VwIkJvkvP81zEbyh4EI2V5gA8zv+V1RBsF4vhF3AvCLl
X-Google-Smtp-Source: AHgI3IYQpZ7F6W90gEUDCgbR7avhVX0UkAukuk2thf7faj266zY75Spbc7Ub3cLXDn4Ca8YnhLNBoIEs0S04sVF0pdQ=
X-Received: by 2002:a24:75c7:: with SMTP id y190mr4639895itc.108.1550643950789; 
 Tue, 19 Feb 2019 22:25:50 -0800 (PST)
MIME-Version: 1.0
References: <CABWD38=R3aZDpEvRTc-aidKuQ9QT1BhfN+h7Zo_PLu2SgvdBmw@mail.gmail.com>
 <alpine.DEB.2.21.1902190755130.2570@hadrien>
In-Reply-To: <alpine.DEB.2.21.1902190755130.2570@hadrien>
From: thomas pedersen <thomas@ibsgaard.io>
Date: Tue, 19 Feb 2019 22:25:40 -0800
Message-ID: <CABWD38nn0PdCbDKKzmH6GisYptXyvec8Z5=zCXNbT5QzQOuisw@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 20 Feb 2019 10:08:07 +0100 (CET)
X-Greylist: Delayed for 31:06:00 by milter-greylist-4.4.3 (isis.lip6.fr
 [IPv6:2001:660:3302:283c:0:0:0:2]); Wed, 20 Feb 2019 10:08:03 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] SmPL patch against C macro
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

On Mon, Feb 18, 2019 at 10:56 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
>
>
> On Mon, 18 Feb 2019, thomas pedersen wrote:
>
> > Hello,
> >
> > I'm trying to write an SmPL patch which will modify C macro. The test files are:
> >
> > # test_macro.c
> > #define MYMACRO(adsf) { \
> >         .foo = (asdf),\
> > }
> >
> > # test_macro.cocci
> > @@
> > expression E;
> > @@
> >
> > {
> > .foo = E
> > + * 1000
> > }
> >
> > Running with:
> > $ spatch --debug --sp-file test_macro.cocci test_macro.c
> >
> > Gives the output:
> > Unsupported form of #define: File "test_macro.c", line 1
> >
> > What's the correct syntax to match against a similar macro?
>
> It was the macro definition itself that was not supported.  The problem
> should be fixed now.  You can get the latest version from Github.

It works! Thanks.

thomas
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
