Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27154C02193
	for <cocci@archiver.kernel.org>; Mon,  3 Feb 2025 07:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=pL2jDbwM2tnoDPxkIcout16iJtvsCV65sn/2QOSZBsY=;
  b=Arj/35NUzslKvp3tRxwv1F7T+FCBGOs7YHfQHcxKAGqBUhy7udXHSaVX
   F0hBFkqMtIgIDB3x0oi6SxqFPLtC3uYrJqmt+snEufI4msmNnOFQm1oFr
   P/Rhizh3GjfiyX+KPo0baAL9zMXWHcx5XhwqZVdSpOyZEaijIEKB6/W6q
   Q=;
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
X-IronPort-AV: E=Sophos;i="6.13,255,1732575600"; 
   d="scan'208";a="206174563"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Feb 2025 08:23:11 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40177E0260; Mon,  3 Feb 2025 08:23:11 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39B59E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Feb 2025 08:23:10 +0100 (CET)
IronPort-SDR: 67a06edd_aLpcZGtvKHVaDhZYRCzaAREBA/bIFvGj0CKc3/11xLok/Ie
 dHZjBdt7e5yxIWCXYeF85A+LGqJ6E6R3RcYKocg==
X-IPAS-Result: =?us-ascii?q?A0GSAADtbaBng07ASNlaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAQGCQmIbWjMEC0iEVo9PgXQwaYNSjxCIdYFWgX4PAQMBDT0EAQIEA?=
 =?us-ascii?q?QEDBIIMgnQCin0CHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQEBOgcOO4V7DUkBEAGCBwGBJIEmAQEBAQEBAQEBAQEBHQINOkQBA?=
 =?us-ascii?q?QECASMdAQERJgEECwkCDgwCJgICVgYBFAEBgn4Bgi8BAw4jBw2WBZxFgTKBA?=
 =?us-ascii?q?YIMAQEGgmjXcx8sIleBZQMGgRouAYVqgmMBhWs7hDwnD4FVRIE8gwM+gkoXB?=
 =?us-ascii?q?BiBRoNbgmmCM4QlJWeMTIRBhF+MZFJ7HANZLAFVExcLBwWBKUgDKjYxI4EmB?=
 =?us-ascii?q?TUKNzqCDWlJOgINAjWCHiRYgitrBAWBLYI7hENfLwMDAwODNoVdghKBXwMDF?=
 =?us-ascii?q?hABgyV4HIM2HUACAQttPTcJCxsGPZ4qPYRLfSCCHZZLAa9ONAeCOIFmgWMMi?=
 =?us-ascii?q?imVMwYTL5dEDgaSey6HZJBqIo1ilVyFToFuBC+BXDMaJIM2TwMZD44hGYQUh?=
 =?us-ascii?q?GDDCEI1AgEBOAIHAQoBAQMJhUYBAYhhggiBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:hgf1cqMIAtpbocBcThWjsMiBIKoaSvp037Dk7TEVdfUnSL3+qy
 nIpoVi6faUskdpZJhEo7u90ca7Lk80maQU3WBVB8bFYOCEggWVxeNZgbcKqgeIc0DDH6xmpM
 NdmsNFeb7N5DZB/KTHyTWZV/A93dKA7KekvuvGyWxxJDsaFp2Ioz0ZNu6BeHcGPzWu6KBJbq
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:L5LPUGAsdtYB2Z36E3Y5qXNEXd4gS2bm833rDG6DETo4RITAHA==
X-Talos-MUID: 9a23:2Lo3xQrBkmRR+qtLPGgezy9hL8VF+62uMUkqrK8ggeCtaRNCOijI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,255,1732575600"; 
   d="scan'208";a="206174558"
X-MGA-submission: =?us-ascii?q?MDHazVW6pEGIQvKOTFwLr36o2e1xXwWhwtnknu?=
 =?us-ascii?q?MkEpsYi9JyuUwy6ze/XDHhntL6haysR0MG39DAd6dnTVke68+rVjCAlr?=
 =?us-ascii?q?NTMITmGLA1UtTnay375HH0p4qHoE0y7YDwSJ7Z0ViweFdydNuD02YXRf?=
 =?us-ascii?q?tCDSys+wEU6hxnNaFDtheoSw=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2025 08:23:09 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1738567338; x=1739172138; i=markus.elfring@web.de;
	bh=pL2jDbwM2tnoDPxkIcout16iJtvsCV65sn/2QOSZBsY=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:From:Subject:To:
	 Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=tPjM0uN4I/GdAFp31++PG26z4Vto4PmHwwKCB+iJ4HIbRwu5joJXwvRpwBps1Vk5
	 BsR+TBN1/gKQUNN6ZGncM+nvFp4kAyRHyxYGr6ANswR2VhX+Sk5BqHpIiTEwtoqV7
	 CYW45ezkvs7otl2YrqdQlFPAZudQCI5wDpQYRd/iR3EILMUFNGcUyJSc7iDH9JyOD
	 FbUpses7uVefH5D3IUULvsEYhibYuqoSt+k+uleYwhAQhNpVKuTLS08qGiRMwzU3I
	 whTVatnsqGvJVTwBvBpdjC7mCZHIZcsSw0Qqlo/EOLaII4kL6LfqeSBy35+o25YKu
	 kUv/J7OgQXFBoRqg1w==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MjgX3-1szyFN23FD-00mF3n; Mon, 03
 Feb 2025 08:22:18 +0100
