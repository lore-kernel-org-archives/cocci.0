Return-Path: <SRS0=LaBa=KW=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3642C4707F
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 13:50:22 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09992613BF
	for <cocci@archiver.kernel.org>; Thu, 27 May 2021 13:50:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09992613BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=inria.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 14RDoHYF028334;
	Thu, 27 May 2021 15:50:17 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8E7797737;
	Thu, 27 May 2021 15:50:17 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E38977648
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 15:50:15 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 14RDoCEg019978
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 27 May 2021 15:50:13 +0200 (CEST)
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A55KG2q2sA0v/dW5FMfa/7QqjBI0kLtp133Aq?=
 =?us-ascii?q?2lEZdPWaSL3gqynOpoVi6faQslwssR4b6LW90cW7MBHhHNtOkOos1NSZPTUO2l?=
 =?us-ascii?q?HYSL2KhLGKq1bd8m/FltK1vp0QFJSWZueAa2SSTvyX3OB7KbsdKRW8n5xATN2x?=
 =?us-ascii?q?80tQ?=
X-IronPort-AV: E=Sophos;i="5.82,334,1613430000"; d="scan'208";a="382649256"
Received: from 173.121.68.85.rev.sfr.net (HELO hadrien) ([85.68.121.173])
 by mail3-relais-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 27 May 2021 15:50:12 +0200
Date: Thu, 27 May 2021 15:50:12 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Fuad Tabba <tabba@google.com>
In-Reply-To: <CA+EHjTwCjzn_gdY8VQs8D35tQ6-gSc6HTCdHC6TFvvKzohNagw@mail.gmail.com>
Message-ID: <alpine.DEB.2.22.394.2105271548230.16566@hadrien>
References: <CA+EHjTzCieJgFQOgiP5YQWurpV9dOj=bw+jF=GsTtum4vy67Ag@mail.gmail.com>
 <alpine.DEB.2.22.394.2105271224160.12673@hadrien>
 <alpine.DEB.2.22.394.2105271225320.12673@hadrien>
 <CA+EHjTyvwxsFgYAUtVbo3UdhNHaqvx6rPfGLDyFX_WPN1m=XRg@mail.gmail.com>
 <alpine.DEB.2.22.394.2105271305530.12673@hadrien>
 <CA+EHjTwCjzn_gdY8VQs8D35tQ6-gSc6HTCdHC6TFvvKzohNagw@mail.gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 27 May 2021 15:50:17 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 27 May 2021 15:50:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Adding a line to a function after all variable
 declarations
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



On Thu, 27 May 2021, Fuad Tabba wrote:

> On Thu, May 27, 2021 at 12:44 PM Julia Lawall <julia.lawall@inria.fr> wrote:
> >
> > > @@
> > > expression a, b;
> > > identifier vcpu;
> > > fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
> > > iterator name kvm_for_each_vcpu;
> > > identifier fc;
> > > @@
> > > kvm_for_each_vcpu(a, vcpu, b)
> > >  {
> > > /* hop over any declarations */
> > > + vcpu_ctxt = &vcpu->arch.ctxt;
> > > <+...
> > > fc(..., vcpu, ...)
> > > ...+>
> > >  }
> > >
> > > So I'm trying to add the line "vcpu_ctxt = &vcpu->arch.ctxt" after any
> > > declarations, only if there's a function in that block that's using
> > > vcpu. This works, but the vcpu_ctxt assignment is of course always
> > > added first, before any declarations.
> > >
> > > Doing the following partially works, but it of course misses the case
> > > where the function call with vcpu comes immediately after the
> > > vcpu_ctxt assignment. Removing S2 altogether gives me a parse error.
> > >
> > > @@
> > > expression a, b;
> > > identifier vcpu;
> > > fresh identifier vcpu_ctxt = vcpu ## "_ctxt";
> > > iterator name kvm_for_each_vcpu;
> > > identifier fc;
> > > statement S1, S2;
> > > @@
> > > kvm_for_each_vcpu(a, vcpu, b)
> > >  {
> > >  ... when != S1
> > > + vcpu_ctxt = &vcpu->arch.ctxt;
> > >  S2;
> > > <+...
> > > fc(..., vcpu, ...)
> > > ...+>
> > >  }
> >
> > @@
> > identifier f;
> > statement S1,S2;
> > @@
> >
> > f(...) {
> > ... when != S1
> > (
> > + new_code
> > S2
> > ... when any
> > &
> > <+...
> > fc(..., vcpu, ...)
> > ...+>
> > )
> > }
>
> I get a parse error when I try that (both copying it verbatim, or
> adapting it to my code):
>
> minus: parse error:
>   File "test.cocci", line 18, column 0, charpos = 209
>   around = '<+...',
>   whole content = <+...

OK, perhaps that is a corner that is not supported.  It might work bettwe
with

... when any
    when exists
fc(..., vcpu, ...)
... when any

in place of the <+... ...+>

But since you have a satisfactory solution, that is fine too.

julia
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
