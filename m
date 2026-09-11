Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C7C2C88E45
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2026 14:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=R3qt+0B/1mnQ36SX7AQjSDbiXzKhmW8PzxAyTaaPd2I=;
  b=LGEIrVu98z1I8U9x4Mgca/PtnI+NH01H3S0iG3Sfy46yyZD6ouGfOYTB
   hskSlaTCwJLMqJNqdgE/KlD9DxlQuhd408hS71PqTKUpX2SpcIGz/UUMI
   mTwZSYuUtgM2Rzboic/Z0VXRBeHjKLpGn9jy0F95J+I41oY/UF4UsyjxG
   o=;
X-CSE-ConnectionGUID: Rqs4Kx2dShaZ5XHAN2VMCg==
X-CSE-MsgGUID: Z+wqnyQeQCmeyPcOhV/Ilw==
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
X-IronPort-AV: E=Sophos;i="6.27,97,1787004000"; 
   d="scan'208";a="294386834"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Sep 2026 16:53:22 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 12BEF817A6; Fri, 11 Sep 2026 16:53:22 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 947B480D1E
	for <cocci@sympa.inria.fr>; Fri, 11 Sep 2026 16:52:46 +0200 (CEST)
X-CSE-ConnectionGUID: Pl2dkqwYR66YNKPncK4qvw==
X-CSE-MsgGUID: n08Q2fvgTvi4ioAUI7SDaQ==
IronPort-SDR: 6aa415bb_r3KU+zaSLlveI9kR39nJGCfpG4jaa9wzrDZoGxMVqcb5lom
 2lk928I4AhH9pv0HaEureytyqh346tE1o0HEewg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FsAQBbFKRqhR/86qxaglmCQYFsMwQLSY1ShliCJIQ7h?=
 =?us-ascii?q?zmSJ4F8Ag8BAwENUQQBAQECBIR+Ao4GAh4HAQQwCQ4BAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8NjBoBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CDX4BAQECAToGAQE3AQQLC0ZWBhODAoIjByQnA8QGgTSBAYIMA?=
 =?us-ascii?q?QEG3DSBawkVgTiIXgGJenonG4FJRIEVJ4MEPosIgiaBDJQIUngcA1ksAVUTF?=
 =?us-ascii?q?wsHBV5FQwOBBiNLBS0dgSMhHRcRHlgbBgUSICpBQyMDPoIjPyMZNnqBCV6BK?=
 =?us-ascii?q?ylgAQIQF0YuFYIIAoJUgSNeAgFJQw4HRVMJJ0sSTCkiCAULbT03FRkEkDYfg?=
 =?us-ascii?q?2yCMJcJjHOjMIQooXYEL5dTkxqZCKlDgWg6gVwzGggoCIMiUAMZD44uDQmIc?=
 =?us-ascii?q?8cIQjU9AgcCBw4DC5IcgUwBAQ?=
IronPort-PHdr: A9a23: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
 RwSzuGhRbk=
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:Qy0nQqAgd5Shb1/lHek955DYdb4zR+YMi2TDj3oBNSC8cqSj5q
 STdYcgpGDJYVcqKQIdcL+7SdG9qB/nhPxICMwqTMqftWrdyRmVxeNZnPDfKlTbckWUnIMwus
 kAE9kcNDSzNykBsS+Q2njeLz9U+qj/zEnev5a5854Cd3AOV0gq1XYGNu/SKDwGeOCQP+tNKL
 OMosJIryGhPXwKc8W2AWQEVeDfp9vN0InrewICGgRP0nj7sRq4rLrhDVya0hMSFzRC360m/X
 XZnxeR3NTVjxiU8G6t61Pu
X-Talos-CUID: =?us-ascii?q?9a23=3AmhzgdmjKpQ+0dW1BkVjM6/QEEzJuSnmHwHTJPH6?=
 =?us-ascii?q?CVzhYbp6tT1SzpLp6jJ87?=
X-Talos-MUID: 9a23:6/XkCwgWZDkdPijkiNZObMMpMp842v6gFk8xj5Raus6tCA0vABuUtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,97,1787004000"; 
   d="scan'208";a="156609490"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGaypco29snDdf36bB2WMLTTv2XnApZprU7J9?=
 =?us-ascii?q?diRIHPpRn9TO0X9HfYmkKwrQ9RNf9ZZGbisVfS+1ODJ2vKFQktiNq56J?=
 =?us-ascii?q?1ds3SyFaWiGFlOUGhAWgKeO97V77cgmxIc1Mvm1TaenlY86/a0U7ugcO?=
 =?us-ascii?q?6A3qCtREHlOad2iCWVN2D02w=3D=3D?=
Received: from sea.source.kernel.org ([172.234.252.31])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2026 16:52:41 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4F9CA43A1D;
	Fri, 11 Sep 2026 14:52:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2FF91F00893;
	Fri, 11 Sep 2026 14:52:30 +0000 (UTC)
Date: Fri, 11 Sep 2026 16:52:28 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Julia Lawall <Julia.Lawall@inria.fr>
cc: Ricardo Ribalda <ribalda@chromium.org>, dmitry.torokhov@gmail.com, 
    bentiss@kernel.org, cocci@inria.fr, corbet@lwn.net, hadess@hadess.net, 
    lains@riseup.net, linux-doc@vger.kernel.org, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, nicolas.palix@imag.fr, 
    skhan@linuxfoundation.org
In-Reply-To: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
Message-ID: <nn19nq4n-50q0-q920-94p1-qo101s85849s@xreary.bet>
References: <20260827112949.2431233-1-Julia.Lawall@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] HID: fix semantic patch and improve its
 performance
Reply-To: Jiri Kosina <jikos@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3729
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/I35AP2zcAsYjny1e4lVjrA>

On Thu, 27 Aug 2026, Julia Lawall wrote:

> Replace "expression" with "identifier" in the declaration of hdev.
> This is necessary because hdev is used as the name of a function
> parameter.
> 
> Move the two uses of @p2 to the relevant function names.
> 
> Convert <... ...>, meaning that the contained pattern is optional,
> to use ..., when any, and exists.  This requires that the function
> contain calls to hid_hw_start, etc, which reduces the set of files
> that are considered for matching against this pattern.
> 
> Reported-by: Ricardo Ribalda <ribalda@chromium.org>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

Applied, thank you.

-- 
Jiri Kosina
SUSE Labs

