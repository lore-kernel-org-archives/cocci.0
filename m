Return-Path: <SRS0=AtCD=PY=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7EE7C433EF
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:25:10 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA39661157
	for <cocci@archiver.kernel.org>; Fri,  5 Nov 2021 21:25:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CA39661157
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
IronPort-Data: =?us-ascii?q?A9a23=3Apq+oa6MGex0yV83vrR20lsFynXyQoLVcMsFnjC/?=
 =?us-ascii?q?WdVK702wggWFWmmEeWWDQPKyDZ2Cnc9xybN7g8xsPvpPTm99gGjLY11k9FiMQ8?=
 =?us-ascii?q?ZKt6fexdxqrYXvKdqUvdK/WhiknQoGowPscEzmM+X9BDpC79SMljPjQG+KnYAL?=
 =?us-ascii?q?5EnsZqTFMGX5JZS1Ly7ZRbr5A2bBVMivV0T/Ai5W31GyNh1aYBlkpB5er83uDi?=
 =?us-ascii?q?hhdVAQw5TTSbdgT1LPXeuJ84Jg3fcldJFOgKmVY83LTegrN8F251juxExYFEcK?=
 =?us-ascii?q?gir+9c0sQQ7eUMxLmZnh+AvLyxEkZ4HVsiOBiaqJ0hUR/0l1lm/h6z95GtNm3V?=
 =?us-ascii?q?gEkJIXNnv4cWl9WCUmSOIUcouKceyXv2SCU5wicG5f2+N1lC0o9PKUR4O13AH9?=
 =?us-ascii?q?D77obJSoLYxTFgPi5qJqxS/J3l8otBMbuNYIb/HpnyFnxBvErR53Fa6rP7N5cm?=
 =?us-ascii?q?jw3g6hmEf/YIchfdjtraBXJZgZnNVIeCZZ4l+Ct7lHzeiNZpEmSo6Y57Gz7wwl?=
 =?us-ascii?q?40byrO93QEvSGSINOmVuKryTN+H70BA0bMvSQzDOE9jSngeqntSjgRYYWBZW38?=
 =?us-ascii?q?fllhFDVzWsWYDUcWF22rfi6lma+VtNZJgoO/SEttsAa/0isScLVXR2zpHmDpVg?=
 =?us-ascii?q?XXN84O+Ez7gCAzuzQ7hSSD24DZjpAbtU8s4kxXzNC/lSJhdLyGTt3sPufTn+d8?=
 =?us-ascii?q?6idqT+/IwARLGkIZDNCRgwAi+QPCqlbYgnnVsxkHOuxj8bpFCrtmmDMrS4khrx?=
 =?us-ascii?q?Vg9Rj6klyxnif6xrEm3QDZlRdCt3rY1+Y?=
X-IronPort-AV: E=Sophos;i="5.87,212,1631570400"; 
   d="scan'208";a="2253258"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Nov 2021 22:25:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 18102E006A; Fri,  5 Nov 2021 22:25:08 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4C318E004C
	for <cocci@sympa.inria.fr>; Fri,  5 Nov 2021 22:25:06 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=vbabka@suse.cz; spf=Pass smtp.mailfrom=vbabka@suse.cz; spf=None smtp.helo=postmaster@smtp-out1.suse.de
