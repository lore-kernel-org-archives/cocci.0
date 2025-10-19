Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57651CCD184
	for <cocci@archiver.kernel.org>; Sun, 19 Oct 2025 17:13:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2/nsvhglHKGLgE5m2owBDC86h0qZvLVX6ICR4qKSu14=;
  b=HFTPd2wg4p4AUC9UkJrbMLasXRpRuVcf6XhKbBLPPWELLdS0Rn82Bu+z
   9yunp4wFWMih4OfdB5ZDYWWFoCB+NHgMphbKpkg1pipSOttSsoTANGW4h
   y5bpBcNPc8mnTUFwQ9651FHY5hzPqAnjS+P4/06JJegXittvLjg0hIJ6a
   w=;
X-CSE-ConnectionGUID: rDnRiEExRKmL0j+C4coqAw==
X-CSE-MsgGUID: byu66loxQwGjZWD9aHr3KQ==
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208";a="245020410"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Oct 2025 19:13:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A291DE0C55; Sun, 19 Oct 2025 19:13:12 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D8088E0171
	for <cocci@sympa.inria.fr>; Sun, 19 Oct 2025 19:13:06 +0200 (CEST)
X-CSE-ConnectionGUID: FsKPPEXoQiSKV83jyDnHAw==
X-CSE-MsgGUID: /yQSfobYRDWcZjvI0SxU5Q==
IronPort-SDR: 68f51c22_vh74SdeDe/+Iac/RQe3o3zus91JjDui04OYLWE7b5cxRb4L
 pbLsZabG8UTbzkpfTIqEDVQ2ukBdQVLg4HzxmBQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FwAABlG/VogwsR49RaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgVCCQGUdBlgzBAtJhFWPUoIkhDuPEYh5g1ICDwEDA?=
 =?us-ascii?q?Q1ECgECBAEBAwMBhQACjEwCHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQEBAQ0BA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABAQE6Bw4KMYZPDYJiAYEkgSYBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQINOkQBAQECASMdAQERJgEPC?=
 =?us-ascii?q?xoCJgICVgYBEgIBAYJ+AYIiAQYQAQMPJwcNBq0ggTKBAYIMAQEGgUYCDAJD2?=
 =?us-ascii?q?EYfLCJZgWQDBoEcLgGFbIJkAYVsO4NDeicPgVVEgTyDAz6CYQOFOoJpgiaBD?=
 =?us-ascii?q?pdbUngcA1ksAVUTFwsHBYEgEDMDKjQtI0sFLR1zDCgSEB8cE2A9F0CDSRsGa?=
 =?us-ascii?q?A8GgRMZSQICAgUCQjqBaQUBHAYfEgIDAQICOlcNgXcCAgSCMYEQgikPhkICA?=
 =?us-ascii?q?QttPTcGAwsbBj2TOCyEBwKZD69rNAeCOIFngWQMii6VPgYTL4NxAZNgDgaTB?=
 =?us-ascii?q?S6HZZBzIotsgXqbOYF/I4FcMxokgzZPAxkPjiEZhBqBC4NVwiZBNQI6AgcLA?=
 =?us-ascii?q?QEDCYVGAQGMVoFLAQE?=
IronPort-PHdr: A9a23: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
 1NpPnHISuAJ51OPXX9mgknQtMkWccM=
IronPort-Data: A9a23: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
 d0VUFYfNA==
IronPort-HdrOrdr: A9a23:FxdBn6+B8OXJxK+B3iVuk+AMI+orL9Y04lQ7vn2ZhyYlEfBw5P
 re+MjzsiWE8Ar5OUtQ4OxoXZPqfZqyz/FICOUqTNCftUzdyQ2VxeJZg7cKoQeNJ8SWzIc0uJ
 uIMZIOauEYZmIK6PoSjjPZL/8d4J2g7L2ig/vYwkxgVAdwdshbnnpE40qgc3GfX2N9dOEE/X
 enl7B6T7HMQx4qUvg=
