Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E534BC3ABA9
	for <cocci@archiver.kernel.org>; Wed, 30 Apr 2025 16:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q1eWSLN+dHfYLaj4ieWD04gph0EYCZBffTrOY2Od6UE=;
  b=cS9IQtdEbDSehIbrgpfMh7KQBhM/HxcW+fxw6Nxa4m+ygnEJISjhkf1e
   YMWBkwIVeObGRcbEsI/uT6msJMJz9mdb3oXBo/59ogUDpiUn/MGP5r2Dk
   hGvINdlh1Bp/u2YFj3XWwJHV8ATQtG6RGiOMHCLGXj99UXqhL7tysx06b
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@messagingengine.com
X-IronPort-AV: E=Sophos;i="6.15,252,1739833200"; 
   d="scan'208";a="220224680"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Apr 2025 18:14:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8A2E7E0261; Wed, 30 Apr 2025 18:14:35 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 96763E007A
	for <cocci@sympa.inria.fr>; Wed, 30 Apr 2025 18:14:31 +0200 (CEST)
IronPort-SDR: 68124c66_8zwqI5w2ShG5ckXmK6XxZI9eo/OmB+KpE/qjc+FEE/JXG3/
 KGRNhM3U6uO4FpRVjDq/PppzYv8sNYT5WK7ZrJw==
X-IPAS-Result: =?us-ascii?q?A0E2AQDLShJoj5J8DMpaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VOCRIFWNAcISIRViHuIeYQ7hzuHU4Rwh1kPAQMBDUQEAQEDBIUAAos1Ah8GA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAjoFSYV7D?=
 =?us-ascii?q?YJiAYEkgSYBAQEBAQEBAQEBAQEdAggkPwEBHgEBAQMjHQEBNwEPCxgCAiYCA?=
 =?us-ascii?q?lYGFQEBgn6CMAEDMQKzLYEygQGCDAEBBtpbAUsDdoFlCYEbLoVtgmMBhWyEd?=
 =?us-ascii?q?ycPgVVEgTyDAz6IHhmCUIIxRFJ6TIFCHWKFFwQRVmyHbos/UnscA1ksAVUTF?=
 =?us-ascii?q?wsHBYEmQwOBDyNLBS4dghGFIYIRgVwDAyIBgxN0HIRphFAtT4MvggJoRCdAA?=
 =?us-ascii?q?gELbT03CQsbBj2WQINkgQITAUuBJaVfjGCUXzQHhB6BXgYMn14GEy+EA5NBk?=
 =?us-ascii?q?xMumFCCWKZdgX4jgVxNg1pPAxkPjiEZg2eBMrokRDI8AgcLAQEDCZBEgUsBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 9VsD7UD6Jy5FX1s
IronPort-HdrOrdr: A9a23:nsZBFKkqmUWL0B/q57pH5PW9iofpDfLD3DAbv31ZSRFFG/FwWf
 re58jzpiWE9Ar5P0tQ6OxoWZPwP080kKQZjbX5Uo3SODUOx1HYT72KgbGSvgEIXheOidK1tp
 0QFJSWaueAaGSS5PySiGLTYrQdKZu8gdqVbIzlvg5QpG9RGtldBktCe2CmO3wzYCUDPIE+BY
 r03Kp6jgvlXVhSV9+8F2lAdeDevdGjrvPbSC9DIzJi0wWFgTO25LOSKXal9yZbdx8K+7sk/G
 Tf+jaX2pme
X-Talos-CUID: =?us-ascii?q?9a23=3ATZDAZ2ommO2S8QA4PU2IRCzmUew1SXz7znSPGAi?=
 =?us-ascii?q?bUmk4C7aNTXaS2qwxxg=3D=3D?=
X-Talos-MUID: 9a23:ZiobhQV9iS1MJM3q/CLFmxYzFeww2K+BF2NOv5EZgO+/bBUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.15,252,1739833200"; 
   d="scan'208";a="115594652"
X-MGA-submission: =?us-ascii?q?MDHKM3pJd8OQQ9l1Je1qRb1sP4rMmiVgyRKhQE?=
 =?us-ascii?q?fTv4I77/TOO0CiY5oC1YsB+5rN4+7FEyGTL/rWn3Z7UGOu4k4xIi+L4z?=
 =?us-ascii?q?uj5ncwo95/N/j84K+3cveGCYxrn0Jfd8kCEvTUB55yxaGQHMz9ZPoKgq?=
 =?us-ascii?q?rWtoEBKYB1bofGHnP81uSL1Q=3D=3D?=
