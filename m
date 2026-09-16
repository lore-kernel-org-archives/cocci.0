Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90564C88E5C
	for <cocci@archiver.kernel.org>; Wed, 16 Sep 2026 09:57:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8l1CcK75qX4HLNwsQKQ3Pw8ostGQp0lUBk8UMhzLJfk=;
  b=jEQ0LvMDtd6C01v8GMkCJ0DfYALF4jUuEhmFUfgRIgggROB0B+vtbThs
   JezmF2BEsbM7BigCdxu6vZpyemU3T2ETx9UAaV0aHrrymeC2YjZsMc8fR
   YwfTqgZG22I980Xokq68xpOTaSA7n+7fsVkB5hBGTQnFVlcqBeHdlG66a
   Y=;
X-CSE-ConnectionGUID: gwZFWpDPRTGJj3IolUIz0Q==
X-CSE-MsgGUID: nKvvKC6wSHWi03zRn9Lqpw==
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
   d="scan'208";a="295251526"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Sep 2026 11:57:06 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2B41F82718; Wed, 16 Sep 2026 11:57:06 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id B1D9F817D9
	for <cocci@sympa.inria.fr>; Wed, 16 Sep 2026 11:24:34 +0200 (CEST)
X-CSE-ConnectionGUID: gspADVmkRLC2ETLXIF1djQ==
X-CSE-MsgGUID: GZkVx3jkTUyzV0QG4TlRow==
IronPort-SDR: 6aaa6052_RSL/x3O+L2veYYnOrEyqNnbrgh+oGDru8YqdmcJEyWC0X30
 bnzwNekraiVoi0SftDg7sNf7yt+clVQaCjUderA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EKBQCkXqpqfIzhfUpaglkCgj+BbDMEVI1ShliCJIt3A?=
 =?us-ascii?q?odThHGHHT0CDwEDAQsBAU8CBAEBAQIEOIESAYMzAo4IAh4HAQQzBg4BAgQDA?=
 =?us-ascii?q?gMBAQEBAQEBAQEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEiGQcOEimGTw1JA?=
 =?us-ascii?q?YROgkKCNAGCCwGBJGECBQM7AQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBBQIsXgEBAQECAToGARsdAQMBCwYFCw0uIhEBBQEcBhOFJQEGE?=
 =?us-ascii?q?AEDECcDBLZYinh4gRcFAhaBAYINBtprChkoDXIDgWgCBwkBCwGBN4R4Kk8Og?=
 =?us-ascii?q?kAfAYV4hAJ6J4IohEA+hFgEhiwEgiKBDJRFAQcHHxIIAQkTBggCAkgLChIDB?=
 =?us-ascii?q?AMEBAECCxMJAwMCDgIIAwIIBhkBPxIEEwIIAwYECwcFHwoCDBQKKCIEDisKA?=
 =?us-ascii?q?zUSDxsVAQgGAgIEBAIEAgoCCQICBQMEAgQNAwQBAQgCAgMqAwEDGQgJCAILB?=
 =?us-ascii?q?REYDAsHMQMQCQMCHQMUEQUIETQIBhYBGgYFBgsBIBYUAQUMEQECGwIfBB0BE?=
 =?us-ascii?q?AgDAQcDEQQCAQcCAwQWBAIUCiEDAwIDBQEDAwMFAgIKBgcBAQEDAgIIAwYDC?=
 =?us-ascii?q?gkCBQMbGAQBAgIDAgECCAMHCAMIBQMEAgMDAwQBAgIBAQECAwEDAwQDAQMDA?=
 =?us-ascii?q?gEDBwICAwMDCwECAwMFAwMFBQICBQUDBQICCgIDAwMCAQMCGggDBgMSARADA?=
 =?us-ascii?q?wYBAwcDBwIEAwkCCAMDCAgDFwMDBQECAgQDAwgIBAMDBAICAwwFAwIDAwUDA?=
 =?us-ascii?q?wcCBAIEAwMBBQECBwIDBwIBGAMCBAgHBwUCCwQCCAQNCQQCBAICDwQGAwMHA?=
 =?us-ascii?q?QECAQcFBgMCAhABCAoFBgICAhwDHQECAQ8GAQkFAgEFDgcFAgIYAwYBAQMGB?=
 =?us-ascii?q?QEDAQoLAQECAQIKAQIEAgUDAwEDAgMCBgMDAgUFBQMJBwUOCQEDAwYFAgIDA?=
 =?us-ascii?q?gMBAggEBgUDAgIDBQEEAwQDCgMCCAMDCAMMAhoCBQMDAwYJAwcHAgMHAwIFA?=
 =?us-ascii?q?gcFAwMFAwYBAwIBAwMICxUiAwEFAwMCAQMCBQMDGAICBAUDAwMDAwgEAgIBB?=
 =?us-ascii?q?wYEAgICAQUFBQQFBgIEAwgBAQUDAwoNAQIHDAMMBgMHAwMEBAMCBQoCBAEHA?=
 =?us-ascii?q?wMHBwkHAwIDCAEBCwQBAwMKAwMFAgEBBwUDBgMHAgMDAwUEBQMCCwMHAgIDA?=
 =?us-ascii?q?wMCKQEBAQMDAwMDBAMBAwEDAwcDBQMCDgIIAQoDAgYDBwYDBQMDAgECAwMFE?=
 =?us-ascii?q?QMGBAUGGQIGEToBCAIDAwEUBAQFBQIFFQIIAQMDBQMDAwMCBQMBBQEBAwMFA?=
 =?us-ascii?q?wMDAwMDBAEDBAIDBwYIAQEBAggDAwIFAwMDBAMDAgECDQQCBQMGAgIEAgQBB?=
 =?us-ascii?q?wMJCQgHDAE8DAcKJAQEDCoBFRQFBCUZZwcHj0QfglmBFVuBT4FQAaNooT0zC?=
 =?us-ascii?q?gYBgkmBCk6BZpMdjFkaM5dTDJMOLodmkHSkWoQ+AgoHBxEkEoFIJIFcMxojg?=
 =?us-ascii?q?QFtgUlQAxkPjmCDRMwbQjU9AgcCBw4DC4VBJhOEWYdJgUwBAQ?=
