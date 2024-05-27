Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB0E7C25B74
	for <cocci@archiver.kernel.org>; Mon, 27 May 2024 07:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=FmeR6v54R8nmwGNyu6NhpRBYor5rqZqSV2LEziNNmOU=;
  b=Zpla3YDevTMxVsi3bnnuL6xfqutUxu51YkWba2NP+eykTdoSce3qqPu1
   X7fW0SF9+/KK9HFwuMCvQLqhoRlkaQXqpFY8sZpFAX5+nvIm2mKu8Iy9N
   /2tnNb96XpYcXdSJIY+IwysoydikjWeBa884dMFgHub1/RpBPQAHcj/ta
   0=;
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
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="167537134"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 May 2024 09:46:12 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CACCDE0CCE; Mon, 27 May 2024 09:46:11 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 49CC3E00B7
	for <cocci@sympa.inria.fr>; Mon, 27 May 2024 09:46:07 +0200 (CEST)
IronPort-SDR: 66543a3e_XJ33+PN28kSl4NJPhYSJAIMoLON17oim/AneJ22ffbnvy7j
 Tf1JxSSYzaqdxNn+PBQbM5MUEkoNFm+w9JsBXDg==
X-IPAS-Result: =?us-ascii?q?A0HcAwByOFRmmILfh8NaHQEBPAEFBQECAQkBFYFRgXBSg?=
 =?us-ascii?q?VcyBAtIhFaIfIZMhmCXeoFqgWoPAQMBDRQTHQQBAQMBA4R/iE4CHgcBBDQTA?=
 =?us-ascii?q?QIEAQEBAQMCAwEBAQEBAQgBAQUBAQECAQECBAYBAhABAQEBAQEBAR4ZBRQKJ?=
 =?us-ascii?q?4V0DYJgO4IQLA2BJR0BATg0AiYCXgEUAQGCfIJlBAOvQIEygQGCDAEBBoJn2?=
 =?us-ascii?q?RcfgWMJgRouAYgtAYV8g0aBIRuBSUSBFScLgzaEKS+DRoJpmWmJYYlYgVEcA?=
 =?us-ascii?q?1khAQERAVUTFws+HQIWAxsUBDAPCQsmKgY2AhIMBgYGWTQJBCMDCAQDQgMgc?=
 =?us-ascii?q?REDBBoECwd1gyUEE0QDgTcGiW2DEwIFIQSCGoEignhLgQGBCQKCZ4FrDmGEV?=
 =?us-ascii?q?YNEgXOBRIFpeB1AAgELbT01BgMLGwY9qjkZgmKkFaFVhB2ES5xrBg8EL4Nyk?=
 =?us-ascii?q?0cOkm4umDUgqGqBfCMuFIEaMxoIMII8Zk8DGQ+OOoQJy0pCNDsCBwsBAQMJi?=
 =?us-ascii?q?SKBSAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:ugEnBah4I24UviPUbUxVyKkD4HBQXmMji2hC6mlwRA09TyX5ra
 yTtdwGyBn/kyYJRRgb6Ku90dq7MBThHPlOkPQs1NaZLXPbUQ6TRuwMg7cKrAeQeREWmtQts5
 uIEJIObeEYb2IK7voSiTPQe71AoOVvm5rY/ds2oU0dND2CJ5sQiztRO0KhCFR/QAQDLZAlFJ
 yaj/A32QaISDAtdN2yAnRAZ/TOu9GOtJ+OW292OzcXrDKVlDut5frBHwOG0gx2aUI+/V7Oyx
 m3r+Xi3NTej9iLjiXE32uW1Z5Rg9eJ8KowOOW8zvINIjHgzj2lfphlRtS5zU8InN0=
X-Talos-CUID: 9a23:KbRGJmGP8ex8WLA9qmJu+lEkPPsOTEHz5zTcJ329DHQ0TpOaHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ANsFniQ/IrZs1tFCVufL67iuQf/V1/JSSFBEGqok?=
 =?us-ascii?q?P6seJDHN2Hi63hh3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,192,1712613600"; 
   d="scan'208";a="88027571"
