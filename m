Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0004EC433F5
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 16:53:30 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 248BD61359
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 16:53:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 248BD61359
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2615926"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 17:53:29 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2EF4DE02C9; Mon,  8 Nov 2021 17:53:28 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B09D3E004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 17:53:21 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out1.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3A7b2r8hbxdEGcdyuvYsxBNl//LTGB0IqcDmcuAno?=
 =?us-ascii?q?PtbtCf+yZ8oj4OwSHvLMx1gaPBN+QtawMy7KP9fy6ASpYudfJmUtBWaQEbwUCh?=
 =?us-ascii?q?8QSkl5oK+++Imq/EsTXaTcnFt9JTl5v8iLzG0FUHMHjew+a+SXqvnYdFRrlKAV?=
 =?us-ascii?q?6OPn+FJLMgMSrzeCy/IDYbxlViDanbr5+Mgi6oR/MusUIjodvK6c8wQbNrndUZ?=
 =?us-ascii?q?uha32xlKUyPkxrm+su84Jtv+DlMtvw88MJNTb/0dLkiQ7xCCzQmPWE15Mn1uhT?=
 =?us-ascii?q?GUACC+HgSXHgInxRRGwTK4w30UZn3sivhq+pywzKaMtHsTbA1Qjut8aFmQwL1h?=
 =?us-ascii?q?SgdNj459GbXitFsjK9evRmsqQBzz5LSbYqIL/d1YL/Tcs0GSmpARsZRVjJOAoW?=
 =?us-ascii?q?gb4sUEuENOf9Uo5Thq1cSqBezAxSnCuHyxT9SnnL43qM03OsvHg/bwgIgEdIAv?=
 =?us-ascii?q?3bIo9v6L6oSTeK4wbPUwTnfYf5b2zHw45XIfBA7pvGMWKp9fsXVyUY1DAPFklS?=
 =?us-ascii?q?QqYnkPzORy+8ArnKU4PFjVe21lmUqrB9xrSO1ycg3iYnGnJkYykvZ9SVi3ok5P?=
 =?us-ascii?q?8G3SU9ibNOiDZBfuD2UOZFsTcM+X2Fnpjw6yrsetJOnYSUHx4oryRDCZ/KJfYW?=
 =?us-ascii?q?G7RztWumfLDplhX9ofK+yihK9/EW9yeDxUsa53llXoydKjtXAqH4A2hLS58SaS?=
 =?us-ascii?q?vVw+Fqq1zWX1w3L9+1JJUA5mbDGJ5MvwrM8jIQfvVrfEiPshkn7j6mbfVg+9Oe?=
 =?us-ascii?q?y8eToeLDmq4ecN4BqjgH+Nbwjmte6AeQkKggCRm+b+fmg1LH+50H5W6hKjuYon?=
 =?us-ascii?q?aXDrZ/VO9wXpq+/AwBLzoYu8wuzAjOm3dgCgHUKIlJIdAiZg4T3J13COu70APS?=
 =?us-ascii?q?nj1SpijhrxvTGPrP7ApXKK3jOiKnhcq1n5EFHywo818tS54lJCrEaPv3/QFP+t?=
 =?us-ascii?q?d3AAh8jLwO02/rnCMl61o4GRW2PBbOWP7/TsVKT/eIuI+yMZJcPtzrnKvgl4eT?=
 =?us-ascii?q?ujX4jllMHc6mpx4MdaGqkEfR+P0WZfX3sj88FEWgQsAsxVujqiFmZXD9SZnayW?=
 =?us-ascii?q?rkz5ishB468DIfDQJqtgL2b0yuhEJ1WfDMONlfZM2rsdozMf/4TYSaWaptjjzg?=
 =?us-ascii?q?FXP6lQpAo0RWGtQngyrMhIPCCqQMCspe26tx8/PHSkBA2vRZ9BceUmzWTRWh+n?=
 =?us-ascii?q?WogXCIt0eZ0sxoumR+4zaFkjqkARpRo7PRTX1J/bMaEpwSfI8vvQQ+HdcXbED5?=
 =?us-ascii?q?Oo/29BC0pC9Us34ZIeFtmFpOug0Kbt8JFK6QIjLHND45mq8rh?=
