Return-Path: <SRS0=MjcO=UK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48F1EC31E44
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 21:52:11 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92F7720874
	for <cocci@archiver.kernel.org>; Tue, 11 Jun 2019 21:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="NYjQAf/Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92F7720874
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5BLpu0c028664;
	Tue, 11 Jun 2019 23:51:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A0207775F;
	Tue, 11 Jun 2019 23:51:56 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 92FCF775D
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 23:51:54 +0200 (CEST)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5BLprGs010750
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 23:51:54 +0200 (CEST)
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com
 [209.85.210.47])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id E35BA20883
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 21:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1560289913;
 bh=R+67+yww4X7e9ZK9ZxWdUiFfNHE3kq1iCXHIegVltnk=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=NYjQAf/YEbNmd7ij5I44I9/9SHT7+g8R5DgTJFn3GyRHRQ7mGmHQXpvLyuwpapr20
 5SBEuhnAl2MF3FgHkBq0GbY03yY5423DotFxuiC6g5ygp8sR0EzofpvwUoPyo+HhMa
 nlUMLLMX47kLHuX4jcZtByxm3bjopR4+/umhDnXg=
Received: by mail-ot1-f47.google.com with SMTP id r10so13443276otd.4
 for <cocci@systeme.lip6.fr>; Tue, 11 Jun 2019 14:51:52 -0700 (PDT)
X-Gm-Message-State: APjAAAUbwA9X5Ks0ZprPDSTeUYWa6K2lxH5pIzY9aVgw4CYH8UW5Xrtz
 uBRij4IXLVN4Ka1rPfOMwZwmMH+BbhyUZCTM6zc=
X-Google-Smtp-Source: APXvYqwy8wfKO2wvcFHhxqlHHCQZGFHMzvlX/BqLoeq2hF1jUmsPw7WJe0LFHqKeWA7JKyim+KF75G70CkYr8rVFdwU=
X-Received: by 2002:a9d:ea6:: with SMTP id 35mr10273484otj.305.1560289912298; 
 Tue, 11 Jun 2019 14:51:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAOZdJXWVyC3o6vVbNEakhr8p4vX4j3wkkSyJg77-hcQ7Nqhf=g@mail.gmail.com>
 <CAOZdJXWja4mBf-gKSZ-HQaPs3c3x1ur2=BgPh6MnPx+eN7EgYQ@mail.gmail.com>
 <alpine.DEB.2.21.1905242138280.2514@hadrien>
In-Reply-To: <alpine.DEB.2.21.1905242138280.2514@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Tue, 11 Jun 2019 16:51:15 -0500
X-Gmail-Original-Message-ID: <CAOZdJXVsdJHZyWSXzOsJTTOj8R=UZcD4yZVxXBB1TELJLT1wSA@mail.gmail.com>
Message-ID: <CAOZdJXVsdJHZyWSXzOsJTTOj8R=UZcD4yZVxXBB1TELJLT1wSA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 23:51:57 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 11 Jun 2019 23:51:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] How to concatenate identifier with text?
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

On Fri, May 24, 2019 at 2:38 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
> On Fri, 24 May 2019, Timur Tabi wrote:
> > I figured it out:
> >
> > @@
> > identifier func;
> > fresh identifier label = func ## "_exit";
>
> Yes, that works too.  Simpler than my suggestion.

I managed to break it somehow.  I suspect I ran into some other quirk
of coccinelle.  I'm trying to convert that looks like this:

x = MACRO1(stuff);
if (x == NULL)
{
  BREAKPOINT();
  status = ERROR;
  goto myfunc_exit;
}

into:
x = MACRO1(stuff);
CHECK_OR_BP_AND_GOTO(x == NULL, status, ERROR, _exit);

I thought this would work:

@@
type T;
expression y, z;
identifier x, s;
identifier func;
fresh identifier label = func ## "_exit";
@@
func(...) {
<+...
 x =
 (T)
 \(MACRO1\|MACRO2\)
 (...);
-if (y)
-{
-      BREAKPOINT();
-      s = z;
-      goto label;
-}
+CHECK_OR_BP_AND_GOTO(y, s, z, _exit);
...
 label:
...+>
}

but I get this error:

18: unexpected use of a fresh identifier label

What am I missing?
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
