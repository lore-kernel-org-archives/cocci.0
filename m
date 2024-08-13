Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A16C52D7C
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2024 11:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=5SZacNjEaUvE74idtyHWd+oMjEwhdm+9QyXOmNj5G84=;
  b=IR/WmRNgTETPCInJDoysESgzFpYM0dFddT6zhrf1IQbtBktpatumJGfD
   0fTgkif37W2Lk4YtCwAFGPTlFg0TrMd15/FqSduUCOpK3cZ/xZ+GqezKw
   1FvHgEx/VP4EGF9iRySyqp4bg88z/JYxy76V1G2RV9Ns6RzejZLQol8aB
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="178876337"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Aug 2024 13:20:00 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 45BB2E0CD0; Tue, 13 Aug 2024 13:20:00 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 4CC7BE0035
	for <cocci@sympa.inria.fr>; Tue, 13 Aug 2024 13:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5SZacNjEaUvE74idtyHWd+oMjEwhdm+9QyXOmNj5G84=;
  b=A4Y8y1HqSH42euIaV3S15EVAYyOmQtwGff8X36vRBxZW/303keJV9e6S
   kPP0GVGWpJNUzmiQZ4cGn/Cew0fJXMzV05mDnQGm0wQGdo7K0mi3C9R8V
   t7ZWdw4fuvy3jAYvJnHomfdHlqbSisVvXkI8dhUCWxIFZ5BCPGVNT+6A0
   c=;
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="178876335"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:19:59 +0200
Date: Tue, 13 Aug 2024 13:19:59 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Andrzej Hajda <andrzej.hajda@intel.com>
cc: Peter Senna Tschudin <peter.senna@gmail.com>, 
    Peter Senna Tschudin <peter.senna@linux.intel.com>, cocci@inria.fr
In-Reply-To: <03d047e0-577c-4c39-b75e-6f8fb998ae57@intel.com>
Message-ID: <54eddab3-1f35-2159-da93-b8668f47149a@inria.fr>
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com> <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr> <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com> <1e637cb0-24cd-dc10-9178-69f314598ce@inria.fr>
 <03d047e0-577c-4c39-b75e-6f8fb998ae57@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1168627866-1723547999=:29894"
Subject: Re: [cocci] Iterator macros
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1852
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/54eddab3-1f35-2159-da93-b8668f47149a%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1168627866-1723547999=:29894
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Tue, 13 Aug 2024, Andrzej Hajda wrote:

>
>
> On 13.08.2024 08:34, Julia Lawall wrote:
> >
> > On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:
> >
> > > Hi Julia,
> > >
> > >
> > >
> > > On Tue, Aug 13, 2024 at 8:19 AM Julia Lawall <julia.lawall@inria.fr>
> > > wrote:
> > >
> > >
> > >        On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:
> > >
> > >        > Dear List,
> > >        >
> > >        > I am trying to make changes to a macro iterator from
> > >        igt-gpu-tools*, and I am failing to use Coccinelle. My current
> > >        attempt only captures about 1/2 of call sites, and I am not
> > >        really sure how to ask Coccinelle to make the changes I want.
> > >        Here is the pattern I am trying to change:
> > >        >
> > >        >
> > >        > From:
> > >        >
> > >        > const struct intel_execution_engine2 *e2;
> > >        > ...
> > >        > for_each_ctx_engine(i915, ctx, e2) {
> > >        >     execbuf.flags = e2->flags;
> > >        >     gem_execbuf(i915, &execbuf);
> > >        > }
> > >        >
> > >        >
> > >        > To:
> > >        >
> > >        > struct intel_engine_data ied;
> > >        > ...
> > >        > for_each_ctx_engine(i915, ctx, ied) {
> > >        >     execbuf.flags = ied.current_engine->flags;
> > >        >     gem_execbuf(i915, &execbuf);
> > >        > }
> > >        >
> > >        > Changes I want:
> > >        > 1. From `const struct intel_execution_engine2 *e2` to `struct
> > >        intel_engine_data ied`.
> > >        > 2. Replace the last argument of for_each_ctx_engine()
> > >        following the change on previous step.
> > >        > 3. Change references from `e2` to `ied.current_engine` inside
> > >        the iterator statement.
> > >        >
> > >        > Here is my starting point that finds about half of the call
> > >        sites:
> > >        >
> > >        > @r1@
> > >        > iterator I =~ "for_each_ctx_engine";
> > >        > statement S;
> > >        > @@
> > >        > * I(...)
> > >        > S
> > >        >
> > >        > I assume that I should create other rules and import I from r1
> > >        as the
> > >        > core of the changes I want. Can you point me to an example to
> > >        help me
> > >        > here?
> > >
> > >        Are you just looking for
> > >
> > >        iterator r.I;
> > >
> > >        If you have only one iterator name, you don't need the regexp.
> > >        Just put
> > >
> > >        iterator name for_each_ctx_engine;
> > >
> > > Thank you! This is much faster but captures one instance less.
> > You can use multiple names like
> >
> > (name1@I|name2@I|name3@I)(...) S
> >
> > The you can use r.I in your other rules.  name1 etc would be iterator name
> > and I would be iterator.
>
> I guess the issue here could be a problem with parsing igt code (it is also an
> issue with kernel drivers using iterators).
> Cocci quite often does not recognize automatically iterators or other
> constructs, and does not scan them at all.
> Try run for example:
> $ spatch --parse-c tests/intel/gem_ctx_exec.c
> ...
> NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
> nb good = 385,  nb passed = 19 =========> 3.12% passed
> nb good = 385,  nb bad = 204 =========> 66.45% good or passed
>
> As I understand, lines marked as "bad" are skipped during cocci pass, am I
> right?
> Some workaround is to define iterators by hand in the script or include files.

Coccinelle has some heuristics for detecting iterators, typically tarting
with "for" and having the indentation of a for loop.

In a .h file provided with --macro-file-builtins, it seems that you can
use YACFE_ITERATOR, but there is currently no example of that.

Finally, if you declare an iterator name in your semantic patch, that
information will be propagated to the parsing of the C code.  On the other
hand, Peter's initial regexp solution would not have triggered that.
Perhaps his performance improvement was actually due to being able to
parse the code immediately rather than iterating over some heuristics.

julia

>
> Regards
> Andrzej
>
> >
> > julia
> >
> > >
> > >        julia
> > >
> > >        >
> > >        > Thank you,
> > >        >
> > >        > Peter
> > >        >
> > >        > * - https://gitlab.freedesktop.org/drm/igt-gpu-tools
> > >        >
> > >
> > >
> > >
> > > --
> > >                           Peter
> > >
> > >
>
>
--8323329-1168627866-1723547999=:29894--
