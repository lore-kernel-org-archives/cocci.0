Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 718B4C27C50
	for <cocci@archiver.kernel.org>; Mon,  3 Jun 2024 19:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nbsQrh+DSBljWYQA/9pDPkgkAK2YnszO65H1IZOBFLM=;
  b=LbEbWs1A+WRiuoS6YRyKK1f8vQNYdPtDboKlg+SRloaIFYPWFXCbE98O
   ADjjIOhJqOY+1cSI1gzsLdLeQkl9+GXECUXgIgbtj/Py5H0mKJ/go27Yu
   mKmKdEcuLiRYSifBHRwyUCx7AriYflNL1GbX9QzcmJITjS1vkJwswgsmR
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.cz
X-IronPort-AV: E=Sophos;i="6.08,212,1712613600"; 
   d="scan'208";a="168827724"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Jun 2024 21:30:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B5CCCE0138; Mon,  3 Jun 2024 21:30:05 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 38A55E0035
	for <cocci@sympa.inria.fr>; Mon,  3 Jun 2024 21:29:59 +0200 (CEST)
IronPort-SDR: 665e19b6_OCxtdyWONaxrG7CRbLvPCOtHbucz8ftMes7/rnK+B172May
 1WvlrR8JOFczYozdEsrAD5eAQRg3Tji5xRXZhsg==
X-IPAS-Result: =?us-ascii?q?A0EdAAASGV5mmILfh8NSCBwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE9BQEBCwGBcVKBVjMEC0iEVoh8hkyBdS0DhDuZUIF+DwEDAQ1EBAEBAwEDh?=
 =?us-ascii?q?H8CiF4CHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAQEBAQEeGQUUCieFdA2CZwEzghAsDXsBAQEBAgEjBBkBATcBBAsLFAQCA?=
 =?us-ascii?q?iYCAlYGARICAQGCfIJCIwQDrzx6fzOBAYIMAQEG234fgWMJgRouAYgwAYlCe?=
 =?us-ascii?q?icbgUlEgRUngRSBbz6EHIQCgmmKWIxYgjaCHE+GeoFCfyYLgR+Hd1R9HANZI?=
 =?us-ascii?q?QEBEQFVExcLPh0CFgMbFAQwDwkLJioGOQISDAYGBlk0CQQjAwgEA0IDIHERA?=
 =?us-ascii?q?wQaBAsHdYFxgTQEE0QDgTeJcwyDLymBSymEHEtsFYNygWsMYYNLhEpjgRCBQ?=
 =?us-ascii?q?4FmAU+Cfx1AAgELbT01CQsbBj2qIFIOGCdhJlongRk2LZV4jXChVoQdhEuca?=
 =?us-ascii?q?wYPBC+XOg6Sbi6YNiCoaoFsDiVCgRozGggwO4IBZk8DGQ+OIQwNCYQAyk9BN?=
 =?us-ascii?q?TsCBwsBAQMJiSKBSAEB?=
IronPort-PHdr: A9a23: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
 PLmpZdASUc4UPgIWB0N9DkqO4psU3Uvg+zD5PM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3XDC5qPKhGCLLMBcTiujsMiBIKoaSvp037BK7SxMYDRIb8qTjN
 C2gZ0gpGLJYfgqKQkdcKO7Sc+9qBTnhOBICOgqTMiftWzd0gbGQr2KgrGSoQEIdxeOjNK1kJ
 0QD5SWa+eAaGSS7/yKgzVQeuxIqLLnkJxAx92utEuFJjsaDJ2IgT0JczpzXncGIDWu6KBJZa
 Z0/PA31AaISDAsd8y+QkMOWfPOzue75K7OUFo9HhYi5U20gSm17aOSKWnr4isj
X-Talos-CUID: =?us-ascii?q?9a23=3AXGxDQWtsfxDN/lcU0gwmvyAr6IsAKVeNw13iM3a?=
 =?us-ascii?q?YBENID5O3W23LwLtdxp8=3D?=
X-Talos-MUID: 9a23:kmeWAgXbxMf3HfLq/HjSoztiGM1v2oqBBHsUq5tXt86JJSMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,212,1712613600"; 
   d="scan'208";a="168827703"
