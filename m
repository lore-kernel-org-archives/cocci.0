Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 760E5FC591C
	for <cocci@archiver.kernel.org>; Thu, 26 Feb 2026 09:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=89reKSYSoKwxxmuLzkRjmLRwtM7KVu/ucpGz+Yxh2aQ=;
  b=kBnyAGxQ23Ik1X+ZNWVkDWz+vlIi7kRcghMAaqNbg7wHAZvkUWGBCOoO
   vDJDGId5Y6i2r4wO0PcXN1eTRPYOekGJUAnJT1IumrhJ+400VoNe5MllK
   Som6gtv/rQUc+nK0JmUe63amCHRJo1ERubpMh4uCPiQhzI92bMWr5MvoH
   Q=;
X-CSE-ConnectionGUID: L7oM/k3FT6Op8smChigtcw==
X-CSE-MsgGUID: GJPe44tdRVy6H2EsXxvxzA==
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
X-IronPort-AV: E=Sophos;i="6.21,312,1763420400"; 
   d="scan'208";a="265253461"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2026 10:59:54 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 1407481F85; Thu, 26 Feb 2026 10:59:54 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id F371681E7F
	for <cocci@sympa.inria.fr>; Wed, 25 Feb 2026 18:55:47 +0100 (CET)
X-CSE-ConnectionGUID: FGb3o+QOTGKYmY2Xqbk2mw==
X-CSE-MsgGUID: Xjk6WQUSQ4O8U//s0YZUXw==
IronPort-SDR: 699f37a3_XxPNnrCMnQK3ZaKFcR2x6PnH2gdDC6BDWYqCkYeRn4A29ZZ
 qYgl3I+C0Rnf2/LXjHAf6CDVcWRkAAQwr5BBzfQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FYBQDZNp9pchxYTy1aHgEBCxIMggULgkGBZjMEC0mNU?=
 =?us-ascii?q?4h8MIs0kGGBVYF9Ag8BAwENTwIEAQEDAQOFAAKNIAIeBwEEMgcOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABgQyGTw2CW4EbEXQwKwINf?=
 =?us-ascii?q?gEBAQIBQAEBNwEECwsOEyUPARA2BgEShSUHEQMPJwMFqQ6BAYIMAQEG2y8Ng?=
 =?us-ascii?q?lUJFYE4iDUfAYV0O4NFeicbgg2BSoJ1PoIfiEYigiaBDh2THlJ4HANZLAFVE?=
 =?us-ascii?q?xcLBwWBIxAzAyAKLy0CFA0PARIPBBYFLR1wDCcSDx0XFB9YGwcFEiEqB2ECA?=
 =?us-ascii?q?gSCE3uBZhsPhmx5Ay5eGg4iAiwSA1k8Fz4LXwWBHQMLbT03Bg4bj04/hiiWV?=
 =?us-ascii?q?I8SoB1xhCaEcJZshhYzg3EBk2yTDZkGIpFwly+BbwIxgVwzGggmCjuCZ08DG?=
 =?us-ascii?q?Q+OIT6IGsEIIzU8AgcLAQEDCYVDJhOMIoFLAQE?=
IronPort-PHdr: A9a23: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
 pcSGOczvLMdEuwcTEJoAI5bSKo=
IronPort-Data: A9a23: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
 Y3tHnDDSfh5hE0EIBy1fWC/Ut37wUuRWdUNQ38=
IronPort-HdrOrdr: A9a23:e8lP2qB2pp3L3tHlHemp55DYdb4zR+YMi2TDj3oBKyC9Afbo8v
 xG/c5rsyMc5wxwZJhNo7290cq7MArhHPxOkOos1N6ZNWGM0ldAR7sM0WKW+Vzd8lrFmNK1u5
 0NT0E0MqyVMbEzt7ec3DWF
X-Talos-CUID: 9a23:Z+taTG74LSpvbnXPqNss2mEeQcdmS1rh41ThJn7iOX9jS+eQVgrF
X-Talos-MUID: 9a23:c21/VwvWei0EG8ZYec2ntDNhavhR3p+XVGddrNJBoJG1BxFAJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.21,310,1763420400"; 
   d="scan'208";a="265171708"
X-MGA-submission: =?us-ascii?q?MDGQhmbqGpxRB2cDZm+T/Q7CJvvAkOlCli+gJ3?=
 =?us-ascii?q?fnkBBEqRBQ8rtr4n2Z0sp1iaW12OX0IadZV7wiCLLCvxIi1dtZnfRSHn?=
 =?us-ascii?q?g1Xt8QIDtjMLPJ/KkaOw1M1rrt+aK+/lK2n04PDQPFTKAPCXv8LyC5JO?=
 =?us-ascii?q?ci6IpQvY60Jz1eMd9EDvahNQ=3D=3D?=
Received: from ms.lwn.net ([45.79.88.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2026 18:55:47 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2C74540C7C
Received: from localhost (c-71-229-227-126.hsd1.co.comcast.net [71.229.227.126])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 2C74540C7C;
	Wed, 25 Feb 2026 17:55:44 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Bhaskar Chowdhury <unixbhaskar@gmail.com>, Julia.Lawall@inria.fr,
 nicolas.palix@imag.fr, skhan@linuxfoundation.org, cocci@inria.fr,
 workflows@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Bhaskar Chowdhury <unixbhaskar@gmail.com>
In-Reply-To: <20260222225536.19196-1-unixbhaskar@gmail.com>
References: <20260222225536.19196-1-unixbhaskar@gmail.com>
Date: Wed, 25 Feb 2026 10:55:43 -0700
Message-ID: <87ms0wyag0.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH V2] Doc: dev-tools:  Added Gentoo in the
 Operating system list under Getting Coccinelle
Reply-To: Jonathan Corbet <corbet@lwn.net>
X-Loop: cocci@inria.fr
X-Sequence: 3312
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-02/Zf9mjDC2lZjKTgxtW2e3Yg>

Bhaskar Chowdhury <unixbhaskar@gmail.com> writes:

>  Adding Gentoo in the operating system list under "Getting Coccinelle".

Applied, thanks.  I also truncated the changelog here, we really don't
need to immortalize your ebuild session.

jon
