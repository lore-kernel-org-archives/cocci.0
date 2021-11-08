Return-Path: <SRS0=6jWL=P3=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1B55C433EF
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 14:35:17 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC1B611C0
	for <cocci@archiver.kernel.org>; Mon,  8 Nov 2021 14:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AEC1B611C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2570250"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 08 Nov 2021 15:35:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 89A54E02C9; Mon,  8 Nov 2021 15:35:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 89592E004C
	for <cocci@sympa.inria.fr>; Mon,  8 Nov 2021 15:35:13 +0100 (CET)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out1.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3AhpfVRRdh89TntEq99shSmlIflGM+R97LVj580XL?=
 =?us-ascii?q?Ho4xHfqnrxZn+JkuXvawr0AWQG9yCoK8fw6qO6ua8AzRGuc7A+Fk5M7V0Hycfj?=
 =?us-ascii?q?ssXmwFySOWkMmbcaMDQUiohAc5ZX0Vk9XzoeWJcGcL5ekGA6ibqtW1aFRrwLxd?=
 =?us-ascii?q?6KfroEYDOkcu3y/qy+5rOaAlUmTaxe7x/IAuroQnLq8UanIRuJ6Y/xxDUpndEZ?=
 =?us-ascii?q?/layXlnKF6Ngxrw/Nu88IJm/y9Np/8v6slMXLngca8lV7JYFjMmM2405M3vqxb?=
 =?us-ascii?q?OSBaE62UfXGsLjBdGGhDJ4x7mUJj/tCv6rfd91zKBPcLqV7A0WC+t4LltRRT1l?=
 =?us-ascii?q?SoILT858GXQisxtkKJWpQ+qqhJjz4LIZoyeKfxzdb7fc9wHX2pMRsVfWSJODYy?=
 =?us-ascii?q?yb4UBEfABPehFoYb/u1QAogCzBRWuCe711jNEmnH70K883u88EQ/GxgsgH9cWv?=
 =?us-ascii?q?XvbqNX6LrwSUfy0zKnNzDXDa+5d1Crn54fTcRAuu+yHULVuccXK00YgDADFgU+?=
 =?us-ascii?q?LpIz+IjOVzfoCv3KH4OthTO+ijXMspA5trDa13MgslpXJiZwPylDC7Sh13Ik4K?=
 =?us-ascii?q?NOmREN6Y9OpEphdui6UOoV4Xs4vTGJltigmx7AItpO1cyoHxZc7yxPBdfGJfYe?=
 =?us-ascii?q?F7g79WOuVPTp0mH1rdbSijBix6Uit0vDwW8203VpQsyZInNnBumoT2xDN9sSLU?=
 =?us-ascii?q?OVx80Sn1D2SzQ7c8PtELloxlafDK54u3Lowlp0LvETYGy/2hF32gLaRdkU55ui?=
 =?us-ascii?q?k9v7rYq77pp+HKYB4kBzxPbo2lsy+B+Q3LBQOUnCG9em41LDv51D1TbtKg/Esj?=
 =?us-ascii?q?KXVrozWKd4FqqO6GwNV15ws6xe7DzeoytQYmnwHIUpbeB2clYfmIFLOL+rjAPe?=
 =?us-ascii?q?knlSsiylky+raMbzgGpnNNGTMkK/9fbZh7E5R0BY8zddD6J1IC7EMO+nzW0/0t?=
 =?us-ascii?q?NzAFBA1KQ20w+D9CNV8zIwSQ2yPArXKeJ/V5HuV5/lnCOmFYYUYojL0Kv5ts/v?=
 =?us-ascii?q?lgmU+l3cecLOv0J9Rb2q3SKdcLl2dcEbr1+kFGHwWvw8/SKTAgVeBWHYHeXy7V?=
 =?us-ascii?q?aE1ziomE4/gBpWVFa63h7nU4iOyBYFXY2FCQnqFG3ThP9GaUf4Gayu6OdJ6n3o?=
 =?us-ascii?q?PR+7yGMcayRiyuVqimPJcJe3O93hA3XoG/MNo/OCVngNgrVSc7uyG1n2VCmZpg?=
 =?us-ascii?q?jpOXCIt0eZzrB4lor9s+bNlmPEeHs4Bvpt0?=
