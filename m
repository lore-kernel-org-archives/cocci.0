Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 126D2CDB479
	for <cocci@archiver.kernel.org>; Thu, 25 Jun 2026 12:26:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=eGPCRroNwL+2UIvY3yNfZi7X2BrPzZzZjfmE/8yKi+4=;
  b=LUE1/mm7dxZDfgp8K7u2NTOktgxPp/h46zxcAnswyysBdx/bhdBaZA+k
   JKFNzezbMosnJludm2mNSSrPBBn8Ij/b/nhmKTW6wFp553DqcVW/86uxK
   njSpY8Zl3AsY+b8F+mvzTMjFEWZkkDP1uRzQvOY3QSU8uEgCqQWZOVzmr
   U=;
X-CSE-ConnectionGUID: h4M768/GRfKj9F9FeVM5JQ==
X-CSE-MsgGUID: YEyX7iSRShaDVTmCfXEn1A==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.24,224,1774306800"; 
   d="scan'208";a="283379899"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Jun 2026 14:26:56 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7EBE781EA1; Thu, 25 Jun 2026 14:26:56 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id C6A4581BD2
	for <cocci@sympa.inria.fr>; Wed, 24 Jun 2026 19:02:48 +0200 (CEST)
X-CSE-ConnectionGUID: WuFRFZuqThS0TH7OCXx1vg==
X-CSE-MsgGUID: zYPweUoOSIqcnlD4H2Um4g==
IronPort-SDR: 6a3c0db8_jetq5yj3aM2IHKiLD54Za1JJJEjB6oFWE9yeecH8ON/R1Ah
 xrqVxD0IhWfTk5JkesIC5/BNBDEDIMSrtR9OiMw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FqAgDMDDxqexEsKNhahRqBaDQHCIUhiHuIfJg9hAmDU?=
 =?us-ascii?q?w8BAwENUQQBAQGFBQKNTCAGAQQ0EwECBAMCAwEBAQEBAQEBAQEBCwEBAQQBA?=
 =?us-ascii?q?QECAQECBAMBAQEBAhABAUIOO4ZcgmIBhAABAQEDI1YQCxgCAiYCAlYGAYYIA?=
 =?us-ascii?q?wW3RYEygQGEftlFgXIVgQouhXGCagGBcIRBhEFCP4FOhEA+hEODW4JqBIMug?=
 =?us-ascii?q?XiPCglJeBwDWSwBVRMXCwcFgSNDAyovLSNLBS0dgSMhHQ8IFh5YGwcFEiAqQ?=
 =?us-ascii?q?UUjAwIoWT84C0MFgVwCgg5OIx8DOX+BQIEkZGYVMDWBAQERHgpsQgMLbT03F?=
 =?us-ascii?q?BsEkG4+UQGCKKYloQ+EJ4FmoEKqbC6HZpB0I6NBDoVQAYF+I4FcTSMVgyNPA?=
 =?us-ascii?q?xkP4EUnbwIHAgcOAwuSHIFLAQE?=
IronPort-PHdr: A9a23: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
 GS/
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:P5TtwqqdxQFFnCTZHooonHMaV5o6eYIsimQD101hICG9JPb4qy
 nIppomPH7P5wr5N0tMpTntAsm9qBDnmaKdn7N6AV7KZmCP01dAR7sSj7cKrQeQeBEWjtQtsJ
 tdTw==
X-Talos-CUID: =?us-ascii?q?9a23=3A08c6AmrtgI1+s7euGDW+lxjmUf84XEfz/mrJH0+?=
 =?us-ascii?q?DUVpJF5q+eU/J5qwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABjwRag7ttvNRVuwholQTSlapxox60pyxBX0Ktq4?=
 =?us-ascii?q?nosKCMQAsG22giWi4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.24,222,1774306800"; 
   d="scan'208";a="150357905"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGJHzkm2b7fzBRdsOHy0Z4y632OCWgnxtAIhp?=
 =?us-ascii?q?P7uuSe2gQZYtHIdr4Q9uNnUU0JNTYp2INz7z1mCnfb0tfzol0QlrL9mF?=
 =?us-ascii?q?hiwA9PBwFbq8SPaybUR7d5AtFHq59gDGtFTaYdXwjuo8SFa9psggQ0bO?=
 =?us-ascii?q?Qr3Z2DCsw1OWM5BVuVdM4EPw=3D=3D?=
Received: from smtprelay0017.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2026 19:02:47 +0200
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 4B4EF8CFDD;
	Wed, 24 Jun 2026 17:02:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf13.hostedemail.com (Postfix) with ESMTPA id 0ABD72000E;
	Wed, 24 Jun 2026 17:02:41 +0000 (UTC)
Message-ID: <50755b746bb30bea3989db9c1f262d5257e8ee1e.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org
Cc: Kees Cook <kees@kernel.org>, driver-core@lists.linux.dev, Julia Lawall	
 <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 cocci@inria.fr
Date: Wed, 24 Jun 2026 10:02:40 -0700
In-Reply-To: <eed0c57a2c897e34d411229c3de41c5402791894.1781575297.git.joe@perches.com>
References: 
	<eed0c57a2c897e34d411229c3de41c5402791894.1781575297.git.joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 0ABD72000E
X-Stat-Signature: mpcswntk4zte9euj4nggo1mdaxfgb9qg
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+NPJg0H/Y4AleE2CoSjDsUZDCUVcqnbps=
X-HE-Tag: 1782320561-665375
X-HE-Meta: U2FsdGVkX18A8PO+/RaZHil8OAbKf+Ud1jEx6YhUJFWiv/KoOWxjDZKAw/SrsKGc3jPCHhOUuN9mI/mA/+yBwiWk2ddAzmNKa0L4GI7jNdNf4mfBMxCaGteAxXNfoEtfWB4JJEr5ea/Pxq+0d4UsfqFVMTXVksYi535Ox+4lSUbYQ7ZqNjh/sKCjRNNfyUiagR9rx5Yl2hL8FmGxpiPDia5bVFEWjf5/1pH2oF/gG8YhBSO/konSz1evj11Xp+ee3Y3RnuJeftbO7m9OWLNT3C8vr5vQucKWaQT/GKr0CkIE4MRn5F2g1yMBCm7+QFh8
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] coccinelle: Add devm_kmalloc_objs conversion
 script
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3588
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-06/uTQTFIvhEKKHc9OGymnMAg>

On Mon, 2026-06-15 at 19:10 -0700, Joe Perches wrote:
> Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion script=
")
> with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GFP_KE=
RNEL arg")
>=20
> Finds and converts sized devm_kmalloc-family of allocations into the type=
d
> devm_kmalloc_obj-family of allocations.

Its been a bit.
Any comments or negatives about using or running this script?

This script would change more than 8000 instances in more than
5000 files in Linus' current master.

$ spatch -D patch --very-quiet --cocci-file ./scripts/coccinelle/api/devm_k=
malloc_objs.cocci \
    --include-headers-for-types --all-includes --include-headers --keep-com=
ments \
    -I ./arch/x86/include -I ./arch/x86/include/generated -I ./include \
    -I ./arch/x86/include/uapi -I ./arch/x86/include/generated/uapi -I ./in=
clude/uapi \
    -I ./include/generated/uapi --include ./include/linux/compiler-version.=
h \
    --include ./include/linux/kconfig.h .
