Return-Path: <SRS0=3aZu=7I=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA1E1C433DF
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 06:42:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41F90207D8
	for <cocci@archiver.kernel.org>; Tue, 26 May 2020 06:42:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41F90207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04Q6fuPo007261;
	Tue, 26 May 2020 08:41:56 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F1B127783;
	Tue, 26 May 2020 08:41:55 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 87A8D3E8A
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 08:41:54 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04Q6frpX003538
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 26 May 2020 08:41:54 +0200 (CEST)
X-IronPort-AV: E=Sophos;i="5.73,436,1583190000"; d="scan'208";a="349598115"
Received: from abo-173-121-68.mrs.modulonet.fr (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 26 May 2020 08:41:53 +0200
Date: Tue, 26 May 2020 08:41:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Thomas Adam <thomas@xteddy.org>
In-Reply-To: <CAOhcEPY8r2fjJmJP4A6ZzFdhTGJB=RYVcVt8k6KV9EaMzc_oSQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.2005260841020.2451@hadrien>
References: <24b3f013-21e4-99e8-5366-cfc944077cc2@web.de>
 <CAOhcEPY8r2fjJmJP4A6ZzFdhTGJB=RYVcVt8k6KV9EaMzc_oSQ@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 08:41:56 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 26 May 2020 08:41:54 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Using SmPL scripts to mangle function arguments
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



On Tue, 26 May 2020, Thomas Adam wrote:

> On Sun, 17 May 2020 at 10:22, Markus Elfring <Markus.Elfring@web.de> wrote:
> > Generally, yes.
> >
> > A more complete source code transformation approach can become challenging.
>
> So I've decided to try and take a different approach, and have
> rethrough the function interface.
>
> Rather than try and modify the arguments in the way I was, I think it
> makes sense to largely keep the existing function signatures.
>
> So for example, currently there is:
>
> func_old(int level, const char *func, const char *fmt, ...);
>
> What I'm after here is to modify func_old, such that I drop the "int
> level" parameter, and change the *func occurrences to "__func__", and
> drag the variadic arguments with the transformation, hence, I'd like
> func_old to now look like:
>
> func_old(const char *func, const char *fmt, ...);
>
> So what was once:
>
> func_old(ERR, "MyFunction", "%s: hello: %d, %d", myvar, x, y);
>
> Should now be:
>
> func_old(__func__,  "%s: hello: %d, %d", myvar, x, y);
>
> I'm having trouble expressing my smPL to understand the ellipses
> correctly.  Here's what I have so far:
>
> @@
> expression L, F;
> @@
>
> - func_old(L, F, ...);
> + func_old(__func_, ...);


You can't add ...  Coccinelle has no idea what it refers to.  You can just
put:

func_old(
- L,F
+ __func__
  ,...)

julia

>
> ... but here, things fall apart:
>
> init_defs_builtins: /usr/bin/../lib/coccinelle/standard.h
> File "contrib/coccinelle/remove_debug.cocci", line 6, column 21, charpos = 68
>   around = '...',
>   whole content = + func_old(__func__, ...);
>
> Any ideas on what I'm doing wrong?  If there's appropriate
> documentation on this, please feel free to point me toward it.  I feel
> as though I'm missing something obvious here, so thanks for your time
> and for any help you can give.
>
> -- Thomas
> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
