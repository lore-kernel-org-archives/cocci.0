Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92510C88E77
	for <cocci@archiver.kernel.org>; Wed, 16 Sep 2026 09:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=2SvvLiHnsXWprFsLpaCyuZ2657b3nrzkaLsovBU0I9w=;
  b=RRuOEWenW9XAUM0EeGNN89SM59fgQsGs+M6mRjcJ+R/ZOKf3bB4Jz35h
   unutdJhZ5moyCBmCZl4Vzs2gICQ+RRbVb41q/2gSWk7CsBRoVSeZtw9wm
   Pf/J4vuH8GXPs6ihC8jYyBt3Flao3B3KNqsxIn/1uH+aw5i4vmri3KPg5
   U=;
X-CSE-ConnectionGUID: 5J8YE5K5ThmvZvcqK5OG3w==
X-CSE-MsgGUID: 5gTkUbnwThqE/fQM4niBTg==
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
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="295251506"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2026 11:57:05 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 3BFF9827F3; Wed, 16 Sep 2026 11:57:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id AAD4D81445
	for <cocci@sympa.inria.fr>; Wed, 16 Sep 2026 11:21:29 +0200 (CEST)
X-CSE-ConnectionGUID: bVpusk5LR1W3XtDq0wPpUA==
X-CSE-MsgGUID: JAZJ5hKsQ0OC197FqkBgLA==
IronPort-SDR: 6aaa5f99_WE5wABNVs6p6A7Cqm1kEI0tCmLHkRHtzoAnltSlVjE1D7DK
 tOYVaQCAarcrCZNR31A08uV8uvElGZM4tbV5lfw==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EDAwCkXqpqhf4EaaxaHgEBCxIMggULgkGBC04TMwQLS?=
 =?us-ascii?q?QSNToZYggQgi2SMWYVegXwCDwEDAQ1EDQQBAQECBIR+Ao4IAh4HAQQyBw4BA?=
 =?us-ascii?q?gQDAgMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8Nj?=
 =?us-ascii?q?BoBgSSBJgEBAQEBAQEBAQEBAR0CDX0BAQEBAgE6BgEBNwEECwsYLhAQNgYTg?=
 =?us-ascii?q?wIBgiIHEQMQJwMRwUN4gTSBAYIMAQEG2zUNcoFrAwYVgTiFcYJNIAGFeIQCe?=
 =?us-ascii?q?icbgg2EQD6CH4hpgiaBDJRFUngcA1ksAVUTFwsHBV5FQwOBBiNLBS0dgSMhH?=
 =?us-ascii?q?RcRHlgbBgUSICpBQyMDPoIjPyMZNnqBCV6BKylgAQIQF0YuFYIIAoJUgSNeA?=
 =?us-ascii?q?gFJQw4HRVMJJ0sSTCkiCBIJARMaMgsJbT03FRmQex+CWYEVLIF+xkJxhCiBZ?=
 =?us-ascii?q?oo8jz6GSYFLlgiTGi6HZpB0jBCBeoQJlzCBbwkqgVwzGggoCIMiUAMZD44iG?=
 =?us-ascii?q?SWIV8cIQjUCOwIHAgcOAwuSHIFMAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 aTZiIyKrIxXiaI8LCq4R0NoJQ==
IronPort-HdrOrdr: A9a23:BMOP96jQwygGWgYUJJbKy0Q0x3BQXtsji2hC6mlwRA09TyVXra
 CTddAgpHnJYVcqKRYdcLW7VZVoLkmyyXcY2+cs1PKZLXDbUQiTXeVfBOnZsl/d8kTFn4Y3v8
 tdmupFebjN5DNB/KXHCWeDcuod/A==
X-Talos-CUID: 9a23:KPAvaGyO8+JGDpm0OEd/BgUeJNg4aX6A6E2JHBSIFUpwEKKtUWK5rfY=
X-Talos-MUID: 9a23:h9cdJAZBFWwYNOBTlRbepmxiF9xRu4OFURFSv4wFkcagHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="295241702"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFirET4EX6tmJinPhmQf97A5SQQj2ponkgPgN?=
 =?us-ascii?q?W2ayvoZYcPswHJzUWyjdRnzVyuNu6niT9O8Y5SokKcqA0GaZlzAb41qH?=
 =?us-ascii?q?r+X2m+CZJUfmbs3ALDH7cpLJfFx5rXRQqGj8WI9iC6261LnlTlDG0YIA?=
 =?us-ascii?q?ZmosjsW8Ak/xaszydtA7fxpw=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:21:28 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id D7D4C60234;
	Wed, 16 Sep 2026 09:21:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8C91F000FF;
	Wed, 16 Sep 2026 09:21:26 +0000 (UTC)
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1x6lpU-00000005xYJ-07ND;
	Wed, 16 Sep 2026 11:21:24 +0200
Date: Wed, 16 Sep 2026 11:21:24 +0200
From: Johan Hovold <johan@kernel.org>
To: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
	cocci@inria.fr
Message-ID: <aqpflCAorrufh1i0@hovoldconsulting.com>
References: <20260915064327.1377-1-joshua.crofts1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260915064327.1377-1-joshua.crofts1@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Johan Hovold <johan@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3736
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/-DAoTBO08HOUrpz5x77GZg>

On Tue, Sep 15, 2026 at 06:43:27AM +0000, Joshua Crofts wrote:
> Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
> called in a file if pm_runtime_use_autosuspend() is called and its
> devm_* counterpart isn't present.
> 
> Without _dont_use_autosuspend(), removing devices causes resource leaks.

No, as I've explained repeatedly elsewhere, it does not cause any
resource leaks. [1][2]

The autosuspend setting leaks if you will, but that only matters in the
theoretical corner case of someone rebinding a different driver (which
will soon also taint the kernel).

So don't exaggerate the impact, this is essentially just a cleanup,
which is fine in itself.

> Assisted-by: LLM
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>

Johan

[1] https://lore.kernel.org/all/aqpd3viN1UoZBkgL@hovoldconsulting.com/
[2] https://lore.kernel.org/linux-iio/aow51Nk-cet9qaUQ@hovoldconsulting.com/
