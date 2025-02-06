Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B60F6C02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 13:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=r/cgpyd1CCv7/zGLRq9m8T594JeDnLjdSbZiRCZCqGo=;
  b=Tuezv5Ir/WjPqS9DIsX4BhzIZ2jaOahpMnaGsSGIRFcwvs1F/q+ZrJel
   e/l+2EBHNr6tsBUm0uNcMBw6aRfyMoiQNOQdkZiV8KVw1F3AeR1yC0TA8
   EuAhlXz1zBkYyIoJQUMUlTYFQZQlP4RSizH7cRJi7nfZTdXLoJr+KrBaq
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206937970"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 14:47:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0B59BE0D1E; Thu,  6 Feb 2025 14:47:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 65187E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 14:47:00 +0100 (CET)
IronPort-SDR: 67a4bd53_G/uaJUjzt/1YRaTOCTZUYmD2j8/MX/yZBMiLPXdGXwWhi27
 LyA54zF+/U0JbpMjv1ww1/QJHhwxutj4O92+bAg==
X-IPAS-Result: =?us-ascii?q?A0HOAwBcvKRng07ASNlaHgEBCxIMQIQXgVczBAtIhFaPT?=
 =?us-ascii?q?4F0hGuHO4dTjEkPAQMBDUEBAgQBAQMEhQACiwECHgcBBDQTAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQE6Bw47hXsNgmIBgSSBJgEBAQEBA?=
 =?us-ascii?q?QEBAQEBAR0CR0QCAQMjBBkBAREmAQQLCxoCJgICVgYVAQGCfoIwAQMxB7A+f?=
 =?us-ascii?q?zOBAYIMAQEG2lwfLCJXgWUJgRouhWyCYwGFagGEdycPgVVEgTwLgng+gQUBh?=
 =?us-ascii?q?xiCaYIzhEhnonZSexwDWSwBVRMXCwcFgSlIA4ERI4EjBTUKNzqCDWlJOgINA?=
 =?us-ascii?q?jWCHnyCK2oEBYEtgjqEQ4RNhVuCEoFiAwMWEAGDIXocg10QHUACAQttPTcJC?=
 =?us-ascii?q?xsGPZ8BhBmDdqRfoTs0B4I4gWaBYwyfXAYTL4NwAZNSDgaSe5h8qS6BfiOBX?=
 =?us-ascii?q?DMaJIM2TwMZD44hFwKEFMdeQjU8AgcLAQEDCYVGAQGKaYFLAQE?=
IronPort-PHdr: A9a23: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
 G3No9Qor1z0yoGy
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:L3qhy62P6vGvmDVhqnCmPAqjBGYkLtp133Aq2lEZdPWaSL39qy
 ncpoV/6faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyTMbEQt6bHCWeDYrUd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: 9a23:gi4lpGxm8NIsEMMZhE/aBgVMGO4OT3D75k7qLlC1DTtSS7mNSQOfrfY=
X-Talos-MUID: =?us-ascii?q?9a23=3AoJOv+Q4QFGf1Kaecw6KhyZGQxoxM8b++FkUdm64?=
 =?us-ascii?q?AtoqGKzZcYhW5gzC4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="108390231"
X-MGA-submission: =?us-ascii?q?MDFUxq0YcN6MQyKPQ97hmHhSudypXygskhlz23?=
 =?us-ascii?q?HQvskcajELknsQaxXpmHOjxG9YcLsb2llO6A4bQTGf/LpBDWMC07bPvi?=
 =?us-ascii?q?FEmecM10eM76k8myinIPluZd1uoJgS/aNVbT8VV/jvT8g2Mnn9m8RGPP?=
 =?us-ascii?q?36jquttfPN3rfPLNDWqXI0gQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 14:47:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738849617; x=1739454417; i=markus.elfring@web.de;
	bh=r/cgpyd1CCv7/zGLRq9m8T594JeDnLjdSbZiRCZCqGo=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=MuiDYdygDKJmG+7JbpDeOZ/ccAah6KMT6kxaPw0ELDjClAmWAjLFkurKUzfpk9Uo
	 HKHFvfAdkhbnTM7gDXUF37Zd5d6ybJpwKQh3kLO9+NoEJHM2PCnKCdpmVJMF2nF+s
	 /UiqKlRK3cBjpSmmwZk80IeR/k6LsFmrwC0Vn95RuAYqN3kob12LG2UB3A54U2+9+
	 WqFkXBE0HnOWpXSEbAFAUcYY/na3jlf7h40+D3rY2w6VrknW82Jab2FouZQLVUjKN
	 NrpVaLMUKU5umaYKPoU8vtb6z+m8D/rp3aca/+ea5QKqH8ZiEr48e0LQmYO1VYv7y
	 t6Dy9KQc3KbL6qfTvA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.8]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MV2Oi-1toJfz3IoQ-00LWLJ; Thu, 06
 Feb 2025 14:46:57 +0100
