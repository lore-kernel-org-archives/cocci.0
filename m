Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B25D591AF
	for <cocci@archiver.kernel.org>; Mon, 18 Nov 2024 18:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wR2vAxb4KjC7bChWhYgHEm7VYOkoUSKJ2zrGmmUQgeU=;
  b=qoAbLnfTqqFnzWzgeuo2/bP0I/oxyecSGYheHax1QPkSJfPfNZZN34bx
   xrsLQMbb7fIdYJVXgc417BXgemgiNzMBDTngTSvI+8kBmp9ONdCZBQ2aK
   ETjd75QlLipRktLbzOUoc9sw3pcLYs3i/zCdTGWD1J3hrZ4J7M92J34QH
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194516867"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:54:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5BAEE0D65; Mon, 18 Nov 2024 19:54:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 46F2AE00B7
	for <cocci@sympa.inria.fr>; Mon, 18 Nov 2024 19:09:23 +0100 (CET)
IronPort-SDR: 673b82d3_ZYLnHqvFmeY8bIjGF5Jn4FuT11EkbfGqH5lBZaGFCu/qtUL
 8rcsBbmhvjN8a6hka5PAst7J6s30Ed2oRa2rqLw==
X-IPAS-Result: =?us-ascii?q?A0ESAgBdgjtnhbaaTQ1aHgEBCxIMQIFIC4JEgQNUMwcIS?=
 =?us-ascii?q?IRWkXETi2CSOIEsPg8BAwFOAQIEAQEDBIUAAopQAh8GAQQzBg4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiAYEkUQ1IAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEfAQEBAxESDwENAQE3AQ8LGAICJ?=
 =?us-ascii?q?gICVgYTAgEBgn2CZQMDAp5NAYdgAQECiyOBMoEBggwBAQbcH4FkCYEaLohMA?=
 =?us-ascii?q?YVphHcnG4FJRIEVJwsDgQaBbz6EBlKDRoJpgkWFDyWHFIFrmhJSexwDWSERA?=
 =?us-ascii?q?VUTFwsHBYEpISwDgkd/gTaBUQGDEEqDLoFeBTcKP4JKaUs3Ag0CNoIkfYEdg?=
 =?us-ascii?q?TKBJQQFg2mBC4NhZy8DAwMDgzyEDx1AAgELbT01CQsbQ6AJRoM1gQ6CS5Zmj?=
 =?us-ascii?q?nehAIQkoUgGDwQvl1SSei6HZJBlqHaCLiSBXEYHIxWDIk8DGQ+OIRmDYcZGI?=
 =?us-ascii?q?jU7AgcBCgEBAwmFRgEBi3CBSwEB?=
IronPort-PHdr: A9a23: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
 h8wlxs4ZOUm7jD35FkrYFHNoXlp+HQ=
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:ux6086zqZTiXIntWQfkMKrPwHL1zdoMgy1knxilNoNJuEvBw5P
 re+8jzsiWE8Ar5OUtQ4OxpWsG7K080kKQZ3WB/B9iftWXdyQ+VxcRZnO3fKl7bdREWlNQw6U
 4IScEXY+EYT2IK6PoSizPIcOrIruP3kpxAyd2+80tQ
X-Talos-CUID: =?us-ascii?q?9a23=3AAsn6v2ue9+MwulP/fMw/4fUb6Is5YmCA6F38Dna?=
 =?us-ascii?q?cUz90TLeNW2+p1Kpdxp8=3D?=
X-Talos-MUID: 9a23:/fQG1wq5Q1cWj0rms4AezxBjHuRJ4/vtM2VTrp5emueCMQtVFCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,164,1728943200"; 
   d="scan'208";a="194512266"
X-MGA-submission: =?us-ascii?q?MDGMWCuHIfFupizdqvI60yYXtVCBMDIpz01JZv?=
 =?us-ascii?q?vEUADFofFJElRJ2DbOk4XWgoeWTFG0JTBe6Sj4fTv7nQTlSLaMvE8sQT?=
 =?us-ascii?q?aNw3VyGgivmx2dyaX7O3WEo4T5pod1CoTjSjF03P60PValGR5er7F0Yz?=
 =?us-ascii?q?AFQ9Fiq6rtLymHM6cbF5emrw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 18 Nov 2024 19:09:22 +0100
Received: from [192.168.35.166] (c-73-118-245-227.hsd1.wa.comcast.net [73.118.245.227])
	by linux.microsoft.com (Postfix) with ESMTPSA id B3D1220BEBD0;
	Mon, 18 Nov 2024 10:09:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B3D1220BEBD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731953360;
	bh=wR2vAxb4KjC7bChWhYgHEm7VYOkoUSKJ2zrGmmUQgeU=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=QcXvfQn32bbEJk/CliGqPjJlSoPmzpqy39Cb7yWbUp/UMAorBMUaWUr/NKZ9e69DC
	 EuA6BiEwniO9Hz9jAZdoaPATG/Z4etAtwQMMCiIdSJ0wltRFnatVskzJPAClKWSWJ2
	 IoOFaRlq/Uc2MlJVJm0M77F7OwMbRuycEwh39LjI=