IronPort-Data: =?us-ascii?q?A9a23=3Ac/NRm64HPiPNYza2BWMYYQxRtGPGchMFZxGqfqr?=
 =?us-ascii?q?LsXjdYENShTcFm2ccXWuBaP/eY2OkeYxxbN7k80gC6pOHyYdnHVEd+CA2RRqmi?=
 =?us-ascii?q?+KVXIXDdh+Y0wC6d5CYEho/t63yUjRxRSwNZie0SiyFb/6x8hGQ6YnSHuClUbe?=
 =?us-ascii?q?cangoLeNZYH5JZSxLy7ZRbrFA2oDR7zOl4bsekuWHULOX82Yc3lE8t8pvnChSU?=
 =?us-ascii?q?MHa41v0iLCRicdj5zcyn1FNZH4WyDrYw3HQGuG4FcbiLwrPIS3Qw4/Xw/stIov?=
 =?us-ascii?q?NfrfTaUgWWvvVIBTXzGFLQKXkjhUqSi4ai/dmcqNHNAEN0W3PxYAZJNZl7fRcT?=
 =?us-ascii?q?S83NKTGm+01SARDHmd1L8Wq/ZedfyHi4ZzKp6HBWyGzn6o3VynaJ7Yw8eF8CmB?=
 =?us-ascii?q?m7u0dMDlLbxaZhuvwzqjTYu1lmc0nKOH5PYYVoHgmzDfDDP9gT4qrfklgzcsAi?=
 =?us-ascii?q?W123dQXSK6YP95DPGIpN02RMgkUbw9RVYZhyc62oFL6VRFYjXOcg5YtxXyKlFk?=
 =?us-ascii?q?plOH5WDbOUsePWd0QmVuE/yTd4n/0RB0XXOFzAAGtqhqE7tIjVwuhAOr+1YFU9?=
 =?us-ascii?q?8KGRHWIw3ALTRoLSQL9uuSihwiyVrqz7mR8FjUG9cAPGI6DF7ERnCFUZFafowU?=
 =?us-ascii?q?RHdFCewH/wB/Y0bLaum51GUBdJgOsq7UaWAseXiEx2xmCjbsFwBQHXKK9ERqgy?=
 =?us-ascii?q?1tfkd9+1eX544PPie/ogDbpO+Xenbw=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AZUvYGqPPDJfQ8sBcTlejsMiBIKoaSvp037BK?=
 =?us-ascii?q?7S1MoNJuEvBw5Pre5sjzsiWE8Qr5OUtQ/+xoV5PwI080maQa3WBzB8bEYOCFgh?=
 =?us-ascii?q?rNEGiz1/qG/9SIIUSXnYRgPMFbHJSWY+eAbmSS+PyKmzVQfexA/DD+ytHRuc7u?=
 =?us-ascii?q?i1FTTEVBbqFt6BpYE2+gfnFedU1hGpt8KYGV7MZd4xqsEE5nE/iTNz07ZKz4nv?=
 =?us-ascii?q?XuvrrbWzJuPW9Y1CC+yQySrITCOzyj9DEkf1p0sMgf2FmArDe83JyKl8uH4iLx?=
 =?us-ascii?q?vlWjk6hrpA=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0BxAgDwVIlhexzch8NaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgVmDdwEBATgxhEeOb4F3MZ4sCwEDAQ1BBAEBhQICglYCHQcBBDQ?=
 =?us-ascii?q?TAQIEFQEBBQEBAQIBAwMEARMBAQ8LDwc6JIVoDYI1KQGDZAECAyMdAQE3AQ8LG?=
 =?us-ascii?q?AICJgICVwYNCAEBgm2DDKwkgTGBAYIIAQEGhWkcgVoJgRAqjS96JxyBSUSBPIM?=
 =?us-ascii?q?DPoRFgxiCZZBmEQ2BI6FSnh2DQoNamw8GDwUtg1qSCg6RNpYQpiyBeIF9MxoIM?=
 =?us-ascii?q?DuCaVEZD44gDBaDeIo3QAEBATA4AgYLAQEDCZB1AQE?=
