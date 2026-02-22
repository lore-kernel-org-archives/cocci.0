Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06260C624A6
	for <cocci@archiver.kernel.org>; Sun, 22 Feb 2026 09:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=jU7N+0FZIxmxEwn1Lp5kVygLKRMnvrCrP1wvwY45zN8=;
  b=nw5VKC+GEMEtxOU8gbwmknXAg9Gd5TByNRKzLy4PJLWiXyLnf1TsnqOP
   6VAOV2xn1Vznm6KkUzyPCz2zOgMV2prOUbdNIJH3vMz7XzcHr/lAgGGqb
   zF2jl4n0r3ez2pofX0HKtXTD7K2R8dpDbrpXtRVcUISw5o614G+ttVA5D
   E=;
X-CSE-ConnectionGUID: NqtQu7h5TgSyOua+Tl6kHw==
X-CSE-MsgGUID: sC7GIlv/QGCKOHm6Hdi+oA==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="264582630"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 22 Feb 2026 10:31:46 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 9BEEB8065B; Sun, 22 Feb 2026 10:31:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 32AED80139
	for <cocci@sympa.inria.fr>; Sun, 22 Feb 2026 10:31:43 +0100 (CET)
X-CSE-ConnectionGUID: vaOREB1kR4erODUIhCjHtw==
X-CSE-MsgGUID: 48AynL+nT8SXUoCsDo0xsg==
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="264582621"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 10:31:42 +0100
Date: Sun, 22 Feb 2026 10:31:42 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Eric Biggers <ebiggers@kernel.org>
cc: Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Randy Dunlap <rdunlap@infradead.org>, Miguel Ojeda <ojeda@kernel.org>, 
    Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
    "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
    Matthew Wilcox <willy@infradead.org>, John Hubbard <jhubbard@nvidia.com>, 
    Joe Perches <joe@perches.com>, Christoph Lameter <cl@linux.com>, 
    Marco Elver <elver@google.com>, Vegard Nossum <vegard.nossum@oracle.com>, 
    Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>, 
    Joonsoo Kim <iamjoonsoo.kim@lge.com>, 
    Andrew Morton <akpm@linux-foundation.org>, 
    Roman Gushchin <roman.gushchin@linux.dev>, 
    Harry Yoo <harry.yoo@oracle.com>, Bill Wendling <morbo@google.com>, 
    Justin Stitt <justinstitt@google.com>, Jann Horn <jannh@google.com>, 
    Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
    Sasha Levin <sashal@kernel.org>, linux-mm@kvack.org, 
    Nathan Chancellor <nathan@kernel.org>, 
    Peter Zijlstra <peterz@infradead.org>, 
    Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
    Jonathan Corbet <corbet@lwn.net>, Jakub Kicinski <kuba@kernel.org>, 
    Yafang Shao <laoar.shao@gmail.com>, 
    Tony Ambardar <tony.ambardar@gmail.com>, 
    Alexander Lobakin <aleksander.lobakin@intel.com>, 
    Jan Hendrik Farr <kernel@jfarr.cc>, 
    Alexander Potapenko <glider@google.com>, linux-kernel@vger.kernel.org, 
    linux-hardening@vger.kernel.org, linux-doc@vger.kernel.org, 
    llvm@lists.linux.dev
In-Reply-To: <20260222041324.GA10695@sol>
Message-ID: <c6ae637-a2de-7919-e9b5-42cd47ddc1a5@inria.fr>
References: <20251203233029.it.641-kees@kernel.org> <20251203233036.3212363-5-kees@kernel.org> <20260222041324.GA10695@sol>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3307
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/gZmEIZx1GciQmnhtb8Zj0Q>



On Sat, 21 Feb 2026, Eric Biggers wrote:

> On Wed, Dec 03, 2025 at 03:30:35PM -0800, Kees Cook wrote:
> > Finds and converts sized kmalloc-family of allocations into the
> > typed kmalloc_obj-family of allocations.
> >
> > Signed-off-by: Kees Cook <kees@kernel.org>
> > ---
> > Cc: Julia Lawall <Julia.Lawall@inria.fr>
> > Cc: Nicolas Palix <nicolas.palix@imag.fr>
> > Cc: cocci@inria.fr
> > ---
> >  scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
> >  1 file changed, 109 insertions(+)
> >  create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci
>
> Is there a way to reproduce commit 69050f8d6d075dc using this semantic
> patch as claimed?  I spend a while installing the latest version of
> spatch (which was quite hard to do due to all the unusual dependencies),
> but it complains that no rules apply:

I guess you would have to write on the command line -D patch?

julia

>
> $ /usr/local/bin/spatch --sp-file scripts/coccinelle/api/kmalloc_objs.cocci --dir . --in-place
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> SPECIAL NAMES: adding u8 as a type
> SPECIAL NAMES: adding u16 as a type
> SPECIAL NAMES: adding u32 as a type
> SPECIAL NAMES: adding u64 as a type
> SPECIAL NAMES: adding __u8 as a type
> SPECIAL NAMES: adding __u16 as a type
> SPECIAL NAMES: adding __u32 as a type
> SPECIAL NAMES: adding __u64 as a type
> SPECIAL NAMES: adding uint8_t as a type
> SPECIAL NAMES: adding uint16_t as a type
> SPECIAL NAMES: adding uint32_t as a type
> SPECIAL NAMES: adding uint64_t as a type
> SPECIAL NAMES: adding uchar as a type
> SPECIAL NAMES: adding ushort as a type
> SPECIAL NAMES: adding uint as a type
> SPECIAL NAMES: adding ulong as a type
> SPECIAL NAMES: adding __le16 as a type
> SPECIAL NAMES: adding __le32 as a type
> SPECIAL NAMES: adding __le64 as a type
> SPECIAL NAMES: adding __be16 as a type
> SPECIAL NAMES: adding __be32 as a type
> SPECIAL NAMES: adding __be64 as a type
> SPECIAL NAMES: adding wchar_t as a type
> No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* code, or you have a failed dependency.  If the problem is not clear, try --debug-parse-cocci or check whether any virtual rules (e.g., patch) should be defined.
>
