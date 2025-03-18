Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D016BC282EC
	for <cocci@archiver.kernel.org>; Tue, 18 Mar 2025 13:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vhf2yFdvIdkY0ES4ZMw6oAyokhaSIllpoSKNDnt86Ig=;
  b=pQ8Hcu0Ddv5tA4Dx85rxgi+3oF5KYvGzO8gkMXyLjfodFm5bpwLuuWDD
   PeOgy9R301ANm4AGtVm9r6Xo/ggs4YWiOgpkdu+KKgJ2J9Qow5RBzBoWc
   cKV4HPp5Cx/scUuy5Kfmt75yQbTVZ0OeY9NMtBtPeIjTh8m25SbOa8dik
   A=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@bootlin.com
X-IronPort-AV: E=Sophos;i="6.14,257,1736809200"; 
   d="scan'208";a="213497932"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 18 Mar 2025 14:45:46 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 74B5FE0D2B; Tue, 18 Mar 2025 14:45:45 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2975DE0260
	for <cocci@sympa.inria.fr>; Tue, 18 Mar 2025 11:26:54 +0100 (CET)
IronPort-SDR: 67d94a6e_GPMHvl3KUkuc8oG6phQNbc5z4oqHMq0w2l7HfBCYsmZYUzU
 X2Vql9pwN/TgZKESnL7vPp90gdP3BX2z+qIprFA==
X-IPAS-Result: =?us-ascii?q?A0ERAABWSdlnjsa3RtlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVY0BwhIhFaRdJg4hVyBfg8BAwENRAQBAQMEhQACix8CHwYBB?=
 =?us-ascii?q?DEIDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO?=
 =?us-ascii?q?4V7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg19AQEBAQIBIx0BATcBBAsLFAEFA?=
 =?us-ascii?q?gUhAgIPAUYGE4MCgjEDDiMHrF96gTKBAYIMAQEG2yciV4FlCYEaLgGFbIJjA?=
 =?us-ascii?q?YVsG4NieicPgVVEhD8+hEODW4JpgjNFgSQBg0CqF1J7HANZLAFVExcLBwWBK?=
 =?us-ascii?q?UMDgQ8jgSIFNAoqDjgpgWNpSToCDQI1ght8giiCF4I3hD6EQYVQghGBXQMDI?=
 =?us-ascii?q?gGCMG91HIQ+PoRkLVCBTR1AAwttPTcUGwajTDqERYF/ggSTDZNrnx00B4Qeg?=
 =?us-ascii?q?V0GDKAmg3ATjQmZSy6HZTWQNqkzgWkBNy6BLjMaI4M3TwMZD44hGR+DQrckR?=
 =?us-ascii?q?TI8AgcBCgEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
 yY=
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:U52wla8lnptRBoaKTnluk+DeI+orL9Y04lQ7vn2ZOiYlEfBw9v
 rDoB1/73TJYVkqNk3I9erwXZVoIkm8yXcW2+Ys1N6ZNWGN1VdARLsSircKqAeQfxEWmNQtt5
 uIP5IfNDWmZmIK9PoStzPIdeod/A==
X-Talos-CUID: 9a23:Ctw7xGxrRj0n7WWcBpW3BgUOHM83KVfS9U3NPkWVIDc1ebe4S3+prfY=
X-Talos-MUID: 9a23:NQkQxwSiWe7CVPEYRXTz1SFnbdtwzZ6rGU0/upldv9GULBxvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,256,1736809200"; 
   d="scan'208";a="213446553"
X-MGA-submission: =?us-ascii?q?MDGwXWBmXhwTEX0FlAL3TjFMMT6XhCJnaAam1l?=
 =?us-ascii?q?xtQXjEuipoehQnLOH/GDxpHnDaUMkO/2cu6tYdLlQBevum3RuDnkPWGa?=
 =?us-ascii?q?7wUwyCoV6/2YVm0+wD0i4xcgO73UyaZGdntUAJUWAif8LM5ReYRgFQ5g?=
 =?us-ascii?q?SJP1LgYA41O19CA2/+3ngzKA=3D=3D?=
