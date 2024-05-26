Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49F99C25B75
	for <cocci@archiver.kernel.org>; Sun, 26 May 2024 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nO71Rr6YTT1Zk0XePrDw6nBVPhQtXNcG/MeRZ9hdRVU=;
  b=RrovOVv2zFYfAYK6IjNibY5e2JptQMyoEqdGasddPVA5lQRNZyczWnwD
   82VrR0zRwUBP9otPgnk8igX71wWhhjY7QxWb09nQQFijOp0DTXMqVlBa6
   I87XTiRMNIsgUpt5mZ0D0uZ1oDy+st0ADR9SuX0HBwfVB8q5jxJef0WxD
   M=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
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
X-IronPort-AV: E=Sophos;i="6.08,190,1712613600"; 
   d="scan'208";a="167475652"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 May 2024 19:30:42 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 206CAE0CCE; Sun, 26 May 2024 19:30:42 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9EA86E0AF1
	for <cocci@sympa.inria.fr>; Sun, 26 May 2024 19:30:37 +0200 (CEST)
IronPort-SDR: 665371bc_QyJrT26VVDVq2Syp5gR2qA3B/iBuPKc95HEMo59jXYPqevd
 mxYUbuv38z4WIZRxRm5UEpXlMeW0bqs1nb2lEVQ==
X-IPAS-Result: =?us-ascii?q?A0EoBADxcFNmhw4P49RagQmBT4JEfAZUMwQLSAglhCmRP?=
 =?us-ascii?q?TCEO48JiHGBVoFAPg8BAwENOwYBAgQBAQMBA4FJQoJ0AmuHYQIeBwEEMgcOA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEjFwcOECeFdA2CZ?=
 =?us-ascii?q?wEQdxd0MAIBAQEBAQEBAQEBAQEBAQEBAQEXAg06QgEBAQIBIx0BAREnDwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ8AYIvAQMOIwcNBrAKgTKBAYIMAQEG2lkfLCJXgWMDBoEaL?=
 =?us-ascii?q?oguAYV8hEAnD4FVRIE8C4J4PoJhBIFeg1uCaZlrk0dUfRwDWTIBVRMXCz4JF?=
 =?us-ascii?q?gIWAxsUBDAPCQsmKgY5AhIMBgYGWTQJBCMDCAQDQgMgcREDBBoECwd1gXGBN?=
 =?us-ascii?q?AQTRAOBNwaJagyDBwIFIYF3KYEkgngIQ2wVgQkCgmWBbQ5hg02ET2SBEIFGg?=
 =?us-ascii?q?WoBeh1AAgELbT01BgMLGwY9pXaFBsgANAeCNoFggWIMiiGVJwYTL4Nyk0cOB?=
 =?us-ascii?q?pJomGMgjVabFIFsCCuBXDMaJIM2TwMZD446g2Ezyx5BNQIBATcCBwEKAQEDC?=
 =?us-ascii?q?YVGAQGDWoFIAQE?=
IronPort-PHdr: A9a23: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
 JdcE9ezsXQqG/lcBkk3RLQ/
IronPort-Data: A9a23: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
 ajZiF2omH2GdHM=
IronPort-HdrOrdr: A9a23:gce/E640VeebS53YhAPXwPfXdLJyesId70hD6qm+c20tTiX4rb
 HXoB1/73XJYVkqKRQdcLy7Scu9qDbnhP1ICOoqXItKPjOW3FdARbsKheDfKn/bexEWndQtsp
 uIHZIObuEYzmIXsS852mSF+hobr+VvOZrHudvj
X-Talos-CUID: 9a23:dhaUuGMrufzpyO5DWBEk6WMNRNgcc17f0nPUDRC5JFl7R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3A/aGoKg9JPPySPn0dedgE4ieQf+Nu4a6TUXkOqLw?=
 =?us-ascii?q?lmM+lMwpVBGyFlyviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,190,1712613600"; 
   d="scan'208";a="87995635"
