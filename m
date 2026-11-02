Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1D3606A336
	for <cocci@archiver.kernel.org>; Mon,  2 Nov 2026 09:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=kVKBMkq/
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=6HEVlUXJ0ULaPW/OwxmHWHvY0QEmaSvRkCaARK7rRpQ=;
  b=kVKBMkq/4mFB5PCWOqCWt0SFsOvnDNnTTjFjS1+/sl3DefZfRxD8fH87
   xvFkfPDddfXpjuE/rSfr6aYdpUJDaDZlxaR0GqRS5nTsA0lC6M31xwMwL
   Cy9ADhk3/L4SjhM3EJvuD8c2fEjP8tQTc3AkUX18UM0OfQmGfakXt49KM
   4=;
X-CSE-ConnectionGUID: 2qmq7GCbRgy7qW7HKXCBxg==
X-CSE-MsgGUID: 8G1gxBniRKqHuw01nLp3UA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="303298547"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2026 10:08:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 99B7A819CB; Mon,  2 Nov 2026 10:08:54 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id A8AD0819A6
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 10:08:53 +0100 (CET)
X-CSE-ConnectionGUID: FIpH9G/JShiE/esooVp5kQ==
X-CSE-MsgGUID: fikoLBn9Tyua+AjFAnKiiQ==
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="161464340"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 10:08:53 +0100
Date: Mon, 2 Nov 2026 10:08:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Ella Ma <alansnape3058@gmail.com>
cc: cocci@inria.fr, linux-kernel@vger.kernel.org, nicolas.palix@imag.fr
In-Reply-To: <20261102090137.6brrzpq2zohop2il@ptb-02009389.paris.inria.fr>
Message-ID: <d1843a68-de61-2e6a-5e1-0966294a6e6@inria.fr>
References: <ec578f57-a7f5-7afc-ec2-9156c336187@inria.fr> <20261007164316.15102-1-alansnape3058@gmail.com> <f635d9fd-8dd5-47f-7996-239bc74bd828@inria.fr> <20261016135718.ab5322cdyozostuj@ptb-02009389.paris.inria.fr> <cd96489d-e980-c4a-9990-7a96e8b31ea@inria.fr>
 <20261102090137.6brrzpq2zohop2il@ptb-02009389.paris.inria.fr>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v3] coccinelle: free: add a checker for
 `__cleanup(kfree)` usage
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3760
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/UvXlmUBCf9sU61PSOH2Taw>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Mon, 2 Nov 2026, Ella Ma wrote:

> On Mon, Nov 02, 2026 at 12:46:11AM +0100, Julia Lawall wrote:
> >
> >
> > On Fri, 16 Oct 2026, Ella Ma wrote:
> >
> > > On Wed, Oct 07, 2026 at 08:27:33PM +0200, Julia Lawall wrote:
> > > >
> > > >
> > > > On Wed, 7 Oct 2026, Ella Ma wrote:
> > > >
> > > > > Using __cleanup(kfree) will pass the stack address of the annotated
> > > > > local variable to kfree functions. This will lead to invalid
> > > > > deallocation issues. Inspired by CVE-2026-45959 and similar bugs
> > > > > recently detected.
> > > > >
> > > > > Signed-off-by: Ella Ma <alansnape3058@gmail.com>
> > > > > ---
> > > > >
> > > > > Changes in v2:
> > > > > - Add virtual rules `report` and `org` as suggested by Sashiko
> > > > > - Remove `kvfree_sensitive` from rule `cleanup` as suggested by Sashiko
> > > > > - Add `free_percpu` to rule `free`
> > > > > - Add `kfree_const` to rule `cleanup`
> > > > >
> > > > > Changes in v3:
> > > > > - Edit the error messages to clarify the reasons and results
> >
> > I applied this, but I changed the first error message to:
> >
> > "ERROR: __cleanup({n}) will cause an invalid free: the stack address of
> > the annotated variable will be passed to {n}; declare the variable using
> > __free({n}) to cause the pointee to be freed"
> >
> > The original message made it look like one should use __free when calling
> > kfree.
>
> OK. Thank you for the change.
>
> >
> > Furthermore, there is one report in the kernel for this case.  It would be
> > worth fixing it or checking whether it is dead code (it's immediately
> > under an ifdef).
>
> A patch fixing it has been reviewed by Thomas Huth <thuth@redhat.com> in
> https://lore.kernel.org/lkml/ffebbb7b-a4f9-488e-8834-199da3073b96@redhat.com/
> Should I reply something to the thread about this new coccinelle report?

No need, I was just wondering.

julia