Message-ID: <52cc0733-49fc-4452-99c6-8c18bf20dde7@linux.microsoft.com>
Date: Mon, 18 Nov 2024 10:09:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, James.Bottomley@HansenPartnership.com,
 Julia.Lawall@inria.fr, agordeev@linux.ibm.com, airlied@gmail.com,
 akpm@linux-foundation.org, andrew+netdev@lunn.ch, anna-maria@linutronix.de,
 ath11k@lists.infradead.org, axboe@kernel.dk,
 bcm-kernel-feedback-list@broadcom.com, borntraeger@linux.ibm.com,
 catalin.marinas@arm.com, ceph-devel@vger.kernel.org,
 christian.gmeiner@gmail.com, christophe.leroy@csgroup.eu, cocci@inria.fr,
 coreteam@netfilter.org, daniel@zonque.org, davem@davemloft.net,
 dick.kennedy@broadcom.com, dri-devel@lists.freedesktop.org,
 edumazet@google.com, etnaviv@lists.freedesktop.org,
 florian.fainelli@broadcom.com, gor@linux.ibm.com,
 gregkh@linuxfoundation.org, haojian.zhuang@gmail.com, hca@linux.ibm.com,
 horms@kernel.org, idryomov@gmail.com, intel-xe@lists.freedesktop.org,
 james.smart@broadcom.com, jeroendb@google.com, jikos@kernel.org,
 jinpu.wang@cloud.ionos.com, jjohnson@kernel.org, joe.lawrence@redhat.com,
 johan.hedberg@gmail.com, jpoimboe@kernel.org, kadlec@netfilter.org,
 kuba@kernel.org, kvalo@kernel.org, l.stach@pengutronix.de,
 linux+etnaviv@armlinux.org.uk, linux-arm-kernel@lists.infradead.org,
 linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-rpi-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-staging@lists.linux.dev, linux-wireless@vger.kernel.org,
 linux@armlinux.org.uk, linuxppc-dev@lists.ozlabs.org,
 live-patching@vger.kernel.org, louis.peens@corigine.com,
 lucas.demarchi@intel.com, luiz.dentz@gmail.com,
 maarten.lankhorst@linux.intel.com, maddy@linux.ibm.com, marcel@holtmann.org,
 martin.petersen@oracle.com, mbenes@suse.cz, mpe@ellerman.id.au,
 mripard@kernel.org, naveen@kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, nicolas.palix@imag.fr, npiggin@gmail.com,
 obitton@habana.ai, ogabbay@kernel.org, oss-drivers@corigine.com,
 pabeni@redhat.com, pablo@netfilter.org, perex@perex.cz,
 pkaligineedi@google.com, pmladek@suse.com, rjui@broadcom.com,
 robert.jarzmik@free.fr, rodrigo.vivi@intel.com, roger.pau@citrix.com,
 sbranden@broadcom.com, shailend@google.com, simona@ffwll.ch,
 svens@linux.ibm.com, thomas.hellstrom@linux.intel.com, tiwai@suse.com,
 tzimmermann@suse.de, xen-devel@lists.xenproject.org, xiubli@redhat.com
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20241115-converge-secs-to-jiffies-v2-2-911fb7595e79@linux.microsoft.com>
 <20241116060541.5798-1-christophe.jaillet@wanadoo.fr>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <20241116060541.5798-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 02/21] coccinelle: misc: Add secs_to_jiffies
 script
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2084
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/52cc0733-49fc-4452-99c6-8c18bf20dde7%40linux.microsoft.com>

On 11/15/2024 10:05 PM, Christophe JAILLET wrote:
> Le 15/11/2024 à 22:26, Easwar Hariharan a écrit :
>> Suggested-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>> ---
>>   scripts/coccinelle/misc/secs_to_jiffies.cocci | 21 +++++++++++++++++++++
>>   1 file changed, 21 insertions(+)
>>
>> diff --git a/scripts/coccinelle/misc/secs_to_jiffies.cocci b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>> new file mode 100644
>> index 0000000000000000000000000000000000000000..af762b1c0aac8f044f21150bfaafd9efc834ee87
>> --- /dev/null
>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>> @@ -0,0 +1,21 @@
>> +// SPDX-License-Identifier: GPL-2.0-only
>> +///
>> +/// Find usages of:
>> +/// - msecs_to_jiffies(value*1000)
>> +/// - msecs_to_jiffies(value*MSEC_PER_SEC)
>> +///
>> +// Confidence: High
>> +// Copyright: (C) 2024 Easwar Hariharan Microsoft
>> +//
>> +// Keywords: secs, seconds, jiffies
>> +//
>> +
>> +@@ constant C; @@
>> +
>> +- msecs_to_jiffies(C * 1000)
>> ++ secs_to_jiffies(C)
>> +
>> +@@ constant C; @@
>> +
>> +- msecs_to_jiffies(C * MSEC_PER_SEC)
>> ++ secs_to_jiffies(C)
>>
> Hi,
> 
> 	@@ constant C =~ "000"; @@
> 
> 	* msecs_to_jiffies(C)
> 
> also spots things like msecs_to_jiffies(1000)
> 
> I'm not sure that coccinelle is enable to capture part of the regex to automate the removal of the 000 when converting from ms to s.
> 
> Just my 2c,
> 
> CJ

Thank you, I'll try that rule for the later parts. Thank you all for
helping with writing Coccinelle rules, I'm not familiar with
metaprogramming in general and Coccinelle in particular, so these are
super helpful.

- Easwar
