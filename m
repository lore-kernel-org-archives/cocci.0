Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23A0C3DA6E
	for <cocci@archiver.kernel.org>; Wed, 10 Jan 2024 07:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hhPaJcyeSBxTfwuEoDUTo5lm2LbnDI4Sufrw3CS2k2s=;
  b=CWSDAXc+l1LtSqN6r+kD5O4vS/SmA7dRU2RtOBd3wt3yOM8cbpHqmwY1
   O9nmd1G7kHY7d0RTephwEe21ptOHvLQmPUMx15IRm730KGL5tYJ+x62sv
   U7aS98Tnyy679lysI1nvdZjXVssr+guviP7eHbWSrmrdupMCKDwj3DqZg
   8=;
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
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="145778001"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jan 2024 08:47:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6CC44E0CD2; Wed, 10 Jan 2024 08:47:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 63422E004E
	for <cocci@sympa.inria.fr>; Wed, 10 Jan 2024 08:47:07 +0100 (CET)
IronPort-SDR: 659e4b7a_fjavqXmNHE0sJksE/M+0wXtAJxDdYGhBASFxcR8T+eYj6Nb
 ljvTuRGSWd0EARrsOMMETAFblzezsnNxuWC08UA==
X-IPAS-Result: =?us-ascii?q?A0HbBwC9Sp5lewwR49RaHQEBAQEJARIBBQUBQIFPgjl8V?=
 =?us-ascii?q?jIEC0iEU5E2MIQ7jwGEa4QEgxY+DwEDAQ07BgECBAEBAwMBgguBYIEUAoc9A?=
 =?us-ascii?q?h4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEkGAYOB?=
 =?us-ascii?q?QsnhWwNglwBEIEMgR4BAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQINOkIBAgIBIx0BAREmAQ8LGgIfBwICVgYBEgIBAYJ8AYIqA?=
 =?us-ascii?q?QMOIwcNBrYTgTKBAYIKAQEGgUUCDAJDrUAfLCJWgWADBoEaLogbAYVngxwle?=
 =?us-ascii?q?icPgVVEgTyDAz6CYQOBX4NbgmiFXJAiUn8dA4EFBFwPGw8eNxEQBQ4NAwhuH?=
 =?us-ascii?q?QIxPAMFAwQyChwLIQVVA0AGSQsDAhoFAwMEgTAFDRoCEBoGDCYDAxJJAhAUA?=
 =?us-ascii?q?zsDAwYDCjEDMFVCDFADZR8yCTwPDBoCGx4NJyMCLEIDEQUQAhYDJBYENBEJC?=
 =?us-ascii?q?yYDKgY4AhIMBgYJXSYHDwkEJQMIBAMrKQMjdBEDBAoDFAcLB3uBFwMZKx1AA?=
 =?us-ascii?q?gELbT01BgMLGwY9ApUqAYMNKD0CIIJXlW6uZjQHgjSBYIFhDIoYlRMGEy+XJ?=
 =?us-ascii?q?g4GklQuh0AQkE8gi1SBdpp8gXojgVwzGiSDNk8DGQ+OIDiDc4ELg1aKZkA1A?=
 =?us-ascii?q?jkCBwEKAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 zYzjRZiJ/sg/nHg7gVvTrIvjDQ9mg89lIe96Q0=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:WmdG5KkgR5Qg5wbb6/WXjZjUiFDpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:YbRl/mG7yGWJmj9DqmJV00ofB9wJW0aE90XbMmjkB2NTV4S8HAo=
X-Talos-MUID: 9a23:Xeg19QblvYsrfuBTrxbQ2DRCMM5UuIewAkAXoYgCm+y6Knkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,184,1695679200"; 
   d="scan'208";a="76330078"
X-MGA-submission: =?us-ascii?q?MDFXu4CmAievhv6Wdq5FX18loBaxeGRh7ZYEqz?=
 =?us-ascii?q?bXZqhKyz9XyPsyz5m+BhgMzdX/54gzXW3uVMLUxeZqjRRMP9rTgfz91H?=
 =?us-ascii?q?E0dp/md7atFwsDMhwI0DjkL34m+nQe4g69xOnAUjeBniTFF1Vgq9+c1E?=
 =?us-ascii?q?yZ4qEEG3tSx1rgknXbzGB0Eg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 08:47:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704872802; x=1705477602; i=markus.elfring@web.de;
	bh=hhPaJcyeSBxTfwuEoDUTo5lm2LbnDI4Sufrw3CS2k2s=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=RDDlycAbIBjqIBZhciOaoMzfl8tat1ml5+qzKdoiHfMJreRpIHAbWIXRnPKwlnhr
	 w0vse/ZAZ3cCwQ7mccrHYN9VDuoVlfWNQ8uIZoL8s+3TUf5O7ga+mecRtASez08rI
	 07w8aaKfxzw/exDThF6Fkwkrpnv/ZCpWbCcynR7vWOWhUdijv5Jjt3cQq8mcyTSJI
	 RT4OMizwoUpYzSXNWSPBgXIEHsEDQQyf5YMDWTPeDR7HY/BXT9aPGL5XZp7AaYCwy
	 ZrYY/gILsaXbNsNlUzLE3Ss51DRCGO3dBL1NNgDiVupzBTuhoQdAYuR6EDnClKaee
	 2l1JfThVel14fi8LUQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MC0LH-1rTH7H11Th-00CKiQ; Wed, 10
 Jan 2024 08:46:42 +0100