X-Talos-CUID: =?us-ascii?q?9a23=3AF36BAmhwIC8Orl1xr3nYDrQlfzJuXGb+9E/9E0i?=
 =?us-ascii?q?BCF1Kdu3OS068/oNNjJ87?=
X-Talos-MUID: 9a23:F3zRKAWIMSchB53q/Hj9vQpsM81Z2YiRA3IPj7RegNm5aBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.19,241,1754949600"; 
   d="scan'208";a="245020398"
X-MGA-submission: =?us-ascii?q?MDGyjCSapCc245ALlOmex7Ivv4qOq0DMMwiGCx?=
 =?us-ascii?q?/Tkql8IQJKHn0UlcEmDexmRE60ZixhVj+eeHblHYbczCV7IuMckl3+uu?=
 =?us-ascii?q?Nxddb6QjwHdnAefvVAOanOs2JUX+Z6r91SdPkXAXhpmLOdtcKt97u5he?=
 =?us-ascii?q?J9pRh+IBGAhnyZRz3Wt3qCug=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2025 19:13:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1760893985; x=1761498785; i=markus.elfring@web.de;
	bh=2/nsvhglHKGLgE5m2owBDC86h0qZvLVX6ICR4qKSu14=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KMQNfqs8Oq+hcrIKjnp5nS1uXZaSfp4P8B4kSvJiX6N/z2B0kX7NLYsRf+PRZ77s
	 MKNzt/i8jPWzZBNUxxDaLENYS9jKyTHZrsxOd6rBQBHodpSFVsBVwpWR2vGlbwvsV
	 Rdx4e2Qv45877c1ZtCuLZcwPypdY6pNitwH6AuobJQHrQdkfjXRExGDA+8GbezfH1
	 rpzohRREeQkdfxNfnNfpUgh142Zdv14AYcxP/ZqWJTj2DjUkvq5PHpv9dS8/OO6aj
	 kPV+a5CKnc5hQyq1SJp1rAOp8tlONVmIwn8RbUVVcZp1+2/nJQ+vqlORrSb70myYa
	 ZtJc2L3qkmXdbdSVSQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.180]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N7gbY-1u7JMB1tfm-00yA5J; Sun, 19
 Oct 2025 19:13:05 +0200
Message-ID: <a6de463a-6ebe-445f-bc06-32e74a8e5a66@web.de>
Date: Sun, 19 Oct 2025 19:13:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 Anand Moon <linux.amoon@gmail.com>, kernel-janitors@vger.kernel.org
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 linux-pci@vger.kernel.org, linux-omap@vger.kernel.org,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Siddharth Vadapalli <s-vadapalli@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>
References: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <26975dab-9631-4661-aaf4-afa213104a13@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:r8HwqWYbZxus8y8tOlbmEE39V6Tk1oUKvw7AwUiMSY8yZMi2x1E
 ZfOWkd/4R/hczF/6SR0Z9xTxKxFrdE+59jSHjzFwZBsU5R/YPAjXJAVf5HpdOdtXLiv4t2o
 DeiBfuR0OicFooKwmI3eLChmze+NxsboUe/aE3Me0NgkbTdWln+sd5jha778zndLbkUxjgp
 NFc3P4tveXj/QDnPDAXNw==
UI-OutboundReport: notjunk:1;M01:P0:VNqRzb13YEI=;1EHcRGKETxQlU+QrRRaTgNutrUe
 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
 c01+w==
Subject: Re: [cocci] [1/3] PCI: j721e: Propagate dev_err_probe return value
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 3084
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-10/a6de463a-6ebe-445f-bc06-32e74a8e5a66%40web.de>

> > As Dan Carpenter pointed out - " Wait, no, this doesn't make sense.
> > It's just assigning ret to itself."
>=20
> Yes, Dan is right.

Would you become more interested in an other source code transformation?
https://lore.kernel.org/cocci/fe93e337-7d8e-4b82-b187-b5a67b627544@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2025-10/msg00020.html

Regards,
Markus