X-MGA-submission: =?us-ascii?q?MDFrssCYJkFwwFqX5Po/4eOXNIliuiw+1zm4R2?=
 =?us-ascii?q?X63H51zyQipvIpAV1++OUFXmQIdYdymvfOBkUQOvdzbQapR960adMEAD?=
 =?us-ascii?q?ibPtgvdSAsZvK5ImQ4itjMBd9UcEapPAoNvOVHQZRcGiYVlAR18pRms/?=
 =?us-ascii?q?DBkqzpslGtaSU8R97OdwbD8Q=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.223.130])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 21:29:58 +0200
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id C971E219D5;
	Mon,  3 Jun 2024 19:29:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717442998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nbsQrh+DSBljWYQA/9pDPkgkAK2YnszO65H1IZOBFLM=;
	b=LSIiXLjBegb5XUf+ugtNjAz3/RJbVQBhWRYfkvwQrc8UZxVYQuJE6qLz7YRgJcvFUktOG0
	asniVcVaUJJxvXTl2upkuRCVZQ6K1qvZezijg7ggARChwOa0BTKjuEsltI644cKZaIOIss
	j/TrX5YDT29Vjv0twa680p1rHRvdwwo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717442998;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nbsQrh+DSBljWYQA/9pDPkgkAK2YnszO65H1IZOBFLM=;
	b=CwW2G3MQ5mEY6ZyHvfeDduDBoFotqDPkpWsqqynPhcwb70Lf60p+fVCxJ5vPMN+Pl/vXI9
	dei+1N5CONYEgGAg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1717442997; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nbsQrh+DSBljWYQA/9pDPkgkAK2YnszO65H1IZOBFLM=;
	b=S4CMpX2YbVPGpWE6QzcC3XFe5PPNRW4IaPt/qd5ML1HZ46Xp4dH7zhyfFbwdwhHtZL4fdj
	tQKE0c9NAUT6qsT9nW8X5qGtKIFnOKkJBcomV5kroyU6hIL/ggCwRpr6tBgPa1dgbvA1Cs
	a17fRVBCFxg4dMbLS1LaBM/cPnRyBbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1717442997;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=nbsQrh+DSBljWYQA/9pDPkgkAK2YnszO65H1IZOBFLM=;
	b=s5BvYGK+aOJHgGjmcQDmuz8/svosd/YpEOg/bHeGCE7P37ueEHSA+GgaIehh863r/EnYRB
	IiCqQECf572GUPAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B282A13A93;
	Mon,  3 Jun 2024 19:29:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id Uk23KrUZXmbfQgAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 03 Jun 2024 19:29:57 +0000
Message-ID: <45d8e64e-aecc-4f5e-9c1c-6da0ddcd5d7c@suse.cz>
Date: Mon, 3 Jun 2024 21:29:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>,
 "Paul E. McKenney" <paulmck@kernel.org>
Cc: Uladzislau Rezki <urezki@gmail.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>,
 cocci@inria.fr
References: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
 <6b7e3ed9-d974-cb3b-6839-a6b7cf5f5a36@inria.fr>
 <a1f15e67-25f5-4a0b-a9d0-ebbc0555fb12@paulmck-laptop>
 <alpine.DEB.2.22.394.2405272226510.3330@hadrien> <ZlXIDZLMNPc7E7XE@pc636>
 <2dd5bafb-ceb1-238d-2f51-83ebf135b73@inria.fr> <ZlXaPuA4lC2ANTdN@pc636>
 <2ec7eb0f-0950-4d65-b33a-64df7c5f89c9@paulmck-laptop>
 <77531e55-3418-d4be-f538-7ddc904ed88f@inria.fr>
