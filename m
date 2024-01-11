Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 743ADC47077
	for <cocci@archiver.kernel.org>; Thu, 11 Jan 2024 12:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=9NzLPOUsm4ThQPwZ92JIgLF7g638ljz+YGoAu8ug0hY=;
  b=AykNnLvRdDfHdE7//xje2dvJ7XleQvE0mR6S7Heyhv+cpsIZtHIFv9GF
   SoZGT2+nlci//kxKQ4zN1qo7YbH2iqGIC0qrqidSyt/JQyLOK3ZaFpm5m
   deA4lJAauxykT+cqSsoMSsnwnJVINJ2vfAEhpffbU2m7myG//mKr/vnYn
   c=;
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
X-IronPort-AV: E=Sophos;i="6.04,186,1695679200"; 
   d="scan'208";a="146084838"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Jan 2024 13:04:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6897DE0CD0; Thu, 11 Jan 2024 13:04:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 73B9FE004E
	for <cocci@sympa.inria.fr>; Thu, 11 Jan 2024 13:04:11 +0100 (CET)
IronPort-SDR: 659fd93c_rZsqYoNZwzzYFeNG9lB4Lo6p5Tg2A5GYpy+fazCLFcePYCq
 UzBNxjVmqO7bjUYCcLxoUFAPyZnRlBcjGPAoTmw==
X-IPAS-Result: =?us-ascii?q?A0GIAgAA2J9l/w4P49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+COQd1VjIEC0iEU5E2MIQ7jwGIb4MWPg8BAwENNA0BAgQBAQMEhH8Ch0UCH?=
 =?us-ascii?q?gcBBDQTAQIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAoEGE4VsDYJcA?=
 =?us-ascii?q?RCBDIEeAQEBAQEBAQEBAQEBAQEBAQEBFwIUM0IBBAEjHQEBESYBDwsaAiYCA?=
 =?us-ascii?q?lYGARQBAYJ8AYIqAQMOIwcNtmCBMoEBggoBAQavWB8sIlaBYAMGgRouiBsBh?=
 =?us-ascii?q?WcJgzh6Jw+BVUSBFSeDAz6EQ4NbgmiCGoNCkEpSfx0DgQUEXA8bDx43ERAFD?=
 =?us-ascii?q?g0DCG4dAjE8AwUDBDIKHAshBVUDQAZJCwMCGgUDAwSBMAUNGgIQGgYMJgMDE?=
 =?us-ascii?q?kkCEBQDOwMDBgMKMQMwVUIMUANlHzIJPA8MGgIbHg0nIwIsQgMRBRACFgMkF?=
 =?us-ascii?q?gQ0EQkLJgMqBjgCEgwGBgldJgcPCQQlAwgEAyspAyN0EQMECgMUBwsHe4FTA?=
 =?us-ascii?q?xkrHUACAQttPTUGAwsbBj0ClUcBgjSBAj+CTsR9NAeCNIFggWEMihiVEwYTL?=
 =?us-ascii?q?4NukzgOBpJULpgfII1KmnyBeiaBRgwHMxokgzZPAxkPjiA4g3M3jxBANQI5A?=
 =?us-ascii?q?gcLAQEDCYVGAQGDWoFGAQE?=
IronPort-PHdr: A9a23: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
 chWIle0fEM4HLUWBxY8dDTnCIh6VHUonOzD5PM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6DerHaljTdXvveBe1BAY1nWMYMDpDfL43DAbv31ZSRFFG/FwWf
 re+cjzpiWE6wr5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6foSizPZLz9P+qjkzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: =?us-ascii?q?9a23=3A10mH3GiQekDHYqo5BrvGpQM9fTJuQlD25jT8BkW?=
 =?us-ascii?q?ECUlsab+1SELOx7pCnJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3As4KITQxSAzGhLpa9yE5VHc6DQM2aqP70EmMHsZo?=
 =?us-ascii?q?YgeKvHiFbP2vGtRSrU7Zyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.04,186,1695679200"; 
   d="scan'208";a="146084822"
X-MGA-submission: =?us-ascii?q?MDGobCCxi67FEaqX+Ggnl7YApk3Ynq7mHLaCq5?=
 =?us-ascii?q?JnsZYBoYtMTZHdKeZ4J+DS0k7Yf17JBez66X8BR+Pwof/XygXvkqqLfk?=
 =?us-ascii?q?XsK0si0Iwb2YCr5r6H9v31oy/pCDHuTFcaUt04YVqRBm/JXuXl7T/2CI?=
 =?us-ascii?q?L7Y+lOsa5Zq2KtFTx4sIO8lQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 13:04:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1704974640; x=1705579440; i=markus.elfring@web.de;
	bh=XPHM31/TfKCxRDz0ZIth51Z9vULocFfBJjxf1ByCGxM=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=MReblS0Xa1Lw1gy5z6IuAQWXzQ57Bwbd0y/lwQxOMULwtYZ6fg5FYZyWP3rsMc+2
	 HVhRiawwCKRSTLIRz6aDoiGMvXBK8taczd6ZUW+o8I3HczwtAMs+ajPbZWZ0CDrbj
	 dYUqT3VKZ3D+whh3Fb86WI94kbyhklGe1j3Y9tbC8jgACrszCd6EKb3C7yQYbiQhi
	 ilP14+NMVzxJ6yEm1ObNKH4HfjKl4eRMPTR002cBbXLC6Pp73h+gZyxTvWeo4FSSC
	 3SbM3Ft30XxNtCduiLMpUScr3k7p9ZsBDQaB+hFQc6NmadfpxZPSwXcR4GgzPJWsN
	 QanFhIRW06xeKzi7hg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.86.95]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MPaMQ-1raSrC2av4-00MgMN; Thu, 11
 Jan 2024 13:04:00 +0100