Received: from relay6-d.mail.gandi.net ([217.70.183.198])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 11:26:54 +0100
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2C7C7432BB;
	Tue, 18 Mar 2025 10:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1742293613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhf2yFdvIdkY0ES4ZMw6oAyokhaSIllpoSKNDnt86Ig=;
	b=T1EftWyoVjXgeLianlFmLfDtluRNEmcDGeGL3vyDI0F43X+fsDh2QFvgrqMHqFkUfyoOIG
	KC7yRHopGDGNJysHPfKOImMqYdWoQO7b3d4L8/LzxOv8r+Jpo3suCYM64AO8Bz94VopMim
	BlRwcr1RBMXwoSDry2U/nTRDVBwxbFoWZUrps5//lXMDp+ZnbwQiQW1pK0h7GcI0DckOwC
	+6sr4srtwAGGlp0pJyqAxHDi8U8l+4LFsUJCX9vPcCeGdgJFCc5yMMudvrvK6tVbRUZMRF
	idDa3yIvviCCJikq0xWc9pkA4Vj4ivNC6h5rtkd6B2hTxaQosZmzJ6OraaWynw==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org,  linux-mtd@lists.infradead.org,
  Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  cocci@inria.fr,  LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de> (Markus Elfring's
	message of "Tue, 4 Mar 2025 20:21:53 +0100")
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
	<3675f707-bff0-3caf-29a2-b99e5b9c6554@web.de>
	<d7b2c8ac-e052-4b93-964b-4cc58a459ba0@web.de>
User-Agent: mu4e 1.12.7; emacs 29.4
Date: Tue, 18 Mar 2025 11:26:52 +0100
Message-ID: <87o6xyab2r.fsf@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugedvvddtucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuifetpfffkfdpucggtfgfnhhsuhgsshgtrhhisggvnecuuegrihhlohhuthemuceftddunecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtgfesthhqredttderjeenucfhrhhomhepofhiqhhuvghlucftrgihnhgrlhcuoehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpeffgefhjedtfeeigeduudekudejkedtiefhleelueeiueevheekvdeludehiedvfeenucfkphepledtrdekledrudeifedruddvjeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeeltddrkeelrdduieefrdduvdejpdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpehmihhquhgvlhdrrhgrhihnrghlsegsohhothhlihhnrdgtohhmpdhnsggprhgtphhtthhopeejpdhrtghpthhtohepofgrrhhkuhhsrdfglhhfrhhinhhgseifvggsrdguvgdprhgtphhtthhopehkvghrnhgvlhdqjhgrnhhithhorhhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqmhhtugeslhhishhtshdrihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehrihgthhgrrhgusehnohgurdgrthdprhgtphhtthhopehvihhgnhgvshhhrhesthhirdgtohhmp
 dhrtghpthhtoheptghotggtihesihhnrhhirgdrfhhrpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: miquel.raynal@bootlin.com
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] mtd: cfi_cmdset_0001: Fix exception
 handling in cfi_intelext_setup()
Reply-To: Miquel Raynal <miquel.raynal@bootlin.com>
X-Loop: cocci@inria.fr
X-Sequence: 2620
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/87o6xyab2r.fsf%40bootlin.com>

Hi,

On 04/03/2025 at 20:21:53 +01, Markus Elfring <Markus.Elfring@web.de> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Tue, 21 Mar 2023 20:13:51 +0100
>
> The label =E2=80=9Csetup_err=E2=80=9D was used to jump to another pointer=
 check despite of
> the detail in the implementation of the function =E2=80=9Ccfi_intelext_se=
tup=E2=80=9D
> that it was determined already that a corresponding variable contained
> a null pointer because of a failed memory allocation.

Can you please rephrase the commit log? It is super hard to understand.

Thanks,
Miqu=C3=A8l