From: Vlastimil Babka <vbabka@suse.cz>
Autocrypt: addr=vbabka@suse.cz; keydata=
 xsFNBFZdmxYBEADsw/SiUSjB0dM+vSh95UkgcHjzEVBlby/Fg+g42O7LAEkCYXi/vvq31JTB
 KxRWDHX0R2tgpFDXHnzZcQywawu8eSq0LxzxFNYMvtB7sV1pxYwej2qx9B75qW2plBs+7+YB
 87tMFA+u+L4Z5xAzIimfLD5EKC56kJ1CsXlM8S/LHcmdD9Ctkn3trYDNnat0eoAcfPIP2OZ+
 9oe9IF/R28zmh0ifLXyJQQz5ofdj4bPf8ecEW0rhcqHfTD8k4yK0xxt3xW+6Exqp9n9bydiy
 tcSAw/TahjW6yrA+6JhSBv1v2tIm+itQc073zjSX8OFL51qQVzRFr7H2UQG33lw2QrvHRXqD
 Ot7ViKam7v0Ho9wEWiQOOZlHItOOXFphWb2yq3nzrKe45oWoSgkxKb97MVsQ+q2SYjJRBBH4
 8qKhphADYxkIP6yut/eaj9ImvRUZZRi0DTc8xfnvHGTjKbJzC2xpFcY0DQbZzuwsIZ8OPJCc
 LM4S7mT25NE5kUTG/TKQCk922vRdGVMoLA7dIQrgXnRXtyT61sg8PG4wcfOnuWf8577aXP1x
 6mzw3/jh3F+oSBHb/GcLC7mvWreJifUL2gEdssGfXhGWBo6zLS3qhgtwjay0Jl+kza1lo+Cv
 BB2T79D4WGdDuVa4eOrQ02TxqGN7G0Biz5ZLRSFzQSQwLn8fbwARAQABzSBWbGFzdGltaWwg
 QmFia2EgPHZiYWJrYUBzdXNlLmN6PsLBlAQTAQoAPgIbAwULCQgHAwUVCgkICwUWAgMBAAIe
 AQIXgBYhBKlA1DSZLC6OmRA9UCJPp+fMgqZkBQJkBREIBQkRadznAAoJECJPp+fMgqZkNxIQ
 ALZRqwdUGzqL2aeSavbum/VF/+td+nZfuH0xeWiO2w8mG0+nPd5j9ujYeHcUP1edE7uQrjOC
 Gs9sm8+W1xYnbClMJTsXiAV88D2btFUdU1mCXURAL9wWZ8Jsmz5ZH2V6AUszvNezsS/VIT87
 AmTtj31TLDGwdxaZTSYLwAOOOtyqafOEq+gJB30RxTRE3h3G1zpO7OM9K6ysLdAlwAGYWgJJ
 V4JqGsQ/lyEtxxFpUCjb5Pztp7cQxhlkil0oBYHkudiG8j1U3DG8iC6rnB4yJaLphKx57NuQ
 PIY0Bccg+r9gIQ4XeSK2PQhdXdy3UWBr913ZQ9AI2usid3s5vabo4iBvpJNFLgUmxFnr73SJ
 KsRh/2OBsg1XXF/wRQGBO9vRuJUAbnaIVcmGOUogdBVS9Sun/Sy4GNA++KtFZK95U7J417/J
 Hub2xV6Ehc7UGW6fIvIQmzJ3zaTEfuriU1P8ayfddrAgZb25JnOW7L1zdYL8rXiezOyYZ8Fm
 ZyXjzWdO0RpxcUEp6GsJr11Bc4F3aae9OZtwtLL/jxc7y6pUugB00PodgnQ6CMcfR/HjXlae
 h2VS3zl9+tQWHu6s1R58t5BuMS2FNA58wU/IazImc/ZQA+slDBfhRDGYlExjg19UXWe/gMcl
 De3P1kxYPgZdGE2eZpRLIbt+rYnqQKy8UxlszsBNBFsZNTUBCACfQfpSsWJZyi+SHoRdVyX5
 J6rI7okc4+b571a7RXD5UhS9dlVRVVAtrU9ANSLqPTQKGVxHrqD39XSw8hxK61pw8p90pg4G
 /N3iuWEvyt+t0SxDDkClnGsDyRhlUyEWYFEoBrrCizbmahOUwqkJbNMfzj5Y7n7OIJOxNRkB
 IBOjPdF26dMP69BwePQao1M8Acrrex9sAHYjQGyVmReRjVEtv9iG4DoTsnIR3amKVk6si4Ea
 X/mrapJqSCcBUVYUFH8M7bsm4CSxier5ofy8jTEa/CfvkqpKThTMCQPNZKY7hke5qEq1CBk2
 wxhX48ZrJEFf1v3NuV3OimgsF2odzieNABEBAAHCwXwEGAEKACYCGwwWIQSpQNQ0mSwujpkQ
 PVAiT6fnzIKmZAUCZAUSmwUJDK5EZgAKCRAiT6fnzIKmZOJGEACOKABgo9wJXsbWhGWYO7mD
 8R8mUyJHqbvaz+yTLnvRwfe/VwafFfDMx5GYVYzMY9TWpA8psFTKTUIIQmx2scYsRBUwm5VI
 EurRWKqENcDRjyo+ol59j0FViYysjQQeobXBDDE31t5SBg++veI6tXfpco/UiKEsDswL1WAr
 tEAZaruo7254TyH+gydURl2wJuzo/aZ7Y7PpqaODbYv727Dvm5eX64HCyyAH0s6sOCyGF5/p
 eIhrOn24oBf67KtdAN3H9JoFNUVTYJc1VJU3R1JtVdgwEdr+NEciEfYl0O19VpLE/PZxP4wX
 PWnhf5WjdoNI1Xec+RcJ5p/pSel0jnvBX8L2cmniYnmI883NhtGZsEWj++wyKiS4NranDFlA
 HdDM3b4lUth1pTtABKQ1YuTvehj7EfoWD3bv9kuGZGPrAeFNiHPdOT7DaXKeHpW9homgtBxj
 8aX/UkSvEGJKUEbFL9cVa5tzyialGkSiZJNkWgeHe+jEcfRT6pJZOJidSCdzvJpbdJmm+eED
 w9XOLH1IIWh7RURU7G1iOfEfmImFeC3cbbS73LQEFGe1urxvIH5K/7vX+FkNcr9ujwWuPE9b
 1C2o4i/yZPLXIVy387EjA6GZMqvQUFuSTs/GeBcv0NjIQi8867H3uLjz+mQy63fAitsDwLmR
 EP+ylKVEKb0Q2A==
