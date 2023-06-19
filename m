Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE17AEB64DA
	for <cocci@archiver.kernel.org>; Mon, 19 Jun 2023 09:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=WQGKDcMtwMGSwNBTypRsFgWP6tmzMxivisowuKufbwU=;
  b=hreT+vhujVJDRQ5roB82y/Jag+yGJgx7bybHJ9MiYgvfvEEKW/Wi+Lps
   WvtjFpKL7DZmJrQ/ivYwHf8ckECSiienm0dQiKnbJrYv1Qo25Ia3N//bN
   Is6Z19Erp7g5WUI730+Wb+XPzx5ClAW8ru7pmdg+5Zpby4jEaYgKcOY9/
   E=;
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
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="113525663"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Jun 2023 11:57:47 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D82E4E03AC; Mon, 19 Jun 2023 11:57:46 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E3547E0157
	for <cocci@sympa.inria.fr>; Mon, 19 Jun 2023 11:57:45 +0200 (CEST)
IronPort-SDR: 6490267c_g/RnVhrGTeI0+R7EbmKoJaf5wg85igXdTY2h1vjF4mHCnQb
 Ie0NodGhH6BsC4GzDa6VDKc6P9vDeyRJlYNe6HA==
X-IPAS-Result: =?us-ascii?q?A0GjAAADJpBkhwwR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYIueFMwBAtHhFKIHYcQgXYxhDaHModFhGiEBIFWFIEsPg8BAwENQ?=
 =?us-ascii?q?QECBAEBAwSBTIMzAoYAAh0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBA?=
 =?us-ascii?q?QIBAQIEBQECEAEBASMXBw4QJ4VoDYI3KQERZIEIAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQESAkc/AQICASMdAQERJgEECwsaAiYCAlcGAQwIAQGCeoIoAQMOI?=
 =?us-ascii?q?wetWIEygQGCCAEBBpwOHywiVYFfCYEVLQGNLoM3eicPgVVEgTyDBD6EDwESA?=
 =?us-ascii?q?YN8gmeOMIVoiz6BKG+BHoEiegIJAhFngQgIX4FxQAINVQsLD1SBHIJSAgIRJ?=
 =?us-ascii?q?xMUBU14GwMHA4EFEC8HBC8fCQYJGBgXJQZRBy0kCRMVQQSDWAqBDT8VDhGCW?=
 =?us-ascii?q?is2PxtRggElBA4DGSsdQAIBC3A9NQkLHwYmAR4CKYFXMFh1IySiKQlygxoqC?=
 =?us-ascii?q?pY7jSqgWTUHgjCBW4FdDJ8cBhMvlxUOBpIvLoc6kDEgqBiBYzpscDMaJIM2T?=
 =?us-ascii?q?wMZD44gGYQOj0g/NDsCBwsBAQMJhUYBAYYAAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 z3TFr0c8yVdGq1UeNs=
IronPort-HdrOrdr: A9a23:+zWVia0xRHkOJlv3HpxOEwqjBGYkLtp133Aq2lEZdPWaSL38qy
 ncpoV56faSskdoZJhAo6H4BEDkexjhHPFOjrX5UY3SOzUO/VHYSr2KjrGN/9SDIUHDH4dmvM
 8MT0E9MqyVMbEQt6bHCWeDYrQd6eWmtIa1mOzZ03Bhdg1ybbp8hj0JdzpzXncWeOFcb6BJb6
 Z0C/A33QZJ8hksBPiGOg==
X-Talos-CUID: =?us-ascii?q?9a23=3AzxHgEGh2tfcFFgbk3rdF4+3hFTJuLkSN0WvbA1K?=
 =?us-ascii?q?DAk0uavrIF3WhypN8qp87?=
X-Talos-MUID: 9a23:jSNWdQlyDWHkwEoR1DD5dno6Dv5m5ISNOXlVjI8tkNDDPAVOERqS2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,254,1681164000"; 
   d="scan'208";a="59100109"
X-MGA-submission: =?us-ascii?q?MDGs7UE/ObQibav3VuK2F6D027kUSGEhpBSHKb?=
 =?us-ascii?q?uafuVtlbsbxmRA3nBkFbOdk3y/xEUM535keuyd4cOThUqF5T+kjPjlYj?=
 =?us-ascii?q?ardX4rvLEzyvyHqWgdAH25Wn6v4Tf3Pu4wuxzjFAZeqK4Wojdu1mDGKn?=
 =?us-ascii?q?Y7iBQJwzr6U0IFWiN8duhVxg=3D=3D?=
Received: from mout.web.de ([212.227.17.12])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2023 11:57:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1687168635; x=1687773435; i=markus.elfring@web.de;
 bh=8VubWdWAKIqTF9u1AwYmpSx5oBdu1gPYcSeN1XNo3XI=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=KaqePeF9gYUV+IlMcjAUlrEV46by9Tf/ZeZpdBBj54L0tr3dUtXqr5PlwDLRTISN1sl2Mky
 mUdJSBmu319Brg2cTyLlvY/fVYmy7lDyHZPmD63w9gfocCiQGibHmZW06wpbdB4/uMfM3CGqv
 E43PrdHN1fWadnt1Dl8YmNDj+Z/FSNCoqCcAFvKS7yvwGfUN42ROVT4Ts66/rDTqWaoWLOl8+
 nuKcjMHE2q8Th6kKdhih4kBXehSzl45BQq+IkPTueb/Spa0Wuz5SZ2rL6lKLUOtK/gDc4YUoc
 Aqkruun/I0zX9XbHV5aLrZbbta4FIlNARQcdRBzMR1+y8U2E55aw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.87.83]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MmQYd-1plATK1RY1-00iSXU; Mon, 19
 Jun 2023 11:57:15 +0200