IronPort-Data: =?us-ascii?q?A9a23=3AOHE2xK8wiFfwpjWpFL5lDrUDwH+TJUtcMsCJ2f8?=
 =?us-ascii?q?bfWQNrUoqhDRSx2ofWWjXM6mPZWWgKNsgOYm+8UhSvcDRnYI1SHM5pCpnJ55og?=
 =?us-ascii?q?ZqcVI7Bdi8cHAvLc5adFBo/hykmh2ipwPkcFhcwnT/wdOi+xZVA/fvQHOOlUba?=
 =?us-ascii?q?UYnkZqTJMEU/Ntzozw4bVvaYz2bBVMyvV0T/Di5W31G2Ng1aYAUpIg063ky6Di?=
 =?us-ascii?q?dyp0N8uUvPSUtgQ1LPWvyF94JvyvshdJVOgKmVfNrbSq+ouUNiEEm3lExcFUrt?=
 =?us-ascii?q?Jk57gd1ESB7nPIVHIkWdNVu6uj3CupARrg/t9baFBLx0N03PTz7idy/0V3XC0Y?=
 =?us-ascii?q?RkjN6fPkcwGTgJVVSpsVUFD0OWafiDl7Zf7I0ruKSSwnKw1ZK0sBqUT/e18AEl?=
 =?us-ascii?q?V5PkAIXYMaAqCjqS42tqGpkNEkpx2do+wKNpK4jc42WuMVbB9GMGSV/6fvZkFy?=
 =?us-ascii?q?Ghlr95oNvP4S8o8SDNJUA7md0QXbw9TUYZWcPyAnXzja3hftU7M47Eq+GWVwAE?=
 =?us-ascii?q?Z7VQkC/KNEvTieCmfth/wSqP6E2XF7tUyL9mD0X+C7271wPTShi69VI96+HiQn?=
 =?us-ascii?q?hJ1qAX7+4DRIER+uZiHTT2RkVOlVpRUOST4PwIw+LMq+hXDosbVBnWFTb3tgvL?=
 =?us-ascii?q?Yc8FNCOB84xPlJm/8i+qGLjBscwOto+DKeCP7qfLGG7NJcx7U6eRTjYCo?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AXhbpdaFRYN6tV6zmpLqE7seALOsnbusQ8zAX?=
 =?us-ascii?q?/mt6Q3VuA6qlfqGV7ZMmPHrP4gr5N0tQ+uxoVJPhfZq+z/9ICOsqTNWftWDd0Q?=
 =?us-ascii?q?PCEGgI1/qG/9SPIVybygef78tdmmpFZeEYwWIUsS8y2meFL+o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AHAAAhNYlhexzch8NaGgEBAQEBAQEBA?=
 =?us-ascii?q?QEDAQEBARIBAQEBAgIBAQEBQIFGBAEBAQELAYF0ggIBAQE4MYRHjm+BdzGcMIF?=
 =?us-ascii?q?8CwEDAQ1BBAEBhQICglMCHQcBBDEIDgECBBUBAQUBAQECAQMDBAETAQEPCw8HO?=
 =?us-ascii?q?iSFaA2CNSKDbAECAyMdAQE3AQ8LDgoCAiYCAlcGDQgBAYJtgwyrY4ExgQGCCAE?=
 =?us-ascii?q?BBoJFFYMPHIFaCYEQKgGOKCccgUlEgRUngwM+h12CZY8hgWN2gQdYoCCeHYNCg?=
 =?us-ascii?q?1qbDwYPBS2VZA6RNpYQpiyBYgGCEjMaCDCDJFEZD44ghBqKN0ABAQEwOAIGCwE?=
 =?us-ascii?q?BAwmQdQEB?=
X-IPAS-Result: =?us-ascii?q?A0AHAAAhNYlhexzch8NaGgEBAQEBAQEBAQEDAQEBARIBAQE?=
 =?us-ascii?q?BAgIBAQEBQIFGBAEBAQELAYF0ggIBAQE4MYRHjm+BdzGcMIF8CwEDAQ1BBAEBh?=
 =?us-ascii?q?QICglMCHQcBBDEIDgECBBUBAQUBAQECAQMDBAETAQEPCw8HOiSFaA2CNSKDbAE?=
 =?us-ascii?q?CAyMdAQE3AQ8LDgoCAiYCAlcGDQgBAYJtgwyrY4ExgQGCCAEBBoJFFYMPHIFaC?=
 =?us-ascii?q?YEQKgGOKCccgUlEgRUngwM+h12CZY8hgWN2gQdYoCCeHYNCg1qbDwYPBS2VZA6?=
 =?us-ascii?q?RNpYQpiyBYgGCEjMaCDCDJFEZD44ghBqKN0ABAQEwOAIGCwEBAwmQdQEB?=