Message-ID: <0d7a06f0-7a0e-47c8-b89e-c3122b46d93e@web.de>
Date: Wed, 10 Jan 2024 08:46:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Justin Stitt <justinstitt@google.com>, virtualization@lists.linux.dev,
 linux-crypto@vger.kernel.org, kernel-janitors@vger.kernel.org,
 netdev@vger.kernel.org, cocci@inria.fr
Cc: kernel test robot <lkp@intel.com>, "David S. Miller"
 <davem@davemloft.net>, Gonglei <arei.gonglei@huawei.com>,
 Herbert Xu <herbert@gondor.apana.org.au>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Xuan Zhuo
 <xuanzhuo@linux.alibaba.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, LKML <linux-kernel@vger.kernel.org>
References: <2413f22f-f0c3-45e0-9f6b-a551bdf0f54c@web.de>
 <202312260852.0ge5O8IL-lkp@intel.com>
 <7bf9a4fa-1675-45a6-88dd-82549ae2c6e0@web.de>
 <20240109234241.4q3ueqdjz5o54oan@google.com>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240109234241.4q3ueqdjz5o54oan@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uYjo0zmC9Bv8IGNYZK4OcE5zWAU90y0/cZTEhqTTR+46QfZcrke
 tgvURLyjA9lTvet4ThfCVXnv8xkFz5vm5k/faG0SI34wHLmSeb4+ISwwXtzGVUNyei+sko3
 imEXpQg0tfMnY2jPBNEQpi1Nej6dOCS3XWYf+0+cvT6Tzo9nqafppm62vyx/roH5eUamaVt
 V+cwMMwdBpWwOAkMutt1A==
UI-OutboundReport: notjunk:1;M01:P0:S0h3qRtm9JU=;wWqjC0b120yckKxNsgoQLwgkgBW
 TANfswLwhLmaw2f/tPyZEWPKAcRWd062YgXcSl/MJ2qJRU1QKDsfT2ThjEWt9E72pzH0XbipK
 ek+fzGIiWGzIJsPlXIujThtScJKp1023bSnfHXoawQA9pX+pihbfTuFGFlAUTWqVRcAWqrqli
 0nCKkRvwtVBpgQQHcOkSiZz2JlCRwk57Shx+Gvg6y5bk4L3PH3AlWQ8tO6Xp3nleW9MR0s7si
 MSvzw7RCAFeB6LwjIZwmlOEOjjPLPbYUs521VFEI/yO6FjCahBvoh12NcXhyV06gTwrZxYSeE
 b8pBwfLUgR/Esz4UAIkpBHYPrX/bWsRwmcnQHgEEK4xgOgGDjqsiyPzEp2Y2Efcn2/R/EF712
 VQk246045auIbeX9HAJOCho2yLaMsyEH1f6EHNTxHg0+SqFqDWpwoGio4SkvRb3I8VuZ3pxn4
 pKeUq4c1gFEumr07bBhEG4mi/NUQgnLyhdgW6BwDdFk4VwWYt4+ogSIr5ka7LK0XE9enEulDt
 FYzDmGriybFkbMm6TBpDciJx5Sh6BnEUu+Et3jr/Wo5juVLgYVUD68PVkhXYCB9kXCZBCdsVV
 ugIrdZ0ILSXTq7qyQMj80Xqu7K02gBTP9d/ghsEIPcwB8ADu4LuJO6tT7jydAQmru2Q2FVJk1
 ivWlGskt+2ukhVot4diVbYzhRSU40RAEtZ+czNRSy7ThyCDOja3gPdwSQvyCuhQFKR8wgwG9b
 XrqtDCFIWRfjgOes6u/gzPr5TaEA4NNxHUyub1v+1OAf9I203fen86ea5RIg7ATId3YwnrbNF
 CPYepQfCHStuUHXi9ghJSc64B7/bq4g0XeNcJeCEkljhWyB2+P2eOjuzJeW/QqYtSYA6LzvEr
 oZ4SBkMQ7rrO/7shvLlLjbwtqb6JDHUcnuYj1+D6YDz0o8p6Hfvl/T+rJqJzOzUkuEamvmJ98
 B+3jVJr1HhEYCoxIDT4FjRo5reo=
Subject: Re: [cocci] crypto: virtio - Less function calls in
 __virtio_crypto_akcipher_do_req() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1442
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/0d7a06f0-7a0e-47c8-b89e-c3122b46d93e%40web.de>

>> The kfree() function was called in up to two cases by the
>> __virtio_crypto_akcipher_do_req() function during error handling
>> even if the passed variable contained a null pointer.
>> This issue was detected by using the Coccinelle software.
>
> If the script is short and simple would you mind, in the future,
> including it below the fold -- this may help others do similar work down
> the line -- Or =E2=80=A6

Would you like to take another look at the clarification approach
=E2=80=9CReconsidering kfree() calls for null pointers (with SmPL)=E2=80=
=9D?
https://lore.kernel.org/cocci/6cbcf640-55e5-2f11-4a09-716fe681c0d2@web.de/
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00096.html

Regards,
Markus
