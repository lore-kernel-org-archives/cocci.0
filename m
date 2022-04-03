Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 109E5C433EF
	for <cocci@archiver.kernel.org>; Sun,  3 Apr 2022 16:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Wbtwe9c/c4JotPvkp3h0n4Nf9apvcAyf9BWl7G5HwqY=;
  b=WD44blHVObD88GuEF8eaMm+1Db5B11NRFB0ufbBZQwkKEzEv2TrfMwac
   jeeiaaVXp2iv61FQFDHQ2aMBST0n480L/JDsj6kVooSv34drw3BR5TW4z
   6+DIH/NhlyWo9CUzje/WdjOIe8QvZdoipebW86/Gzlr5ju8+7vxvJXsPh
   g=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@univ-grenoble-alpes.fr
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29755204"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Apr 2022 18:44:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2663CE033B; Sun,  3 Apr 2022 18:44:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9980E00A8
	for <cocci@sympa.inria.fr>; Sun,  3 Apr 2022 18:44:44 +0200 (CEST)
IronPort-SDR: WVOXezlIEy2pF+Hh/Gj+Sxbq4gi4BJDBhH0aFc8P0rwZjjSHdsWm9xssziIfkf82L/03rmFIYN
 X2hNfHbOqpEaP6nzaaalIEf4UEXGvIEms2tjQ0AvvYb66qN1GlNXABBQU039hHpb9BbLwjF55y
 pyM1GeFviPQOopSxa6mIA7Ac9yBYUJVICom2VRj1wv6B4iTY74lqym9O7HwEm89jRBTTZUocmD
 HvP9uu5LsZmNXSfL01iL835+s0cjN84AJ219gewF9jSC0XqfNKdKgQKNsKdJYccZbZYS5RMN5t
 XLjjs2bd7AUZy9WX6u6s82r3
X-IronPort-AV: E=Sophos;i="5.90,231,1643670000"; 
   d="scan'208";a="29755198"
X-MGA-submission: =?us-ascii?q?MDEe/fseI/xQj6t3R3cWWROyqYiFMp6BpBb1XB?=
 =?us-ascii?q?wFgHQnc3btYTc6QHpIa1p1K9MxZjqZe6S9+Oymh5AZnU0XtH3BLnjwsd?=
 =?us-ascii?q?XExJRoYQMC1eu7DTc5nICzWrwt9HTQUm/cCZcXeJwPc0KSd/98L25vB1?=
 =?us-ascii?q?xkHHxMJA8+9svv1tvobNzM/Q=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 18:44:44 +0200
Received: from mailhub.u-ga.fr (mailhub-1.u-ga.fr [129.88.178.98])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 2E4DA402AA;
	Sun,  3 Apr 2022 18:44:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=univ-grenoble-alpes.fr; s=2020; t=1649004284;
	bh=aGgVtM/+11Xtk1P5ipHQHpj1yc/aLAuwao3xL9R2/vc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DWz9k9kz+6tJtB08/6K3StnykpUCM9KrUuyXNBz8Ygwg3um6XrjlJYLDaDqjM0/8y
	 WAB37NXTrrKuH+UwcWYdw4UDlAuFcsmxrNI7tI1q5RhTyfKdNg4LF/XgCAHWIdlJRz
	 HjRG05WJqHkrG9loXt5yCY98v5YfKbY+4eN7vGSWVyFevcRGwZ8XdOuZz4xqFDCKaY
	 LlQeN1BoaBGhxrEchUv+6NiKpDjuUli2ap3DXpGPJMpduSoYGhQxpL5Y7vEeoueOnJ
	 MmqFL/rZoSnJJ85Lsj3U/WE5sYtxxW6q/d2QQRTk9RixxlLm9gfGK/LNTJ/nGMEnzw
	 /IKdiqtq8EELA==
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
	by mailhub.u-ga.fr (Postfix) with ESMTP id 2C52C1000AD;
	Sun,  3 Apr 2022 18:44:44 +0200 (CEST)
Received: from [147.171.161.135] (pers-161-135.vpn.u-ga.fr [147.171.161.135])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 149AB4005E;
	Sun,  3 Apr 2022 18:44:44 +0200 (CEST)
Message-ID: <4715acb0-7b7a-9671-bd15-e5dfd36af74e@univ-grenoble-alpes.fr>
Date: Sun, 3 Apr 2022 18:44:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: fr
To: Eric Wheeler <cocci@lists.ewheeler.net>
Cc: cocci@inria.fr
References: <4f40e17b-67ed-97f0-10ca-41285d7c3d1a@ewheeler.net>
 <alpine.DEB.2.22.394.2204022320520.3208@hadrien>
 <9a8c392a-413b-afc0-16c5-a013e403372b@web.de>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
In-Reply-To: <9a8c392a-413b-afc0-16c5-a013e403372b@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (41)
Subject: Re: [cocci] Completing documentation for SmPL scripting interfaces
Reply-To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
X-Loop: cocci@inria.fr
X-Sequence: 351
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-04/4715acb0-7b7a-9671-bd15-e5dfd36af74e%40univ-grenoble-alpes.fr>

On 03/04/2022 16:55, Markus Elfring wrote:
>>> Also is there a reference for the `coccinelle.` and `cocci.` python calls
>>> that seem to be available in a script:python section?
>> There is Coccilib.3cocci, but that is for ocaml.
>>
>> My understanding is that there are reflective features in python that let
>> you find out what functions are available.  python/python_documentation.md
>> in the source tree also has some information.  Or look at the code in
>> python/coccilib.
> 
> 
> Would you like to improve the documentation for these programming interfaces?
> https://gitlab.inria.fr/coccinelle/coccinelle/-/blob/5069eaeadd731ecdd99e7a6f4465c286a2792354/python/python_documentation.md#fields-and-methods-exposed-via-cocci-object
> https://github.com/coccinelle/coccinelle/blob/31bf3aefce245e43cc58f6b6ff49fc9b8e9084ff/python/python_documentation.md#fields-and-methods-exposed-via-cocci-object
> 
> 
> Should the method “cocci.make_expr()” be explained also?

An example:

https://gitlab.inria.fr/coccinelle/coccinelle/-/commit/d0666cf3f6faa4516bd42bac1f319d6bc894e32d
> 
> Regards,
> Markus
> 


-- 
Nicolas Palix