X-MGA-submission: =?us-ascii?q?MDFAY58WB4ADAOkod3mdCtkIPWCPbpA2Ptfv1f?=
 =?us-ascii?q?GMCWIvbGu8rXwluygwDZK5IUr4j0p8mOaYWr7vlZBdH2x7spJ5XRv/C/?=
 =?us-ascii?q?Rd5XkcaIq0R5ON5ZdvETnBZ2yg0G9uBGyq5Kw/KclXMEwa1dTgDQ7b2c?=
 =?us-ascii?q?PCE3gnKVRh/FZgPdmrbUL20g=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.223.130])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:46:06 +0200
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 23D3721D22;
	Mon, 27 May 2024 07:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716795964; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=FmeR6v54R8nmwGNyu6NhpRBYor5rqZqSV2LEziNNmOU=;
	b=1rKgljJrpBebOjfWqIVtRfUaGKjvlI8lfAq/qa+eF3e+GD8WHtSY5Hl1aI2eDB23rteTnl
	glTbVbXCTB6NI7lWT9qFq1HhfPeUY5NQnE2tZkKmFNkjjuc8SezSYn8dlWySRelp8Wzzy5
	Ly4y3+R8i+yU9jgpF9LCDP3xOkB5GDY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716795964;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=FmeR6v54R8nmwGNyu6NhpRBYor5rqZqSV2LEziNNmOU=;
	b=gde5e9EjKksO7AqFOlxLAWfYjL32YQyJXwwZgjYz37TyLMBFbjAiZCW2TEe7h0DuqriThn
	0RLqF0YhzGBMaHAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1716795963; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=FmeR6v54R8nmwGNyu6NhpRBYor5rqZqSV2LEziNNmOU=;
	b=XxIFFu7wK3dZuQTRI7kbclQ5XEomNCmJqYwvjbNapdLxE9bGYSSQ1sI1pNfrhVcTeEd4mC
	B/oGpbKzN4oEnAzNvPmmzk+z9OQt139abWvh3KvoVGrV2ZoQ/jbappvk3+mKk+5QlRU3Mj
	GHNl4ny6a9ochtgkHzgppO189f78O0c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1716795963;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:autocrypt:autocrypt;
	bh=FmeR6v54R8nmwGNyu6NhpRBYor5rqZqSV2LEziNNmOU=;
	b=hpOUd+ishBYTta/HcpXkvyRMbD1Atz9ix+Z0uu84wPP/fdyCFN7DEGx3/uPRyJ0cqomI0z
	9t1q9IrEnNtBJvDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 181C413A6B;
	Mon, 27 May 2024 07:46:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id uD9YBTs6VGbhWAAAD6G6ig
	(envelope-from <vbabka@suse.cz>); Mon, 27 May 2024 07:46:03 +0000
Message-ID: <68b85796-c674-4691-936a-2051849f4692@suse.cz>
Date: Mon, 27 May 2024 09:46:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Vlastimil Babka <vbabka@suse.cz>
To: "linux-mm@kvack.org" <linux-mm@kvack.org>, RCU <rcu@vger.kernel.org>,
 cocci@inria.fr
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-4.39 / 50.00];
	BAYES_HAM(-2.89)[99.54%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 23D3721D22
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Subject: [cocci] patch idea: convert trivial call_rcu users to kfree_rcu
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 1759
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-05/68b85796-c674-4691-936a-2051849f4692%40suse.cz>

Hi,

one bit from LSF/MM discussions is that there might be call_rcu users with a
callback that only does a kmem_cache_free() to a specific cache. Since SLOB
was removed, it's always ok to use kfree() and thus also kfree_rcu() on
allocations from kmem_cache_alloc() in addition to kmalloc(). Thus, such
call_rcu() users might be simplified to kfree_rcu(). I found some cases
semi-manually, but I'd expect coccinelle could help here so if anyone wants
to take this task, feel free to.

Vlastimil