IronPort-PHdr: A9a23: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
 MTpoSsanQ1ka9ExKOrbI68bljBt
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:nLJyL6sMmeYFgqxCVRTmI7KC7skCLYAji2hC6mlwRA09TyXGra
 2TdaUgvyMc1gx7ZJh5o6H6BEGBKUmslqKdkrNhR4tKPTOW8ldASbsP0WKM+UyGJ8STzI9gPO
 JbAtBD4b7LfBVHZKTBkW+F+r8bqbHpnpxAx92utkuFJjsaCZ2Imj0JbjpzZXcGITWua6BYKL
 Osou584xawc3Ueacq2QlMfWfLYmtHNnJX6JTYbGh8O8mC1/HyVwY+/NyLd8gYVUjtJz7tn23
 PCiRbF6qKqtOz+4gPA1lXU849dlLLau5V+7Y23+4kowwfX+0WVjbdaKv+/VfcO0aSSAWMR4Z
 nxStEbToBOAj3qDyaISFDWqnTdOX4VmgPfIBmj8DfeSIXCNUwH48Ytv/MnTjLJr0Unp91yy6
 RNwiaQsIdWFwrJmGDn68HPTAwCrDvDnZMOq59ms5Vka/poVJZB6YgEuE9FGpYJGyz3rIghDe
 l1FcnZoPJba0mTYXzVtnRmhIXEZAV6Ij6WBkwZ/sCF2Tlfm350i0Me2cwEh38FsJYwUYNN6e
 jIOrlh0OkmdL5cUYttQOMaBcenAG3ERhzBdGqUPFT8DakCf3bAsYT+7rk57PyjPJYI0Jwxkp
 LcV04wjx96R2v+TcmVmJFb+BHER2uwGTzr18FF/pB8/qbxQbL6WBfzPWzGU/HQ0cn3LverKM
 pbYqgmcsMLBVGeabp04w==
X-Talos-CUID: 9a23:BIM1ZmOGWpZJme5DVzJ/3WIqH8MfVlaH4Uv0E26WUGprcejA
X-Talos-MUID: 9a23:os5oAgjqpPmq2p+x/BxUcMMpG/Vr3bT1CkMxrIQUhZG9GnBMPw2ak2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,103,1787004000"; 
   d="scan'208";a="295242561"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFKtLd1A3VdD4As61lLobCtr5OqEY4rjN6srI?=
 =?us-ascii?q?tYFdktn1m+n3D//6AIRaf6DY9BFCXJ6Xb7xyUVzh1jN3fi/mhKNVF8hd?=
 =?us-ascii?q?cTvNppk+bybAuXiEkPGYAAid0WC2jjCptBMQc/2tmlqFhaPi/99g0w58?=
 =?us-ascii?q?NIxLWqB2xQTwVDjRnk1BzxKQ=3D=3D?=
Received: from mail-wm2-f12.google.com ([74.125.225.140])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2026 11:24:34 +0200
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49cd5462b69so3938245e9.1
        for <cocci@inria.fr>; Wed, 16 Sep 2026 02:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789550674; x=1790155474;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8l1CcK75qX4HLNwsQKQ3Pw8ostGQp0lUBk8UMhzLJfk=;
        b=TxfwrbGtZ46mvX1vlCNIP4T0hL9L6S3bMDLNaas5tr22K60JnKTU3cCoZGZl+X/15S
         7R7CedsCpTD4qpjbgALVmEZCYHOEsqqBBmGbRO+nhsLW8q+PpDdZZ4y84SM6lGtft51h
         1ccgkFmzTXG9ScOnP25l3h48G/4lqAGDPwQd9wDGvqH69WGds/B0urIYPgQC0ATyU2Fp
         641sFS59AjRWJQ9xMq/3mKGjLVU4WkvsmVc9aq/6XKfhNeH/T9UhGR0uhCd1ZcevRMwl
         +NSXYF68vGfJATj/4I+NYYBMSfiAMohTrPLp/aXvzE5DwvUKBbMbxBd5RgYUVhbeP2ta
         0MTw==
