Return-Path: <SRS0=bJsz=6M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3B4C83004
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 19:01:16 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B299C206A1
	for <cocci@archiver.kernel.org>; Tue, 28 Apr 2020 19:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=cilium-io.20150623.gappssmtp.com header.i=@cilium-io.20150623.gappssmtp.com header.b="JxCBr2rr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B299C206A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cilium.io
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 03SJ102c022448;
	Tue, 28 Apr 2020 21:01:00 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A33C87807;
	Tue, 28 Apr 2020 21:01:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 909B43DC8
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 20:58:50 +0200 (CEST)
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:441])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 03SIwnR3018528
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 20:58:49 +0200 (CEST)
Received: by mail-wr1-x441.google.com with SMTP id b11so25954372wrs.6
 for <cocci@systeme.lip6.fr>; Tue, 28 Apr 2020 11:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cilium-io.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=fJy+2QZmgWghPEPdi4fzKTpJEznTzrW1f/Pzs2aLFqk=;
 b=JxCBr2rre7gPRXZVpo34i/lSU0em0hn10TKCSZdasyC8GtIjj3wDzGDj0akI8M6ilG
 Rp8Cxh77MOD5ACnLnwTKY2uoZKba14cUhY1Auu7CFnOD1QTKGXyjDqg3D32hTBeuYVt2
 5sPfBbR2VtIKqSRYxY+SvaTddQzELrbfXDY2DINBwdw9k2nuM8AbnW4rVAt4h49e5hAV
 2dMCp4bTFAGnnJCoU5JsSnOToWMAR8D8CLsrokGTqRupS2WMVsZxLtH/ABVW2sgExT2g
 m0UsZd7YrsdjkS+bolmVX8tn37mS9ygmEutj160MHj9kwQjNWCi97JKeLgEmX1J88/BS
 VHPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=fJy+2QZmgWghPEPdi4fzKTpJEznTzrW1f/Pzs2aLFqk=;
 b=FCcFWwDRf/qTWE6VjLt4Q9WHL07DMJ7MG51MSnFU6fpIIo8Xlr2zBWGX7ESDVOSLtz
 qoDc1wjc26D3U/KjuBh0mLJ7HhAyqJWQp0/Av5eqAf7BxMlsOs7v9i417MWg5+NE38oP
 /aZkZ66m/5fvDVCAYwe3cW11qWvrlLZ/gqxZ7WCpBXMVAqCCGWzgJvnZpla/OVbEwWtc
 YCGzdJb1QHnZ1XsDcU6xsqrCl2aFg6cxU5MGF0/XRe463AnzMtO3KiXtDEN0C/bq5r4u
 m528slHZha1xo+1g31BjzWLuqYni71HJz0dj0oEewxRpo9j7myNpjpgbV4R4gKAys7ui
 f76A==
X-Gm-Message-State: AGi0PuY/ZmXWMCdQS4VF7/x573h8EH6hWrUB7zIyC/Tlo7GDY6bEJBIm
 eazqoas+CmJz+OidSdXeCGaJaM/+xKfU9lA=
X-Google-Smtp-Source: APiQypIQzFO4tzXCApTosemm1d7QItEcp5dCZRq6c3qYW5Qc6il0QsaGKyY5OQ6Ld3q+lesB95Gorw==
X-Received: by 2002:adf:e450:: with SMTP id t16mr37309979wrm.301.1588100329403; 
 Tue, 28 Apr 2020 11:58:49 -0700 (PDT)
Received: from Mem ([145.136.49.157])
 by smtp.gmail.com with ESMTPSA id f2sm27952125wro.59.2020.04.28.11.58.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2020 11:58:48 -0700 (PDT)
Date: Tue, 28 Apr 2020 20:58:48 +0200
From: Paul Chaignon <paul@cilium.io>
To: Julia Lawall <julia.lawall@inria.fr>
Message-ID: <20200428185846.GA11412@Mem>
References: <20200428101124.GA18321@Mem>
 <alpine.DEB.2.21.2004281943320.3273@hadrien>
 <20200428181746.GA8848@Mem>
 <alpine.DEB.2.21.2004282036540.3273@hadrien>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.2004282036540.3273@hadrien>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 28 Apr 2020 21:01:00 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 28 Apr 2020 20:58:49 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Tue, 28 Apr 2020 21:00:58 +0200
Cc: cocci@systeme.lip6.fr, paul.chaignon@gmail.com
Subject: Re: [Cocci] Using a macro for variable attributes
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

On Tue, Apr 28, 2020 at 08:41:08PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 28 Apr 2020, Paul Chaignon wrote:
> 
> > Thanks for the quick answer!
> >
> > On Tue, Apr 28, 2020 at 07:44:15PM +0200, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 28 Apr 2020, Paul Chaignon wrote:
> > >
> > > > Hi all,
> > > >
> > > > I am working on a small semantic patch to annotate specific variables in
> > > > our codebase with __attribute__((aligned(8))). The following program works
> > > > fine.
> > > >
> > > >   @r@
> > > >   expression e1, e2;
> > > >   identifier x;
> > > >   @@
> > > >   (
> > > >     struct \(icmphdr\|icmp6hdr\) x
> > > >   + __attribute__((aligned(8)))
> > > >     ;
> > > >   |
> > > >     struct \(icmphdr\|icmp6hdr\) x
> > > >   + __attribute__((aligned(8)))
> > > >     = ...;
> > > >   )
> > > >     ... when exists
> > > >     ctx_load_bytes(e1, e2, &x, ...)
> > > >
> > > > However, when I replace __attribute__((aligned(8))) with our internal
> > > > macro __align_stack_8, it fails with the following error:
> > > >
> > > >   plus: parse error:
> > > >     File "/home/paul/cilium/contrib/coccinelle/aligned.cocci", line 7, column 2, charpos = 77
> > > >     around = '__align_stack_8',
> > > >     whole content = + __align_stack_8
> > > >
> > > > I've tried adding '#define __align_stack_8' in a file passed with
> > > > --macro-file, without success. Is this a known limitation for macros or
> > > > am I missing something?
> > >
> > > Try adding the "metavariable" declaration:
> > >
> > > attribute name __align_stack_8;
> >
> > Awesome, that worked. And I think I understand: undeclared identifiers are by
> > default considered symbols, leading to the parse error.
> >
> > Unfortunately, my semantic patch now leads to the following changes:
> >
> >   -	struct icmphdr icmphdr __align_stack_8;
> >   +	struct icmphdr icmphdr __align_stack_8 __align_stack_8;
> >
> > I would normally add a first case to my conjunction to match on
> > already-present attributes, but Coccinelle can't match on attributes yet.
> > Any workaround?
> 
> Jaskaran is working on it.

Great! I'll keep a watch on new releases :-)

> A hackish solution would be to put a position variable on the variable
> name and put a position variable on the ; and then use python to see if
> they are not adjacent to each other...
> 
> Do you get a lot of occurrences of the problem?  In the short term it
> could be simpler to just clean it up by hand.  It should be easy to search
> for at least.

We don't have a lot of variables that need this annotation overall, but
I'm hoping to run the semantic patch as part of our CI pipeline.

In the medium term, I think I can just keep my current version (as above
but extended with positions and a Python error message). Because it
doesn't try to add missing attributes, it doesn't need the attribute name
and doesn't have the double annotation problem.

Thanks a lot for your help!

Cheers,
Paul

> 
> julia
> 
> 
> >
> > Paul
> >
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
