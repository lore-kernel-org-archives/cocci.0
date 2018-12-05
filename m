Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53F0DC04EB9
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 17:58:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A5CD22146D
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 17:58:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1xnSaptu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A5CD22146D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5Hvpqt026570
          ; Wed, 5 Dec 2018 18:57:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EB0D376DA;
	Wed,  5 Dec 2018 18:57:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 25A6D76D4
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 18:57:49 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5HvmTV016530
 for <cocci@systeme.lip6.fr>; Wed, 5 Dec 2018 18:57:48 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com
 [209.85.210.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 84EF22146D
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 17:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544032667;
 bh=MDNgwEJUs7BCYKtr3Sw39Wr2+ZRtSIcZMekVR/G7rUg=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=1xnSaptuSa3YNYcmjsfdlqQ3wsebJlRTEFV4gK0vjk4m9jqU522Q8AtMUVmwEhXbD
 g9GrRF3f8itRQibbUzTfbK+7FUtqAtY++RD3PNwtMPUeMXRqE2EBi4sy9N3TjE4Jqq
 ZoEzQre5NG6ATtVyqyRBKEgiTzIhIgjmiBCSMgiI=
Received: by mail-ot1-f46.google.com with SMTP id 32so19425532ota.12
 for <cocci@systeme.lip6.fr>; Wed, 05 Dec 2018 09:57:47 -0800 (PST)
X-Gm-Message-State: AA+aEWa6QCTWYMO5P4BNRsQqUDPG+eEx/kVy9RrJHjlWeCVaxJcaGDUD
 NC1+kIHeqB0+UzOrAteckhRHEasIHwCNxpkfH7o=
X-Google-Smtp-Source: AFSGD/W+pRDasv9/H/ow9JBl//FVlExpnw0I5E4fpuRACz/rEX0n1sL5u/jDZQvlp+Sw3eipCo5OC2R31UaHjZF3WVQ=
X-Received: by 2002:a9d:6009:: with SMTP id h9mr16917093otj.349.1544032666848; 
 Wed, 05 Dec 2018 09:57:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <alpine.DEB.2.21.1812050732260.2670@hadrien>
In-Reply-To: <alpine.DEB.2.21.1812050732260.2670@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 5 Dec 2018 11:57:09 -0600
X-Gmail-Original-Message-ID: <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
Message-ID: <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 18:57:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 18:57:48 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>, Timur Tabi <timur@kernel.org>
Subject: Re: [Cocci] Can the current function name be passed to a Python
	snippet?
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

On Wed, Dec 5, 2018 at 12:44 AM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > > In the example, p1 will store the position of n.  In the python rule, you
> > > can then access p1[0].current_element to get the name of the function in
> > > which n occurs.
> >
> > What do you mean by "position of n"?
>
> The code that n matches is in some file, within some function, at some
> line number, and at some column offset.  All of that information is
> collected in p1.

I'm having trouble figuring out how to access p1[0].  I tried this

// Use Python to clean up the string literals.
// Comments are still C-style though
@r depends on rules@
expression x;
position p1;
constant char[] c;
@@
NV_PRINTF2(x, c, ...)

@script:python s@
c << r.c;
c2;
p1 << r.p1;
@@
import re

print p1

But that gave me this error:

warning: r: metavariable p1 not used in the - or
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
