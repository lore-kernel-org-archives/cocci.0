Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D78D41C3E
	for <cocci@archiver.kernel.org>; Thu, 11 Dec 2025 14:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=HXPsWGzqZNdQCafR+rn1ATjDdBIDY0Ma0kVhJ2NwlQM=;
  b=G44LdIydinG9Tw7B6K+vHY7YGzuVmZ1H6P0Kd4UkFe75vWWr4z+MyOpy
   ljshyYtSk/CSIrShBPoWmwZEC12fPX45DnM/krmECrE+UejlYk01t0Rs4
   /1I1HgrS6bqZZZLGJjalKIpI+XaRZp/QycBb8dFjeS4eRFw6YN8zviL+S
   g=;
X-CSE-ConnectionGUID: RcUQqyv4R8eO+kpOjoki8A==
X-CSE-MsgGUID: EA2R50v1RrGhaCyFTXFMuQ==
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
X-IronPort-AV: E=Sophos;i="6.21,141,1763420400"; 
   d="scan'208";a="253976090"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Dec 2025 15:16:01 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 7A9D2814D4; Thu, 11 Dec 2025 15:16:01 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (dsi-ha-lb1-dmz.inria.fr [128.93.162.100])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 8AAE780FE9
	for <cocci@sympa.inria.fr>; Thu, 11 Dec 2025 15:15:57 +0100 (CET)
X-CSE-ConnectionGUID: N/EV6ydQSbS/BRJGA3yeMA==
X-CSE-MsgGUID: SXw5kxnNQ2yw8vCDBoSXbw==
IronPort-SDR: 693ad1fe_MwzfY+EdATykoVW+yoIUyMrGDm7vBT+fyMuEnCNYcbJJMhM
 GGYEpnMtrduzuvfVgjTkV4hQec/UWxqrmQ4SK3A==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EJAAB60TppgwsR49RaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIE+AwEBAQELAYI/Zx8GWTMEC0mEVYgihzGCJIQ7jxGIeYFVg?=
 =?us-ascii?q?X0CDwEDAQ1ECgECBAEBAwMBhQACjGgCHgcBBDIHDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEBAQENAQEFAQEBAgEBAgQGAQIQAQEBOgcOO4ZPDYJiAYEkgSYBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdA?=
 =?us-ascii?q?QERJgEECwsaAiYCAlYGARICAQGCfgGCIgEGEAEDDycHDQazbYEygQGCDAEBB?=
 =?us-ascii?q?oFGAgwCQ9hIHywiWYFkAwaBHS4BhW2CZQGFbjuDQ3onD4FVRIE8gwM+gmEDh?=
 =?us-ascii?q?TqCaYImgQ6ZYlJ4HANZLAFVExcLBwWBIxAzAyAKNC0CFA0QEg8EFgUtHXAMJ?=
 =?us-ascii?q?xIPHQ8IE2A9F0CDSRgGaA8GgREZSQICAgUCKxU6gWYFARwGHBICAwECAoEND?=
 =?us-ascii?q?IF3AgIEghV9gW8bD4dCgQYFLntDAgELbT03BgMLGwY9lQwpJYNqAoITjXSJB?=
 =?us-ascii?q?wGOJqFFNAeCOIFngWQMii6OM4cLBhMvg3EBk2AOBpMFLphYIotsgXqVWoVeg?=
 =?us-ascii?q?W8IK4FcMxokgzZPAxkPjiEZhBqBC4NVunRCNQI6AgcLAQEDCYVGAQGMVmphA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:CnjIAqyF0pVXiGw7zmNKKrPw+L1zdoMgy1knxilNoNJuA6+lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFeb/N5DNB/KPHCWeDc+oI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:LpWYyG+iHaVA9YFaTsOVv2hTN/57Y3Hk933rZGWCK0lAE6yYbHbFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AbnTtZAy7w1WR8gRhgV20KF28Ed+aqJ+eFx0OgZM?=
 =?us-ascii?q?ggpOVKnxuEBu3iw+HSJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,141,1763420400"; 
   d="scan'208";a="133446301"
X-MGA-submission: =?us-ascii?q?MDGRCqVvy1m5T6Hm9xQsnn3mWOP7LfK1qHIt//?=
 =?us-ascii?q?Wsb4D3yQtSzh54yOnr4+EOxRMTc+fce8KXhDpYOYUjM6GKgIHute9XZz?=
 =?us-ascii?q?hENqGKxalu0GGMkmEHAj1E8LVIO0bN8poGvsv4TO5lLWVzMYRapHZCrW?=
 =?us-ascii?q?9GafkOshSCgu7rarHyqyw6lw=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2025 15:15:25 +0100
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.1]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mc1ZN-1w1Om42sJj-00g0ku; Thu, 11
 Dec 2025 15:15:15 +0100
Message-ID: <22e31f45-55fc-43c6-bede-fee1c829aefc@web.de>
Date: Thu, 11 Dec 2025 15:15:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kees Cook <kees@kernel.org>, cocci@inria.fr,
 linux-hardening@vger.kernel.org, linux-mm@kvack.org,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>,
 Vlastimil Babka <vbabka@suse.cz>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-doc@vger.kernel.org,
 llvm@lists.linux.dev, Alexander Lobakin <aleksander.lobakin@intel.com>,
 Alexander Potapenko <glider@google.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bill Wendling <morbo@google.com>,
 Christoph Lameter <cl@linux.com>, David Rientjes <rientjes@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Harry Yoo <harry.yoo@oracle.com>, Jakub Kicinski <kuba@kernel.org>,
 Jan Hendrik Farr <kernel@jfarr.cc>, Jann Horn <jannh@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Justin Stitt <justinstitt@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Marco Elver <elver@google.com>, Matthew Wilcox <willy@infradead.org>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Pekka Enberg <penberg@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Randy Dunlap <rdunlap@infradead.org>,
 Roman Gushchin <roman.gushchin@linux.dev>, Sasha Levin <sashal@kernel.org>,
 Tony Ambardar <tony.ambardar@gmail.com>,
 Vegard Nossum <vegard.nossum@oracle.com>, Yafang Shao <laoar.shao@gmail.com>
References: <20251203233036.3212363-5-kees@kernel.org>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20251203233036.3212363-5-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:VtTnkvdHyx2N8zaT7+mVD3UDdwU4U/rdXNiikXVORMv6VYV8Ogj
 QO81oGcmk1PW1LR+HEFchod3sdWVxqB3i47bFm+BHhn6aEGGcS+/9M+wmeMWv5Mg8qMX/pw
 8FiNvrGdj2vCRWC8hS63XVG0EBqP1REZchF+gMueq0w2iygrZGK4/OQJCOo1091iqD1h0q4
 2gGabs7EbmLApY22t+/Ew==
UI-OutboundReport: notjunk:1;M01:P0:soOv9wERWaM=;YnN3t8FtRA8Bt6Lr38W/P8Eesha
 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
 AU7LMQ87Gjr0AixRxww4Gyvk3U0+5X9BIazYOg
Subject: Re: [cocci] [PATCH v6 5/5] coccinelle: Add kmalloc_objs conversion
 script
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3261
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2025-12/IZVSp8AJVsavO5qLzNFgPg>

> Finds and converts sized kmalloc-family of allocations into the
> typed kmalloc_obj-family of allocations.

Can previous patch review concerns get more development attention anyhow?
https://lore.kernel.org/cocci/71d406fb-9fb1-44a9-912a-7a0d270b9577@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-11/msg00066.html

Regards,
Markus