X-IronPort-AV: E=Sophos;i="5.87,218,1631570400"; 
   d="scan'208";a="2570243"
X-MGA-submission: =?us-ascii?q?MDGM0tpW5hLOkewfEuNA8/l+RuOdq1M4f3o+RA?=
 =?us-ascii?q?+4aKhWBNO0+ne2njb7bFfpeaxWlrJpyqWa+3jkZCkMVrd9xb7+JO7Wju?=
 =?us-ascii?q?3on/Df/fwgp00gQriwEhI7wrjeniLTWI8spPdZVv+EkdfUCDpfAFUbPA?=
 =?us-ascii?q?L3halnTLsOD7PaIQYm8RDA2Q=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 08 Nov 2021 15:35:13 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 390E1218E0;
	Mon,  8 Nov 2021 14:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636382112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2gF4xcGXYPQQnWgMvVLaf/hjnSedSd1K9LB4s+Ujwg=;
	b=ZKLhwsXVowQZQ6w+LVQR0rrjVo9cQ4MDSI5ojdknx3JYRsJBvREB7PR1l0a9AHRMh4GX2H
	9Cal3YWR5dqS1m3yFY8or8Fe5CCXNcvrSZ2YuSCQy9ZBis5ckZ/egtIwotEK/2N6ttMjxy
	lfIMQMoI2xwqJflVHiLAE8AZGIZegn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636382112;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v2gF4xcGXYPQQnWgMvVLaf/hjnSedSd1K9LB4s+Ujwg=;
	b=FjmDeS4dGH2ze97KSjdh6P5qwCQ/o9LW+3w5hntJW9YyPIxzFIAkrXV+HqbPut8zVRjWHK
	ccDp1GSB1nmbQlAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2A23D13BA0;
	Mon,  8 Nov 2021 14:35:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id YoaRCaA1iWGHKgAAMHmgww
	(envelope-from <vbabka@suse.cz>); Mon, 08 Nov 2021 14:35:12 +0000
Message-ID: <b7aea196-c9d9-6d8d-8ba0-ab2a361ba1ad@suse.cz>
Date: Mon, 8 Nov 2021 15:35:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: Luis Chamberlain <mcgrof@kernel.org>
Cc: cocci@inria.fr
Reply-To: Vlastimil Babka <vbabka@suse.cz>
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <YYVZva1hfwanXdyB@bombadil.infradead.org>
 <70748876-5df6-080b-f1da-1f94371001db@suse.cz>
In-Reply-To: <70748876-5df6-080b-f1da-1f94371001db@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Need some help with spatch
X-Loop: cocci@inria.fr
X-Sequence: 95
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/b7aea196-c9d9-6d8d-8ba0-ab2a361ba1ad%40suse.cz>

On 11/8/21 00:08, Vlastimil Babka wrote:
> On 11/5/21 17:20, Luis Chamberlain wrote:
>> On Fri, Nov 05, 2021 at 05:12:09PM +0100, Vlastimil Babka wrote:
>>> 1) patching complex variable declarations;
>>> 
>>> I need to perform changes such as:
>>> -struct page *page;
>>> +struct slab *slab;
>>> 
>>> This I was able to somehow specify in the .cocci, but not for situations
>>> where the original declarations looks like this:
>>> 
>>> struct page *page, *page2;
>>> 
>>> or
>>> 
>>> struct page *page = NULL;
>> 
>> For this, this seems to work well:
>> 
>> @@
>> @@
>> 
>> -struct page
>> +struct slab
> 
> Written exactly like above it works, but then it affects code in all
> functions, and I need some exceptions.

Still not full success, but I was able to make work at least some
combinations of declaration and initial assignement, such as

struct page *page = NULL;

by a rule like this:

@@
expression E;
@@
- struct page *page = E;
+ struct slab *slab = E;

But still not luck for e.g.
struct page *page, *page2;

where rules such as

- struct page *page, *page2;
+ struct slab *slab, *slab2;

don't work. Also no luck for this case:

struct page *page, *discard_page = NULL;

And thanks to the hints from Julia I was able to split up the rules so that
I no longer have unconverted expressions at places where two changes apply
to a single line.

I'll now try to build 1.1.1 to deal with the whitespace issues.