Message-ID: <875fe1a2-64b4-43f9-8b6c-60e416a37248@web.de>
Date: Mon, 3 Feb 2025 08:22:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Markus Elfring <Markus.Elfring@web.de>
To: Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>,
 Ricardo Ribalda <ribalda@chromium.org>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <e06cb7f5-7aa3-464c-a8a1-2c7b9b6a29eb@web.de>
 <632be2db-78d2-4249-92f0-3f60e0373172@linux.microsoft.com>
Content-Language: en-GB
In-Reply-To: <632be2db-78d2-4249-92f0-3f60e0373172@linux.microsoft.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:unmzcva3DfFDe8J5T/SEse13ECLrm00SFr+jMbswdVLKuVhkuYO
 KrTlmHqHj2q9ogvXNY+OT9rpa/y77P4OKcbhTRE4HQfNnHl3vyWWfzK02lPKs/doF/0oo/N
 zaSBPOg0Tas1K5KCmS6LhNSs0R2vs1xLG29Gypkmwc3S031NZBDDMgkSSAGcQ2a7o9N0Sjo
 97PGMtERfjxkxxcBQ4+cg==
UI-OutboundReport: notjunk:1;M01:P0:ttbGuD59yWE=;aR8uoScoWimrSRCmRkUV4SeMiC4
 W79hOF4H0lhnQHYtzx3m5sNeqoeEjllyRz8YO7qpX8lmmz5+tS5bf6f8vLVqYn9Kaf48xHqma
 GMO3bXWom5xZ+oVyIxDcLJs8p7PgYEA5ypLybnd2/T+GawWIBGs+YXCKBHx9HvPqPogF+ZWbt
 K+TyhUDO5bQsBtbetxS3RKRmFHZaezGpeiwamE4tJBcayt8rdci1cnRAVxZjRrnyUeMDPgD6w
 WKKXvMYQI9xNIms2eXtV9M1bxbS+lhSfb6gN7tJf2LwY4iDuINHUwQnKRfA26lORiGW/UmxpA
 VDJglYJvc0HJJqymSDraa9W3b84J+5STNVqd3FDiOGXm1u1Lg5SvWgA1viCB3U/T6eNlmBKxu
 cW3HuColf7JWTbOCtYKQMticsxdqTUl6/icidZDIKeZA/6BTvCAJ5yo10i++PE5kYqE0mQ1ho
 4NVa2X6CB+FFnhhsQwwWTKFynfvg6dK/P1RIrFw78t5WsC8zz4qm64j7mnJS57vOm+HlNeNlJ
 dATJc1VHQDMoj9hjzdFzfzgZw9h5kyLYh8oVruDNFJ/+FH75gEuWoZlsU8KTOZQFV7EoxkSYe
 EVfenvSMPnmSzjQa+vNyzYbKtqQOPF88CdXdnAAym8guV56rCHkNBsyBuIPwADo10ZAjBpNzA
 OBRBkYWMqMkvqRqoLGiggpeqewsL9YdiEBa4oesyjAGQIw7IJ8/0snpG+f+cuMaO7kmaB6nHE
 nOpJS6Z9qzdfoJVXgs+47u+CzVBhVhWLqb0XCPk9jzzEHfYLkrIHTUIhakYc7nZUEAyJDC73r
 /hzw3PToNCTxBrUrwiTLOAoOxpa5fcHyJWusNq5FrbAxgole7higv+1sBb8NprFHptypkZ+Cw
 iq1xF2BAP1xbwfSfH760NHJ4EMEjOMI/iDzAJwPxQkxSlaDBQ4Gbv5ujQYBd3YMxgiuIGsl/w
 MdFuwIfMQU5oEMCItKFmMAIf7k7pEPQrOuKnG6AZ/LH/H2vUdfQfPyq8wJxV64EFZr9eSy6wJ
 Oy+t8DI1kdV301z/zAZQ8OpU2xnB8IxTLqrcbF63n+gYPUELXtWaXOoIbr5o0TxUA7XsBRCAL
 PYOoStHMrzPoz4tMq6bqU3gJQfZq4+hT0/1xGvJHF3EYYHdBGWrL7T8ngj9APgUClmkiUid9u
 qhcbZXpp66SsJcS9vzL/rjOnWJmMD3M+Ha1/NMDr7Hx2giHnnM35m2TcteG0N0JcefSzkj9ds
 f+5nMopNsnV7A3egbviqSJLT+UcbhaOvEXNf4avchAw4jPQ3zsTkczrYbZ8buav0UwNGXIMsG
 NwU97T/pGW1qLPWQZzQJs0EPaXBDrr4upn8u/GPLFGYGs6cf+BXQ4GT4mOQgByfpkCi
Subject: Re: [cocci] [01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2328
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/875fe1a2-64b4-43f9-8b6c-60e416a37248%40web.de>

> As it stands, I'll fix up the current rules in v2 following your
> suggestion to keep the multiplication in each line to allow Coccinelle
> to use the commutativity properties and find more instances.

Corresponding software development challenges can eventually be clarified =
further.


> I'll refrain from implementing the report mode until current instances
> have been fixed because of the issue we have already seen[1] with CI
> builds being broken. I would not want to break a strict CI build that is
> looking for coccicheck REPORT to return 0 results.

You got into the mood to test support for an information in the software d=
ocumentation.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.13#n92
=E2=80=9C=E2=80=A6
Note that not all semantic patches implement all modes.
=E2=80=A6=E2=80=9D

Regards,
Markus
