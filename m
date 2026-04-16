Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DE56F8A16A
	for <cocci@archiver.kernel.org>; Thu, 16 Apr 2026 12:31:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=VyPrg9GQ2OOkA0iAAEE3gj1RNHhV/N2lAktXeN9rB7c=;
  b=b/epvmxcG1jIT7PT97ryPscG1EtQQQYfLXGvsw4k+pQ6E7/Z1ijTRCeJ
   aBMw+gPZJhL5ziLsAp8TqiDELQeihTiPGwjVv4P9+JfDDX94HJAPno2A8
   1Rxn203yLfwWhDMWowhYWSag0/lUgWlFDleEifQEslqU6+Kh7hZ+/Qv8E
   A=;
X-CSE-ConnectionGUID: OZOSImxcTSWV2p4W+GlTIQ==
X-CSE-MsgGUID: ixUGlwOnS6CuRlrbWSwoLg==
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
X-IronPort-AV: E=Sophos;i="6.23,181,1770591600"; 
   d="scan'208";a="272806468"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Apr 2026 14:31:44 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id BB5E981F03; Thu, 16 Apr 2026 14:31:41 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 46C8281C4D
	for <cocci@sympa.inria.fr>; Thu, 16 Apr 2026 14:31:10 +0200 (CEST)
X-CSE-ConnectionGUID: QrNonafMRFm+d+BNoYnHqQ==
X-CSE-MsgGUID: ziNM5yQgSye1kGEYT5m7Jg==
IronPort-SDR: 69e0d681_0Z/kGxIbowJ1rBSL0R+QCqYb6y9eAw9w2x7yRdUMdGACQOl
 qePMsRdZa8vJeZGfRqCq95WXDNm0IhmdOgegs4Q==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FwAQBM1uBphR/86qxaHgEBCxIMggULgkGBZjMEC0mEW?=
 =?us-ascii?q?Ih7hliCIQOEO4c5kFGBVRSBaQIPAQMBDVEEAQEBAQEEhQACjS0CHgcBBDAJD?=
 =?us-ascii?q?gECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBA?=
 =?us-ascii?q?UBJhk8NgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDIx0BATcBDwsOCgICJ?=
 =?us-ascii?q?gICVgYBEgIBAYJ+giMHSgO3A4EygQGCDAEBBtwqgWcJFYEKLohXAYVcGjuDR?=
 =?us-ascii?q?XonG4FJRIEVJ4MDPoQqBSmDRoJpgRKBFIEOhCeBcINYhS5SeBwDWSwBVRMXC?=
 =?us-ascii?q?wcFXkUQMwMgCi8tAhQNEBIPBBYFLR1wDCcSDx0XFR9YGwcFEiEqboJ7di5eG?=
 =?us-ascii?q?g4iAjkDWUo+C1IFgXYCgQuBCwIBC209NwYDCxsEPYs4IoI3AQGBDYMKkwORV?=
 =?us-ascii?q?KF5hCaEcJxtBg8EL5dSkxkuh2WQcyKkAIUfgWg6gVxNMAiDIk8DGQ+OIRmIe?=
 =?us-ascii?q?4oqsRxBNT0BAQcCBw0DC4FohF6LVoFLAQE?=
IronPort-PHdr: A9a23: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
 FWkKBMCird36tXckpc=
IronPort-Data: A9a23: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
 FXZjlyojK12pYAd3Cqgl7No9MklgQ7S
IronPort-HdrOrdr: A9a23:+kWQ0q9D6qOBrnMUVetuk+DyI+orL9Y04lQ7vn1ZYQBJdMaCh9
 my9c5rsyMcRgxhOk3I6urwX5VoJkmsjqKdgLNhRYtKOTOKhILGFu5fBOfZslnd8mjFh5dgPM
 RbHZSWauedMbESt6+Ti2OF+pQbsby6GcuT5ds2oU0dLj2CJ5sA0ztE
