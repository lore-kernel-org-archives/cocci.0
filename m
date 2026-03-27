Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6856110ED656
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2026 10:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=v8zsjPB59+AVlMwWB30wKFExXpJ3F4tl4r983mXyX80=;
  b=g9Yv9BBUlhJy+nHyxSMWIx45s4qW+6miBGcB4iTZBQhBxksH0B7j5kJM
   AYUXaJP713uanumcTnRZ8/gp5P5/sxSJtTtIcuh4HuANKnr7KbfX1YIvz
   6IKRF/mpxyZJPbmhRtfvwbkWiXdD8wOP7x9m4rm0nPF1snFH48Q12jlyz
   A=;
X-CSE-ConnectionGUID: ml9bVT2jSVOQBVBi3JlyUA==
X-CSE-MsgGUID: L9UQ/qnSTHitWO7inIBu2g==
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
   d="scan'208";a="269791302"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Mar 2026 11:50:47 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 89E2D8191A; Fri, 27 Mar 2026 11:50:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 5F9118176C
	for <cocci@sympa.inria.fr>; Fri, 27 Mar 2026 11:49:58 +0100 (CET)
X-CSE-ConnectionGUID: 9vnfkF+zQDu2v8zAtjqc9Q==
X-CSE-MsgGUID: xhvNHb4DSO6Rmj0JtDCnOg==
IronPort-SDR: 69c660cb_T9FqWlB2oW4CWe5OZolOPDRMIEo1zsiC/hxDGwiuGHrUOzJ
 XJfyKZbHSIIqG5UIGsrMs+2pADt/y1Fo259SV3w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HyBAD7X8ZpchAmd6hahRqBZTQHCEmEWIh7iHycRYNSA?=
 =?us-ascii?q?g8BAwENTgECBAEBAwEDhQACjScgBgEENBMBAgQBAQEBAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEFAQEBAgEBAgQGAQIQAYEMhk8NgmIBM4IWLAhjAR8BAQEDIwQZAQE4D?=
 =?us-ascii?q?wsYAgImAgJWBgGFNwEGSgO0Bn8zgQGCDAEBBoJp2UGBZwmBHy6Fb4JmAYFwh?=
 =?us-ascii?q?AQBO4Q/QoINhD8+gQUBhxiCaYImgQ4dhmeKWQlJeBwDWSwBVRMXCwcFgSNDA?=
 =?us-ascii?q?yovLSNLBS0dgSMhHRcVH1gbBwUSISqBAw+GZXkDLngOIgIoEVxKPgtSBYITA?=
 =?us-ascii?q?oEgLgMLbT03FBuOADGEDoJXxjeEJoFkoEGBS4ImAaZ5mQYiqR+BfyOBXDMaC?=
 =?us-ascii?q?CYKgyJPAxkPjjiIQcEJRTI9AgcCBw0DC4VCAYxZgUsBAQ?=
IronPort-PHdr: A9a23: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
 Bg7llknCQzC3Czt+0wwIkfWpSw2iw83lMm32Fis
IronPort-Data: A9a23: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
 abZiIyErIyGpZbNLPtd
IronPort-HdrOrdr: A9a23:yd05uazIV99ysJi/8Yu+KrPwH71zdoMgy1knxilNoHtuA6mlfq
 GV7ZYmPHrP4wr5N0tApTntAsa9qDbnlaKdgrNhWotKPjOKhILAFugLh7cKgQeQeBEWndQw6U
 4PScZD4ZHLfDxHpPe/5AG8Dd46zJ2N+LOhjfy29QYKcT1X
X-Talos-CUID: 9a23:06azxm0W33acY7AhIHUWyrxfS94jfH7zj2XpD1LiFzZ7YaGXUFTBwfYx
X-Talos-MUID: 9a23:Ym1PSwTksccTKhEzRXT8hC9EFM00z5+JVnoIk80kp+WvMwt/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,144,1770591600"; 
   d="scan'208";a="269790734"
X-MGA-submission: =?us-ascii?q?MDGpzGeKIuWX3HuJJ+HmUftKE6zNLZBnpGcy8I?=
 =?us-ascii?q?4xdicDow6bZsQ0AL2o/q/ozE9BuZ+HP9N7I7kW+Lm+5TKK+qnlPAt9Dg?=
 =?us-ascii?q?oWswk/dTzAMRDOFMNcs7wkV44ntqUnrE7ErM7KJ0hC2ZQ9eHe+8nP3Xx?=
 =?us-ascii?q?kbI8ySv2gp2Kr/ytKUZO5IqA=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2026 11:49:47 +0100
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1w64l8-0000000EBHl-2FWM;
	Fri, 27 Mar 2026 11:49:46 +0100
Message-ID: <7876e6c9ef1479122cedf66497d4ecaebc564b71.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Victor Gambier <victor.gambier@inria.fr>, cocci <cocci@inria.fr>
Date: Fri, 27 Mar 2026 11:49:45 +0100
In-Reply-To: <15727dea-42b9-4dda-a006-2c383cbc7619@inria.fr>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
	 <e9273f8b-7e6d-4441-8681-3f9044c23257@inria.fr>
	 <15727dea-42b9-4dda-a006-2c383cbc7619@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 3460
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/sst0LtgSSoa76QCsge9JfQ>

On Fri, 2026-03-27 at 11:43 +0100, Victor Gambier wrote:
> I'm happy to report this performance issue was identified and will be=20
> fixed in the next release.

Nice, thanks! I went with the <+... ...+> version at the time, I think,
so I didn't really have this issue any more :)

But it's great to see performance work in general, so thanks for that!

johannes
