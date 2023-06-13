Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2843BC77B7A
	for <cocci@archiver.kernel.org>; Tue, 13 Jun 2023 09:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=fxhSX/PkC9aqREhLP2+DfHyKLkgyhPawLcKZfog1wow=;
  b=U6co260BNt7fvxbLjryLhlpdwy5mJmNpBvH17vLm3EIM2YYzknTktbIf
   9j7LBNfKYoqm3NwwoBgGpz5TJaZ9RgnvF3chMm5wCudKo2lZoFQ2VlKmQ
   s8p+rVEDi/l39zxpEaZOYvBejoWHTBfps2uXbrmJYd+0PMnwjpck0mxcz
   c=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.00,239,1681164000"; 
   d="scan'208";a="112598994"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Jun 2023 11:16:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B12EE0CCE; Tue, 13 Jun 2023 11:16:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 998D7E00BA
	for <cocci@sympa.inria.fr>; Tue, 13 Jun 2023 11:16:01 +0200 (CEST)
IronPort-SDR: 648833d0_KAyE6fPswsgC/v+3SBbcqLlkNS9RShRTyv7hdfqvrmfKYag
 Nn7W/7zyzBeGAdl7oIvKod0+LQdxuMXXQKQweYg==
X-IPAS-Result: =?us-ascii?q?A0EjAACwMohkh07ASNlaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBOwYBAQELAYIueFMwBAtHhFKIHYcNgXYxhDaHMYdFhGiEBIFWgUA+D?=
 =?us-ascii?q?wEDAQ1BAQIEAQEDBIFMgzMChXUCHQcBBDAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQFAQIQAQEBIxcHDgULJ4VoDYI3KQERZIEIAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQESAkc/AQICASMEGQEBESYBDwsODAIfBwICVwYBDAgBA?=
 =?us-ascii?q?YJ6gigBAw4jB61XfzOBAYIIAQEGnA4fLCJVgV8JgRUtAY0ugzd6Jw+BVUSBP?=
 =?us-ascii?q?IMEPoREg1uCZ44lkAqBKG+BHoEifwIJAhFngQgIXoFxQAINUwsLY4EcUj2BR?=
 =?us-ascii?q?gICESkTFAVNex0DBwQCgQUQLwcEMgkVCQYJGBgXJwZRBy0kCRMVQgSDWAqBD?=
 =?us-ascii?q?T8VDhGCWyQCBzZDG1oQJQQOAxkrHUACAQtwPTUGAwsfBiYBHgIpgVcwWHAKJ?=
 =?us-ascii?q?CSjEgekfqILNQeCMIFbgV0MnxwGEy+XFA4Gki4uhzmQMCCoF4FjOoFcMxokg?=
 =?us-ascii?q?zZPAxkPjiAZHoNwj0g/NDsCBwEKAQEDCYVGAQGGAAEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Pwhoofv5eURkAmoqSnB3ek=
IronPort-HdrOrdr: A9a23:rU5NeqzEtE0PtUgPJil5KrPw+L1zdoMgy1knxilNoNJuA66lfr
 OV7ZAmPHjP+U4ssRAb6Km90cy7Kk80mqQb3WB8B8bEYOCighrPEGgA1+XfKl/bdxEWn9Q1vc
 pdmupFebjN5DNB7foSjjPIcOoI/PnC1ry0juHDyHpXQRhtcLwI1XYFNu/WKCxLrBItP+tDKH
 Nw3Ls8m9IqFE58UviG
X-Talos-CUID: 9a23:KyQ5zmDDzXJP3J36E3Y40UcdC+4/S2bc9HXPLUSUK19ZY5TAHA==
X-Talos-MUID: 9a23:oqnlmAqUSEseZ7mCy3sezwFGFMlq2761Ml5OqJEKgJimNGtxCw7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,239,1681164000"; 
   d="scan'208";a="58572521"
X-MGA-submission: =?us-ascii?q?MDGvv30x8NsTG1vV8qEDhBwlCI+8+TayhiZznz?=
 =?us-ascii?q?UZq4odZvM8GiGP7/ZWid6+4NLn/RKImYuZHip9RHic5/BZBAjnHnnphB?=
 =?us-ascii?q?VQpx7k89Bpl5rrBVJPUFUfdj6GP1b6ibFasJ+vyQpJbUVrnxpHUcx3sy?=
 =?us-ascii?q?xsLkob3pHcVtXReds2UM6NoQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2023 11:16:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1686647753; x=1687252553; i=markus.elfring@web.de;
 bh=yzGw4OeU03QGQOfSpeGc69DR3iYlyEOH/0JVL9Wdbl4=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=GVm5GV6e5QbggF8v/sYVTPB5nBer8ubVWnCVja8lj30lwHrsZ+0ZSaxilr0NHhPFe9vkxQz
 F045bgdcY4yc3GzLHHuFhYtT2QQdeo65YoZlsmqn2+LkhVLO3pWVNJLQOepIq3lb7vuVKKkw2
 qBFS2PjywQd6o+nDZ8aUu9ScyQPTVzHYwArTdsd++XfXo2MDXyGcizMdERRoLeZ8JwDzTFrqs
 C+WDSRabi6qZWRs5XSH0UccA+SajnP2Uia9YJlrkd4WGPpG5LibZQ3Pwm14NBVJlZMMyefq89
 WOvpYiguZZsswywpzBNJxuWgmXiFo7A1N7kzzqbszRkAzoXcyV5g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.84.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MdO5C-1pZwMK3riS-00ZUou; Tue, 13
 Jun 2023 11:15:52 +0200
