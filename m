Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D882910ED65C
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 10:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=kVFwZCuR+IoKjLPlwhT5pETmVhvtzHuWlvUbqLlgWcE=;
  b=G4nKu9FCRlZtlr2Ix4863oh6QphH99eC55vYGwbvLr7NYHOhmok0tkIO
   PDEnzOLQeT9/ZeZlEP5S3F2MUpCJO/U/D4b4C6px/tAoCkinqbdz2GBmC
   0C2WPiFbADU4yByl1SDC+17F5NR06vO+lrlBVs+Wp+pOAjcOvLne5WVxE
   w=;
X-CSE-ConnectionGUID: XkOQNfCtS76HmCWqEgI5Vw==
X-CSE-MsgGUID: gLz/aXIYToCarvCejuiJCA==
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
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269791455"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 11:51:07 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 07E8D8191F; Fri, 27 Mar 2026 11:51:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 76E4081531
	for <cocci@sympa.inria.fr>; Sun, 22 Mar 2026 21:53:21 +0100 (CET)
X-CSE-ConnectionGUID: ybM7sZ0hReKwD4FDnlRrRg==
X-CSE-MsgGUID: msX6EehUQlKI8JXjDAyo6Q==
IronPort-SDR: 69c056c0_iowHFQ/UY665SrGli08ySWJgoTqyfT8bWVw362BuhMA8XWl
 a1Qj/1oucCPW6rJ3xqsvkpp4kvJFE2skbZdRzCQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EuAACpVcBpchxYTy1aHQEBAQEJARIBBQUBgXwIAQsBg?=
 =?us-ascii?q?W1TgWYzBAtJjHSHN4IkMJ1qgX0CDwEDAQ1PAgQBAQMBA4UAAo0kAh4HAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBAQEBDQEBBQEBAQIBAQIEBgECEAGBDIZPDYJiA?=
 =?us-ascii?q?YETEXQwKwINfgEBAQIBQAEBNwEECwshJQ8BRgYThSUHIycDAQS2A4EBggwBA?=
 =?us-ascii?q?QbeEQkVgTgBiFQBhWwJhAB6JxuCDYFKgnU+iweCJoEOHZI2UngcA1ksAVUTF?=
 =?us-ascii?q?wsHBYEjQwOBBiNLBS0dgSMhHRcVH1gbBwUSISqCKQ+GZXkDLngOIgIoEVxKP?=
 =?us-ascii?q?gtSBYImAoEmAwttPTcUG45WO4I0gQ+BeJdBAY8RoQ6EJoRwnQIzg3ETk1qTD?=
 =?us-ascii?q?ZkGglimaYFoOoFcMxoIJgqDIk8DGQ+OIYhYwzUkNT0CBwIHDQMLhUEmE4wig?=
 =?us-ascii?q?UsBAQ?=
IronPort-PHdr: A9a23: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
 nO6RjtGp06g1O+C1mg/OCc=
IronPort-Data: A9a23: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
 Y3tHnDDSfh5hE0EIBy1fWC/Ut37wUuRWdUNQ38=
IronPort-HdrOrdr: A9a23:IaZvKKMYs3edxcBcTs+jsMiBIKoaSvp037Dk7S5MoH1uA6ulf6
 LHpp8mPHrP4gr5N0tQ++xoVJPtfZqYz/5ICOoqTNOftWvdyQ6VxehZhOOO/9SjIVycygc378
 ZdmsZFZ+HNMQ==
X-Talos-CUID: =?us-ascii?q?9a23=3APCwarGoExR08UvTQiMFVQhbmUdEvVyLG/i/QGUK?=
 =?us-ascii?q?bFko1ZpGTTWWKwqwxxg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AkhEyZQx2If/iIFh/zVgMCymWEi6aqKG1OB4gnJU?=
 =?us-ascii?q?7gs2nFHxSCzWxpSWwHLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,136,1770591600"; 
   d="scan'208";a="142015813"
X-MGA-submission: =?us-ascii?q?MDFZoSX6cetvm4VEFppD/be+gF9QhJQxjmcWVg?=
 =?us-ascii?q?doobEtPFFdNmAUxK365/dGMGFJQe6d5GBMiV0m4Dh8LXEGIXz7QFiYcg?=
 =?us-ascii?q?R8Wh63lkIKfFHjQPcPdI5LQtVd9EKmuBrePLMNLfIgk28ke3TF5n/n7y?=
 =?us-ascii?q?LcyrNjbLN5XEJhi8XRS34l7Q=3D=3D?=
Received: from ms.lwn.net ([45.79.88.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2026 21:53:20 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 7C584411E2
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 7C584411E2;
	Sun, 22 Mar 2026 20:53:16 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Julia Lawall <Julia.Lawall@inria.fr>
Cc: Shuah Khan <skhan@linuxfoundation.org>, workflows@vger.kernel.org,
 cocci@inria.fr, Nicolas Palix <nicolas.palix@imag.fr>, Hu Haowen
 <2023002089@link.tyut.edu.cn>, Alex Shi <alexs@kernel.org>, Yanteng Si
 <si.yanteng@linux.dev>, Dongliang Mu <dzm91@hust.edu.cn>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, Federico Vaga
 <federico.vaga@vaga.pv.it>, Carlos Bilbao <carlos.bilbao@kernel.org>,
 Avadhut Naik <avadhut.naik@amd.com>, LIU Haoyang <tttturtleruss@gmail.com>
In-Reply-To: <20260310121431.362091-1-Julia.Lawall@inria.fr>
References: <20260310121431.362091-1-Julia.Lawall@inria.fr>
Date: Sun, 22 Mar 2026 14:53:15 -0600
Message-ID: <87ikand1s4.fsf@trenco.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2] coccinelle: update Coccinelle URL
Reply-To: Jonathan Corbet <corbet@lwn.net>
X-Loop: cocci@inria.fr
X-Sequence: 3463
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/cnnYmA9h2nNpYtS-3ZKPxg>

Julia Lawall <Julia.Lawall@inria.fr> writes:

> The LIP6 URL no longer functions.
>
> Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>
> ---
>
> v2: corrected the character encoding, no other changes
>
>  Documentation/dev-tools/coccinelle.rst                |    2 +-
>  Documentation/translations/it_IT/process/4.Coding.rst |    3 ++-
>  Documentation/translations/sp_SP/process/4.Coding.rst |    3 ++-
>  Documentation/translations/zh_CN/process/4.Coding.rst |    2 +-
>  Documentation/translations/zh_TW/process/4.Coding.rst |    2 +-
>  5 files changed, 7 insertions(+), 5 deletions(-)

Applied, thanks.

jon