Received: from fout-b3-smtp.messagingengine.com ([202.12.124.146])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 18:14:30 +0200
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id BDF211140159;
	Wed, 30 Apr 2025 12:14:28 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 30 Apr 2025 12:14:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.fm; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746029668;
	 x=1746116068; bh=q1eWSLN+dHfYLaj4ieWD04gph0EYCZBffTrOY2Od6UE=; b=
	l35Rkt6q+ZuwBa5VuqWho6xGyXUb6tcqaaLzPYnh0Aew9lmBevQaIThoiK09oTVK
	X7BcrWwiXDjazGrNcW0s6J/X39TQVdARRRwDAwKBi0lLSvf7jB//oIjiuoO5InKP
	ETmCRY/WlnR2kRkVlTwzej2QmxxBVaK1qPvII7wvNkKR5wRbfYMcbSOrqmg5kjUM
	+bbMdX5M3HosbwLNXDQdkiqfhnLkP8dP853S8IwRCTUR1sF4knMQf1vSAtt0vUTy
	s+InxFxBsGK14gLlncEMZgEfb4m8BGOW4SyekAWqQ20k/SlirM54xKzXQCLXaFAi
	d71aFfKzQZV/ODYyUt9+Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746029668; x=
	1746116068; bh=q1eWSLN+dHfYLaj4ieWD04gph0EYCZBffTrOY2Od6UE=; b=f
	/Di5VY2V9FtibjuhvUb6BeAm2KzbB6/UQEsw5+NBbSensDTFyXUJQGr6Fn06zSzX
	vU4EUpGgR56DRVvV7jNy7fVuVdAtB0soQpK3o4DlNSQie0sjmnaJI954qRqe/Fa2
	DzXqFHV+MUjR4efuxB8bQ8J9n3M06tGi8cHCFfDnZEkE0peTnWC4vfKhp9lvhUP3
	dIIErTK3vS4yXzLoPqtuYvM2euPXHKJ66C8RxMD6rK4Rt2trQs7hFte3xmTJLHit
	hM/T4o4ZrU3gh6x9KcW8PTrHwI5Jyr5oJXG2qEIG1xpTH/mjYFAAsequZuUJNhN5
	qM5tcNNENO0paKC8znkvA==
X-ME-Sender: <xms:ZEwSaFMayWPmM9Rh_YRwBwvbo-zqSAjZ13BBmm6Vp1ot0D2PzEHb5w>
    <xme:ZEwSaH_jwLD8ueza-2yCdFWvw1isAdeHhfbrXI9IkSATfpMD0d3EnxsKplQ5tk-cw
    wzdfZuNtiiVTgtq>
X-ME-Received: <xmr:ZEwSaERP-WCUbtLk1urdaoAiZLcSBcopJyNDpk3pU8EUgBcw4fshGf77DA6_hoqZF6ahpUT3L7TEhMEWNmFj63qvYk2NYoc8UtjgB0isCzzbwzhTjtYy>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieejudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddt
    vdejnecuhfhrohhmpeeuvghrnhguucfutghhuhgsvghrthcuoegsvghrnhgurdhstghhuh
    gsvghrthesfhgrshhtmhgrihhlrdhfmheqnecuggftrfgrthhtvghrnhepvefhgfdvledt
    udfgtdfggeelfedvheefieevjeeifeevieetgefggffgueelgfejnecuvehluhhsthgvrh
    fuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsggvrhhnugdrshgthhhusggv
    rhhtsehfrghsthhmrghilhdrfhhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehjuhhlihgrrdhlrgifrghllhesihhnrhhirgdrfhhrpdhr
    tghpthhtoheptghotggtihesihhnrhhirgdrfhhr
X-ME-Proxy: <xmx:ZEwSaBtE8Zbzw_gtw2fuxIRHhQh3MQ3L4aa4h5KkI3acPhV92azvQw>
    <xmx:ZEwSaNcFEnfEa53_AiIuvr1g2JoSgechRbZVo_LOBmERhJ0YYhIEwQ>
    <xmx:ZEwSaN1CBjkie_5FYQujvnuMpTW5wWIU1YNMR42ORTrqYcWLKvFJgg>
    <xmx:ZEwSaJ-XFqTSBiYwIOZRgJOV1vHr5RpX7yJQrbAMieX2y9-xpZ6ijw>
    <xmx:ZEwSaAVlOkuYRHLXTO4TnddK5RFkzo2s6JjKL0tyoidSaz0KGbCGBa9M>
Feedback-ID: id8a24192:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Apr 2025 12:14:27 -0400 (EDT)
Message-ID: <355eed68-d4ce-4a3d-abf1-ef2f0ed3c751@fastmail.fm>
Date: Wed, 30 Apr 2025 18:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <5ed0ac32-bb11-4faf-8f70-76431df289ec@fastmail.fm>
 <474ce813-bcd-53e4-fa69-64379dc97f9@inria.fr>
From: Bernd Schubert <bernd.schubert@fastmail.fm>
Content-Language: en-US, de-DE, fr
In-Reply-To: <474ce813-bcd-53e4-fa69-64379dc97f9@inria.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Fatal error: exception
 Coccinelle_modules.Common.Impossible(126)
Reply-To: Bernd Schubert <bernd.schubert@fastmail.fm>
X-Loop: cocci@inria.fr
X-Sequence: 2735
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-04/355eed68-d4ce-4a3d-abf1-ef2f0ed3c751%40fastmail.fm>



On 4/30/25 17:59, Julia Lawall wrote:
> 
> 
> On Fri, 25 Apr 2025, Bernd Schubert wrote:
> 
>> Bonsoir,
>>
>> we just found a simple reproducer for an issue that was affecting a few
>> of our files. At least I hope that this is the only issue
>>
>>
>> bschubert2@imesrv6 red>spatch --sp-file find_bug.cocci --c++=17 coccinelle_bug_example.cpp
>> init_defs_builtins: /usr/lib/coccinelle/standard.h
>> Starting the test...
>> HANDLING: coccinelle_bug_example.cpp
>> Fatal error: exception Coccinelle_modules.Common.Impossible(126)
> 
> Thanks for the report.  The problem was that the : in : public base_type_t
> was not being accounted for.  I didn't use the provided patch as is, but
> rather made something more specific to this case.  But using the provided
> patch will also not cause any harm.  I will update the version in github
> shortly.
> 

Thank you very much!


Bernd
