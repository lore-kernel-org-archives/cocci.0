Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97B68C433EF
	for <cocci@archiver.kernel.org>; Thu, 23 Jun 2022 19:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=06weyMqLvNB/6b/w8/aHLUdNvZ+9XIZUHHAKo9e9L6E=;
  b=HSXgqilt7IuSNeInuyLEKoMR1Hwq414CT6UjY0KsHCr6R6FJHgy770DR
   SobPi7aRg/GKnymGCDGu58Wg2U0OrM3w04uR6y1SKAX6P4cAmzvrKwtEJ
   8nbJzzrueUS5nlEp/MR/n6d39PGsAM6N7oxXcT8rVxxsrN2LZt1yai8um
   4=;
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
X-IronPort-AV: E=Sophos;i="5.92,217,1650924000"; 
   d="scan'208";a="42636963"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jun 2022 21:35:37 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40D0AE7E65; Thu, 23 Jun 2022 21:35:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id CEE56E7E61
	for <cocci@sympa.inria.fr>; Thu, 23 Jun 2022 21:35:33 +0200 (CEST)
IronPort-SDR: 9ThRH9WLfeRO0toQVgWSVZq6dUhcpo89G7xekJ5Hl5XjO3ZzlstwV/nl357xeUhXwxxt+3ezze
 k02DFfybdlXEKjEYMQdQuu/BfFZeBfMnFzBzjaNgX4XSD5zN9jc4jERT5sDC9MXfv4VMVesq5u
 GdbByFrA6PYDTwJaDK9UHNh9Wv8FmdIDXZheyhKazzLwOulywQOb/AbqqNnK5/kuRzOmramBeP
 /0K3yD3SF6OexU8NThPgu9rL5awtdBe2OGsfswLeasg0+KhwcEXeseguh+o0lOPdOgZ+4J4Zcy
 kJYwyr4eS0TCp/r/t+Eomzny
X-IPAS-Result: =?us-ascii?q?A0BIAADtv7Rihk7ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T4EAQELAYIjgVcuBAtEhE6OZ4F3MYQhhwqHHIo7gWgLAQMBDT8BAgQBAYIPg?=
 =?us-ascii?q?moKAoVKAh0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETA?=
 =?us-ascii?q?QEBDAsJBwgKBw4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMdAQERJgEEC?=
 =?us-ascii?q?wsaAhEVAgJXBgEMCAEBgnmCZQEDDSMHrDyBMYEBgggBAQaESh8sIlKBXAmBE?=
 =?us-ascii?q?SwBileDI3onEIFVRIE8glMwPoEPgm5HP4MXgmWMdoweJgQPAxotLxKBIG4BC?=
 =?us-ascii?q?AYDAwcKBTAGAgwYFAQCExJNBhwCEgUHCgYVDhQcEhIXDA8DEgMRAQcCCRIIF?=
 =?us-ascii?q?SsIAwIDCAMCAyALAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKA?=
 =?us-ascii?q?xEEAxMYCRYIEAQGAwgvDScLAwUPDQEGAwYCBQUBAyADFAMFJAcDIQ8mDQ0EG?=
 =?us-ascii?q?wcdAwMFJQMCAhsHAgIDAgYVBgICGFYuDQgECAQYHyQPBQIHLwUELwIeBAUGE?=
 =?us-ascii?q?QgCFgIGBAUCBAQWAhAIAggnFwcTGBsZAQUyJxAJIRYGCh8KBgUGFgMjSCYFC?=
 =?us-ascii?q?jsPKDQ2PCwfGwqBGywJIhgDBAQDAgYeAwMsBiIBGwKaI2uDVAySW65QNAeCF?=
 =?us-ascii?q?IE9gUQMni8GEy2WVg4GkXqWcCCnG4F3gX8zGiSDN04BAgECDQECAgMBAgECC?=
 =?us-ascii?q?QEBAo4dGR6DbootPzQ7AgYBCgEBAwmFRwEBiTgBAQ?=
