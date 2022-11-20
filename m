Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70842C4332F
	for <cocci@archiver.kernel.org>; Sun, 20 Nov 2022 16:15:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=wIb4GM2grUIWHE3yUKBU77Y6dKLp94nn7Trlo4Hejjk=;
  b=cK43y+UPL8KPjsgkq5SGmaqvL8zBZEiPMfVTGVSJaS6al0/UluGpuAI6
   btq1kxxT/ezRZcEu7eca2i0rIrnUl+aizi5VjcxZi2K/lzMLB9eDqmdF3
   Ku1+5eez4s4Jry5ry7oYVZ9L9uz0WK0Q7g0Hpi5uWFzMPgbyeUaQ/rU8t
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@web.de
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79133537"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Nov 2022 17:15:36 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A7100E027D; Sun, 20 Nov 2022 17:15:36 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BCBD8E027C
	for <cocci@sympa.inria.fr>; Sun, 20 Nov 2022 17:15:34 +0100 (CET)
IronPort-SDR: 637a52a6_84trHGCna2Ixg8C4f4c6UrzLFY4wZPYba0556zogBxYVq52
 /aL8RC4wue2RVAFXyRojJwii4//aWg1fxXV/YtQ==
X-IPAS-Result: =?us-ascii?q?A0GKCAAaUnpjh07ASNlagQmDfIEHUy4EC0WET5BsMYQph?=
 =?us-ascii?q?yGHMIhhg1QPAQMBDUEBAgQBAQMEgguCcwKFAgIdBwEENBMBAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEXCxcHDhAFIoVoDYI1KQF1gQgBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFgJHUz0BAgIBIx0BAREnDwsaAiYCAlcGAQwIA?=
 =?us-ascii?q?QGCeYJuAQMOIweyVIEygQGCCAEBBpwGHywiU4FeCYEULIxghDAnEIFVRIE8D?=
 =?us-ascii?q?IJHMD6IG4JFIo50iQklBA4DGSsdQAIBC20KShsxJw4JHxwKBBcNBQYSAyBsB?=
 =?us-ascii?q?Qo3DygvZyscGweBDCooFQMEBAMCBhMDIgINKTEUBCkTDSsnbwkCAyFlBQMDB?=
 =?us-ascii?q?CgsAwkhHwcWESY8B1Y6AQQDAg8gOAYDCQMCIlVzAi4RFQUDCxUlCAVLBAg5B?=
 =?us-ascii?q?QZTEgIKEQMSDwYmRQ5IPjkWBid0Dg4UA16BaQQ1ZoELCpxvK6VOn1k0B4Ifg?=
 =?us-ascii?q?UyBTQyeZgYTLoNlkwkOBpIUHZcXIKdYgXkjgVwzGiSDNk8DGQ+OOYQMiixAN?=
 =?us-ascii?q?DsCBwsBAQMJhUcBAYUZAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JzUV5q68fpVTfRr/CgPXwBbXdLJyesId70hD6qkDc203TiX+rb
 HWoB17726TtN91YhodcL+7V5VoLUmskaKdpLNhWotKPzOJhILLFu1fBOLZqlWMJ8S9zJ856U
 4KSchD4bPLfDpHpPrbpC+lDt0n3N6Ly6ywg/zCpk0dNz2CJ5sA0+9jYDzranGeqTM2fqbQn/
 enjPZ6mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,179,1665439200"; 
   d="scan'208";a="79133527"
X-MGA-submission: =?us-ascii?q?MDHSFbNjUBiPQa18CMteXAdpKKs0Ih/4keKsa/?=
 =?us-ascii?q?lR7OP/215NBEwWNvYo12bamf8froVqJrlKCne0bfur4/UvwmgMKzIjHr?=
 =?us-ascii?q?uokLnsG0ANNjhzmkJzaOG0mf9RiK6mQQ8RqwivYxDrSTeFHwUHXdTkV6?=
 =?us-ascii?q?dJqIZJGY0RPLdQFTJ2lAPWvA=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2022 17:15:34 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1668960933; bh=wIb4GM2grUIWHE3yUKBU77Y6dKLp94nn7Trlo4Hejjk=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=NsR1AX1EY1PM0DV/JF0fSs7zSfKD21+i8Lk4IHT+4CdTlBHcznvCb2w8JkALouQ50
	 6tEsItknjm45N6CiWLnRBrMl9GYQWU7TD7kpLJUEu81Happd0cWtGr7BT1ttT0byy0
	 mFYtJ67STEoyXL6fJbkBtMzLSgiNZFpD5RukhH3BYgOYb6xrsX6L9uqxrrPrzHQCRY
	 fb1MEwsIbDxooDnvFcHNrnHb0nlgjARlaEJ/luLAxsvPF7kTfchQHFR8Z0l6ZjgIpt
	 6SS64kPaTB9qfZvK2w7T+v5t7C2ie75nl0hUg04I8sdaIcvXr96qKaN1j6x0MKL8NP
	 eVbBHCACyY5LA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M43GU-1owmyj2XdQ-000SJj; Sun, 20
 Nov 2022 17:15:33 +0100