Message-ID: <12cf24d4-2391-4c13-ae75-14dc6fe329ff@web.de>
Date: Thu, 6 Feb 2025 14:46:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Johannes Berg <johannes@sipsolutions.net>
References: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
 <9063a6e6c83f9169456bc009cc35426889cc46e1.camel@sipsolutions.net>
 <66addf31-2af9-457c-24e1-a97367d84d8f@inria.fr>
 <708c689f63c3df2bca99282996fc2812f8557f1a.camel@sipsolutions.net>
Content-Language: en-GB
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <708c689f63c3df2bca99282996fc2812f8557f1a.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:4HcOH6E5DummAf5BzmDOYzOhidKA9Gsc+6qowgTXtp+tXFcpnyy
 0JkDE+7axJGuXB+kArzBMWviD6TSIaffQH5chcZ/yXdIAog2gNBQqWKrWNOM3oT35VqwROd
 MFgrkKznM0DBx1FVd+WLzAKqSlQb9L5K/YVcMqLRDu/v0/WyGlu4LyzMPJjJc6x3SptPfpK
 clOh8GCs54+VWB4frM+UQ==
UI-OutboundReport: notjunk:1;M01:P0:w6e5gv6JaHM=;pCD+zJF/EABUlreMGDJ6GLc7OzN
 q/+o1Hass2yjwJ0MnlZEj6wqBFQB+SKqPoaHPZNJf7jdGsOcgA554GLWKF0XxwE5YwnETYB8P
 qlS3yQUKouFibhwZj4Vb0riJnAR5tYWyGekx8lUFWlrCO7U7cfqNYcfOASjYECntXxODDOts5
 OoH2LROz8UmBicJMdglxIYEewI0LJGtRfLGqunmKIIY95INluxFf/AOXqRH3c1axkHXSs1zKE
 egrgM9TnQvGWdLGWsnLejjj1UqNUyYkxo/Q+i/ngUBwLnZHmdNYppOzDw1cNMaT9TEjCeVqr8
 H9Rq13TvPySu/QbpfDnAi7C+pLd89htPnGwEPU5OEcfo99PKGz/h8J5uGwpvJ6/Fzk08bauoo
 LL130Ak2wLypEIHG9eUsI1wo6bDFDuM4fBL+LlrFqNFxlezwohXDu64rM9eoir0vP9QEL72kz
 kBFInmTQxbzJje+vxnqxOK43B1uzknu3CS0J2hXTGAGFzRAzqi/k3vZ5fjkQWvOlbJUtn3jGt
 cuCsZHlaI4rOapOLaZykS5zK+otdCvyJUsbcdxJ0Jvfg+Dy8Tka57knRofk4h4nVYi+rterXg
 wvl/yyse/2LpefgDGndapfCcWSSrJtstNPqrU8CYra98OpkbFIh2mrnKBT7yGTdqy6LIgIdrD
 uh5OI8akiyZkpVkDBjrx031JrZGaaFOhBAKh3X94E7bYhjyLCsjdCRH0Wxnwxakh47KNZCMcP
 VYc1KTxFxrX/txYmGhxSkjLQWeb5prxo7Z6BtYKFPMBNYRVsCywQ8ke5IQJDMbnYqJL848r7G
 pGioJAHmvVz2IUKGgePrSoyWDeuUT5FNdfNgPel6Kirdp/5/Oga7U6wdjSJMTN2+tZxeVCL8V
 IeNdN8bLMSQJjzQjDnmskVXvxbLVSFFimAFIb2K5+pB/vGlUCa044bDaYO+Hl+s4D3O2kIQhg
 B4oDgKpq/linUhR3bKumeidh5YuevhLFGjCGVt4Jh0JXCirv+3c+zZJ0tiBNAm6sWfqR/BBC6
 apWOk+jlwDu/N0hRwdCR4GRcLWqGgInd5G0zDFiPq1n5Jycb8+ZbW5P85QBZ9j7dreEaC/j1M
 7Bi/OIfxt231kwicKct2WCZQtTsjZV+Wh0/5bN2GpDewHsRuFCu1Iafro9IgilPdgsKEjbRq1
 P05HvL3JM1rhCxez8bkjQATmcRFpVEFwfDXKcz2h59QudUjd6aGhhj6Ta0hR8WYU0RlvVBio/
 myTVypWmA3CvQP4WIVW6FcbpIyE6qYq4gpYrJ3lx1aGTq+7eMZS31B5bvgAKxETc3AA05SgRk
 ic/a6C2BFh3BXG4wDfd7B9pW0x4iwdynezbgn5O4n3Fnm61739gA1o1G5cdWnCC8vyyttV9+E
 6+1RP+SH+ZRX4//HlNO0xXT0WTrsxr+/oRKx+1nmMG3UWxXPKeO5859NsX0f+BLKDhba4MlTz
 ki+TNxg==
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2363
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/12cf24d4-2391-4c13-ae75-14dc6fe329ff%40web.de>

> I don't even care about <+ or < because we check the resulting output anyway :)

I would appreciate further clarification for such information.

I tend to care more for the proper selection and support
of dot variants according to efficient applications of scripts
for the semantic patch language.

Regards,
Markus