Message-ID: <0ec93feb-221a-c10b-289c-6e787b232b51@web.de>
Date: Mon, 19 Jun 2023 11:57:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-GB
To: Dan Carpenter <dan.carpenter@linaro.org>, kernel-janitors@vger.kernel.org
Cc: Fei Shao <fshao@chromium.org>, Jerome Brunet <jbrunet@baylibre.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-clk@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, cocci@inria.fr
References: <20230617160901.1.I2b151cdf7a72d9e3ecc7ab2ff38409ebe6d65d6b@changeid>
 <71168ceb-8273-4067-d0e0-c6c219d4618e@web.de>
 <CAC=S1ngN=TFQa0Y4FoSCOTUs8HRi4NEP1OwY8WccUEUMG_UDeQ@mail.gmail.com>
 <8366a35f-bc2c-4aee-b2bb-5fc9b2a7072b@kadam.mountain>
 <ea5c0b0b-7aa5-d4eb-def9-fa279d69cd44@web.de>
 <56998d04-7f09-4982-b0f1-20ef917aa524@kadam.mountain>
 <6e1071ec-f19a-454c-215a-b5193984bc6b@web.de>
 <8352fe9a-f76d-4ddb-aec4-d2c443f2fb2a@kadam.mountain>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8352fe9a-f76d-4ddb-aec4-d2c443f2fb2a@kadam.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:QfCPw+tWHSyBWRnf5j3B9W3Rgh+v+tnTnVsJ+t+9BfyZt6wgSF4
 ws0e2YWQoRC17c6IVuyc6IXFuVsheB4CalJoU4y1auUl3LLla+y3g7HAHEd7KHNAHQchNMg
 adgvS6E287vXfNjD9Cfv1AZU51e9FREgDMVmDx41qlGj6WXIP1Kz3UNFKrYh0TscqZBmPWP
 imet6Id79XoZqAyXA7ZhQ==
UI-OutboundReport: notjunk:1;M01:P0:ywgOlxISJ5Q=;P77ZIaTW2theCWj1eES36Wrv0tE
 9qSzHf4J1WP9jJW0Mu0MlhQwoxLeO+ijw1RgIztNR9bYFEPZWuNs88ELUG6VUFavSH688KvCD
 aJJs1dGZhRWB2NhS9ekIRSkeB+x9CYAl5O7bvGBLr5RxuhI2mfolR6Jkd6wvn9kJb7qtvPPXv
 8ghkyHQa3hP/Hei+tjoKLPD0x1sytD8HDUCd3nIJzJl7XBMJn6f05qxgGEbVyqAuWgzPGrwIe
 nvBJ8yeOS84AuHwYOAq+/eQrDsrk4WzVyJCQowI4UFUATMDHBiu6HtjHGbKzdfs5wKslx1ISB
 Pgf0gIwJQVXX3GxjbbjusiW3U7gc8EW/TaP6yhUomU7r5mPyPxDDX5+ExuIqMSQPnJC4vs9Nr
 r+zhvz6K2+AFYyl1x5bmLoIpSOH+MInISuW7OuUpgSmOiUHCoIOcXJ+ARzoz70E8hC5cxeciJ
 ZqUYF3aRnxoCOlZZf40BBokCu+PH1EFKP0/U9EU6lPy7irgLk5FETb81YUiyEAvmZV1zXM/gX
 NqMYa9d9Af0CDDNSrCtLJWxWeYdzCE53kQC+gkGr5NdYWULWk74rVftmmu41dRGrthfZttGlt
 EqpXB1TWALY0lRiJz2N2B20DhBero650enbrd61kj81Qa60E2JayUfNRB2X3MhsZmUU3fPWr4
 ADfbOSRCP3LKSP2lGBNjXcErrKrbpkH/Yg29DIqjihX0l6+Dxv4bWeeqyjr9MYWQSJNSEaHCs
 sLvgWSz3uOzFfe7f1IMEvuyAaH8mylWFkVYHhaeXPbnhFyD0Jye5C0lCWLKvzbfoVW9GOSdLd
 CC6x5/Lw4KH7SGytHVFzJexugZlYvBTUNJ1WcLJ7ZtmP3uxfW7HBZOo44Wm0pVXWZKN/YPEmP
 CMZEGumKhuv+SYNO1oLdIRFbU29IIoaoMCqSPqd3/eJriH5CeN3KYKhIUMMxJMa86S/VvgNoJ
 /3JBvg2RtEqUsE2glH/x+zxnzUc=
Subject: Re: [cocci] clk: Fix memory leak in devm_clk_notifier_register()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1195
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/0ec93feb-221a-c10b-289c-6e787b232b51%40web.de>

> Markus you always answer every email with more questions instead of
> just listening to what I am saying.

Additional input triggers further clarification opportunities.


> This is why you were banned.

I guess that various factors were involved for this historic action.


> Even though you are banned, I encourage people to merge your patches
> if they fix bugs.  And if your review comments are about bugs then they
> are welcome.

Thanks for another bit of positive feedback.


> If they are about coding style or grammar then they are distracting.

Such items belong also to patch review approaches.


> I know that you are going to ask more questions

Some developers and code reviewers are used to such a habit.


> but I am not going to respond further.

Constructive responses can evolve also according to various change possibilities
(which are still in waiting queues).

Regards,
Markus
