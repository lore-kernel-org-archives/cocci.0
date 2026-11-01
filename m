Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D978606A326
	for <cocci@archiver.kernel.org>; Sun,  1 Nov 2026 23:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=RZD3UI3q
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=KIvY7c6eGNR1PYr4Rw2sHXHPIR5Jl1oXe/FN4rg1gXs=;
  b=RZD3UI3qtcMyfQsH4B17r7z3mPwTSE36WJbNCvTz61e0YN9E5ttbzbNt
   ILtUDufiSOmTuxFGSnB9wk+OsPukG12GvGY46K002+6YKttb7N8OosP6U
   jrl/Sd8vQV3qh9YF7RvRSBbsr/TRzHk/NW8noh8be6dYNdCB/ndCHUhhp
   I=;
X-CSE-ConnectionGUID: L0KWpVwJQ1C0BNrtkNeyxQ==
X-CSE-MsgGUID: rv9VPibMQreskAJ2z+wU6A==
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
X-IronPort-AV: E=Sophos;i="6.27,190,1787004000"; 
   d="scan'208";a="303236724"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2026 00:52:00 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id D814780E5C; Mon,  2 Nov 2026 00:51:59 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F29B680E5C
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 00:51:53 +0100 (CET)
X-CSE-ConnectionGUID: KvlqFKkSQByscQ4HsivZmQ==
X-CSE-MsgGUID: cwhUsx3XTdCozV56cvniZA==
X-IronPort-AV: E=Sophos;i="6.27,190,1787004000"; 
   d="scan'208";a="303236714"
Received: from 88-188-149-159.subs.proxad.net (HELO hadrien.home) ([88.188.149.159])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 00:51:54 +0100
Date: Mon, 2 Nov 2026 00:51:53 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
To: Joe Perches <joe@perches.com>
cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
    Linus Torvalds <torvalds@linux-foundation.org>, 
    Kees Cook <kees@kernel.org>, driver-core@lists.linux.dev, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
In-Reply-To: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com>
Message-ID: <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3759
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/BHZxwvjw3U2SFRTnxKuXbQ>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On Sun, 1 Nov 2026, Joe Perches wrote:

> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script")
> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KERNEL arg")
>
> Finds and converts sized devm_kmalloc-family of allocations into the typed
> devm_kmalloc_obj-family of allocations.

Applied

>
> Signed-off-by: Joe Perches <joe@perches.com>
> ---
>
> Maybe this might be useful to run and apply just prior to some -rc1
>
> This script would change more than 8000 instances in more than
> 5000 files in Linus' current master.
>
> $ spatch -D patch --very-quiet --cocci-file ./scripts/coccinelle/api/devm_kmalloc_objs.cocci \
>     --include-headers-for-types --all-includes --include-headers --keep-comments \
>     -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include \
>     -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./include/uapi \
>     -I ./include/generated/uapi --include ./include/linux/compiler-version.h \
>     --include ./include/linux/kconfig.h .

I'm not sure that --include-headers-for-types is useful.  That is useful
when there is an expression metavariable that is required to have a
particular type.  I don't see that here.  I also got around 5000 changes
in Linus's current master without using that argument.  I didn't try it,
but I think --no-includes would thus be fine.  --include-headers will get
the changes in the header files.

If the --keep comments argument is useful, it could be added to the
semantic patch, by putting #spatch --keep-comments at the top of the file.

julia

