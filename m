Return-Path: <SRS0=qIOj=GO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18D32C433E0
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 20:40:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A5B722CF7
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 20:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A5B722CF7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BKeYgo025546;
	Mon, 11 Jan 2021 21:40:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C291877B8;
	Mon, 11 Jan 2021 21:40:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 67F6B74B6
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 21:40:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BKeVv3004204
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 21:40:31 +0100 (CET)
X-IronPort-AV: E=Sophos;i="5.79,339,1602540000"; d="scan'208";a="486525900"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail2-relais-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 11 Jan 2021 21:40:31 +0100
Date: Mon, 11 Jan 2021 21:40:31 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Denis Efremov <efremov@linux.com>
In-Reply-To: <a9c270d0-19c4-0357-173f-a2f9c8a1d7ce@linux.com>
Message-ID: <alpine.DEB.2.22.394.2101112135260.15982@hadrien>
References: <854fdad7-cf2d-49d8-571c-1ac64fa90fb6@linux.com>
 <alpine.DEB.2.22.394.2101112122350.15982@hadrien>
 <a9c270d0-19c4-0357-173f-a2f9c8a1d7ce@linux.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 21:40:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 21:40:31 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] How to match function-like macro calls,
 e.g. RTA_ALIGN(rta->rta_len)?
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



On Mon, 11 Jan 2021, Denis Efremov wrote:

>
>
> On 1/11/21 11:23 PM, Julia Lawall wrote:
> >
> >
> > On Mon, 11 Jan 2021, Denis Efremov wrote:
> >
> >> Hi,
> >>
> >> Let's suppose I want to match otx_cpt_aead_cbc_aes_sha_setkey() function from
> >> drivers/crypto/marvell/octeontx/otx_cptvf_algs.c file (linux kernel).
> >>
> >> My pattern:
> >> @exists@
> >> identifier rta, param, key, keylen;
> >> position p;
> >> @@
> >>
> >> otx_cpt_aead_cbc_aes_sha_setkey(...,
> >> 	unsigned char *key, unsigned int keylen)
> >> {
> >> 	...
> >> *	if (RTA_PAYLOAD(rta) < sizeof(*param))@p
> >> 		goto badkey;
> >> 	...
> >> *	key += RTA_ALIGN(rta->rta_len);
> >> *	keylen -= RTA_ALIGN(rta->rta_len);
> >> 	...
> >> }
> >>
> >> $ spatch --no-includes --include-headers --cocci-file test.cocci drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
> >> init_defs_builtins: /usr/lib64/coccinelle/standard.h
> >> minus: parse error:
> >>   File "test.cocci", line 13, column 9, charpos = 219
> >>   around = 'RTA_ALIGN',
> >>   whole content = *     key += RTA_ALIGN(rta->rta_len);
> >>
> >>
> >> What can I do to match RTA_ALIGN(...) lines?
> >
> > I don't understand the problem.  I took your rule and your command line,
> > and everything was fine.
>
> I use version:
> spatch version 1.0.8-gc1dbb4f-dirty compiled with OCaml version 4.11.1
> Flags passed to the configure script: --build=x86_64-redhat-linux-gnu --host=x86_64-redhat-linux-gnu --program-prefix= --disable-dependency-tracking --prefix=/usr --exec-prefix=/usr --bindir=/usr/bin --sbindir=/usr/sbin --sysconfdir=/etc --datadir=/usr/share --includedir=/usr/include --libdir=/usr/lib64 --libexecdir=/usr/libexec --localstatedir=/var --sharedstatedir=/var/lib --mandir=/usr/share/man --infodir=/usr/share/info --with-python=/usr/bin/python3 --with-menhir=/usr/bin/menhir
> OCaml scripting support: yes
> Python scripting support: yes
> Syntax of regular expressions: PCRE
>
> Maybe parsing error is fixed in new versions?

I can't imagine what would cause a parsing error here.  I don't see what
could be special about RTA_ALIGN.  Normally Coccinelle doesn't even know
that it is a macro.  Maybe you can try to simplify the semantic patch a
little bit and see if there is some change that causes the problem to
disappear?  Does the problem disappear if you use a name other than
RTA_ALIGN?

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