Message-ID: <b6c1500b-c901-00c7-e1be-1fa0088972a3@web.de>
Date: Tue, 13 Jun 2023 11:15:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
To: Chester Lin <clin@suse.com>, kernel-janitors@vger.kernel.org,
 s32@nxp.com, linux-gpio@vger.kernel.org, opensource.kernel@vivo.com
Cc: Linus Walleij <linus.walleij@linaro.org>, Lu Hongfei
 <luhongfei@vivo.com>, LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230606070201.14249-1-luhongfei@vivo.com>
 <fca44dcf-e632-fed6-aee9-03a5b0c6b1d9@web.de> <ZIgPl0UShltd0VEe@linux-8mug>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <ZIgPl0UShltd0VEe@linux-8mug>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MQ8MwzHyrSpk5jdpdciXU9STz4azkIWzhj4HLxb5bvDozcz8+bF
 3Q45aby81ejN8FOcTiShxhN+t1cAM0MC1lyWHMG9dbW57XyvY+74f2z/u6ihIn66puTkRof
 /Nmn7oDJ0MOb/TFbN9oj09okHr/mhoXawYxKeEgCyJTqId77IFEtTH2aLlX1H1hh463bynG
 XoyTBwqOoOo0mBz7OZ5kg==
UI-OutboundReport: notjunk:1;M01:P0:M7eKwzASMgs=;f04Burq/LkNuSHSbnidhzcu7Dee
 1wRusQewioFoWBPaRMHQTOj37TIQ4jr8M9ZqxFhCI3Dn6SRUBKmLuscvrn4OTbIPgAyTWhESE
 nhGatLh5NtP2GdQvPWaVC/D1+lXiwrzvdzx8u5TImKgwtoTakir9+6Tq9+L2SHmzlw965mjo+
 MYHsVvGeQKCJv26akudv9Fx5I6Q3Sg1a4Gn8dOiH1r1vj94mJejJihaAqGkUdhnAbzuwaOUtl
 0eKDxMzOgmiQwlWVeTldADakhWNKoofDQnCtvZuzjQwu6GB9J287hf4fJ9xbD6h1tiKOfTl6o
 +jJNM/VufzOfkitjUhszvY+OeOwK6t03J18R0JfgSqIlsQt4h07loM5UeZIL6k6psYMQfYNfc
 5xXaZ+8o1//s2nBfnvtptj7RnuyCmkJ2XsyP198WCYVKX6GzDX2bl0tZ4QbMskjG48WmP7P5S
 Wc5iRzfPn+ScFfh27O6BfyIYxsFd6McXEfRXm3u0Skyf1+OpY/9MzZ6ORFItpEe87O0jSmOQH
 r7ojW4nCvhtN2dyORCXOxOZT2+6pHqd1tl1kYuJbQ6B+iVFSq7s7VEvVXw62XHC7ltC1HVYnB
 toiUQfKNoai23XGec8Ouq0AEob1zHXTzLwuEmRq8rKUHlxsmgHlCV5o1HjLH9/wqOd+Wo2KaN
 tdlmQ7DlY1N8fCw4XkrCeJsMfqsFRc0G8DPqSgQ646ooodKiQRAYv68goQSRMkdTlWHn4s0yy
 L/j5pzf/vWk2OXmRF+t6oVrVE0eVVbFyJuH4RLMeUknJ8+VDsEa27E27bu1iVF2MFl5ygTguW
 P7OlfReRxt7NhmkoA66lBQF5K9fcGTmWEJ6vjGLdQszA/O3NM3acCYZSgRjSZL9d9kr+MVUIf
 qSPugiDv1qlktHg3wgBsD6JUtODe2Hb81dAjPfkkZWJz+G34Lrxz0EpsWntFIjYnaSj8jj62Z
 crEs7g==
Subject: Re: [cocci] [PATCH] pinctrl: nxp: Adjust error predicates for
 improved exception handling in s32_dt_node_to_map()?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1180
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/b6c1500b-c901-00c7-e1be-1fa0088972a3%40web.de>

>>> Ensure child node references are decremented properly in the error pat=
h.
>> =E2=80=A6
>>> +++ b/drivers/pinctrl/nxp/pinctrl-s32cc.c
>>> @@ -279,8 +279,10 @@ static int s32_dt_node_to_map(struct pinctrl_dev =
*pctldev,
>>>  		ret =3D s32_dt_group_node_to_map(pctldev, np, map,
>>>  					       &reserved_maps, num_maps,
>>>  					       np_config->name);
>>> -		if (ret < 0)
>>> +		if (ret < 0) {
>>> +			of_node_put(np);
>>>  			break;
>>> +		}
>>>  	}
>>>
>>>  	if (ret)
>>
>> May the same error predicate be applied at two places here?
>>
>
> I think these two error predicates can be combined together in another p=
atch.

Are you going to reduce such error predicates so that exception handling
can be improved another bit?

Regards,
Markus
