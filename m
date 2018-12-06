Return-Path: <SRS0=3TVc=OP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AB1C04EB8
	for <cocci@archiver.kernel.org>; Thu,  6 Dec 2018 06:34:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 035BE2146D
	for <cocci@archiver.kernel.org>; Thu,  6 Dec 2018 06:34:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 035BE2146D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB66Xr3R014889
          ; Thu, 6 Dec 2018 07:33:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D55FB76D6;
	Thu,  6 Dec 2018 07:33:52 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4618A75E8
 for <cocci@systeme.lip6.fr>; Thu,  6 Dec 2018 07:33:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB66Xolp010158
 for <cocci@systeme.lip6.fr>; Thu, 6 Dec 2018 07:33:50 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,321,1539640800"; d="scan'208";a="288077632"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail3-relais-sop.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Dec 2018 07:33:50 +0100
Date: Thu, 6 Dec 2018 07:33:50 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXWnjAPwrvWEO58fa8O28jf8YC+yt0b46Oi3TYhXazYzJQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1812060731560.3006@hadrien>
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <alpine.DEB.2.21.1812050732260.2670@hadrien>
 <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
 <CAOZdJXUxWV+v5UanQXRVLpOJbxA27a_zitCeUdW4uJaqX0jWgQ@mail.gmail.com>
 <CAOZdJXWnjAPwrvWEO58fa8O28jf8YC+yt0b46Oi3TYhXazYzJQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 06 Dec 2018 07:33:53 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Thu, 06 Dec 2018 07:33:50 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
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



On Wed, 5 Dec 2018, Timur Tabi wrote:

> On Wed, Dec 5, 2018 at 1:11 PM Timur Tabi <timur@kernel.org> wrote:
> >
> > Never mind, I now understand how the @p1 is supposed to be used.  I
> > have it working now.
>
> I spoke too soon, I'm getting a weird error:
>
> rule starting on line 232: already tagged token:
> C code context
> File "/tmp/cocci_small_output-22474-8398df.c", line 43, column 23,
> charpos = 1216
>   around = '"init_PllId: Error programming clock.  Stopping script.\n"',
>   whole content =                        "init_PllId: Error
> programming clock.  Stopping script.\n");
>
> Line 232 is the "depends on rule" in this snippet:
>
> // Get rid of the function name at the beginning of the string
> @script:python s4@
> c << r4.c;
> c2;
> p1 << r4.p1;
> @@
> import re
>
> f = p1[0].current_element
> coccinelle.c2 = re.sub('"%s[: ]*' % f, '"', c, 1)
>
> @depends on rules@
> expression x;
> constant char[] r4.c;
> identifier s4.c2;
> @@
> NV_PRINTF2(x,
> -c
> +c2
> ,...);

Probably the same string occurs in multiple functions, so you get multiple
new propositions for it.  To guard against this, you should reuse the
position variable:

@depends on rules@
expression x;
constant char[] r4.c;
position r4.p1;
identifier s4.c2;
@@
NV_PRINTF2(x,
-c@p1
+c2
,...);

You may need to move the @p1.  It should be in the same place that it
appears in r4.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
