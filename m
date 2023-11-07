Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 043BEC4332F
	for <cocci@archiver.kernel.org>; Tue,  7 Nov 2023 06:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=TxA/X5Y19z1EAi0BkhZomgyS8lnJ/m8h08i3vDPPetM=;
  b=UIZe36arjtTkvIjPRnSbqiyXYjBmTMIKpLK/1MF8aGjOQv3UOjVcC/Y6
   TGZQzHyNRztY6mVGsHIiBIs2xm8L100uOH+My6G0fQ+hzfs6AdedHD3QR
   b9xyFA46o52GyFuZP2XZgNOi1ZnkBW4bzRWI2239OjseWrnyX1FHWFybe
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
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="134930760"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2023 07:38:44 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A0D93E0CD5; Tue,  7 Nov 2023 07:38:44 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B1223E00B6
	for <cocci@sympa.inria.fr>; Tue,  7 Nov 2023 07:38:42 +0100 (CET)
IronPort-SDR: 6549db71_Bh0PaWeJiDJbecNBBsxyJJ7bHwiZAGMBPmXABEejImJdyNf
 8/yc3PCE9MRStZYeYSIBlHRyX0uxZWVF50vWEzw==
X-IPAS-Result: =?us-ascii?q?A0FXBgD32kllek7ASNlaHgEBCxIMQIQIfVMwBAtIhFORM?=
 =?us-ascii?q?TCEO4c0h0qMBT4PAQMBDUEBAgQBAQMEhH8ChycCHgcBBEcBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBQECEAEBIhoGDgoBBSeFaA2CNysBEYEMgR4BA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEXAkdCAQICASMdAQERJgEPCw4MAiYCAlcGARQBA?=
 =?us-ascii?q?YJ6gioBAw4jB6xNgTKBAYIJAQEGr1QfLCJVgV8JgRqIOAGJDHonD4FVRIE8g?=
 =?us-ascii?q?ksHMT6IHoJoiS4DBDKFdo0fXiIFQnAbAwcDgQAQKwcEMBsHBgkUGBUjBlEEL?=
 =?us-ascii?q?SQJExI+BIFjgVEKgQI/Dw4Rgj8rNjYZSIJYCRUMNUp2ECoEFBeBEQRqHRUeN?=
 =?us-ascii?q?xESFw0DCHYdAhEjPAMFAwQzChINCyEFVwNCBkkLAwIaBQMDBIE2BQ0eAhAaB?=
 =?us-ascii?q?g0nAwMTTQIQFAM7AwMGAwsxAzBVRAxQA2wfNgk8DwwfAhseDScoAjVDAxEFE?=
 =?us-ascii?q?gIWAycEDgMZKx1AAgELbT01CQsbBj4CJ6IKAXsTgkAelimuSDQHgjGBXoFfD?=
 =?us-ascii?q?J8jBhMvg24BEoxzhiwOBpJMLpgQIKgxgh2BXDMaJIM2TwMZD44ghCuPR0A1O?=
 =?us-ascii?q?wIHAQoBAQMJhUYBAYNagikBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VUIqat4rI1XhKI//QuMu5KYJf3BgA7S8g==
IronPort-HdrOrdr: A9a23:tlr0NKH7uMQiVkX3pLqEPMeALOsnbusQ8zAXPo5KOH5om7+j5q
 STdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAs1D4bbLbWSS4/yKgzWQL/Zl5sWb+6a1gurkw25qVhwCUdAc0+40MGem+lYdfng8OXPVLu
 vn2iLNygDLRUgq
X-Talos-CUID: =?us-ascii?q?9a23=3A5fuuVWk3RHExoo1apA8BMeznJkzXOWbP/m+IOwy?=
 =?us-ascii?q?SNUxgGZizc1PLx7tovcU7zg=3D=3D?=
X-Talos-MUID: 9a23:aOzBZgtMs8bKyIye8c2ngD1TFf5Rv4iUJ280gLgb58OYOClBJGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,282,1694728800"; 
   d="scan'208";a="70699216"
X-MGA-submission: =?us-ascii?q?MDEsafBOQhvehvEcHqDhues7iqZEYwQ8BMxxiR?=
 =?us-ascii?q?beV34HWHTs2Jy9En18zlAi/xWDuwJ2IPxAimjf5cDBKr+/h7n15LZZaR?=
 =?us-ascii?q?HN87E8aYka7EL/OhccaBQ4/1Y4/56D7a9+qQ6ASS9Y8kFkqtm3deqEEl?=
 =?us-ascii?q?7ufDaZN228Kf8Kt1nnTjKIjw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2023 07:38:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1699339113; x=1699943913; i=markus.elfring@web.de;
	bh=dyrvO4jp+FcnYndOBXe6vRqDh6iKvs3/XCz5EqIvItE=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=OwHtopZiF6X55Q63yRs639L8Y+J+DxrviktF7rRXrWEX1OIZhHBeZFuSmNBcTY8/
	 GMNc78Oy7BFQ7kih8XRZdvrpGahV4YpO2WEdKgFfQpNCDyuuMo2R3PLuv18qRK89j
	 BcEaXSGIaGQv5ISPA25J8kI0SRVxW/fBh0Hhk7v6e/98xE9dH41jSi8OtyT+g/6x6
	 1kETCALiGjKCcwXl8CAKd9eP0TP+C2QpOkKoyUe/SzzXDMjS7O6wU1t8Dc7IHJplG
	 JQeuQ7UzaTYINn29hujX72prCyo0y7iFZLFDnriuIJXMVSLanNcB7uVBb7ME2+6mr
	 78x+dYLiZQYpVUR/5Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MqZQY-1rmWuO3viy-00mRhT; Tue, 07
 Nov 2023 07:38:33 +0100
