Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A14C1E9B250
	for <cocci@archiver.kernel.org>; Tue, 24 Feb 2026 11:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=T+lOsDmbrLG+37RLcP+i5OjgdDr1iH4MiXfrLxOUmAg=;
  b=FS/AZqNLNbOJgbRR2CytlAF9/TazFnT7vaVdl32xRVGabkL8Z3mzyRe/
   gXTYmaDQvhu4dDl34KGZZO7bM3WBQ4qR3JWFMBvrp0iWUgQJyFVNBFGCp
   a996zpq0N9oZ8XhpH1Y1Kb5lTEiDsCkipa5ua/k+pmV2z4puZ26maMwby
   o=;
X-CSE-ConnectionGUID: eu3yaLxTQ0WofKeUzXXbbQ==
X-CSE-MsgGUID: lQyoLzGrTgqwgNoAzDjACw==
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
X-IronPort-AV: E=Sophos;i="6.21,308,1763420400"; 
   d="scan'208";a="264908113"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Feb 2026 12:04:50 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id EAE838367E; Tue, 24 Feb 2026 12:04:49 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id D782C8008A
	for <cocci@sympa.inria.fr>; Sun, 22 Feb 2026 05:14:17 +0100 (CET)
X-CSE-ConnectionGUID: dl49R5gNTaC5oTbkhKko3Q==
X-CSE-MsgGUID: kPMdz2yOTvWksVcQNZIRmQ==
IronPort-SDR: 699a8299_Y65NDNSU59NwE9bn6DjE36Cm48Jay5xdYtWmNs/dZ4dA+LN
 qSnk+TRdoNlFF1vgjeUkL8XuUOeOHtChH2hVImg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HMAQBLgZpphf4EaaxUBh4BAQsSDECBRQuCQYFmMwQLG?=
 =?us-ascii?q?TCNU4ZYgiSST4tLgX0CDwEDAQ1RBAEBAwSFAAKNIAIeBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABAQEBQEmGTw2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINfgEBAQM6BgEBNwEPCxguVgYTgwKCIwdKA6hKgTSBA?=
 =?us-ascii?q?YIMAQEG3CqBZwkVgTiIVAGFdIQAeicbgUlEhD8+gVKCYYQlgi+DNIIAiCyJM?=
 =?us-ascii?q?1J4HANZLAFLChMXCwcFMytFQwOBBiNLBS0KE1ISPyEdDwgUH1gbBwUSIREZB?=
 =?us-ascii?q?4FYAgIEghN7ggEPhmp5Ay5hGg4iAj5cUgU+C2AFUQMLbT03FBsEj2g/gjQBg?=
 =?us-ascii?q?Q2BcZQVgzQBjxGBNZ9ZhCahWE0Tlz+TGS6YWKNjhV6BbgEzgVwzGggoCIMiT?=
 =?us-ascii?q?wMZD44hGYh6tDwiNTwCBwsBAQMJkh6BSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vp9jvaBh+5YHKVHlHemj55DYdb4zR+YMi2TDGXoRdfVwSL3+qy
 nOpoV+6faQslsssR4b9exoVJPufZqYz+8S3WBzB8bGYOCFghrKEGgK1+KLqFfd8m/Fh4xgPM
 xbE5SWZuefMWRH
X-Talos-CUID: 9a23:0xQZgm7bQ3K8X1mdgdss+EpIS/p4fVvhxVyNJHOyCmZKS7rOcArF
X-Talos-MUID: 9a23:U6oliwsMQbDL1XjJaM2nhwlHONUy8oOSFn8OiqsNgu+2FBZ1AmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,304,1763420400"; 
   d="scan'208";a="264569362"
X-MGA-submission: =?us-ascii?q?MDGIT8NTd990fHbwX0x1gNKEj/SW/2BPaPA3B2?=
 =?us-ascii?q?0OLq3+yKzVQsl3k1+3XJ42OxQozLZngUrXph79KU0iHxQhHWiaGekm5n?=
 =?us-ascii?q?QX1LoAjdgBQuGSKlSbA1+tR3O6vi8kjGPXcnQ3I/0Ui/qQr9hIlO3BIc?=
 =?us-ascii?q?HSXtOVEbYrdG9sAx7CJktPVA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2026 05:14:16 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 59ED06001D;
	Sun, 22 Feb 2026 04:14:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AE8C116D0;
	Sun, 22 Feb 2026 04:14:13 +0000 (UTC)
Date: Sat, 21 Feb 2026 20:13:24 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Kees Cook <kees@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	John Hubbard <jhubbard@nvidia.com>, Joe Perches <joe@perches.com>,
	Christoph Lameter <cl@linux.com>, Marco Elver <elver@google.com>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
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
	Alexander Potapenko <glider@google.com>,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
	linux-doc@vger.kernel.org, llvm@lists.linux.dev
Message-ID: <20260222041324.GA10695@sol>
References: <20251203233029.it.641-kees@kernel.org>
 <20251203233036.3212363-5-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251203233036.3212363-5-kees@kernel.org>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Eric Biggers <ebiggers@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3308
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/Ut5S0s44V5bv2KbL6_RmzA>

On Wed, Dec 03, 2025 at 03:30:35PM -0800, Kees Cook wrote:
> Finds and converts sized kmalloc-family of allocations into the
> typed kmalloc_obj-family of allocations.
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

Is there a way to reproduce commit 69050f8d6d075dc using this semantic
patch as claimed?  I spend a while installing the latest version of
spatch (which was quite hard to do due to all the unusual dependencies),
but it complains that no rules apply:

$ /usr/local/bin/spatch --sp-file scripts/coccinelle/api/kmalloc_objs.cocci --dir . --in-place
init_defs_builtins: /usr/local/lib/coccinelle/standard.h
SPECIAL NAMES: adding u8 as a type
SPECIAL NAMES: adding u16 as a type
SPECIAL NAMES: adding u32 as a type
SPECIAL NAMES: adding u64 as a type
SPECIAL NAMES: adding __u8 as a type
SPECIAL NAMES: adding __u16 as a type
SPECIAL NAMES: adding __u32 as a type
SPECIAL NAMES: adding __u64 as a type
SPECIAL NAMES: adding uint8_t as a type
SPECIAL NAMES: adding uint16_t as a type
SPECIAL NAMES: adding uint32_t as a type
SPECIAL NAMES: adding uint64_t as a type
SPECIAL NAMES: adding uchar as a type
SPECIAL NAMES: adding ushort as a type
SPECIAL NAMES: adding uint as a type
SPECIAL NAMES: adding ulong as a type
SPECIAL NAMES: adding __le16 as a type
SPECIAL NAMES: adding __le32 as a type
SPECIAL NAMES: adding __le64 as a type
SPECIAL NAMES: adding __be16 as a type
SPECIAL NAMES: adding __be32 as a type
SPECIAL NAMES: adding __be64 as a type
SPECIAL NAMES: adding wchar_t as a type
No rules apply.  Perhaps your semantic patch doesn't contain any +/-/* code, or you have a failed dependency.  If the problem is not clear, try --debug-parse-cocci or check whether any virtual rules (e.g., patch) should be defined.