IronPort-PHdr: A9a23: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
 pYDGOczvLkdCf4QTEhoToRqHQ==
IronPort-Data: A9a23:hjWChqhY+8PQLG3CWan3O/TuX161DhYKZh0ujC45NGQN5FlHY01je
 htvC22HPvjfNzGnco0kaN7n90xX6pPQx9BhQQdopH9nRixjpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UKieUsxIbVcMpB0J0HqPoMZkxN8y6TSFK1nV4
 4mq/ZeEYAXNNwNcawr41YrT8HuDg9yp4Fv0jnRmDRyclAK2e9E9VfrzFInpR5fKatE88t2SG
 44v+IqEElbxpH/BPD8KfoHTKSXmSpaKVeSHZ+E/t6KK2nCurQRquko32WZ1hUp/0120c95NJ
 Nplh62uTFY3L+r2ob4edB1ZIRlSJrZD9+qSSZS/mZT7I0zudnzx37NxAUtwMYBwFuRfWzgRs
 6NCbmlcNFbc14paw5rjIgVoruEqNsr2J8Uyvn96zDfWJekrS9bPTs0m4PcEhmlr2JETQ54yY
 eI5Rh5rQR+ZZCcfeUUOIok8pb/4vljGJmgwRFW9/PdrvTGKkmSdyoPFNNPKc9iObddUm0yCr
 yTH+X74C1cULrS3wj2O+XOEnf7KhSq9WYQIFbT++OQCvbGI7mkUFQFQSlax5/W04qKjZz5BA
 34l5C9/s7l1znXxTf75Xi+AjGWfuxFJDrK8DNYGwA2Kz6PV5SOQCW4FUiNNZbQaiSMmedA5/
 gLQxYK4XlSDpJXEFSPErt94uBvoYXB9EIMUWcMTZScoi+QPTak2iQ/TCMluGui5g7UZ+A0cI
 Rja80DSZJ1J1abnMplXG3iZ2lpAQbCXF2YICv3/BD7N0++ATNfNi3aUwVba9+1cC42SU0OMu
 nMJ8+DHsr1QVcnczHbSHLlTdF1M2xpjGGKM6bKIN8ZxnwlBB1b/Jei8HRkjeBY3aZxslcHBO
 hWK5V85CGBv0IuCNPIrPdvoVazGPIC5W42tV/bIY8BIb4Q5fQDvwc2dTR744owZq2B1yftXE
 c7DL66EVC9GYYw6kmbeb7pCidcDm3FmrUuOFMuT50n2gdK2OiXOIZ9bawTmUwzMxPjYyOkj2
 40Cb5fiJtQ2eLGWXxQ7BqZCcgFbdSVlXfgbaaV/L4a+H+avI0l5Y9e5/F/rU9UNc319mria8
 3ejdFVfzVaj13TLJR/UOG9uYvXjUM8n/348OCUtO3eu2mQiONr+sv1AKsFvJbR3pvZ+yfNUT
 uUef5vSCPp4SgPBp2YXY677odEwbx+snw+PY3GobWFnLZ5tTgDE4PH+eQ7r+HVcBya7r5Vsv
 LCqkA/WGMJRSwNnBcfQSfSu01Lo4SlDwr0vBROQL4AKKkv28YVsJyjgtdMNIpkBeUfZ2z+X9
 weKGhNG9+PDlI8C9oWbj66zqYr0QfB1GVBXHjWA4Lu7aXva826kzdMSWeqEZ2mEBmbz5bnke
 uhfif3xaaVVkFFPuot6MrBq0aNnu4qx/eAHlFw8ESWZdUmvB5NhPmKCg5tFuJpN8bkF6wG4b
 USCp4tBMrKTNcK5S1MceFg/YuKY2a1GkzXe961sckD9+TMx47eNF0lfZkHehCtYJbpzEYUk3
 eZ45J9IsVPi0EJyP4bUlD1Q+kSNMmcEDfctuKYaN4m32AAl/VdPPM7HASjs7ZDTMNhBPyHG+
 NNPaHYuWlid+qbDT5b3PX3KwPYbmpkE/hxHpLPHy5JlhfKd7sLbHjUImdj0cuiR5gpK2aR/N
 wCH8mVrcL6W8W4AaNdrBgiR9sIoOPFd0lP8wR0FmQU1iqVuunPldAUABApGwKzVH6+wsNSWE
 HF0BVsJiQrXQfw=