In-Reply-To: <77531e55-3418-d4be-f538-7ddc904ed88f@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.29 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,kvack.org,vger.kernel.org,inria.fr];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
Subject: Re: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 1774
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/45d8e64e-aecc-4f5e-9c1c-6da0ddcd5d7c%40suse.cz>

On 5/31/24 6:02 PM, Julia Lawall wrote:
> Here are the changes proposed by Coccinelle.
> 
> I didn't succeed to compile the powerpc code, but the rest has been
> compile tested.
> 
> julia
> 
> commit 1881f31fe3ad693d07ecff45985dd0e87534923f
> Author: Julia Lawall <Julia.Lawall@inria.fr>
> Date:   Wed May 29 18:54:41 2024 +0200
> 
>     misc

Looks great, thanks!

Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Now comes the hard part, how to submit this. One patch (to rcu or linux-mm?)
with many Cc's, or multiple per-subsystem patches. There's always someone
who wants the other way that was chosen...

> diff --git a/arch/powerpc/kvm/book3s_mmu_hpte.c b/arch/powerpc/kvm/book3s_mmu_hpte.c
> index ce79ac33e8d3..d904e13e069b 100644
> --- a/arch/powerpc/kvm/book3s_mmu_hpte.c
> +++ b/arch/powerpc/kvm/book3s_mmu_hpte.c
> @@ -92,12 +92,6 @@ void kvmppc_mmu_hpte_cache_map(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
>  	spin_unlock(&vcpu3s->mmu_lock);
>  }
> 
> -static void free_pte_rcu(struct rcu_head *head)
> -{
> -	struct hpte_cache *pte = container_of(head, struct hpte_cache, rcu_head);
> -	kmem_cache_free(hpte_cache, pte);
> -}
> -
>  static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
>  {
>  	struct kvmppc_vcpu_book3s *vcpu3s = to_book3s(vcpu);
> @@ -126,7 +120,7 @@ static void invalidate_pte(struct kvm_vcpu *vcpu, struct hpte_cache *pte)
> 
>  	spin_unlock(&vcpu3s->mmu_lock);
> 
> -	call_rcu(&pte->rcu_head, free_pte_rcu);
> +	kfree_rcu(pte, rcu_head);
>  }
> 
>  static void kvmppc_mmu_pte_flush_all(struct kvm_vcpu *vcpu)
> diff --git a/block/blk-ioc.c b/block/blk-ioc.c
> index 25dd4db11121..ce82770c72ab 100644
> --- a/block/blk-ioc.c
> +++ b/block/blk-ioc.c
> @@ -32,13 +32,6 @@ static void get_io_context(struct io_context *ioc)
>  	atomic_long_inc(&ioc->refcount);
>  }
> 
> -static void icq_free_icq_rcu(struct rcu_head *head)
> -{
> -	struct io_cq *icq = container_of(head, struct io_cq, __rcu_head);
> -
> -	kmem_cache_free(icq->__rcu_icq_cache, icq);
> -}
> -
>  /*
>   * Exit an icq. Called with ioc locked for blk-mq, and with both ioc
>   * and queue locked for legacy.
> @@ -102,7 +95,7 @@ static void ioc_destroy_icq(struct io_cq *icq)
>  	 */
>  	icq->__rcu_icq_cache = et->icq_cache;
>  	icq->flags |= ICQ_DESTROYED;
> -	call_rcu(&icq->__rcu_head, icq_free_icq_rcu);
> +	kfree_rcu(icq, __rcu_head);
>  }
> 
>  /*
> diff --git a/drivers/net/wireguard/allowedips.c b/drivers/net/wireguard/allowedips.c
> index 0ba714ca5185..e4e1638fce1b 100644
> --- a/drivers/net/wireguard/allowedips.c
> +++ b/drivers/net/wireguard/allowedips.c
> @@ -48,11 +48,6 @@ static void push_rcu(struct allowedips_node **stack,
>  	}
>  }
> 
> -static void node_free_rcu(struct rcu_head *rcu)
> -{
> -	kmem_cache_free(node_cache, container_of(rcu, struct allowedips_node, rcu));
> -}
> -
>  static void root_free_rcu(struct rcu_head *rcu)
>  {
>  	struct allowedips_node *node, *stack[MAX_ALLOWEDIPS_DEPTH] = {
> @@ -330,13 +325,13 @@ void wg_allowedips_remove_by_peer(struct allowedips *table,
>  			child = rcu_dereference_protected(
>  					parent->bit[!(node->parent_bit_packed & 1)],
>  					lockdep_is_held(lock));
> -		call_rcu(&node->rcu, node_free_rcu);
> +		kfree_rcu(node, rcu);
>  		if (!free_parent)
>  			continue;
>  		if (child)
>  			child->parent_bit_packed = parent->parent_bit_packed;
>  		*(struct allowedips_node **)(parent->parent_bit_packed & ~3UL) = child;
> -		call_rcu(&parent->rcu, node_free_rcu);
> +		kfree_rcu(parent, rcu);
>  	}
>  }
> 
> diff --git a/fs/ecryptfs/dentry.c b/fs/ecryptfs/dentry.c
> index acaa0825e9bb..49d626ff33a9 100644
> --- a/fs/ecryptfs/dentry.c
> +++ b/fs/ecryptfs/dentry.c
> @@ -51,12 +51,6 @@ static int ecryptfs_d_revalidate(struct dentry *dentry, unsigned int flags)
> 
>  struct kmem_cache *ecryptfs_dentry_info_cache;
> 
> -static void ecryptfs_dentry_free_rcu(struct rcu_head *head)
> -{
> -	kmem_cache_free(ecryptfs_dentry_info_cache,
> -		container_of(head, struct ecryptfs_dentry_info, rcu));
> -}
> -
>  /**
>   * ecryptfs_d_release
>   * @dentry: The ecryptfs dentry
> @@ -68,7 +62,7 @@ static void ecryptfs_d_release(struct dentry *dentry)
>  	struct ecryptfs_dentry_info *p = dentry->d_fsdata;
>  	if (p) {
>  		path_put(&p->lower_path);
> -		call_rcu(&p->rcu, ecryptfs_dentry_free_rcu);
> +		kfree_rcu(p, rcu);
>  	}
>  }
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index a20c2c9d7d45..eba5083504c7 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -571,13 +571,6 @@ opaque_hashval(const void *ptr, int nbytes)
>  	return x;
>  }
> 
> -static void nfsd4_free_file_rcu(struct rcu_head *rcu)
> -{
> -	struct nfs4_file *fp = container_of(rcu, struct nfs4_file, fi_rcu);
> -
> -	kmem_cache_free(file_slab, fp);
> -}
> -
>  void
>  put_nfs4_file(struct nfs4_file *fi)
>  {
> @@ -585,7 +578,7 @@ put_nfs4_file(struct nfs4_file *fi)
>  		nfsd4_file_hash_remove(fi);
>  		WARN_ON_ONCE(!list_empty(&fi->fi_clnt_odstate));
>  		WARN_ON_ONCE(!list_empty(&fi->fi_delegations));
> -		call_rcu(&fi->fi_rcu, nfsd4_free_file_rcu);
> +		kfree_rcu(fi, fi_rcu);
>  	}
>  }
> 
> diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
> index 7c29f4afc23d..338c52168e61 100644
> --- a/fs/tracefs/inode.c
> +++ b/fs/tracefs/inode.c
> @@ -53,14 +53,6 @@ static struct inode *tracefs_alloc_inode(struct super_block *sb)
>  	return &ti->vfs_inode;
>  }
> 
> -static void tracefs_free_inode_rcu(struct rcu_head *rcu)
> -{
> -	struct tracefs_inode *ti;
> -
> -	ti = container_of(rcu, struct tracefs_inode, rcu);
> -	kmem_cache_free(tracefs_inode_cachep, ti);
> -}
> -
>  static void tracefs_free_inode(struct inode *inode)
>  {
>  	struct tracefs_inode *ti = get_tracefs(inode);
> @@ -70,7 +62,7 @@ static void tracefs_free_inode(struct inode *inode)
>  	list_del_rcu(&ti->list);
>  	spin_unlock_irqrestore(&tracefs_inode_lock, flags);
> 
> -	call_rcu(&ti->rcu, tracefs_free_inode_rcu);
> +	kfree_rcu(ti, rcu);
>  }
> 
>  static ssize_t default_read_file(struct file *file, char __user *buf,
> diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
> index b924f0f096fa..bad5db979664 100644
> --- a/kernel/time/posix-timers.c
> +++ b/kernel/time/posix-timers.c
> @@ -412,18 +412,11 @@ static struct k_itimer * alloc_posix_timer(void)
>  	return tmr;
>  }
> 
> -static void k_itimer_rcu_free(struct rcu_head *head)
> -{
> -	struct k_itimer *tmr = container_of(head, struct k_itimer, rcu);
> -
> -	kmem_cache_free(posix_timers_cache, tmr);
> -}
> -
>  static void posix_timer_free(struct k_itimer *tmr)
>  {
>  	put_pid(tmr->it_pid);
>  	sigqueue_free(tmr->sigq);
> -	call_rcu(&tmr->rcu, k_itimer_rcu_free);
> +	kfree_rcu(tmr, rcu);
>  }
> 
>  static void posix_timer_unhash_and_free(struct k_itimer *tmr)
> diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> index 003474c9a77d..367fc459cbd2 100644
> --- a/kernel/workqueue.c
> +++ b/kernel/workqueue.c
> @@ -5022,12 +5022,6 @@ static struct worker_pool *get_unbound_pool(const struct workqueue_attrs *attrs)
>  	return NULL;
>  }
> 
> -static void rcu_free_pwq(struct rcu_head *rcu)
> -{
> -	kmem_cache_free(pwq_cache,
> -			container_of(rcu, struct pool_workqueue, rcu));
> -}
> -
>  /*
>   * Scheduled on pwq_release_worker by put_pwq() when an unbound pwq hits zero
>   * refcnt and needs to be destroyed.
> @@ -5073,7 +5067,7 @@ static void pwq_release_workfn(struct kthread_work *work)
>  		raw_spin_unlock_irq(&nna->lock);
>  	}
> 
> -	call_rcu(&pwq->rcu, rcu_free_pwq);
> +	kfree_rcu(pwq, rcu);
> 
>  	/*
>  	 * If we're the last pwq going away, @wq is already dead and no one
> diff --git a/net/bridge/br_fdb.c b/net/bridge/br_fdb.c
> index c77591e63841..6d04b48f7e2c 100644
> --- a/net/bridge/br_fdb.c
> +++ b/net/bridge/br_fdb.c
> @@ -73,13 +73,6 @@ static inline int has_expired(const struct net_bridge *br,
>  	       time_before_eq(fdb->updated + hold_time(br), jiffies);
>  }
> 
> -static void fdb_rcu_free(struct rcu_head *head)
> -{
> -	struct net_bridge_fdb_entry *ent
> -		= container_of(head, struct net_bridge_fdb_entry, rcu);
> -	kmem_cache_free(br_fdb_cache, ent);
> -}
> -
>  static int fdb_to_nud(const struct net_bridge *br,
>  		      const struct net_bridge_fdb_entry *fdb)
>  {
> @@ -329,7 +322,7 @@ static void fdb_delete(struct net_bridge *br, struct net_bridge_fdb_entry *f,
>  	if (test_and_clear_bit(BR_FDB_DYNAMIC_LEARNED, &f->flags))
>  		atomic_dec(&br->fdb_n_learned);
>  	fdb_notify(br, f, RTM_DELNEIGH, swdev_notify);
> -	call_rcu(&f->rcu, fdb_rcu_free);
> +	kfree_rcu(f, rcu);
>  }
> 
>  /* Delete a local entry if no other port had the same address.
> diff --git a/net/can/gw.c b/net/can/gw.c
> index 37528826935e..ffb9870e2d01 100644
> --- a/net/can/gw.c
> +++ b/net/can/gw.c
> @@ -577,13 +577,6 @@ static inline void cgw_unregister_filter(struct net *net, struct cgw_job *gwj)
>  			  gwj->ccgw.filter.can_mask, can_can_gw_rcv, gwj);
>  }
> 
> -static void cgw_job_free_rcu(struct rcu_head *rcu_head)
> -{
> -	struct cgw_job *gwj = container_of(rcu_head, struct cgw_job, rcu);
> -
> -	kmem_cache_free(cgw_cache, gwj);
> -}
> -
>  static int cgw_notifier(struct notifier_block *nb,
>  			unsigned long msg, void *ptr)
>  {
> @@ -603,7 +596,7 @@ static int cgw_notifier(struct notifier_block *nb,
>  			if (gwj->src.dev == dev || gwj->dst.dev == dev) {
>  				hlist_del(&gwj->list);
>  				cgw_unregister_filter(net, gwj);
> -				call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +				kfree_rcu(gwj, rcu);
>  			}
>  		}
>  	}
> @@ -1168,7 +1161,7 @@ static void cgw_remove_all_jobs(struct net *net)
>  	hlist_for_each_entry_safe(gwj, nx, &net->can.cgw_list, list) {
>  		hlist_del(&gwj->list);
>  		cgw_unregister_filter(net, gwj);
> -		call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +		kfree_rcu(gwj, rcu);
>  	}
>  }
> 
> @@ -1236,7 +1229,7 @@ static int cgw_remove_job(struct sk_buff *skb, struct nlmsghdr *nlh,
> 
>  		hlist_del(&gwj->list);
>  		cgw_unregister_filter(net, gwj);
> -		call_rcu(&gwj->rcu, cgw_job_free_rcu);
> +		kfree_rcu(gwj, rcu);
>  		err = 0;
>  		break;
>  	}
> diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
> index f474106464d2..3ed92e583417 100644
> --- a/net/ipv4/fib_trie.c
> +++ b/net/ipv4/fib_trie.c
> @@ -292,15 +292,9 @@ static const int inflate_threshold = 50;
>  static const int halve_threshold_root = 15;
>  static const int inflate_threshold_root = 30;
> 
> -static void __alias_free_mem(struct rcu_head *head)
> -{
> -	struct fib_alias *fa = container_of(head, struct fib_alias, rcu);
> -	kmem_cache_free(fn_alias_kmem, fa);
> -}
> -
>  static inline void alias_free_mem_rcu(struct fib_alias *fa)
>  {
> -	call_rcu(&fa->rcu, __alias_free_mem);
> +	kfree_rcu(fa, rcu);
>  }
> 
>  #define TNODE_VMALLOC_MAX \
> diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
> index 5bd759963451..5ab56f4cb529 100644
> --- a/net/ipv4/inetpeer.c
> +++ b/net/ipv4/inetpeer.c
> @@ -128,11 +128,6 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
>  	return NULL;
>  }
> 
> -static void inetpeer_free_rcu(struct rcu_head *head)
> -{
> -	kmem_cache_free(peer_cachep, container_of(head, struct inet_peer, rcu));
> -}
> -
>  /* perform garbage collect on all items stacked during a lookup */
>  static void inet_peer_gc(struct inet_peer_base *base,
>  			 struct inet_peer *gc_stack[],
> @@ -168,7 +163,7 @@ static void inet_peer_gc(struct inet_peer_base *base,
>  		if (p) {
>  			rb_erase(&p->rb_node, &base->rb_root);
>  			base->total--;
> -			call_rcu(&p->rcu, inetpeer_free_rcu);
> +			kfree_rcu(p, rcu);
>  		}
>  	}
>  }
> @@ -242,7 +237,7 @@ void inet_putpeer(struct inet_peer *p)
>  	WRITE_ONCE(p->dtime, (__u32)jiffies);
> 
>  	if (refcount_dec_and_test(&p->refcnt))
> -		call_rcu(&p->rcu, inetpeer_free_rcu);
> +		kfree_rcu(p, rcu);
>  }
>  EXPORT_SYMBOL_GPL(inet_putpeer);
> 
> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> index 31d77885bcae..bafc49de270e 100644
> --- a/net/ipv6/ip6_fib.c
> +++ b/net/ipv6/ip6_fib.c
> @@ -198,16 +198,9 @@ static void node_free_immediate(struct net *net, struct fib6_node *fn)
>  	net->ipv6.rt6_stats->fib_nodes--;
>  }
> 
> -static void node_free_rcu(struct rcu_head *head)
> -{
> -	struct fib6_node *fn = container_of(head, struct fib6_node, rcu);
> -
> -	kmem_cache_free(fib6_node_kmem, fn);
> -}
> -
>  static void node_free(struct net *net, struct fib6_node *fn)
>  {
> -	call_rcu(&fn->rcu, node_free_rcu);
> +	kfree_rcu(fn, rcu);
>  	net->ipv6.rt6_stats->fib_nodes--;
>  }
> 
> diff --git a/net/ipv6/xfrm6_tunnel.c b/net/ipv6/xfrm6_tunnel.c
> index bf140ef781c1..c3c893ddb6ee 100644
> --- a/net/ipv6/xfrm6_tunnel.c
> +++ b/net/ipv6/xfrm6_tunnel.c
> @@ -178,12 +178,6 @@ __be32 xfrm6_tunnel_alloc_spi(struct net *net, xfrm_address_t *saddr)
>  }
>  EXPORT_SYMBOL(xfrm6_tunnel_alloc_spi);
> 
> -static void x6spi_destroy_rcu(struct rcu_head *head)
> -{
> -	kmem_cache_free(xfrm6_tunnel_spi_kmem,
> -			container_of(head, struct xfrm6_tunnel_spi, rcu_head));
> -}
> -
>  static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
>  {
>  	struct xfrm6_tunnel_net *xfrm6_tn = xfrm6_tunnel_pernet(net);
> @@ -200,7 +194,7 @@ static void xfrm6_tunnel_free_spi(struct net *net, xfrm_address_t *saddr)
>  			if (refcount_dec_and_test(&x6spi->refcnt)) {
>  				hlist_del_rcu(&x6spi->list_byaddr);
>  				hlist_del_rcu(&x6spi->list_byspi);
> -				call_rcu(&x6spi->rcu_head, x6spi_destroy_rcu);
> +				kfree_rcu(x6spi, rcu_head);
>  				break;
>  			}
>  		}
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 2f191e50d4fc..fbb730cd2d38 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -1580,14 +1580,6 @@ static int kcm_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  	return err;
>  }
> 
> -static void free_mux(struct rcu_head *rcu)
> -{
> -	struct kcm_mux *mux = container_of(rcu,
> -	    struct kcm_mux, rcu);
> -
> -	kmem_cache_free(kcm_muxp, mux);
> -}
> -
>  static void release_mux(struct kcm_mux *mux)
>  {
>  	struct kcm_net *knet = mux->knet;
> @@ -1615,7 +1607,7 @@ static void release_mux(struct kcm_mux *mux)
>  	knet->count--;
>  	mutex_unlock(&knet->mutex);
> 
> -	call_rcu(&mux->rcu, free_mux);
> +	kfree_rcu(mux, rcu);
>  }
> 
>  static void kcm_done(struct kcm_sock *kcm)
> diff --git a/net/netfilter/nf_conncount.c b/net/netfilter/nf_conncount.c
> index 8715617b02fe..587bfcb79723 100644
> --- a/net/netfilter/nf_conncount.c
> +++ b/net/netfilter/nf_conncount.c
> @@ -275,14 +275,6 @@ bool nf_conncount_gc_list(struct net *net,
>  }
>  EXPORT_SYMBOL_GPL(nf_conncount_gc_list);
> 
> -static void __tree_nodes_free(struct rcu_head *h)
> -{
> -	struct nf_conncount_rb *rbconn;
> -
> -	rbconn = container_of(h, struct nf_conncount_rb, rcu_head);
> -	kmem_cache_free(conncount_rb_cachep, rbconn);
> -}
> -
>  /* caller must hold tree nf_conncount_locks[] lock */
>  static void tree_nodes_free(struct rb_root *root,
>  			    struct nf_conncount_rb *gc_nodes[],
> @@ -295,7 +287,7 @@ static void tree_nodes_free(struct rb_root *root,
>  		spin_lock(&rbconn->list.list_lock);
>  		if (!rbconn->list.count) {
>  			rb_erase(&rbconn->node, root);
> -			call_rcu(&rbconn->rcu_head, __tree_nodes_free);
> +			kfree_rcu(rbconn, rcu_head);
>  		}
>  		spin_unlock(&rbconn->list.list_lock);
>  	}
> diff --git a/net/netfilter/nf_conntrack_expect.c b/net/netfilter/nf_conntrack_expect.c
> index 21fa550966f0..9dcaef6f3663 100644
> --- a/net/netfilter/nf_conntrack_expect.c
> +++ b/net/netfilter/nf_conntrack_expect.c
> @@ -367,18 +367,10 @@ void nf_ct_expect_init(struct nf_conntrack_expect *exp, unsigned int class,
>  }
>  EXPORT_SYMBOL_GPL(nf_ct_expect_init);
> 
> -static void nf_ct_expect_free_rcu(struct rcu_head *head)
> -{
> -	struct nf_conntrack_expect *exp;
> -
> -	exp = container_of(head, struct nf_conntrack_expect, rcu);
> -	kmem_cache_free(nf_ct_expect_cachep, exp);
> -}
> -
>  void nf_ct_expect_put(struct nf_conntrack_expect *exp)
>  {
>  	if (refcount_dec_and_test(&exp->use))
> -		call_rcu(&exp->rcu, nf_ct_expect_free_rcu);
> +		kfree_rcu(exp, rcu);
>  }
>  EXPORT_SYMBOL_GPL(nf_ct_expect_put);
> 
> diff --git a/net/netfilter/xt_hashlimit.c b/net/netfilter/xt_hashlimit.c
> index 0859b8f76764..c2b9b954eb53 100644
> --- a/net/netfilter/xt_hashlimit.c
> +++ b/net/netfilter/xt_hashlimit.c
> @@ -256,18 +256,11 @@ dsthash_alloc_init(struct xt_hashlimit_htable *ht,
>  	return ent;
>  }
> 
> -static void dsthash_free_rcu(struct rcu_head *head)
> -{
> -	struct dsthash_ent *ent = container_of(head, struct dsthash_ent, rcu);
> -
> -	kmem_cache_free(hashlimit_cachep, ent);
> -}
> -
>  static inline void
>  dsthash_free(struct xt_hashlimit_htable *ht, struct dsthash_ent *ent)
>  {
>  	hlist_del_rcu(&ent->node);
> -	call_rcu(&ent->rcu, dsthash_free_rcu);
> +	kfree_rcu(ent, rcu);
>  	ht->count--;
>  }
>  static void htable_gc(struct work_struct *work);