IronPort-PHdr: =?us-ascii?q?A9a23=3Anvp3WxyO08J+ZI3XCzIVylBlVkEcU1XcAAcZ59I?=
 =?us-ascii?q?dhq5Udez7ptK+ZhSZtKwm0QCBdL6YwsoMs/DRvaHkVD5Iyre6m1dGTqZxUQQYg?=
 =?us-ascii?q?94dhQ0qDZ3NI0T6KPn3c35yR5waBxdq8H6hLEdaBtv1aUHMrX2u9z4SHQj0ORZ?=
 =?us-ascii?q?oKujvFYPekdi72/q29pHObAlFhDiwaq5uIRurqgncqtMYipZ4JKYrzRvJrHpIe?=
 =?us-ascii?q?+BIym5tOFmegRXy6Nqu8ZB66yhftO4v+MBGUaXhYqQ3VqdYAyg8M2A0/8Lkqx/?=
 =?us-ascii?q?ORhaS63QGU2UWlh1IAxXZ7Bz/Q5z8vDf2uvZ71SKHJsD9U6w6Viq+4KdqUB/oi?=
 =?us-ascii?q?TkINzgl8GHMl8d8iLtXrA+9qxBjxoLZZpyeOvhjcaPHZd4URmRPUclfWCJcHI2?=
 =?us-ascii?q?8YYsBAOgdMuhXtIT9u1kDoAGiCQWwCu7iyDlFjWL2060g1OQhFBnL0wMkH90Uq?=
 =?us-ascii?q?3TUsNT1NKITUeCx0aLF0C/MYOhV2Tjn9YPFdQ4hruqWUr1rcsre01IiFxjYjlW?=
 =?us-ascii?q?Lt4PpJS+a1+UUvmWd8uFvWv6hhXQ9pAFtvjig2N0sio/Ri48J113J+jt1zogoK?=
 =?us-ascii?q?dO2RkN1btCqHpReuiyHNoZ7Rt4vTmVntSsnybALvZG2cicXxZko2xLTdfKKfoa?=
 =?us-ascii?q?J7x7+VOicJypzinF9eL+nmhq/9UitxvfhWsS60FtGtDRJnsfQunwXyRDe6c6KQ?=
 =?us-ascii?q?eZn8Ei7wzaAzQXT5/lEIU8qkarbLIYswqU1lpoPqUTPByj2mFjqjKOLbEkk4fW?=
 =?us-ascii?q?o6//5bbn8u5CTKZd4igD4MqswhsyyGfk0PwwOUmSB5Oix2r3u8VfnTLlUkvE6i?=
 =?us-ascii?q?LfVvZPCKcQevKG5AgtV0og56xa4CjeryMoYkmIdI11eexKIlZPkO0rTIPDjE/i?=
 =?us-ascii?q?zmUijkTZzy/DcIrLhGonNLmTEkLr5Ybl97FJTxxYyzd1E/JJVCrQBIOrpVUPrt?=
 =?us-ascii?q?dzYCAU5Mw2uzOr9BtV9zJsUWXiTDa+BLKPSrViI6/orI+aWao4aojL9K/w+6v/?=
 =?us-ascii?q?vjH85nEQSfbOz0pcNaXC4GO5mI0SDbnb2jNcBCzRCgg1rbvHuiVTKdTdMbnK2F?=
 =?us-ascii?q?/Y++zU6AcSiBJjKQoSFgbqb3S79EIcANU5cDVXZL3PhbJmFXvYIIAibKMxo2mg?=
 =?us-ascii?q?aX7GrSIYJzgy1uUnx2ew0faLv5iQEuMe7h5BO7OrJmER3rGQsZyxy+3qQVGwyl?=
 =?us-ascii?q?XFaHlfePYhkpFBlj1CezfE+mOFDGJpf6qEROu/fHYXB1OE8AMKgAmr8?=
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3AIrj3lquQU0vguVXT/mE8yO/r7skDU9V00zEX?=
 =?us-ascii?q?/kB9WHVpm6uj5r2TdZUgpGXJYVMqM03I9urhBEDxexnhHPJOkOos1M6ZLW/bUQ?=
 =?us-ascii?q?iTXeRfBOnZrQEIcheWnoNgPMFbAspD4bXLbGSS5vyU3ODXKbodKaG8gcSVbQi3?=
 =?us-ascii?q?9QYLcemlA5sQljuQ526gYzVLrMkvP+tDKKah?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AlAgASaxphexzch8NaHAEBAQEBAQcBA?=
 =?us-ascii?q?RIBAQQEAQFAgVmDeAEBATgxhEePSYF3MIQYmUwLAQMBDUEEAQGEYQKCawIdBwE?=
 =?us-ascii?q?ENBMBAgQVAQEFAQEBAgEDAwQBEwEBDwsPBzokhWgNgjUpAYNjAQEBAQIBIwQZA?=
 =?us-ascii?q?QE3AQQLCxgCAiYCAlcGDQgBAYJtgmclpn16fzKBAYIHAQEGhgwcgVoJgRAqjHl?=
 =?us-ascii?q?6JxyBSUSBPIJ+PodbgmSEFwGDWZJHjUmcYoEYgzKDU5pqBg8FJpVJDpEeu1aBd?=
 =?us-ascii?q?4F9MxoIMIMkUBkOjiALF4N4ijdAAQEBLzgCBgsBAQMJiXUBAQ?=