IronPort-HdrOrdr: A9a23:XOs406HnAuNHenuzpLqEzMeALOsnbusQ8zAXPo5KOHlom7+j5q
 OTdZMgpGfJYVcqKQgdcLW7U5VoLkmyyXcY2/h3AV7mZniBhILKFu9fBOnZrwEIcheWnoNgPO
 VbAsxD4bbLbWSS4/yKgjVQX+xA/DGdmprY/ts2Ik0dNz2DUstbnnpE4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,217,1650924000"; 
   d="scan'208";a="42636956"
X-MGA-submission: =?us-ascii?q?MDHPGrvtDQS+Yv5bNHlcCWswF5F7v8oXWlnemX?=
 =?us-ascii?q?7igyigGVQS+GBj9pTPHUiWWEEBoGRZhjtArDUEtjJqDFI9mj1ca3H9IT?=
 =?us-ascii?q?8fvtKCnwJFdJbYppBITQ2zegcxWjhQIbxLHm3mXkPaFgwKf7nLR6rqly?=
 =?us-ascii?q?icWMso+IKhuorVjUUNOHV40Q=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:35:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1656012931;
	bh=06weyMqLvNB/6b/w8/aHLUdNvZ+9XIZUHHAKo9e9L6E=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=J+q9ppoADYhuEnfbuAUWwwVJb5odeoIbOeRKz9aJ60XoCrf1N2sUYT9ZmM+HX+JiX
	 ktKET4dKNwDZcBD4QbcvEMjsyUYPcUTGtdwdfC9HB/1GtfPq/p6dbW5w1dZN290BXM
	 wfJUr9IvJjf7ZMVDpyXWzBVIjEJS0cfhVzNR50EA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.20] ([78.49.47.129]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MActe-1nxu703dJA-00BIyC; Thu, 23
 Jun 2022 21:35:30 +0200
Message-ID: <e3432f40-8cb3-a068-0adb-6938d60c1ff0@web.de>
Date: Thu, 23 Jun 2022 21:35:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-GB
To: =?UTF-8?Q?J=c3=a9r=c3=a9my_Lefaure?= <jeremy.lefaure@netatmo.com>,
 cocci@inria.fr, kernel-janitors@vger.kernel.org
Cc: Julia Lawall <julia.lawall@inria.fr>,
 Nicolas Palix <nicolas.palix@imag.fr>
References: <AS8PR03MB76033CF2848D03651D6E189093A69@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <6aef3ee4-d934-daff-7145-73ac563d2fb4@web.de>
 <AS8PR03MB7603675681B64E5F14C1995593B39@AS8PR03MB7603.eurprd03.prod.outlook.com>
 <e887b364-7e69-267c-3a25-356bb2075699@web.de>
 <AS8PR03MB76034D043F7A3FA878E13FA093B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <AS8PR03MB76034D043F7A3FA878E13FA093B59@AS8PR03MB7603.eurprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:W86q6pRCctGdBbke54EZVw47xRj5hhhqTHPyGzUwFsf2Ux9eq4q
 +sugXvMOyhVDQe1qqFXiOJx/ORfjoFZbJySQSM7QhL3maGvuFZw6CQ+r49pSzS7a99r1kTC
 1UlCywPUWdNo/Wb+7WoVb1OmPvqpZSTehFYkynUAH0YrjXC7KIt4pcVaqPpVjHoMDCYuIIr
 cthbH/Osoh43k7ZlF2tCw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QqX9lLFzb2s=:g2SObEDSCBZziu1xEOGtkx
 VZHBGx+X5M8CZgHYEJBYsP43qYe4Uf6Z0l5kKGb4J/kT2mBk6ApMyg8btaDjq4Bv5xqGWNJZG
 kbkn002G/VYnWN43XCVFQMqclPajedEiaIu4OwYsfxKSR5SfAZghSjU8asfx6o0AhqP3Qg4O0
 L04cUhf6btCRWZBXQx+Z8aJZ9ysG4VJXQsxemHCcbvqv0l1T9NQynRPhpd9HFs2u2tQOsMBgE
 /aoCUc+sdXAt7ezLF6LSQa7oc8adPnCb2gxCmREAFTw+lD6U/RoioJ1juBw9jeny9HjmUFcQk
 mB66w6vl3D4ZkvAyQi1IfJnHUza9eXVNbFcwmsPVpT6DVDQneMtOOfWW6f1nIgeJiscZinYKB
 rTqhLFGnPXg9roMDu19H0gexxl8XP3lZh8Koy2yeydSrWmxt5LmzgBXbPEDccB1ACdQKLsoO/
 bShvCnNYvsWerKyovucKVzGJ0Wnnee7fbNl1rDqNCxjNHr/1ibBQoVq+lNxAWstCz54hhgjKG
 zSKX+KnZuBb0r4bI86ByeBAqEcOrnRl1/KcSW4h7Ve7D/DPOoYds+xxzF/urwCT7obP0p9ZXj
 QViZBShK8Vsy8jPhgbNo1IbKLANe+3UnexQd/5YaRUqyXET0pr1ywixPAvds1fQgC77XI9bQU
 eZuzSlKrxATZx3pErrIMydhxEdh2y1lc6x6s35mz9ZbzEoI3ltGKPzNSehMeGM56BPuoSt46c
 glvHMzn64rap2x3fWF2kiPRpQ8aohgun1o8G4GiXbO534S86yMmFClJg1+CLmm0p5pTohEqZk
 9ZcoSeaCWqjvU+WSbSUN2qvHh7v8iPe0vlfJFGcyZVyC0mhrZ5mtB0E4S1GXEO7+8ABMBLNMO
 CARpjGPNEm7pyLCh61Gj8T0QcVHeIppE+/Qj+ksFWYIQxmwDSKTXzFizAkgN+O16X9xGx1+re
 RI6C5qaPt5Lt6inIB5TnjepcN5chvgqpacH+H0QsTgcMVBx75eJx0H1NKmUUPp7f7YpqQQ6B0
 +3pXusr41SyP5fd67Z7sastqjG/aaKLSNdCw3QMyedZrqAEl4SLKqa0RlfCA/gvtU9FKU8gEV
 dmaLT4hZcWs8W+kxv35pF/00KrjyiLWP+F/UYN0PcGx/szUZtgwuTTy8Q==
Subject: Re: [cocci] coccinelle: Extend address test from ifaddr to every
 test expression
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 451
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/e3432f40-8cb3-a068-0adb-6938d60c1ff0%40web.de>


> For me the patch description is fine. Do you have a part of the
> description in mind that is not ok?


Yes.

I indicated by my review that explanation consequences should be taken
better into account also for the key word =E2=80=9Cevery=E2=80=9D, didn't =
I?



>> Are we looking for further collateral evolution?
> I can't speak for the coccinelle part but for this semantic patch I'm
> not planning other changes for the moment (except the improvements
> suggested during the review of the patch).


Would other contributors like to influence affected software components
any more?



> Actually I don't know if the example you presented (bool t =3D (&s);) is
> really a text expression of if it is a cast to bool. But even if it is a
> separate case, it may be possible to detect that with a semantic patch.
> But I'm not sure that it is in the scope of this patch nor the rule
> modified by this patch.


I am curious if understanding variations for such implementation details
will trigger corresponding software improvements.

Regards,
Markus