X-IPAS-Result: =?us-ascii?q?A0BxAgDwVIlhexzch8NaHAEBAQEBAQcBARIBAQQEAQFAgVm?=
 =?us-ascii?q?DdwEBATgxhEeOb4F3MZ4sCwEDAQ1BBAEBhQICglYCHQcBBDQTAQIEFQEBBQEBA?=
 =?us-ascii?q?QIBAwMEARMBAQ8LDwc6JIVoDYI1KQGDZAECAyMdAQE3AQ8LGAICJgICVwYNCAE?=
 =?us-ascii?q?Bgm2DDKwkgTGBAYIIAQEGhWkcgVoJgRAqjS96JxyBSUSBPIMDPoRFgxiCZZBmE?=
 =?us-ascii?q?Q2BI6FSnh2DQoNamw8GDwUtg1qSCg6RNpYQpiyBeIF9MxoIMDuCaVEZD44gDBa?=
 =?us-ascii?q?DeIo3QAEBATA4AgYLAQEDCZB1AQE?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2615881"
X-MGA-submission: =?us-ascii?q?MDFwRD5d+hkHLIShTwfhomfKKDEX1/t2B/Hy5f?=
 =?us-ascii?q?8++e2kcLH6Axv6fF1CAEPL5TIxehS+XjuZBCueZojec+fx66JaYb0liq?=
 =?us-ascii?q?OdFr6FMM8NwMjJF+7iDqj3SZdTmYCLcch47LM7gn9zADo5OTZtoD6PDb?=
 =?us-ascii?q?fhVK/iCuO8wLq70zEbFuSpCg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 17:53:21 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A744821958;
	Mon,  8 Nov 2021 16:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636390399; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztpQK1uGO7Y7ezHQn3lX7UUjxluHW6N7ZygMEY5hkco=;
	b=Gp6MqIndXGIrty8fp0iS228MNj4/zqC/y3nJfvjF8IDnOZQD34ipRtdOJPK8KuUYSNZH+S
	PDiMkwd+kLpy0oznZy2ZWRWTwp2/zwWGk2kL1Lz8j9MZloe5EY8pooZ+ihxl/DRZcVFev2
	jxg0hzNmjjkliI9fLRAzCmy3E8zn5cM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636390399;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ztpQK1uGO7Y7ezHQn3lX7UUjxluHW6N7ZygMEY5hkco=;
	b=lm+PXGN19b3Bfxzsp0fANGp3pJhqSSBEJIa1niwb/ecK7iQrIWwLFjpG6j6kn2aMZG4fdv
	6l9AYS9nVotyEkCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9382F13BC0;
	Mon,  8 Nov 2021 16:53:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id jxFNI/9ViWEadAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 08 Nov 2021 16:53:19 +0000
Message-ID: <682ecb85-3c8e-f0c7-8f02-b56cd6e11872@suse.cz>
Date: Mon, 8 Nov 2021 17:53:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Luis Chamberlain <mcgrof@kernel.org>, cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <YYVZva1hfwanXdyB@bombadil.infradead.org>
 <70748876-5df6-080b-f1da-1f94371001db@suse.cz>
 <b7aea196-c9d9-6d8d-8ba0-ab2a361ba1ad@suse.cz>
 <alpine.DEB.2.22.394.2111081542290.2988@hadrien>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <alpine.DEB.2.22.394.2111081542290.2988@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Need some help with spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 97
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/682ecb85-3c8e-f0c7-8f02-b56cd6e11872%40suse.cz>

On 11/8/21 15:45, Julia Lawall wrote:
>> I'll now try to build 1.1.1 to deal with the whitespace issues.
> 
> Sorry, I got interrupted on this.
> 
> @initialize:ocaml@
> @@
> 
> let ok_function p =
>   not (List.mem (List.hd p).current_element ["functions";"to";"ignore"])
> 
> @@
> position p : script:ocaml() { ok_function p };
> @@
> 
> - struct page@p
> + struct slub
> 
> julia

Thanks a lot, that did the trick!

Note that this still patched also the struct page *page; field in struct
kmem_cache_cpu definition, which is not part of any function, but as I was
patching it anyway, it's no problem.

