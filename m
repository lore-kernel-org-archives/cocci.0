Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C58C7618A
	for <cocci@archiver.kernel.org>; Mon, 20 Mar 2023 16:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:references:cc:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nM1wPI7c+EvP8BRCkFopQj/ONIH+560YLB+rYNdm9i8=;
  b=Q9W6YaPx+KREvPYTVIfiaJk7lRsz5meDHHku5FzY80uJRKldVjhtgPJx
   Eu/OH80iWIUVNe6gWPznadHwrfTEBG5MQ3jYJQXsB2DMQdpwMOeZsOq2p
   xPzUN+VEISVkXQbfxnmF+n3ZWsCh6NvBrQdek9UmKM4PbFU7APgbD9MJM
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,276,1673910000"; 
   d="scan'208";a="98147247"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2023 17:49:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id DAC9EE0C95; Mon, 20 Mar 2023 17:49:37 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24B22E0AF5
	for <cocci@sympa.inria.fr>; Mon, 20 Mar 2023 17:49:32 +0100 (CET)
IronPort-SDR: 64188e89_rLrC6WDQnAUrh+vbkYJvk4LWJvR1b7yvm+nkjebIi3E2ZMN
 ZD1fPCyeaRKWRmIiRvWIxcjjKj5BJzgk6i9UCLQ==
X-IPAS-Result: =?us-ascii?q?A0GWAAAnjhhkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYItgUsvBAtGhFOPCoF3MYQvhyyHOohpgVYUgSw+DwEDAQ1BAQIEA?=
 =?us-ascii?q?QEDBDiERgKFNgIdBwEEMgcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECB?=
 =?us-ascii?q?AQBAQIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBEgJHUz0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB7Nsg?=
 =?us-ascii?q?TKBAYIIAQEGgmOZJx8sIlOBXgmBFCwBjQOEMCcPgVVEgTwMgzWDfYEGgxmCZ?=
 =?us-ascii?q?4EMl34KgTR1gSAOgT2BBAIJAhFrgRIIa4F9QQINZQsOcoFLAmRPKSUEDgMZK?=
 =?us-ascii?q?x1AAgELOzo/NQYDCyEGWGsCCSMREwUDCxUqRwQIOQYbNBECCA8SDyxEDkI3N?=
 =?us-ascii?q?BMGXAEpCw4RA0+BRwSBDXwKBgEmJJ0LgQ+VXrA9NAeCKIFVgVkMnwwGEy6Da?=
 =?us-ascii?q?gESkwsOBpIjl2oggi6lTIFpBS6BXDMaJIM2TwMZD44gDA0JhAOPCQE9QDQ7A?=
 =?us-ascii?q?gcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 OzyMUEc8vR8Ll+FiArTCjGGbT9b+87n
IronPort-HdrOrdr: A9a23:ZCqzaapLZFmZncNMeSJ0q7waV5r/eYIsimQD101hICG9vPbo8P
 xG785rtiMc7wxhIE3I+OrwQZVoJEm2yXcb2+Ys1NuZLWvbUS6TXedfBOjZrQEIeReTygc178
 4JHpSWSueAaWSS5vyb3ODXKadE/PC60OSPmfrUyWtrQDpncqd68m5Ce3um+wFNJTWvHvACZe
 GhDyd81kCdkf97VK6GOkU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,276,1673910000"; 
   d="scan'208";a="50722803"
X-MGA-submission: =?us-ascii?q?MDF3GltO6ZdbevOLj6dEGQVaz5By9Ip2tzow1A?=
 =?us-ascii?q?+L/yUPg5RkTfK0X0mfPXoWOziEQjLMcF1R+ze+604MKWC9Y6e91UwN/c?=
 =?us-ascii?q?bQUol03Gi6Q5SCjTM7Sr8VwDwrtqbP1GjLgcb4otGZudij+ws1EAUTfC?=
 =?us-ascii?q?5BVNQmFsxs9dtlO5LcFR36pg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 17:49:14 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679330874; i=markus.elfring@web.de;
	bh=nM1wPI7c+EvP8BRCkFopQj/ONIH+560YLB+rYNdm9i8=;
	h=X-UI-Sender-Class:Date:Subject:From:To:References:Cc:In-Reply-To;
	b=IFUoF39exMyIERxS9x3v4Rr0qysv9Cj+6avOfE0N9dS/RxELUMlTC3bob2X28DKfO
	 WuZdoH6p2M9xHARkXXb/0X10Gc9ZmwyBkkCdQ4vJrwROJRuPhoyqn/l9HnBGtLql9S
	 qGG8VQNAWeSvMSVSkJNS47zjswnS5UiEyb5RSrU5qe3yR/K2bQht/QHWVTaOE5kFFM
	 PjR874s+WzYVefMLrQ/9C/WctoHGFXTY/EgdFtUisO6YcWdGfF+5vGG9nscaGn0SH3
	 jqzh48Kut7uiOp6v3VT4Zts9xshGhYgZv59vPk4BAEs2c5dd32cpmwcXrqzvCrKHEs
	 ijTbYRgPRY+zw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6sBp-1qZBu11cEB-018Mop; Mon, 20
 Mar 2023 17:47:54 +0100