X-IPAS-Result: =?us-ascii?q?A0AlAgASaxphexzch8NaHAEBAQEBAQcBARIBAQQEAQFAgVm?=
 =?us-ascii?q?DeAEBATgxhEePSYF3MIQYmUwLAQMBDUEEAQGEYQKCawIdBwEENBMBAgQVAQEFA?=
 =?us-ascii?q?QEBAgEDAwQBEwEBDwsPBzokhWgNgjUpAYNjAQEBAQIBIwQZAQE3AQQLCxgCAiY?=
 =?us-ascii?q?CAlcGDQgBAYJtgmclpn16fzKBAYIHAQEGhgwcgVoJgRAqjHl6JxyBSUSBPIJ+P?=
 =?us-ascii?q?odbgmSEFwGDWZJHjUmcYoEYgzKDU5pqBg8FJpVJDpEeu1aBd4F9MxoIMIMkUBk?=
 =?us-ascii?q?OjiALF4N4ijdAAQEBLzgCBgsBAQMJiXUBAQ?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="398384287"
X-MGA-submission: =?us-ascii?q?MDHXzes4I0eXRDcCn4u5ndmkdQ901M94jCsFhv?=
 =?us-ascii?q?TKMKEBg9v2raGRiTNTIdKjvk4puaSHP3uu9LB9R2oZob4shPQjtYR8hM?=
 =?us-ascii?q?hWm3Qk7bqOC3LCOZBJ5EbN76JMGU7OzHaZZPrpvTUbFkpMIO2+CHVbaG?=
 =?us-ascii?q?fwdL9iDIOlkkBnoZ3kIJpq1w=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Nov 2021 22:25:05 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A2C1021963;
	Fri,  5 Nov 2021 21:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1636147504; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97H/1A6mbXhCBykj/jF8N9iFBhJTMIXzlsCHDQWGlPk=;
	b=itodtmB5zDCZxQUpp6j63LCL3chCQf3/vCFrQhh6kS4Yox4wuksYP+emIONQIAv3POIMJc
	RsObuWoWCBWe3ffFLpAUP7B0nkMc+mMPK3Pu3NWbtZqefXU6NZk6b/8Q2BwE2wGgLByNyc
	mVqeN/XoF69STPNEvH6aMhQDdBA4Ct0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1636147504;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=97H/1A6mbXhCBykj/jF8N9iFBhJTMIXzlsCHDQWGlPk=;
	b=S5RcNdTekHmcyeUhYjGfRf6p01QpAP9ppF9i/t9lwdFHBLDn7DkDaJ2SZOQKk8rZ+T5FTH
	Sg1AKv/dzQRbzmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8CA511401F;
	Fri,  5 Nov 2021 21:25:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BDEBITChhWHAOAAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 05 Nov 2021 21:25:04 +0000
Message-ID: <b7d146ac-c493-db4a-a326-58bb37392634@suse.cz>
Date: Fri, 5 Nov 2021 22:24:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <17a7a40f-b736-e0ea-02ae-1b03ef4483bf@suse.cz>
 <alpine.DEB.2.22.394.2111052212190.3000@hadrien>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <alpine.DEB.2.22.394.2111052212190.3000@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Need some help with spatch
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 78
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-11/b7d146ac-c493-db4a-a326-58bb37392634%40suse.cz>

On 11/5/21 22:13, Julia Lawall wrote:
>> for example the cocci patch is supposed to change all "page" to "slab", but
>> some lines are patched like this:
>>
>> -       __free_slab(page->slab_cache, page);
>> +       __free_slab(page->slab_cache, slab);
> 
> I assume that here you are using the semantic patch in 184d9494c1a4.  I

Yes, that's the slub.cocci one from that commit.

> get that both occurrences of page are changed.  What version of Coccinelle
> do you have?

It's 1.1.0 in openSUSE Tumbleweed, so it should be the latest?

But that reminds me, yesterday I adjusted just that rule in the semantic
patch a bit and suddenly it converted almost everything. Today I re-ran
spatch for some rebasing reason and it again needed the fixup. I assumed
there was some git snafu on my part and the fixup was already applied.
But if it works differently for you, I'm not sure now. Is it possible
for the result to be non-deterministic? E.g. some internal state of
coccinelle is based on, say, hash table and in some cases the
non-deterministic order matters?

And just to be sure, does .config matter for coccinelle (through effects
on #ifdefs etc)? I assume it doesn't, if I don't use that switch to
perform preprocessing?

Thanks,
Vlastimil

> julia
> 