Message-ID: <fda7b28c-6007-4438-c96a-26c8d82ab869@web.de>
Date: Sun, 20 Nov 2022 17:15:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-GB
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <dce20c86-de6b-92ef-3bc3-af39ca99b5c4@web.de>
 <alpine.DEB.2.22.394.2211201641340.40755@hadrien>
 <fd1e099a-986b-b528-7cd0-d1d0c3d51ca3@web.de>
 <alpine.DEB.2.22.394.2211201702090.40755@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2211201702090.40755@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:njCJkgoYqIfIXGi9qMc8FSLs+NYZ2i4DOkv7XW2v0Ps0UFPL9L4
 JZ9nkuFLLuWGKGWdcn6Cud0XmQJy6W2BGmf/EFFhfYTOYimUBAg9eHf/gpZvf5aP9+tDVdr
 8VTceBS8iR8Xl7cvfHBhdv96GE53TDOz5IeDPGXF+tI5JBFZ/FrB0+ulT1/BYZU2HR2LNSw
 fRkXdsN8sFm1JtaluqQ0g==
UI-OutboundReport: notjunk:1;M01:P0:k7DP3JqgMqY=;y2dKFoA6EwA4wXZ3KWVCmETNRZi
 5AxZWlzmxkcGWpYTZwljrtgnc4jaraLltxtfkD0Z+kjawq6V5glgBGg5oYQ0yxAcKb2zf1m/3
 jfH+Pxk5CHOALf4Awd0k75OREgTKiTgkJpS/AfqCD1r7hg4ytN6wLVmb/tEq2doXq0CIWf+Rq
 B3t4sbhbIwSxX8hJq6B5EF0MKtZ8WdCehMCpcv977cNcMM+LZGfPr2zaMnLRVXV55NbKzXj0c
 J8HqEgCDQ6EihNJ3ydT5HfpcAw7gtNqOpnMeG3I0UKOYWaTNGMhaco3r7atNcS4CHT7Epwruu
 90kZirY6hbBuhHViBQwiDI7vnYL44tnaRdbp/L4gM2V1yvBB8B9yauDCkvxlux2QGzLWHOSYJ
 doxLhGL+sVthSb//pI+AvM/IjaccqJBWxBMrWKf/QmAp08MoM8W/i6k/qi+cxSQ0Bgp65oDL0
 ve8lm5dR77dBrRMBKt2QQQb1OrdG5g4v8ud5tgm3xeDtKVuL/faGpW9ZETVwgucqYl+irIcro
 BJyK0OtmZNHLHB2J/LTUGJIiFZRGBqNXgyzIrBZ9MhXbWBYhWf1F/6g7xunVIkm8qpQmuhPi5
 PIQkzWEq2jQPR+p2KnDBP6RSq9Qa1LKZ79UQ6Gt20DtuZfQaocSqiKcnaFVXMupU+adirLXAW
 +NDNVkVe2z/t4ETUMeWoHfadSQ2BInQmJsOxq67F57noHXLTk8/SRog9AmW/jqUqAvYGQTrMK
 q+Z1r6rIzOhwc3UwGZPTfx9RoKnz3CadhRV+M8ilJW9VG8ogLlbFEkrHPI6WLsOOuP8pZg8iP
 5C3bAV1sKtTj4TmMwCrv/OpFyoNCyqC7OMchFO5SPbsUDaBUjGDtWXlOrMvEGBnFmuVrqLe80
 6mt5v+Hfu75LmO592z8cf9wIaC9ivmO9pg+kUHEOCXCJNWCACWuga5Yd7IUPIirJw1J94l2yJ
 JxOdDQ==
Subject: Re: [cocci] Data structures for source file analyses
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 754
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/fda7b28c-6007-4438-c96a-26c8d82ab869%40web.de>

>>>> How do you call the intermediate data representations according to the involved
>>>> processing pipelines?
>>> Abstrat syntax tree? Control-flow graph?
>> Do the following data representations matter for you?
>>
>> * Abstract semantic graph
>>
>> * Parse tree
> No.


Such a terse response makes me curious if the distinction will evolve further
for known abstraction levels.



>> How are they mapped to components which are provided by the Coccinelle software?

Will the chances grow to document the applied data structures better?

Regards,
Markus