>
> Lightly tested but directly copied and modified to update the devm_ uses
>
> Its been a bit.
> Any comments or negatives about using or running this script?
>
>  .../coccinelle/api/devm_kmalloc_objs.cocci    | 136 ++++++++++++++++++
>  1 file changed, 136 insertions(+)
>  create mode 100644 scripts/coccinelle/api/devm_kmalloc_objs.cocci
>
> diff --git a/scripts/coccinelle/api/devm_kmalloc_objs.cocci b/scripts/coccinelle/api/devm_kmalloc_objs.cocci
> new file mode 100644
> index 0000000000000..322f79a2d9654
> --- /dev/null
> +++ b/scripts/coccinelle/api/devm_kmalloc_objs.cocci
> @@ -0,0 +1,136 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/// Use devm_kmalloc_obj family of macros for allocations
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
> +	if name == "devm_kmalloc_array":
> +		func = "devm_kmalloc_objs"
> +	elif name == "devm_kvmalloc_array":
> +		func = "devm_kvmalloc_objs"
> +	elif name == "devm_kcalloc":
> +		func = "devm_kzalloc_objs"
> +	elif name == "devm_kvcalloc":
> +		func = "devm_kvzalloc_objs"
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
> +typedef uchar, ushort, uint, ulong;
> +typedef __le16, __le32, __le64;
> +typedef __be16, __be32, __be64;
> +typedef wchar_t;
> +type INTEGRAL = {u8,__u8,uint8_t,char,unsigned char,uchar,wchar_t,
> +		 u16,__u16,uint16_t,unsigned short,ushort,
> +		 u32,__u32,uint32_t,unsigned int,uint,
> +		 u64,__u64,uint64_t,unsigned long,ulong,
> +		 __le16,__le32,__le64,__be16,__be32,__be64};
> +char [] STRING;
> +INTEGRAL *BYTES;
> +INTEGRAL **BYTES_PTRS;
> +type TYPE;
> +expression VAR;
> +expression GFP;
> +expression COUNT;
> +expression FLEX;
> +expression E;
> +expression DEV;
> +identifier ALLOC =~ "^devm_kv?[mz]alloc$";
> +fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
> +fresh identifier ALLOC_FLEX = ALLOC ## "_flex";
> +identifier ALLOC_ARRAY = {devm_kmalloc_array,devm_kvmalloc_array,devm_kcalloc,devm_kvcalloc};
> +fresh identifier ALLOC_OBJS = script:python(ALLOC_ARRAY) { alloc_array(ALLOC_ARRAY) };
> +@@
> +
> +(
> +-	VAR = ALLOC(DEV,(sizeof(*VAR)), GFP)
> ++	VAR = ALLOC_OBJ(DEV,*VAR, GFP)
> +|
> +	ALLOC(DEV,(\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
> +|
> +	BYTES = ALLOC(DEV,(sizeof(E)), GFP)
> +|
> +	BYTES = ALLOC(DEV,(sizeof(TYPE)), GFP)
> +|
> +	BYTES_PTRS = ALLOC(DEV,(sizeof(E)), GFP)
> +|
> +	BYTES_PTRS = ALLOC(DEV,(sizeof(TYPE)), GFP)
> +|
> +	ALLOC(DEV,(sizeof(void *)), GFP)
> +|
> +-	ALLOC(DEV,(sizeof(E)), GFP)
> ++	ALLOC_OBJ(DEV, E, GFP)
> +|
> +-	ALLOC(DEV,(sizeof(TYPE)), GFP)
> ++	ALLOC_OBJ(DEV,TYPE, GFP)
> +|
> +	ALLOC_ARRAY(DEV,COUNT, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), GFP)
> +|
> +	BYTES = ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
> +|
> +	BYTES = ALLOC_ARRAY(DEV,COUNT, (sizeof(TYPE)), GFP)
> +|
> +	BYTES_PTRS = ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
> +|
> +	BYTES_PTRS = ALLOC_ARRAY(DEV, COUNT, (sizeof(TYPE)), GFP)
> +|
> +	ALLOC_ARRAY(DEV, (\(sizeof(STRING)\|sizeof(INTEGRAL)\|sizeof(INTEGRAL *)\)), COUNT, GFP)
> +|
> +	BYTES = ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
> +|
> +	BYTES = ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
> +|
> +	BYTES_PTRS = ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
> +|
> +	BYTES_PTRS = ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
> +|
> +	ALLOC_ARRAY(DEV, COUNT, (sizeof(void *)), GFP)
> +|
> +	ALLOC_ARRAY(DEV, (sizeof(void *)), COUNT, GFP)
> +|
> +-	ALLOC_ARRAY(DEV, COUNT, (sizeof(E)), GFP)
> ++	ALLOC_OBJS(DEV, E, COUNT, GFP)
> +|
> +-	ALLOC_ARRAY(DEV, COUNT, (sizeof(TYPE)), GFP)
> ++	ALLOC_OBJS(DEV, TYPE, COUNT, GFP)
> +|
> +-	ALLOC_ARRAY(DEV, (sizeof(E)), COUNT, GFP)
> ++	ALLOC_OBJS(DEV, E, COUNT, GFP)
> +|
> +-	ALLOC_ARRAY(DEV, (sizeof(TYPE)), COUNT, GFP)
> ++	ALLOC_OBJS(DEV, TYPE, COUNT, GFP)
> +|
> +-	ALLOC(DEV, struct_size(VAR, FLEX, COUNT), GFP)
> ++	ALLOC_FLEX(DEV, *VAR, FLEX, COUNT, GFP)
> +|
> +-	ALLOC(DEV, struct_size_t(TYPE, FLEX, COUNT), GFP)
> ++	ALLOC_FLEX(DEV, TYPE, FLEX, COUNT, GFP)
> +)
> +
> +@drop_gfp_kernel depends on patch && !(file in "tools") && !(file in "samples")@
> +identifier ALLOC = {devm_kmalloc_obj,devm_kmalloc_objs,devm_kmalloc_flex,
> +		    devm_kzalloc_obj,devm_kzalloc_objs,devm_kzalloc_flex,
> +		    devm_kvmalloc_obj,devm_kvmalloc_objs,devm_kvmalloc_flex,
> +		    devm_kvzalloc_obj,devm_kvzalloc_objs,devm_kvzalloc_flex};
> +@@
> +
> +	ALLOC(...
> +-		 , GFP_KERNEL
> +	     )
>
