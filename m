Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FB2FC5CFC1
	for <cocci@archiver.kernel.org>; Mon, 17 Aug 2026 07:58:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=06mLJwL4Uya+skJAcclFI2TzrZHJaJpAths2EEz7XYc=;
  b=nG8/d8+cxBo7KAmUMxNDVHALTV+i+XO0Os6n6tcbtVCcCp2TDyIWSMwH
   5f7w3NNIv5koZBcLWBrmQiJhIYtOpjcGFs6YxGNzgJvqVmm4vmS2uLFnQ
   TJnKcPia5xRlFtSb1nsqk2UluMqSiyjA7+gPCZSUu/bT/DyT97ntMsXlJ
   0=;
X-CSE-ConnectionGUID: 4O44ONa6TNGSCZmaltamkA==
X-CSE-MsgGUID: sH2CpxRrRfuKPt+22FBXsw==
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
X-IronPort-AV: E=Sophos;i="6.25,228,1779141600"; 
   d="scan'208";a="290358505"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Aug 2026 09:58:14 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 94D15803BA; Mon, 17 Aug 2026 09:58:14 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 36065804FC
	for <cocci@sympa.inria.fr>; Fri, 14 Aug 2026 14:47:56 +0200 (CEST)
X-CSE-ConnectionGUID: k1aY6EyZTeOutzD0uZGXtA==
X-CSE-MsgGUID: hjZiZ/1eSZ2BMTO9YS3KsQ==
IronPort-SDR: 6a7f0e7b_MSi8BpjETpgBbaHB5/4/MU5s3zcQJ4T8orzi3sdR58evvG0
 RPQFnNdNi/QcN1MDALo/q0Qfv4kT+fX22mpthDg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FfBAAPDX9qhf4EaaxaglmCGCmBaTMEC0mNUoZYgiSEO?=
 =?us-ascii?q?4cpEIxJhV6BfAIPAQMBDVEEAQEBAgSEfgKNagIeBwEEMQgOAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQFASYZPDYJFAQQHAwMBA?=
 =?us-ascii?q?QwBgSGBJgEBAQEBAQEBAQEBAR0CDX4BAQECAToGAQE3AQQLC0YgNgYTgwKCI?=
 =?us-ascii?q?wcRAxAnA8M1gTSBAYIMAQEG2zQNcoFpCRWBOAGIPCABhXgbg2d6JxuBSUSBF?=
 =?us-ascii?q?SeDBD6CH4hpgiaBDIRdjjtSeBwDWSwBVRMXCwcFXkVDA4EGI0sFLR2BIyEdF?=
 =?us-ascii?q?xceWBsGBRIgKkFEIwM+OIEIQQKBdT8jGTZ6gQlegSsqYQECEBdGLhWCEgKCc?=
 =?us-ascii?q?4EoXgIBSQwLbT03FBkEj00gghMtglIygTKSbIMurzFxhCibX4YWBC+XU5MZL?=
 =?us-ascii?q?phakhOXMIFqATeBXDMaCCgIgyJQAxkPji0NCRx4AQKHXMcIQjU9AQEHAgcOA?=
 =?us-ascii?q?wuBaJIAAQE?=
IronPort-PHdr: A9a23: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
 U9pLjHJQ/RWlbQyLQhW
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:dUt2oq+yI9I09kURHz5uk+DqI+orL9Y04lQ7vn2ZKCYlEPBw8v
 rFoB11726TtN98YgBCpTn/AtjmfZqsz+8R3WB5B97LN2nbUQOTTb2KhrGSpwEIdReOj9J15O
 NPd+xRBrTLYmSSTvyX3OB7KbsdKaG8gdiVbC7loUtQcQ==
X-Talos-CUID: 9a23:DWNMEmCuDbhbKmX6Eyo+/X9KN9EXTnD60WvCDxelO0lZVJTAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3ANYtgEg5ZDk9HCK3VUSMmw6pexoxo4ZavOgdUnK4?=
 =?us-ascii?q?04eOhCQshCgzGry+OF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,222,1779141600"; 
   d="scan'208";a="290149504"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGcUv/wAKYUjcWZU009N0spwXppIMeyCdXV46?=
 =?us-ascii?q?CuZl9ZNxuJggKiT6kb4BJeUz64gWDU/xceB1adK38ofGMQ3brdRJu9TK?=
 =?us-ascii?q?sQn321tbI8nkWmA8fyYggUx5TcNrrgk1CxL5yNsJrmpt0gyODdoukkP2?=
 =?us-ascii?q?oxyoKOrF73QcxDACFQVjQ+aA=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2026 14:47:55 +0200
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 32513601E0;
	Fri, 14 Aug 2026 12:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 468031F000E9;
	Fri, 14 Aug 2026 12:47:52 +0000 (UTC)
Date: Fri, 14 Aug 2026 14:47:50 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
cc: Benjamin Tissoires <bentiss@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
    Shuah Khan <skhan@linuxfoundation.org>, 
    Julia Lawall <Julia.Lawall@inria.fr>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    =?ISO-8859-15?Q?Filipe_La=EDns?= <lains@riseup.net>, 
    Bastien Nocera <hadess@hadess.net>, linux-input@vger.kernel.org, 
    linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, cocci@inria.fr
In-Reply-To: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
Message-ID: <56p6654o-p626-s2r8-9429-9785065865rn@xreary.bet>
References: <20260803-hid-ff-input-configured-v1-0-1dc9bbacd88c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 00/21] HID: fix racy force feedback
 initialization via .input_configured()
Reply-To: Jiri Kosina <jikos@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 3679
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
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-08/IYjahNdWdOaz7gwTVTQITw>

On Mon, 3 Aug 2026, Dmitry Torokhov wrote:

> When a HID driver calls hid_hw_start() with the HID_CONNECT_HIDINPUT
> flag (included in HID_CONNECT_DEFAULT), the HID core immediately registers
> the input device with the input subsystem, making it live and accessible to
> userspace.
> 
> Historically, many HID drivers initialized force-feedback capabilities (via
> input_ff_create_memless() or custom workqueues) in their probe() callback
> after calling hid_hw_start(). This introduces a window where userspace can
> open the input node and trigger force-feedback ioctls before the driver has
> finished preparing its private structures or workqueues, leading to potential
> NULL pointer dereferences and race conditions.

Hm, this has probably been the case for ages indeed. Thanks for noticing.

> To eliminate this anti-pattern across the subsystem, this series:
> - Enhances the HID core to automatically handle driver force-feedback
>   initialization during input device registration.
> - Refactors individual HID drivers to perform all force-feedback setup
>   inside the .input_configured() callback, ensuring the input device is
>   fully prepared before it is exposed to userspace.
> - Adds documentation and a Coccinelle script to prevent future regressions.
> 
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Now queued in hid.git#for-7.3/core.

Thanks,

-- 
Jiri Kosina
SUSE Labs