Message-ID: <dce77105-47ab-4ec7-8d46-b983c630dad8@web.de>
Date: Tue, 7 Nov 2023 07:38:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>,
 Wojciech Drewek <wojciech.drewek@intel.com>
Cc: Julia Lawall <Julia.Lawall@inria.fr>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Justin Chen <justin.chen@broadcom.com>, Paolo Abeni <pabeni@redhat.com>,
 bcm-kernel-feedback-list@broadcom.com, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>, Simon Horman <horms@kernel.org>
References: <0b2972cb-03b2-40c7-a728-6ebe2512637f@web.de>
 <20231106145806.669875f4@kernel.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20231106145806.669875f4@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:pdIZHKFQErHqx0NbYleSCo5hE4ZCvSBGK+/n/+5T+uMOLQIVel1
 a02M8DQPWIYN1zFE7Z3KitYHOrD1ancHzD+Qlj2Mb6wxElhUBd0aKfCFqlPiJbtID7kARj0
 8cX0xGT8LF549KqsHUFj4BYkP1OrlRVEuVEcAypApUXTdL1PdgjB56UYqnSL9gv3psXcADi
 lEF38jpyEsA9zNXIzHGgA==
UI-OutboundReport: notjunk:1;M01:P0:rp6EM0Fli/k=;/BHlwusWqvK0jm7hl8YNXaOjWRx
 gXKzhT1RKvAjOL7NbCp8Zcw29fllzLXzXQNE02FSNP7gmh72wZ9DfcaF4Rbgsxqo3kVKkdYAC
 WKOhDHtmsX4v1Fro8/T7DIzXnF7NJyP/cF21WLHvpWVFuEMVC251d/iUFKn52DgIRSq1L9vio
 xnKZT/4gkMcKOVyJ5AaSYyAzgqfqtfyK3ArrDBTx4nPSPnRRoS0xq5+H1nq9Z6jXg6jFfu9zh
 eW34Toi7hUZj3MznlgcbZ+FDwgzguE21i6Ru389mS7idJSpHjqasZIqvuDC96MU3FV4qD3GFM
 YyiqgEceeFGOxKg7RQihU1s9mlsWYxlwwdhRWrGBNS8l5oRgP009aUownRZAJAekXU+0dwfJJ
 y20tDGmnPusQYLPKs2vHP7ksksnWFaXD9mMpuE7Hw/hEb0ffPwMgmWAwVOeRHQDczgxH25dg3
 vTSvOE3X6BgJS8PuUobE9jGt7bKQMlxV3KLHOyVi2HYz+Ux9iuRooMIgHW/CClkibwnVSk85E
 8njooqzR6N6XCIwEbQDFbPDYx6s66JwWxObdcHjjhZb+0W9c+yu+0z3JTFI63rrv3aGWJDgYJ
 bBeq90gACUDPYfpem7ehaiPeO0BBuTe7YS41QoSv+LgDkEPwaJTQs+m/omuNRqLVJTHHKyx3w
 MLtznwq2ijik8lFiGa1QOYNKLv+CAapjZ2SX6Eu7M/cBbgFEKqJm6SNsRO6O8hVL7jHz2f4AO
 GFIFpWPJis/cZqj4feAO6DjXg4wDeKm+FrH0y5v0YgrovD23p/uF+/uZxQbkhoJ8GfI+Gnb0O
 XFs57nKzsvZm0q+Ac4OqOFFFnr5F+rBFGdyOy58athI8B8gggEZoTze4ZqPh/dcd87OiPNuq1
 lE9ZdthiGhRNKy7LzG2Z2dKv4LFmx5sUuGPkykjJjBMnrAmh/PeU0J5oakSL72zdH6XMHKCtw
 fnpwNg==
Subject: Re: [cocci] net: bcmasp: Use common error handling code in
 bcmasp_probe()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1294
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/dce77105-47ab-4ec7-8d46-b983c630dad8%40web.de>

>> Add a jump target so that a bit of exception handling can be better
>> reused at the end of this function.
=E2=80=A6
>> ---
>>  drivers/net/ethernet/broadcom/asp2/bcmasp.c | 10 ++++++----
>>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> The diffstat proves otherwise.
> Please don't send such patches to networking.

How does this feedback fit to a change possibility which was reviewed by
Wojciech Drewek yesterday?

Regards,
Markus
