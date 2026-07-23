Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14B5C531F9
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=LSQ3TmK6+uWISy9/POQp13YIfoaEQVzoY7e/Lh+j58I=;
  b=UZQMocwpYFbuN5+j9pTm2Nynql+KWprHPiv0B8G7Gv95yyCQdhG1IGyA
   tVLNk3yogukuIDQdeMPvIt5HMi1ZTr34AU5+DmqRaHeMJYnqzpfLgacnd
   BPey7aYZcwnuayNsrtBShBLoWDtc630y+clwMgXLVGAokZIDOIarKQMi1
   E=;
X-CSE-ConnectionGUID: VTrocbgTQx+UBTslS/NDKQ==
X-CSE-MsgGUID: mYjGzqG6R1m5n/7iCyAxEQ==
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734330"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:50 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 297668044D; Fri, 24 Jul 2026 10:54:50 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 2906E81971
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 21:04:25 +0200 (CEST)
X-CSE-ConnectionGUID: SksjsigYQsKm0nOMXPocTw==
X-CSE-MsgGUID: tNISLc40SQGyYvwNisIXYw==
IronPort-SDR: 6a6265b8_RWaUw/Gf/mp7Rz7vDi+qXetmEvp4bCDiCpAh63EWwoQy14i
 WG7xBspJ9EGyjud35els2Xwyo1KSyVe/YbKd4NQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EkAADuZGJqhWUKQ5xaHQEBAQEJARIBBQUBgX0HAQsBg?=
 =?us-ascii?q?kCBaDQHCEmWThGEKocpkjeBfAIPAQMBDVEEAQEBAgEDhH4CjWACHwYBBDEID?=
 =?us-ascii?q?gECBAMCAwEBAQEBAQEBAQEBCwEBAQQBAQECAQECBAMBAQEBAhABAQEBQEmGT?=
 =?us-ascii?q?w2CYgEzghYsgQsBAQEDOgYBATcBDwsYHBIgNgYTgwKCKhEDNwPDGoE0gQGCD?=
 =?us-ascii?q?AEBBtsyDXKBaQkVgTgBhXCCSyABhXeEAnonG4INgTwLgnk+gh+IaYImgQySK?=
 =?us-ascii?q?lJ4HANZLAFVExcLBwWBI0MDgQYjSwUtHYEjIR0XFh5YGwcFEiAqQUUjA0EmE?=
 =?us-ascii?q?DgLQwWBVgKBeD8jHwM5f4EvdUp3LWkBAhAXSjgkg0kCgTcCAQttPTcJCxkEj?=
 =?us-ascii?q?x0jgkGDNheWegGvMXGCPx+BSYFmmXmGAQYPBC+BS4ImAaZ6mQiSE5cwgWoCN?=
 =?us-ascii?q?oFcMxoIMIMiUAMZD44hGYNBzDJFMj4BBwIHDwKBc5A0gUwBAQ?=
IronPort-PHdr: A9a23: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
 TxhdUULpb3CtEuwY91hA3cZqH54K+/CkCbLtoHl
IronPort-Data: A9a23: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
 Qkix0DN
IronPort-HdrOrdr: A9a23:/MnXCai8V6iAErhxQ5NpbSScS3BQXtcji2hC6mlwRA09TyVXra
 6TddAgpHvJYVcqKRQdcLW7U5VoLkmwyXcY2+Us1PKZLW7bUQiTXeNfBOnZowEIcheWnoRgPO
 VbAstD4bbLbGSS4/yU3DWF
X-Talos-CUID: 9a23:LdSBImzWjhfZ+t5War8jBgUvGdsnaXzS/U7LAErgD0FMeIWSQmOPrfY=
X-Talos-MUID: 9a23:0B9nrAi11GCWp4KHA+QuJsMpKOFJ2IClVBg2qLoXitebEy1rGgesk2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152816062"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGwbTAmQwm3oOESZ+Va+0PKDQp+1ZfepJ7wIa?=
 =?us-ascii?q?MlkgxvjxTMtMk6zXGeKcdksVpZmG+PnhSgdKfbBN97O3yVyi+oTBUXJJ?=
 =?us-ascii?q?Y6AJee4RsnDNg809eniDeOaGrADKfulsIsnRHJb4mffaW0tfsK6FtvVN?=
 =?us-ascii?q?8X5BYRYLwpvBCcGb7QejwAOw=3D=3D?=
Received: from vps0.lunn.ch ([156.67.10.101])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 21:04:23 +0200
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wmyiJ-00DsJO-G7; Thu, 23 Jul 2026 21:04:11 +0200
Date: Thu, 23 Jul 2026 21:04:11 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Arun Ramadoss <arun.ramadoss@microchip.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>, UNGLinuxDriver@microchip.com
Message-ID: <836a6044-beed-4372-a58e-68bde8e14c22@lunn.ch>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-9-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723184538.3888637-9-ekffu200098@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 08/36] net: remove conditional return with no
 effect
Reply-To: Andrew Lunn <andrew@lunn.ch>
X-Loop: cocci@inria.fr
X-Sequence: 3634
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/YtNrCJZtYCb5SQsHOy283Q>

On Fri, Jul 24, 2026 at 03:45:10AM +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
