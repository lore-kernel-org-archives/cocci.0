Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB6D7D637B3
	for <cocci@archiver.kernel.org>; Tue, 16 Dec 2025 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=4hFe0Tf5kPTvVQt6GjVYTuMYv34fhcLZszt7yKbypcE=;
  b=Vv392viV650YyivRB6ujK5sJd/P78Rc6T29ql2XCnJ8vXB9xCbQw5Z3S
   bmnZI+ieTvbuww30NVgk3ItoxU/P2uweLVUPqaQHIkbsjclrCTWYX63Ad
   PmuwLmfAiSMFydTqDYbp7UFqfUuKoNnr+fB1T8iqm/kiP7YNJJidQKnre
   g=;
X-CSE-ConnectionGUID: VSWvk/sKQ1O7SDV+nvv2Dw==
X-CSE-MsgGUID: fS2u2lg4R9mwMuwP5CYCHw==
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
X-IronPort-AV: E=Sophos;i="6.21,154,1763420400"; 
   d="scan'208";a="254782147"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Dec 2025 22:57:04 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2534281CF4; Tue, 16 Dec 2025 22:57:04 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 7E14C80288
	for <cocci@sympa.inria.fr>; Tue, 16 Dec 2025 22:57:01 +0100 (CET)
X-CSE-ConnectionGUID: XOW00uDeQLq1zCiinoX62Q==
X-CSE-MsgGUID: f+q89m9cRzC9em7sw3lJKg==
X-IronPort-AV: E=Sophos;i="6.21,154,1763420400"; 
   d="scan'208";a="133900367"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Dec 2025 22:56:58 +0100
Date: Tue, 16 Dec 2025 22:56:57 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Kees Cook <kees@kernel.org>
cc: Vlastimil Babka <vbabka@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>, 
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
In-Reply-To: <20251203233036.3212363-5-kees@kernel.org>
Message-ID: <bfaeb31e-1b4-4e8-6059-907bb27124e0@inria.fr>
References: <20251203233029.it.641-kees@kernel.org> <20251203233036.3212363-5-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3266
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/SrIqcnWXd83UkhWCUlXqxA>



On Wed, 3 Dec 2025, Kees Cook wrote:

> Finds and converts sized kmalloc-family of allocations into the
> typed kmalloc_obj-family of allocations.

The combination of the use of a regular expression to find the function
names and the big disjunction makes this unnecessarily slow.  I will try
to propose something shortly.

julia

>
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Julia Lawall <Julia.Lawall@inria.fr>
> Cc: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: cocci@inria.fr
> ---
>  scripts/coccinelle/api/kmalloc_objs.cocci | 109 ++++++++++++++++++++++
>  1 file changed, 109 insertions(+)
>  create mode 100644 scripts/coccinelle/api/kmalloc_objs.cocci
>
> diff --git a/scripts/coccinelle/api/kmalloc_objs.cocci b/scripts/coccinelle/api/kmalloc_objs.cocci
> new file mode 100644
> index 000000000000..916cc3a661b9
> --- /dev/null
> +++ b/scripts/coccinelle/api/kmalloc_objs.cocci
> @@ -0,0 +1,109 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use kmalloc_obj family of macros for allocations
> +///
> +// Confidence: High
> +// Options: --include-headers-for-types --all-includes --include-headers --keep-comments
> +
> +virtual patch
> +
> +@initialize:python@
> +@@
> +import sys
> +
> +def alloc_array(name):
> +	func = "FAILED_RENAME"
> +	if name == "kmalloc_array":
> +		func = "kmalloc_objs"
> +	elif name == "kvmalloc_array":
> +		func = "kvmalloc_objs"
> +	elif name == "kcalloc":
> +		func = "kzalloc_objs"
> +	elif name == "kvcalloc":
> +		func = "kvzalloc_objs"
> +	else:
> +		print(f"Unknown transform for {name}", file=sys.stderr)
> +	return func
> +
> +// This excludes anything that is assigning to or from integral types or
> +// string literals. Everything else gets the sizeof() extracted for the
> +// kmalloc_obj() type/var argument. sizeof(void *) is also excluded because
> +// it will need case-by-case double-checking to make sure the right type is
> +// being assigned.
> +@direct depends on patch && !(file in "tools") && !(file in "samples")@
> +typedef u8, u16, u32, u64;
> +typedef __u8, __u16, __u32, __u64;
> +typedef uint8_t, uint16_t, uint32_t, uint64_t;
> +typedef __le16, __le32, __le64;
> +typedef __be16, __be32, __be64;
> +type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,
> +		 u16,__u16,uint16_t,unsigned short,
> +		 u32,__u32,uint32_t,unsigned int,
> +		 u64,__u64,uint64_t,unsigned long,
> +		 __le16,__le32,__le64,__be16,__be32,__be64};
> +char [] STRING;
> +INTEGRAL *BYTES;
> +type TYPE;
> +expression VAR;
> +expression GFP;
> +expression COUNT;
> +expression FLEX;
> +expression E;
> +identifier ALLOC =~ "^kv?[mz]alloc$";
> +fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
> +fresh identifier ALLOC_FLEX = ALLOC ## "_flex";
> +identifier ALLOC_ARRAY = {kmalloc_array,kvmalloc_array,kcalloc,kvcalloc};
> +fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARRAY) };
> +@@
> +
> +(
> +-	VAR = ALLOC((sizeof(*VAR)), GFP)
> ++	VAR = ALLOC_OBJ(*VAR, GFP)
> +|
> +	ALLOC((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
> +|
> +	BYTES = ALLOC((sizeof(E)), GFP)
> +|
> +	BYTES = ALLOC((sizeof(TYPE)), GFP)
> +|
> +	ALLOC((sizeof(void *)), GFP)
> +|
> +-	ALLOC((sizeof(E)), GFP)
> ++	ALLOC_OBJ(E, GFP)
> +|
> +-	ALLOC((sizeof(TYPE)), GFP)
> ++	ALLOC_OBJ(TYPE, GFP)
> +|
> +	ALLOC_ARRAY(COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
> +|
> +	BYTES = ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
> +|
> +	BYTES = ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
> +|
> +	ALLOC_ARRAY((\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
> +|
> +	BYTES = ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
> +|
> +	BYTES = ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
> +|
> +	ALLOC_ARRAY(COUNT, (sizeof(void *)), GFP)
> +|
> +	ALLOC_ARRAY((sizeof(void *)), COUNT, GFP)
> +|
> +-	ALLOC_ARRAY(COUNT, (sizeof(E)), GFP)
> ++	ALLOC_OBJS(E, COUNT, GFP)
> +|
> +-	ALLOC_ARRAY(COUNT, (sizeof(TYPE)), GFP)
> ++	ALLOC_OBJS(TYPE, COUNT, GFP)
> +|
> +-	ALLOC_ARRAY((sizeof(E)), COUNT, GFP)
> ++	ALLOC_OBJS(E, COUNT, GFP)
> +|
> +-	ALLOC_ARRAY((sizeof(TYPE)), COUNT, GFP)
> ++	ALLOC_OBJS(TYPE, COUNT, GFP)
> +|
> +-	ALLOC(struct_size(VAR, FLEX, COUNT), GFP)
> ++	ALLOC_FLEX(*VAR, FLEX, COUNT, GFP)
> +|
> +-	ALLOC(struct_size_t(TYPE, FLEX, COUNT), GFP)
> ++	ALLOC_FLEX(TYPE, FLEX, COUNT, GFP)
> +)
> --
> 2.34.1
>
>
