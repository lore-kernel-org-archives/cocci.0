Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06D08C433EF
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 23:35:40 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3635C611BF
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 23:35:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3635C611BF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2669264"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2021 00:35:38 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A1D8AE790A; Tue,  9 Nov 2021 00:35:37 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B7B59E03AE
	for <cocci@sympa.inria.fr>; Tue,  9 Nov 2021 00:35:33 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out2.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AQsw15BSp/RNc9AwDCK8jTso6bdpsoiufAWYlg6H?=
 =?us-ascii?q?Pa5pwe6iut67vIFbYra00ygOTBMOCsbka1aKW6/mmBTZYp87Z8TgrS99lb1c9k?=
 =?us-ascii?q?8IYnggtUoauKHbQC7rUVRE8B9lIT1R//nu2YgB/Ecf6YEDO8DXptWZBUhrwOhB?=
 =?us-ascii?q?oKevrB4Xck9q41/yo+53Ufg5EmCexbal9IRmosAndrNQajZVtJqswyxbCv39Ed?=
 =?us-ascii?q?/hLyW9yKl+fgQrw6t2s8JJ/9ihbpu4s+dNHXajmZaozUKZWDC4hM2A75c3rsQf?=
 =?us-ascii?q?MQA6S7XYCUWsYjwRFDRHd4B71Qpn+vC36tvFg2CaBJs35Uao0WTW54Kh1ThLjl?=
 =?us-ascii?q?ToKOCQ48GHTjcxwkb5brRe8rBFx34LYfIeYP+dlc6jDYd0VW3ZOXsdJVyxAHIy?=
 =?us-ascii?q?8aZcPD/EcNupctoXxukcCoQe7CQSqGejhyCJHhmXu0KM53eouHg/J0hIuH9wOr?=
 =?us-ascii?q?Xrbrsn6OqgJXOCpz6TF1ynPY+9Y1Dr/7oXDbxAvoeuLXbJ1acfexk0vGBnejlW?=
 =?us-ascii?q?MqIzlOjKV1uAQuGWG9eVvTuGvhHQ6oAx2vDig3d0jhZLKho0P0V3E7jh5wJ0rK?=
 =?us-ascii?q?tGiVEF6YMepHZ1NvC6VK4V4WNktQ310uCkk0L0Gv4a2cTYUxJknyRPTd+GLf5S?=
 =?us-ascii?q?K7x/+SuqcITZ1iXB5db+xmRq/9Uytx+78WMS0zVtGsyRLnsTRunwQyhDf98qKR?=
 =?us-ascii?q?uZz80qnxD2B1BjT5/lZLU0wlafXMYMtz7Awm5YJr0jPADP6lF/ogKKScEgv5/K?=
 =?us-ascii?q?m5P79Yrr8o5+RL490hR/6MqQpgsG/GuE4MhQWX2SC/uS8yaHj8VPjTLVRk/02i?=
 =?us-ascii?q?bfWvIrHKssFvqK5AglV3Zg/6xunEjur1NQVkWMaIF9LeB+LlZblN0/SLPziE/u?=
 =?us-ascii?q?yh0ygkDJxyPDHOr3hDI/NLn/GkLr5Y7Zy8FRTxxEwzd9F/J9UEawBIOntVUPrq?=
 =?us-ascii?q?NPZDwc1MxaozOb/FNV9yoQeVHqTDa+eLKzdrV6I6/k0I+iMYY8VoCzyJ+Ik5/7?=
 =?us-ascii?q?ol385mEUScbOn3ZsNcHq4BOhpI12FYXrwhdcMCWMKsRAwTePwjF2CVSVeZnezX?=
 =?us-ascii?q?6I5/T47EpipAZ3CRoCrmryB3T20EodYZmBcWRiwFiLNfp+HRuxERSacOM5nnXR?=
 =?us-ascii?q?QcLG7SJI6kzyquhX7zbVPMefevCEV49ar9sVx5uSbsRgt/DhwR5CfzmWMRidwl?=
 =?us-ascii?q?3wBQzse3aZloEU7xE3VgoZihPkNK9ha/O9IVwY+fbTVxe9zQ4TsUAvLfd6hU0u?=
 =?us-ascii?q?9T5OtE2diHZoK39YSbhMlSJ2ZhRfZ0n/vWudN/1RqLIcx7rqZ2GXtfYBm1m3Lk?=
 =?us-ascii?q?qUs3QFOqiRnLnC9i+h05VqKb2Ysu16EjKvsfrZOhEbw?=