Message-ID: <58d6b9d0-a2d6-4d8d-bc36-fe783839ca79@web.de>
Date: Thu, 11 Jan 2024 13:03:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-GB
To: Lee Jones <lee@kernel.org>, linux-leds@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>,
 cocci@inria.fr
References: <c73761c5-7150-4f20-9b3e-1da680400250@web.de>
 <20240111104109.GB1665043@google.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20240111104109.GB1665043@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qumbmpRY/AvugoD+arzlfhgcwcM2WMYsUP+tFvej/BAbGvxkk0Z
 e8y7OICMQuzVRm8s5LQRo1FexoABXySiyHNy+QXWnLInWQUoNRaEGBLQPWpeFOOKawso4Nx
 LYmrOyL4cSHDzg+r5Y8tNV40c0u16U87YhMfqfpaBg0Cgn/th+CAubmnVYsk0l1+9nAwQD0
 bJHdPeEaL5RwzIKQ/PzgA==
UI-OutboundReport: notjunk:1;M01:P0:HUQG9nPB8vc=;kuYbAD82Z4Urm4GTFEM8Jzm2C9x
 Bvt3YOEdxzFMzVCuRkW4I83vAgEuJgmyCqOOtZiTlY2C/5cZxfSuU8ZXoBj7JTbfbgppXSeJa
 TmlOceBYybxxkFptQHGSYLjnBEZtPG4l4PRJ1qmYIEuKpEmBxneh3s426HXBex2yikHXegBVc
 aq3srAR1GTS8IEnKgiRHVofcT808PmVM3U5a0wd5D8oqgKN580E8SkQT0xtrnshNV+6vHoGVx
 Oxck1zZn/mcGuWYU4A4vsJgJjX/j7FH+RMIHjukpXmP/ezEKI9EZn3E/BiNySVEAM5b63Mc+p
 ZZ+xm4qT42XdltpLGZagpqbY0c7nDbQEBPw3M46Shj6Goe24vf1GjSI6qJIb11K5jmr8E9c5/
 yV/1AtH94uYeK8Dho7ZT4fEetj+OXnCMSsAbU2C/ioGpnxtnqCGzT2kXI7CpnCqwmvnTXWUXE
 si1pdIruNdI9cnWLQY3JHZRrTw4Ft/yiCp8rijGO5qvw4OiuwY0TYbbMuJSDUGz4UYLWuZiGM
 zmMUBdpgG/yjMo3ynhcSVoqh/DUpQsP7xancrSafgZLtW8TMv60gao8wmmDoc9+9cuXXZv97o
 C1HC6rYO9bAjGvGgtc4Zm4wzL3IOs1VO1+G2gV9fQaSboxlA/81anFma5zQECwl3Wrdl+RqoA
 ZN+uMLnbXikCmVPXnrKGbKrVRpJhYviTwgVbEhJyPvdlosF7CcFrzfv6HPTIBqPxgfvy4Bwx2
 P+He0VFCSb042PrRyNOwUYhiTwIVhbfVNzvZS/SQY6fM16LPyIrzvgueCWbbS8fvEaz20QXGE
 SlnCkVupTKyBeXhvif9cBAq1ufBYpTUvOzpBr9gnzjwKZENhIbDpuQFy1M4wXEOssbc3IGqmN
 pV/fr7iHzCdyva18wZOG5s4dBi67P1f2MkCrOs34Et34nj1xwGCnxKJuq3n4gAAVXkZSfPqLF
 KHxEcTKxb6mhV2YVdzEXjkYSQ5k=
Subject: Re: [cocci] leds: trigger: oneshot: One function call less in
 pattern_init() after error detection
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1457
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-01/58d6b9d0-a2d6-4d8d-bc36-fe783839ca79%40web.de>

>> The kfree() function was called in one case by
>> the pattern_init() function during error handling
>> even if the passed variable contained a null pointer.
>
> It's totally valid to call kfree() on a NULL pointer:
>
>   * If @object is NULL, no operation is performed.
>
> Why do we care all that much?

Would you dare to categorise such special function calls as redundant?

Should they be skipped in more cases?

See also:
https://wiki.sei.cmu.edu/confluence/display/c/MEM12-C.+Consider+using+a+go=
to+chain+when+leaving+a+function+on+error+when+using+and+releasing+resourc=
es


Regards,
Markus