X-Forwarded-Encrypted: i=1; AKwUvByKubgHHYjvUi3B/Cwc+L1XnU5MYlFgaHUcqMyKjsDTL9UtlTawH8j7baUhKOYalDO9IZVgig==@inria.fr
X-Gm-Message-State: AFuF++l5TxJPc0yGoELBSanomGMzIesJL5Q72EQ7/ueYAzbJRMv0B+B/
	hPAcgc4zQ9afxH2ka8zZv8nxG6Z17bQUp+8KmqphoxKjWLxYhp4/XVle
X-Gm-Gg: AYBFou3wvg4LlcNYvAxBsFQv7kZzXSoo5DOe96Nvm7LijXCxzRxPH81o+fdSgVtemIm
	rOH8M9rcDp13l3P70fwJyMJqOLkXQKmCtf4bpZr1DaA/pRw8R8HgIV1WEYkc6Mc+cNlX5ZV2ZVI
	7JdTDAMP6QFxTPjYRdFqZHMrEkVyzMEs9WUsR7/qobqBweUsMapZPJhnOWm7L+4cumzJk6UMcuU
	zszm9c8RZKPAYqiNCB0akU9HT5ksv7gZaIfOMpb//m1G961fFF9EzZN0/R3A3rZ6+hFbuHBl89o
	X3e7padw0IKrMTO2eaJasXQ/S+evr1SBOZ59nXhTWaNSAnbAjcB6P7LyqGUbKPjd9UzAoBJC6UE
	W6FSmS7gMGafmNJZ6CRPG9pqfPtos6O3xgiDpGPH0LvFr7fm49rL9nq/UPGu1npqL9KNWVI4qmn
	w+UrSQj2SDz0ApROXj9RVUMWM7xJkGu/+uTGI5voz54PCS7JunntSIa2TO2D9ZTrWzo4hRmFEbP
	3jeUJwrn/x/yBz556DPgYnoqjKqk8tXYwRh/zzjeVSxhHhT4jX0lhNQWNSDNJIrhUjjvy6XReDb
	GWGU45J/qKWrJIbdeZs0/FsyKti/KXLfgbgaBavi7+gaBNMqe2GAAuMXMusczaghiU30+T8vEqd
	/fWlj/I3jYZra9lcGV0WEMAe8pb1Hr3dgTjt1elGS6t7YuOOBu7E1OvxKMwUIxjyzfEAoDiLfce
	Ae3/7DdxpFb6O7T8Wk
X-Received: by 2002:a05:600c:3b97:b0:49e:6050:9fbe with SMTP id 5b1f17b1804b1-49ebcc010d5mr41139825e9.15.1789550673785;
        Wed, 16 Sep 2026 02:24:33 -0700 (PDT)
Received: from localhost (90-182-112-124.rcp.o2.cz. [90.182.112.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e84202028sm48192515e9.0.2026.09.16.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 02:24:33 -0700 (PDT)
Date: Wed, 16 Sep 2026 11:24:33 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Johan Hovold <johan@kernel.org>
Cc: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org, cocci@inria.fr
Message-ID: <20260916112433.00006c8c@gmail.com>
In-Reply-To: <aqpflCAorrufh1i0@hovoldconsulting.com>
References: <20260915064327.1377-1-joshua.crofts1@gmail.com>
	<aqpflCAorrufh1i0@hovoldconsulting.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: api: add a checker for
 pm_runtime_use_autosuspend() usage
Reply-To: Joshua Crofts <joshua.crofts1@gmail.com>
X-Loop: cocci@inria.fr
X-Sequence: 3737
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-09/F2sdseNc78cpces55XOP8g>

On Wed, 16 Sep 2026 11:21:24 +0200
Johan Hovold <johan@kernel.org> wrote:

> On Tue, Sep 15, 2026 at 06:43:27AM +0000, Joshua Crofts wrote:
> > Add a checker for ensuring that pm_runtime_dont_use_autosuspend() is
> > called in a file if pm_runtime_use_autosuspend() is called and its
> > devm_* counterpart isn't present.
> > 
> > Without _dont_use_autosuspend(), removing devices causes resource leaks.  
> 
> No, as I've explained repeatedly elsewhere, it does not cause any
> resource leaks. [1][2]
> 
> The autosuspend setting leaks if you will, but that only matters in the
> theoretical corner case of someone rebinding a different driver (which
> will soon also taint the kernel).
> 
> So don't exaggerate the impact, this is essentially just a cleanup,
> which is fine in itself.

Yes, I got your point the first time. I'll edit the commit message for
this patch and all subsequent patches based on this script.

-- 
Kind regards,
Joshua Crofts
