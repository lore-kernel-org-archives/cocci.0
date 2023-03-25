Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 978A5C6FD1F
	for <cocci@archiver.kernel.org>; Sat, 25 Mar 2023 09:20:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wDIMNVzQLAo/QH3A81Pxr+xVCK0Uf5w+w0MZYhSfwlA=;
  b=IBbKhlfSiKU5/38Xju64Grj/oEyBldOvWlUCadcpMrKOaQDiDRG07u17
   DpMh6ZgAXoaN/oE5jLhqtdjYlVmOx1t6LbMLVBgwQpEMDiVfgI6SdPfxV
   7eFsMZJX7ej0RDoomugUdZJxKIayBgFckdWKpcqGIoeCyWW0pljvOsVXd
   s=;
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
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="99045898"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Mar 2023 10:20:53 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CBF1DE0D44; Sat, 25 Mar 2023 10:20:51 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2C538E0D40
	for <cocci@sympa.inria.fr>; Sat, 25 Mar 2023 10:20:49 +0100 (CET)
IronPort-SDR: 641ebcf0_j2vVgnooV1U93N2c98785lnYSyIcOsMJKl6PReZa4I1Xc+C
 RlzACUvINCk/mF1C1uEzmyjOM1Pdi427fNgECsg==
X-IPAS-Result: =?us-ascii?q?A0HHAACmux5khwwR49RaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YItgUsvBAtGhFORATGEL4cshzqIaYFqgSw+DwEDAQ1BAQIEAQEDBDiERgKFO?=
 =?us-ascii?q?gIdBwEEMwYOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBG?=
 =?us-ascii?q?gkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEgJHU?=
 =?us-ascii?q?z0DAyMdAQERJgEPHwYCERUCAlcGAQwIAQGCeoIoAQMxB7ElgTKBAYIIAQEGg?=
 =?us-ascii?q?mOZJx8sIlOBXgmBFC0BjQSDNnonD4FVRIE8g0GDfYEGgxmCZ4EMmEYKgTR1g?=
 =?us-ascii?q?SAOgT2BBAIJAhFrgRIIa4F9QAINZAsOb4FKAmRMgR4lBA4DGSsdQAIBCzs6P?=
 =?us-ascii?q?zUGAwsgBlhrAgkjERMFAwsVKkcECDkGHDQRAggPEg8sRA5CNzQTBlwBKQsOE?=
 =?us-ascii?q?QNQgUcEgQqBAQYBJiSdW4EPlV6wPTQHgiiBVYFZDJ8MBhMug2oBEpMLDgaSI?=
 =?us-ascii?q?5dqIIIupUyBeSSBXDMaJIM2TwMZD44gDA0JhAOPCQE9QDQ7AgcLAQEDCYVGA?=
 =?us-ascii?q?QGFewEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Ko02oanLzDPXTr1Frv+n0W7bw3PpDfL43DAbv31ZSRFFG/FwWf
 re+MjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQmVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6voSizPZLz9P+qjjzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,290,1673910000"; 
   d="scan'208";a="51219881"
X-MGA-submission: =?us-ascii?q?MDFCgvWY/qT+LdhGTUWxIF4ycK0yy7YEqirDVb?=
 =?us-ascii?q?QSneXqS4n0Qe5mMXbUyRTSoJzlMWcTiU4HEcTCPUg6wHu7IGNI58Z+hx?=
 =?us-ascii?q?cJviiHkanZAE4SG87PwZg1rZukxxTbc6i+dyXX4oDO9lGgFUgF20ep4B?=
 =?us-ascii?q?xFepJk7+AbFKYm6KliNtQ6nQ=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2023 10:20:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679736038; i=markus.elfring@web.de;
	bh=Yb2EN9MQnQJZenZSU5t1ge3z6SEb9yBsno+pOBkeqcU=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=t7d+XauIDkGtZ8rJRIRvyvirag79CAfp6nQZ3kP5IPovfPn79gUgl3cDlra9BAcBL
	 9DoHs1SjUhLc+ZaKMh4vaTPG7J+hotzaKMkcnzbo19w08caP9KBcyYltCUSt8iWaWl
	 6IGgLa2ZSGX1RYKYjCqlvFAszJNLAAeWxLUpU6lJn53GTL5D0SaXOBjJETeQX31/c4
	 d1D7jW3wEzP9gcLZ4H1xLpGTiTndJNy4vmKRJC1R2KLjF/kdVvqFZO28GWf/Uw0R5w
	 TrA8nrwrpEJtnBZatjU/4xmeM2vjQxl/5GbgxwL4kBax493V9HRZDqC52vyM0Luwlk
	 xkT5xxI570P/g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MEUW8-1phalo2lpq-00GTdy; Sat, 25
 Mar 2023 10:20:38 +0100