X-Talos-CUID: 9a23:O5ri92NSe+usoe5DYTNB80gdFOUfXHiewDT6BUiJD0ZwcejA
X-Talos-MUID: 9a23:2VE6Twm4I3wpamXKYq97dnpwNeFNvrWXB3scnMwFlOS1CXF1ZBWS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,181,1770591600"; 
   d="scan'208";a="272806017"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDHsibL2koaBiX6Pfufw/vTsDWwXDZg0nyh3IF?=
 =?us-ascii?q?p+uK9ZStXmi5tP43383KIqo0vXbzPNmmgr0u0qU4yjdcoLseFQXiClt4?=
 =?us-ascii?q?r0phfebBkPlQ3jEsHq9fsnVt8DMWK7FGN46c9Dqui3CWrfbxHmrFSbhT?=
 =?us-ascii?q?E4MKA+lNYcUQM56kSUJ7bIfQ=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2026 14:30:56 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 91B2640474;
	Thu, 16 Apr 2026 12:30:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB8D2C2BCAF;
	Thu, 16 Apr 2026 12:30:40 +0000 (UTC)
Message-ID: <1fba96bd-124d-431d-8de8-78688c248600@kernel.org>
Date: Thu, 16 Apr 2026 14:30:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Philipp Hahn <phahn-oss@avm.de>, amd-gfx@lists.freedesktop.org,
 apparmor@lists.ubuntu.com, bpf@vger.kernel.org, ceph-devel@vger.kernel.org,
 cocci@inria.fr, dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
 intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
 kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
 linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
 linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
 sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <20260310-b4-is_err_or_null-v1-1-bd63b656022d@avm.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 01/61] Coccinelle: Prefer IS_ERR_OR_NULL over
 manual NULL check
Reply-To: Krzysztof Kozlowski <krzk@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3477
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-04/Sn03ACk_TqH-ZsxNL5tMmA>

On 10/03/2026 12:48, Philipp Hahn wrote:
> Find and convert uses of IS_ERR() plus NULL check to IS_ERR_OR_NULL().
> 
> There are several cases where `!ptr && WARN_ON[_ONCE](IS_ERR(ptr))` is
> used:
> - arch/x86/kernel/callthunks.c:215 WARN_ON_ONCE
> - drivers/clk/clk.c:4561 WARN_ON_ONCE
> - drivers/interconnect/core.c:793 WARN_ON
> - drivers/reset/core.c:718 WARN_ON
> The change is not 100% semantical equivalent as the warning will now
> also happen when the pointer is NULL.
> 
> To: Julia Lawall <Julia.Lawall@inria.fr>
> To: Nicolas Palix <nicolas.palix@imag.fr>
> Cc: cocci@inria.fr
> Cc: linux-kernel@vger.kernel.org
> 
> ---
> drivers/clocksource/mips-gic-timer.c:283 looks suspicious: ret != clk,
> but Daniel Lezcano verified it as cottect.
> 
> There are some cases where the checks are part of a larger expression:
> - mm/kmemleak.c:1095
> - mm/kmemleak.c:1155
> - mm/kmemleak.c:1173
> - mm/kmemleak.c:1290
> - mm/kmemleak.c:1328
> - mm/kmemleak.c:1241
> - mm/kmemleak.c:1310
> - mm/kmemleak.c:1258
> - net/netlink/af_netlink.c:2670
> Thanks to Julia Lawall for the help to also handle them.
> 
> Signed-off-by: Philipp Hahn <phahn-oss@avm.de>
> ---
>  scripts/coccinelle/api/is_err_or_null.cocci | 125 ++++++++++++++++++++++++++++
>  1 file changed, 125 insertions(+)
> 

Neither this, nor try from 2011, nor any future try should be accepted,
because it creates impression IS_ERR_OR_NULL is somehow okay. No, it is
not okay, it is a discouraged pattern leading to less readable and
maintainable code. We should not have therefore any tools suggesting
usage of IS_ERR_OR_NULL, because people will be converting poor code
into that, instead of fixing that poor code.

Best regards,
Krzysztof