IronPort-Data: =?us-ascii?q?A9a23=3AL1LgCKAXHTq+gRVW/3Liw5YqxClBgxIJ4g17XOL?=
 =?us-ascii?q?fDVHtgjtw1zRRxzEZWDvSMvjbZWv8KIokOoS/oBkE6p+km99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPjQFuKlYAL?=
 =?us-ascii?q?5EnkZqTFMGH9JZS1LwLZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFEda?=
 =?us-ascii?q?5ivP8b1FQBKXPJgXIhnc+t6qK20kf4HVpj+BhbqJaMxY/Zzahx7idzP1Tv5W6S?=
 =?us-ascii?q?g4BJbDXlaIWQXG0FgkkY/MXouGeSZS4mZfPkR2YKSaEL+9VJEoxNoYZ0v1mBHl?=
 =?us-ascii?q?Hs/0eMjEEKB6Z78qyya2yTu1ElMUmJtPieoIZoHBpiz/DZcvK67jXG/CXo4VMh?=
 =?us-ascii?q?WJowJhaR6OGIZNJN2R7N0GYJUBbZQI+FrQVmcGEhl/eehtksnSB/PJiuiyL2GS?=
 =?us-ascii?q?dy5D2NcbNP9uXWZ8ThVuDqyTK8gzE7tghHIT34VK4HriE34cjXB8XWb7+0JWj8?=
 =?us-ascii?q?+JyxVqO2jZVEwANWB23rJFVT2bWt813cyQpFugG9MDeN3BHivHmQga15nWW1vL?=
 =?us-ascii?q?Zc8QFCPU0sWlh1YKNizt0xQE4ovppc8E9uYk9V1TGE3fhc8zBXVRSjVFedZ5RG?=
 =?us-ascii?q?np4Y99/1ej54FLuvRM5cDY=3D?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A7X4hU6svot4B5VdUhuxr+UVF7skDTtV00zEX?=
 =?us-ascii?q?/kB9WHVpmwKj9vxG+85rtyMc6QxhO03I9ursBEDtexzhHP1OgbX5X43JYOCOgg?=
 =?us-ascii?q?LBEGgL1+DfKlbbdxEWmNQy6Y5QN5JhCNLsSWN3kNrg502AG8sgqeP3lZyVuQ?=
 =?us-ascii?q?=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0CCAAASs4lhmB3ch8NaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgVmDdwEBATgxhEeOb4F3MZ4sCwEDAQ1BBAEBhQICglYCHQcBBDQ?=
 =?us-ascii?q?TAQIEFQEBBQEBAQIBAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1KQGDZAECAyMPA?=
 =?us-ascii?q?Q0BATcBDwsYAgImAgJXBgEMCAEBgm2DDKwLgTGBAYIIAQEGhWkcgVoJgRAqjS9?=
 =?us-ascii?q?6JxyBSUSBFSeDAz6HXYJljyGCGSOBfL0ZgSSDQoNamw8GDwUtlWQOkTaWEB+mD?=
 =?us-ascii?q?YF4gX0zGggwgyRRGQ+OIBmEAYo3QAEBATA4AgYBCgEBAwmQdQEB?=
X-IPAS-Result: =?us-ascii?q?A0CCAAASs4lhmB3ch8NaHAEBAQEBAQcBARIBAQQEAQFAgVm?=
 =?us-ascii?q?DdwEBATgxhEeOb4F3MZ4sCwEDAQ1BBAEBhQICglYCHQcBBDQTAQIEFQEBBQEBA?=
 =?us-ascii?q?QIBAwMEARMBAQEBAQEBAQkLEAY6JIVoDYI1KQGDZAECAyMPAQ0BATcBDwsYAgI?=
 =?us-ascii?q?mAgJXBgEMCAEBgm2DDKwLgTGBAYIIAQEGhWkcgVoJgRAqjS96JxyBSUSBFSeDA?=
 =?us-ascii?q?z6HXYJljyGCGSOBfL0ZgSSDQoNamw8GDwUtlWQOkTaWEB+mDYF4gX0zGggwgyR?=
 =?us-ascii?q?RGQ+OIBmEAYo3QAEBATA4AgYBCgEBAwmQdQEB?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2669261"
