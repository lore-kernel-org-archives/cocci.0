Return-Path: <SRS0=UtEZ=PN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05A2BC43387
	for <cocci@archiver.kernel.org>; Sat,  5 Jan 2019 06:25:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51C1221874
	for <cocci@archiver.kernel.org>; Sat,  5 Jan 2019 06:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51C1221874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lip6.fr
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x056PfSY017928
          ; Sat, 5 Jan 2019 07:25:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A1C9A76E0;
	Sat,  5 Jan 2019 07:25:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DEAD46251
 for <cocci@systeme.lip6.fr>; Sat,  5 Jan 2019 07:25:39 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x056PdVs013309
 for <cocci@systeme.lip6.fr>; Sat, 5 Jan 2019 07:25:39 +0100 (CET)
X-pt: isis.lip6.fr
X-Addr-Warning: ATTENTION - Votre correspondant a fourni une adresse
 d'enveloppe @lip6.fr, mais ce message ne provient pas
 de lip6.fr ! postmaster@lip6.fr.
X-IronPort-AV: E=Sophos;i="5.56,441,1539640800"; d="scan'208";a="362621298"
Received: from abo-91-111-68.mrs.modulonet.fr (HELO hadrien) ([85.68.111.91])
 by mail2-relais-roc.national.inria.fr with
 ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Jan 2019 07:25:38 +0100
Date: Sat, 5 Jan 2019 07:25:38 +0100 (CET)
From: Julia Lawall <julia.lawall@lip6.fr>
X-X-Sender: jll@hadrien
To: Timur Tabi <timur@kernel.org>
In-Reply-To: <CAOZdJXWUhEcm8HgJFE2L1dqgMRX51X+LF=b=Obzj55pU4gc3QA@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1901050714330.2519@hadrien>
References: <CAOZdJXWUhEcm8HgJFE2L1dqgMRX51X+LF=b=Obzj55pU4gc3QA@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 05 Jan 2019 07:25:42 +0100 (CET)
X-Greylist: IP, sender and recipient auto-whitelisted, not delayed by
 milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]);
 Sat, 05 Jan 2019 07:25:39 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can I pass a variable from a Python script in one rule
 to another rule in the same .cocci file?
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



On Fri, 4 Jan 2019, Timur Tabi wrote:

> In one rule, I have some Python code that parses a string literal to
> see what it looks like.  If I detect a specific pattern, then I want
> another rule (that has no Python code) to act differently.
>
> More specifically, if a string literal passed as a parameter to
> DBG_PRINTF() starts with "NVRM: ", then I want my script to replace
> DBG_PRINTF with NV_PRINTF.  This works today.
>
> If the string does not begin with "NVRM:", however, then I want
> DBG_PRINTF changed to NV_PRINTF_EX instead.
>
> If this can't work, an alternative would be to create a second script
> that handles DBG_PRINTF to NV_PRINTF_EX.  However, it would need to
> abort the change if the Python script detects that NVRM: doesn't
> exist.  So is there a way for Python to return a value that says,
> "Woah, stop and undo everything you just did!"

I think that you want to use cocci.include_match(False)

In your python script, make the checks that you want, and then if you are
not satisfied with the results, use cocci.include_match(False) to get the
curent match of the metavariables to disappear.  You may need to rematch
something to get the information needed for the second change option.

julia

> _______________________________________________
> Cocci mailing list
> Cocci@systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