>
> ella
>
> >
> > julia
> >
> >
> > > > >
> > > > >  scripts/coccinelle/free/cleanup-free.cocci | 112 +++++++++++++++++++++
> > > > >  1 file changed, 112 insertions(+)
> > > > >  create mode 100644 scripts/coccinelle/free/cleanup-free.cocci
> > > > >
> > > > > diff --git a/scripts/coccinelle/free/cleanup-free.cocci b/scripts/coccinelle/free/cleanup-free.cocci
> > > > > new file mode 100644
> > > > > index 000000000000..48e47ed2186a
> > > > > --- /dev/null
> > > > > +++ b/scripts/coccinelle/free/cleanup-free.cocci
> > > > > @@ -0,0 +1,112 @@
> > > > > +// SPDX-License-Identifier: GPL-2.0-only
> > > > > +///
> > > > > +/// Find __cleanup(kfree)
> > > > > +/// Using __cleanup(kfree) will pass the stack address of the annotated
> > > > > +/// local variable to kfree, causing an invalid free.
> > > > > +/// I.e., `T v __cleanup(kfree);` --> `kfree(&v);`
> > > > > +/// Such usage is impossible to be correct.
> > > > > +///
> > > > > +// Confidence: High
> > > > > +// Copyright: (C) 2026 Ella Ma
> > > > > +// Options: --no-includes --include-headers
> > > > > +
> > > > > +virtual report
> > > > > +virtual org
> > > > > +
> > > > > +// Suggesting using __free for the functions with a DEFINE_FREE definition.
> > > > > +// Update this list when new DEFINE_FREE definitions are added.
> > > > > +@free@
> > > > > +attribute name __cleanup;
> > > > > +symbol kfree, kfree_sensitive, kvfree, kvfree_atomic, free_percpu;
> > > > > +type T;
> > > > > +identifier v, n;
> > > > > +position p;
> > > > > +@@
> > > > > +
> > > > > +(
> > > > > +  T v __cleanup@p(
> > > > > +(
> > > > > +  n
> > > > > +&
> > > > > +(
> > > > > +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> > > > > +)
> > > > > +)
> > > > > +  );
> > > > > +|
> > > > > +  T v __cleanup@p(
> > > > > +(
> > > > > +  n
> > > > > +&
> > > > > +(
> > > > > +  kfree \| kfree_sensitive \| kvfree \| kvfree_atomic \| free_percpu
> > > > > +)
> > > > > +)
> > > > > +  ) = ...;
> > > > > +)
> > > > > +
> > > > > +@script:python depends on report@
> > > > > +p << free.p;
> > > > > +n << free.n;
> > > > > +@@
> > > > > +
> > > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> > > > > +coccilib.report.print_report(p[0], msg)
> > > > > +
> > > > > +@script:python depends on org@
> > > > > +p << free.p;
> > > > > +n << free.n;
> > > > > +@@
> > > > > +
> > > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}; use __free({n}) to free the pointee"
> > > > > +coccilib.org.print_todo(p[0], msg)
> > > > > +
> > > > > +
> > > > > +// Reporting __cleanup usage for the functions without a DEFINE_FREE definition.
> > > > > +// The following list only contains frequently used functions. Supplement it if
> > > > > +// necessary.
> > > > > +@cleanup@
> > > > > +attribute name __cleanup;
> > > > > +symbol vfree, vfree_atomic, kfree_const;
> > > > > +type T;
> > > > > +identifier v, n;
> > > > > +position p;
> > > > > +@@
> > > > > +
> > > > > +(
> > > > > +  T v __cleanup@p(
> > > > > +(
> > > > > +  n
> > > > > +&
> > > > > +(
> > > > > +  vfree \| vfree_atomic \| kfree_const
> > > > > +)
> > > > > +)
> > > > > +  );
> > > > > +|
> > > > > +  T v __cleanup@p(
> > > > > +(
> > > > > +  n
> > > > > +&
> > > > > +(
> > > > > +  vfree \| vfree_atomic \| kfree_const
> > > > > +)
> > > > > +)
> > > > > +  ) = ...;
> > > > > +)
> > > > > +
> > > > > +@script:python depends on report@
> > > > > +p << cleanup.p;
> > > > > +n << cleanup.n;
> > > > > +@@
> > > > > +
> > > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> > > > > +coccilib.report.print_report(p[0], msg)
> > > >
> > > > Hello, this is more words, but is not what I was hoping for.  You explain
> > > > the effect, but not the cause.  And to fix the bug with confidence the
> > > > reader wants to know the cause.  Here I would have expected something like
> > > > "__cleanup usage for a function without a DEFINE_FREE definition. This will cause an invalid free"
> > >
> > > Do you mean only the second rule needs a refinement, or both rules?
> > >
> > > ==> __cleanup vs __free, both rules:
> > >
> > > Using DEFINE_FREE declarer only defines a forwarding function that can
> > > be annotated to a local variable via __free attribute. Defining such a
> > > function with DEFINE_FREE will not automatically make __cleanup correct.
> > > User still need to use __free instead.
> > >
> > > FYI: __cleanup will pass the stack address to the annotated function
> > > directly; while __free will first call the forwarding function defined
> > > with DEFINE_FREE, and then the forwarding function will correctly pass
> > > the pointee address to the annotated function.
> > >
> > > ==> Only the second rule:
> > >
> > > Yes. For the functions without a forwarding function definition, one of
> > > the root cause is lacking the definition. But I am not sure whether this
> > > semantic patch should suggest adding one.  As these free functions are
> > > all those frequently used, perhaps the DEFINE_FREE definition should be
> > > added to the corresponding public header files.  Or, do you mean this
> > > semantic rule only needs to report this missing, and the users will add
> > > them where they think is good?
> > >
> > > Besides, after adding a definition, the current error message will
> > > become misleading, as there are no rules to search for existing
> > > DEFINE_FREE definitions in the code base. Do you think it is necessary
> > > for this semantic patch to search for the corresponding DEFINE_FREE
> > > definitions first and then generate the error message accordingly?
> > >
> > > I.e.,
> > > with DEFINE_FREE:
> > > requiring replacing __cleanup with __free.
> > > without DEFINE_FREE:
> > > reporting missing DEFINE_FREE and also requiring replacing __cleanup
> > > with __free.
> > >
> > > ella
> > >
> > > >
> > > > julia
> > > >
> > > >
> > > > > +
> > > > > +@script:python depends on org@
> > > > > +p << cleanup.p;
> > > > > +n << cleanup.n;
> > > > > +@@
> > > > > +
> > > > > +msg = f"ERROR: __cleanup({n}) will cause an invalid free: the stack address of the annotated variable will be passed to {n}"
> > > > > +coccilib.org.print_todo(p[0], msg)
> > > > > --
> > > > > 2.34.1
> > > > >
> > > > >
> > >
>
