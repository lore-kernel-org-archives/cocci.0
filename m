Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 262F0C369CB
	for <cocci@archiver.kernel.org>; Sat, 26 Apr 2025 10:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Tta21mMLGTn3K2tn7y/mZmOLIBCqpI/zDg0q/+0iZrY=;
  b=KPmviNb3c2cXpL3bi8rXI/CTJfzO82/debOaE+hHYDa0RlqCpkLestlA
   6hFwi2CCbMkaHhUzVATntWJyH/BBYbigoqtQbkWGBh59+c9JQ7msNvEtR
   nN923MiN9F2POLcMRWHVx21P1+x9ySpCxGJoliTrJ2dDrrNeu0FsZ5XCv
   s=;
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,241,1739833200"; 
   d="scan'208";a="219554445"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Apr 2025 12:41:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0E784E0261; Sat, 26 Apr 2025 12:41:26 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CD284E007A
	for <cocci@sympa.inria.fr>; Sat, 26 Apr 2025 12:41:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Tta21mMLGTn3K2tn7y/mZmOLIBCqpI/zDg0q/+0iZrY=;
  b=BsxY6/GIz4yYQnPeJ4rraSi74jJFmOXgRQ8FBe86HvDPPB6vsN02m5e1
   tm8WoafQPSrgoQtF4FVmIWrpJIFS7IWaPEgAHQ+Ey0tpQCzaDNhoKTbvO
   oqMz/3NLoFM5mf0TL+f7gIfxzN+r5KGhZ8Zh+qReTtC5gIXzG9NDu/BC/
   E=;
X-IronPort-AV: E=Sophos;i="6.15,241,1739833200"; 
   d="scan'208";a="219554437"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2025 12:41:23 +0200
Date: Sat, 26 Apr 2025 12:41:23 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Andrew Morton <akpm@linux-foundation.org>
cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org, 
    linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
    Mark Rutland <mark.rutland@arm.com>, 
    Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Ingo Molnar <mingo@redhat.com>, x86@kernel.org, 
    Kees Cook <kees@kernel.org>, bpf@vger.kernel.org, 
    Tejun Heo <tj@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
In-Reply-To: <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
Message-ID: <alpine.DEB.2.22.394.2504261157210.3375@hadrien>
References: <20250425204120.639530125@goodmis.org> <20250425161449.7a2516b3fe0d5de3e2d2b677@linux-foundation.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [RFC][PATCH 0/2] Add is_user_thread() and
 is_kernel_thread() helper functions
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2723
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/alpine.DEB.2.22.394.2504261157210.3375%40hadrien>



On Fri, 25 Apr 2025, Andrew Morton wrote:

> On Fri, 25 Apr 2025 16:41:20 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > While working on the deferred stacktrace code, Peter Zijlstra told
> > me to use task->flags & PF_KTHREAD instead of checking task->mm for NULL.
> > This seemed reasonable, but while working on it, as there were several
> > places that check if the task is a kernel thread and other places that
> > check if the task is a user space thread I found it a bit confusing
> > when looking at both:
> >
> > 	if (task->flags & PF_KTHREAD)
> > and
> > 	if (!(task->flags & PF_KTHREAD))
> >
> > Where I mixed them up sometimes, and checked for a user space thread when I
> > really wanted to check for a kernel thread. I found these mistakes before
> > sending out my patches, but going back and reviewing the code, I always had
> > to stop and spend a few unnecessary seconds making sure the check was
> > testing that flag correctly.
> >
> > To make this a bit more obvious, I introduced two helper functions:
> >
> > 	is_user_thread(task)
> > 	is_kernel_thread(task)
> >
> > which simply test the flag for you. Thus, seeing:
> >
> > 	if (is_user_thread(task))
> > or
> > 	if (is_kernel_thread(task))
> >
> > it was very obvious to which test you wanted to make.
>
> Seems sensible.  Please consider renaming PF_KTHREAD in order to break
> missed conversion sites.

Maybe:

@r depends on !(file in "include/linux/sched.h")@ // Kees's suggestion
position p;
expression e;
@@

(
e = (PF_KTHREAD | ...)
|
e |= (PF_KTHREAD | ...)
|
PF_KTHREAD@p
)

@script:ocaml@ // change to python if desired
p << r.p;
@@

Printf.printf "%s:%d: Warning: remaining use of PF_KTHREAD\n" (List.hd p).file (List.hd p).line

julia