Message-ID: <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
Date: Mon, 20 Mar 2023 17:47:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: kernel-janitors@vger.kernel.org, linux-raid@vger.kernel.org,
 Coly Li <colyli@suse.de>, Jens Axboe <axboe@kernel.dk>,
 Kent Overstreet <kent.overstreet@gmail.com>,
 Maciej Trela <Maciej.Trela@intel.com>, Neil Brown <neilb@suse.de>,
 Shaohua Li <shli@fb.com>, Song Liu <song@kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YWIbXC/Bw0dNVz5O/hmuZENB5g+3v6lEd7bVTbOTK4FbF/GnYtB
 2I1ulgtN1vzS2ulBMg1IWVETDsq6GrEVdELMNRvwONuSoHBGutZMj2Aap8reOe110/qsqHJ
 ZmvdC0MbJsJwbcUpH2E5R9jlf1Me9RWxA8sjxx61Bi4gyGKdSQwphFKpPmwt5NlGIShpfB0
 mLipzsFgymD59N3qht86g==
UI-OutboundReport: notjunk:1;M01:P0:sFUrCTg/C7g=;YIvE/ASsa6wMf0I4Y4h0Nx759st
 Nb9OhMKdOxKuIOwn9486rD7d1f4ASHqIuP/Fu/l4zQdG41rWm7OHDpPCWmVHfuKWExYi4kgKd
 Mv++9zfDBVYGk2HcnQEIJn4XIw3PuLGrLA9vhtvnh3c9oO8OBNfh6ONOdgpDIK3wImLRNGewg
 dHstzsiWrKqegeBZ1pbetQbmyH8Mq3ImwC92XyotdpGW2SDp7FRnHg9sQUXIzO8UnlBVvdhdS
 O9DDzFUg3ukpHY0o/qW1ti9iAr3rUCFemsdMZf9zUg6GPGTuLnW8QiYNU0XT7IjrTsFInLayg
 FoP306YvYQXIiBonjjt+4zMhnKwh1enD/PoMGSx8/yHggMwqrdWDBIZXhP/UUTIPNqs4wtXLz
 fmihtl3wMZNlX8g/3sXA102eD3F8TDz1gwQt00+p7WXksRyzD/Xtz7ccWx+me2ItGNTvuxnvm
 gzml2bRv5EMqYYjS2Xwcvc48Y+5DJv+ms08t1FCumMTp5ddPHiDmVRMPzoapov7tpAlUMQBdF
 B+e2Z9tSug9mbZ1Vwn2ZkzKUkFeW/6eidKw3P5PQbU8W8qNsPrHlFxTCKsSDYwnM5rdzFWNPV
 rEFPrvlbcLVdh9SmnO4G9k794hIgPhrbQKWB9P+OnkMOdv9wvAxCOKewjEou7XF1UeVYh4m8r
 6L5sfaxo+0lNAvGR0XFb+HybCI+WinhVO+IMo/ZtJFAsB3dfkrzSLnzv3yuWonzBtORhsKZ3n
 DNqn1A1yAPKcpE2Fpgw0PuBMWcDMDq7+ZoNnhP34hxo3vq0fccbUUAuZgJG4ab5Ac2dVDH7ac
 ucEPPXEjKTWg7zNy3tDuYiiMZ28uT4l85H0R9RiQaCpfU9ZSts3CMtH/T9KYga13JXjBDARm4
 h+Bf7nHMY9iMlHFqeO0bqGehfW7m6nflRbqCvLXQrSVSO4VYY31WTw6UohwkrmFF06fFuV8u9
 dV12oQ==
Subject: [cocci] [PATCH 0/2] md/raid: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 904
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/6ee3b703-2161-eacd-c12f-7fa3bedf82dc%40web.de>

Date: Mon, 20 Mar 2023 17:28:05 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
=C2=A0 raid1: Fix exception handling in setup_conf()
=C2=A0 raid10: Fix exception handling in setup_conf()

=C2=A0drivers/md/raid1.c=C2=A0 | 75 ++++++++++++++++++++++++++------------=
-------
=C2=A0drivers/md/raid10.c | 42 +++++++++++++------------
=C2=A02 files changed, 67 insertions(+), 50 deletions(-)

=2D-
2.40.0