X-MGA-submission: =?us-ascii?q?MDEXfbIYHaiZUjS62yGJRvIruVzXAC1MZ7Jg4y?=
 =?us-ascii?q?KC8DECLVcoK4f7iDE+1+YAuLdOpkg7utwA20CxBwF/pFRYFhQ1kzUEdr?=
 =?us-ascii?q?68k3xNIYd0kx26pqtRp2aXU6k2OkJH37NW02ssLDvGuGxjAfnGa6H8GV?=
 =?us-ascii?q?9Mgn5M/8xgTyUN3ea+goicBw=3D=3D?=
Received: from smtp-out2.suse.de ([195.135.220.29])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Nov 2021 00:35:34 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 93F911FD52;
	Mon,  8 Nov 2021 23:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636414532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiBHUzlJnbZLnZbOO9E2LI0T4MTToUY9+zZKwbeIilw=;
	b=1MKjJ2jV9I86irI8nMH8FHbYHTJFOwHSafd+fWYqoC3Bmig2om2VfmpiU8SK9NtSj9s20i
	0YY/W9omaf6S8fau1ufME41UjCz0ZZ+cyz6oJWcKh+F99QD3eloABYFNnzP6APOTg1bPAp
	HnZnJ0zkvoxYntPIIGKFRfdewb7cot0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636414532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RiBHUzlJnbZLnZbOO9E2LI0T4MTToUY9+zZKwbeIilw=;
	b=pZo3E1pz5usUcaA7ck5c7xDPLY7BmiDddnjKDUlmcV70/0r+HuBQSV+8os+AHcu8GGXBL8
	B4a6dxhsqUdvurBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 74E6113780;
	Mon,  8 Nov 2021 23:35:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id IzbJG0S0iWFLCQAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 08 Nov 2021 23:35:32 +0000
Message-ID: <d743be25-66d4-7db9-d978-0d2e73528297@suse.cz>
Date: Tue, 9 Nov 2021 00:35:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <a02a8c42-011d-0f9c-6a2f-7d45a3f216a5@web.de>
 <alpine.DEB.2.22.394.2111071321530.2988@hadrien>
 <000e221f-1bac-6e29-8c68-2c1eab5b2128@web.de>
 <89bb8f39-4527-a1b4-dab9-82929773e9d9@suse.cz>
 <alpine.DEB.2.22.394.2111071908410.2988@hadrien>
 <96c0476d-beef-ed62-26d3-5f754cec0f45@web.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <96c0476d-beef-ed62-26d3-5f754cec0f45@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] mm/slab: prepare for struct page conversion by spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 101
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/d743be25-66d4-7db9-d978-0d2e73528297%40suse.cz>

On 11/8/21 18:35, Markus Elfring wrote:
>>> - struct page *page;
>>> + struct slab *slab;
>>
>> If you first rename struct page as strict slab and then do
>>
>> struct slab *
>> - page
>> + slab
>>   ;
>>
>> it might work even for the multiple declaration case.
> 
> Will there are need occur to adjust any more variable names?
> (Would different suffixes matter for corresponding identifiers?)

I was suprised that it works, which means the matching is more complex than
I thought. So I was able for example to achieve this:

-       struct page *page, *discard_page = NULL;
+       struct slab *slab, *slab_to_discard = NULL;

by the following rules (with ok_function per Julia's other e-mail):

@@
position p : script:ocaml() { ok_function p };
@@
- struct page@p
+ struct slab

@@
@@
struct slab *
- page
+ slab
;

@@
expression E;
@@
struct slab *
- discard_page
+ slab_to_discard
= E;

Thanks,
Vlastimil