Message-ID: <49adf0c8-825a-018f-6d95-ce613944fc9b@web.de>
Date: Sat, 25 Mar 2023 10:20:36 +0100
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
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
In-Reply-To: <6ee3b703-2161-eacd-c12f-7fa3bedf82dc@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+v62+H9FgGMcWQjWMYlGAlLm/E6eVwaLC0wPKPFv/3kqksT+wls
 U+AwTK1iUCMFeElrXbUXPG59MJQvnT3SMeZw44IFoJf+ZSYFr6KSMnZsXIuz7XQ6E2WhdqP
 uq1EVjI4TkOogLl2uFxcow0Yf+oAMbngQHqe8Inmw8q+HdhlSuLpzjKY8VPtllAnlLFtvkV
 M7jlHEk6ysdCO8TVWdusQ==
UI-OutboundReport: notjunk:1;M01:P0:uM4ZsydJhIE=;Nd1YLcgUFIyOC6iJW0bCv8BcbFk
 sFARssTn7YDZGuJcLI0TU4TP10MO2gOJCq8yp4+SL47cah43M9QY1/T6iAYfFPSSgjgcrDS2w
 AEYknMeLk5XaOkGipK+zJqepLSkdKoHcJoSNr2aCUOWAR64RFya2sI376RgULiYDEWNaRodYo
 etApxQFrtl2U7V5HAeFAlibk75dOaSII6nloP5EQZ+TW9UymOzvdVBvMRPmVqSqDlgYmCNuAr
 Kt6XHN+Iy94Bk8mTWxdUGBdyqWzAAEF3ZXs519HwT6DHc0voLvboER5xYdbFN94fXYL9bhYgc
 CEqohH8llDojNtWW7qGvfJaEmEnkdO9iczmvwmga7ssFnNWT0CH7XPtr5XCeeLal8FZK3hmP7
 8eZnAE6C4kT7zgywZ6Hx91FAylFN4iZxL4LtnCQZppVagBCkU0gCxIzk/7+pnuMoRWw0wys3w
 BmZ4S0e9R63+eygVTsfD5ENv5bDszt1vGYeSudIhScDlx/r2NcdH0VTKYeD9pAYtCi1LK99qv
 5HaYBL+u4CegGnqmZxnmRJQWzN0cdY5Tca/YsgrzMk9DeaquU8tNthGcHov4cJLLbRC8S2ywc
 nm5eJdX82v8qBix4g2UP3OgDCWGCI+TanMgRBuB3qCAzauj9y6L+2sa9EZG1StML4m2AxI2/v
 GGYewC3DM50Ku0FoZfn25m87SytQXB6XxgidkoDx2IiF+lFSX9xvc83MNeRWyJhRfF7pQqAzQ
 sQXuSfM1lB6jO6v30OmZ7YFagkGV8bIUXe2hZQoSDWPTVqjULl6rrJ/UHRF8pN/9FmdIcTTV5
 3cSZWapaTgEfv4CDofnv/oxkP3QW9XwirKR2xWbKxlURYS3GYkI4mXpFbDAPHBB1FGZnUSxts
 lLTPKC175VsjTYUUipUSrrxh2AOKhopjV2Pk+S4Fm8bxazFVlXyAvEW8e
Subject: [cocci] [PATCH resent 0/2] md/raid: Adjustments for two function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 929
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/49adf0c8-825a-018f-6d95-ce613944fc9b%40web.de>

Date: Mon, 20 Mar 2023 17:28:05 +0100

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (2):
  raid1: Fix exception handling in setup_conf()
  raid10: Fix exception handling in setup_conf()

 drivers/md/raid1.c  | 75 ++++++++++++++++++++++++++-------------------
 drivers/md/raid10.c | 42 +++++++++++++------------
 2 files changed, 67 insertions(+), 50 deletions(-)

=2D-
2.40.0