X-MGA-submission: =?us-ascii?q?MDEx0zeZq8OQ6ZRgaS5zw3/OJXDNyEIW1Zu9qp?=
 =?us-ascii?q?WfUlX6Yk5oJxMrS+IJ6mu2XEDvzi9a936Vi0XYkiIXEpgwWfndWT3Dpm?=
 =?us-ascii?q?E1oAunddAxVLIZu7YXZ4xZWAoM6LXPlznHaA1T41NcvY+Nn01TFz9CHW?=
 =?us-ascii?q?hHWmw7vbmdrWxelQb1a3+fqQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2024 19:30:37 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1716744635; x=1717349435; i=markus.elfring@web.de;
	bh=nO71Rr6YTT1Zk0XePrDw6nBVPhQtXNcG/MeRZ9hdRVU=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=EmC/EC+IFB03BRgpp1jFMboaOVc3uhOJK0J5eJnRw55BI+Ke4Gyx115q5J04UYrR
	 kMrDIXRyRuMKRk5LVy5l00ZTDo4sALby6YeuGwzyaGhiMK8W1ft8R6gjTWY95OKKR
	 fU9ksNeZkV89nfamZWkhhzCYDv+mlXaBGPdizSHwoAIvUKHkjL4g2IWx0+3fWzD9U
	 iuBEMTqgrbeShtvTQa51FnQ2fNheOTcql/vgDKSkE0bShs9FK8JvHcflbj2LQtkP3
	 hzbnQF2pbhQIKVnbrX0n/NrahYepmGsxfkbadx0EtYCPPQFtXX/N7Wi4dvR6YVm2Y
	 J86IA6s1pnhroPNiew==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.95]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MV2KQ-1s2wFZ2wMw-00HjMU; Sun, 26
 May 2024 19:30:35 +0200
Message-ID: <702c16f2-33ae-4493-8062-24b14b7fb0be@web.de>
Date: Sun, 26 May 2024 19:30:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr,
 kernel-janitors@vger.kernel.org
References: <7eb9626c-da7b-414d-bf50-da1eed27be31@web.de>
 <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2405261847380.16852@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QxDcZ1Q4NKfZv1oR89qimddPactD1jInaztwz31nQIXQE3RCkHm
 +9ZvZpI13uL9tARAztyBc9AZdryUEksFb6PsrDXch3yZDqVZKlCqyM3KMOlalLzUI8Ovjek
 EBEOGm7kyAG6SBGK4Rh4/fgsYlmT6IM0dm0FwmyrIkSc9dkLEQxUKc5vzH3v8BQ8rXrJ3gY
 4BK1arL0AqT1K7r+R6S3w==
UI-OutboundReport: notjunk:1;M01:P0:EOuGqvImNtI=;yGQ3liq7C0sZyOAkg/f0z6J1Nyj
 bngNN9DdS1z7MzVQnLh8rZ9kfZA91eShGNANQRJCR964F8AIvlaXkFk9vI2goFBrPxAXrBm6n
 RFdgoRGDzetdAwX/TBy49rT572563+C9c9o3LR0rvyI6O+AEXwC6hnyT1d6wwvscAqm/XJZQ6
 fHU8XkRRpt9IlU2OYnOQ+xrKtvewK3FBnmSFl7DAJ99WpZnZxwSQYndJ4e/Veusbqwqvp7iR6
 UgULEPi/szvDyeIjIBg6SHglRSFdaLyQvKWyC0AIiY+ungqIu/TsfJe75IbPw+Y2H7AWIpRJW
 5S8O4N3LETUEH9FdKg4eN4301QFeOGnAA5Q5916NKHjiDMnmr6KJVCIwPEuJtYjqJV8oPVrjO
 HLX8C41ILsmswnzJ/gRNH3wGkxaElMq9q74+3agzZw4Qfb9sML4psVATPrSFKioe/7sVUtzR8
 9+srciPwstJHLsY8K09JqpcriiGsD75Bhn2kPrgipwy5p0a+hBUQTHC2BNdFqa978yfc1qiOp
 Vp7PjziLgmZOvhIP73/BMSvMNxGzkra3oZxvgSWzTeeKfsrr/LUF6AuRt7YlTv8oYyCcRwf6D
 EZ/i3pqQMIjluizR7XQPDzAXpN2r1eF+KWeb/5hK8/RaAQNvgi0UONkGkHVc6Auqj8d1/SViq
 0wUWs7EQ9cNzrjGqLVvicMXjj9qaX3xbnEr7uSya92iWaGuMdnPSy/D6Ic1C0Yi/HFYz4mFSM
 RyFHUmKYxGuKJune1Wv29HVdX9KmUJOcm951CDF/4T/gHjy8c2PLO9hz9qMjloA5S2kcgeqWo
 FcLX3ZPoGOPlSNRcMx0Cq8aJ4+IDCHWVmcs9dEBdLuzmk=
Subject: Re: [cocci] Increasing usage of mutex guards (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1757
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/702c16f2-33ae-4493-8062-24b14b7fb0be%40web.de>

>> Will it become helpful to offer further SmPL script variants which can =
be used
>> together with the tool =E2=80=9Ccoccicheck=E2=80=9D?
>
> I'm not the one to decide whether we should use cleanup for mutex locks.
> Intuitively, my opinion would be that we should not.  Something that can
> have so much impact on the execution of the system should be visible.

You are trying to influence software evolution also according to
scope-based resource management for a while, don't you?
https://elixir.bootlin.com/linux/v6.9.2/source/include/linux/cleanup.h#L12=
4

Regards,
Markus
