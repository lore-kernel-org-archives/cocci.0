Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02A40C77B76
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 17:01:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:cc:references:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FPIjcwbce8liIONqeZ07cCqTC+X+DboDmmyYHdyQ24M=;
  b=AXVcLWq0LlzWqM7rvVYDL+cGG4HOjYecVHQnZT46JoROgZvur1Ud/T9x
   zvdKMq+GmbNAKiOqor4YyBGUB6yu8RE5DJ7z25u4bFK7MyMUPJ4SJcg/P
   UE28wY1n9uZjXPm+EZXAwTAn3+Wa9PoaO2STpTTxTIKBeLiAIYaLctT6N
   I=;
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
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103476306"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 19:01:35 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F71BE033A; Mon, 17 Apr 2023 19:01:36 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 319CDE00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:01:33 +0200 (CEST)
IronPort-SDR: 643d7b6b_3eWMD5XtnHGLnzBiMGijwhLhXW+fFzzhCfPSxW9boGfJQLo
 p7Vp8XBvsGuzCemqaT4mDNaysP9ebhYEEjqMYlA==
X-IPAS-Result: =?us-ascii?q?A0FAAABhej1khwQP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TwGAQELAYItdVYvBAtGhFORAjGEMI5shGeEA4FWgUA+DwEDAQ07BgECBAEBA?=
 =?us-ascii?q?wQ4hEcChTwCHQcBBDEIDgECBAEBAQEDAgMBAQEBAQEDAQEFAQEBAgEBAgQFA?=
 =?us-ascii?q?QIQAQEBGgkXBw4QBSKFaA2CNykBEWSBCAEBAQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBEgINOj4DAyMEGQEBESYBDxkGBgImAgJXBgEMBgIBAYJ6AYInAQMxBwytU?=
 =?us-ascii?q?H8zgQGCCAEBBoFAAYEimSgfLCJUgV4DBoEULQGMSz+DNnonD4FVRIE8glNvi?=
 =?us-ascii?q?B+CZ5oWRYE0doEgDoE8gQQCCQIRa4EQCGs5gUBAAg1kCw5vgUljTB+BXAQCF?=
 =?us-ascii?q?EQOHCUEDgMZKx1AAgELOzo9NQYDCx8GVmsCCSMREwUDCxUqRwQIOAYcNBECC?=
 =?us-ascii?q?A8SDyxEDEI3MxMGBVcBKQsOEQNNgSEfBgQkZ4EBBgEmJJ8gAYENLFCBesM+N?=
 =?us-ascii?q?AeCK4FWgVkMig2VAAYTL5cJDgaSJS6XSSCLRIFvmkyBZQE3gVwzGiSDNk8DG?=
 =?us-ascii?q?Q+OIBmEDIRhimc/NAI7AgcBCgEBAwmFRgEBgyYtgioBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 R3yN5E+0tVdAn2keArL2sGGvA==
IronPort-HdrOrdr: A9a23:jUVWHa4Wr1Eyul/GiQPXwBzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhX4tKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkYNDSaNzhHZKjBkWyFOuoBhP+a7auvmeDS9Ht1Sxp2ApsQkjuRRjz7LqVsLjM2fqbR+a
 DsnPauLFebE0gqUg==
X-Talos-CUID: 9a23:1YJfImMpBtv66O5DXBF6xWQbFJ0eYnD67XbRP2KyTl13R+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AbS2m3A6C0mrkLDQeyAixKXnfxowy8ZyPWXwSga4?=
 =?us-ascii?q?Huse1DnRLKRa3sTWOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103476295"
X-MGA-submission: =?us-ascii?q?MDFY+6xadZniSHMZ/n+qEXUY+7oc2kHjqQb2Pl?=
 =?us-ascii?q?CbyvEAU6MOoTg64ULL72K6y+mPKa9m30S/YxRcVVJl3WmSfILL59liFT?=
 =?us-ascii?q?3kh+tgAtVuFlKFhlbk5hbddkeGzwQVOaKxsWIyKNSKfFy/XOT+Tw/n2v?=
 =?us-ascii?q?Hg8jyQ3yffIf6YElORJvWMCA=3D=3D?=
Received: from mout.web.de ([212.227.15.4])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:01:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681750891; i=markus.elfring@web.de;
	bh=hhUr9izmXDATi20AFbENnNRpzAy3yd45X+OoUWLLADc=;
	h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
	b=C40cWGDjPOTc2ib2Kpoa+Z+LsUuX7/p4VLWPAkbUK8HiCyunA0uoTsIsLb1v8tWAN
	 fX781z4yH7NJ/OiVX0lzJHYFwVzDaQ2g25rVvdQk23SUzKfQhIa3yEwWxZyaFmVnlN
	 2m6lF4AkRdTHOlmP2oW/hfin2HebQASc7AQIxCJKJb7CKtJad8kP0dZp5jLo8QaNaK
	 lC2aikGQDuRM6ccZ2baw2rN+0WH3oFdUhlZqQPBYuRFSNORy+e2DPbeAqDIW84eCEe
	 aVVEUDP8G7lFArsV7RCwZ7zXIyvNstE1bDqmoK0HHtFZPlWZUHzjOYPGQXunF9ppO5
	 rltM3s+1zWYRA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MaHSb-1prMUQ3Lwj-00W9Ra; Mon, 17
 Apr 2023 19:01:31 +0200
Message-ID: <390c7d54-b027-c6d2-5fb9-d4bfed2e83b1@web.de>
Date: Mon, 17 Apr 2023 19:01:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel-janitors@vger.kernel.org,
 linux-media@vger.kernel.org, Devin Heitmueller
 <dheitmueller@kernellabs.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
 <8153cc88-2cea-0528-9d54-bda72cbaac5b@xs4all.nl>
 <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
In-Reply-To: <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qbjBePQJlRKO58yADg8jRWraJx/OJfTDpXPr7qBLkj4sFdBU2MC
 dkuKjWAPmG7DVDNgdnSv9/1sSbNmRMTJH9snbkoKZ6wHK8i6p2qI0KPAAUlmEYVSDxUhtd0
 +l/DXWmCIPAzbLr63lU52b2d9OOioxjbycqZGZaSoYdabqF+mqAMPTmRnYSIBPuwVTwbfrp
 jD6HIUNyrIuiM7uRQ4PlQ==
UI-OutboundReport: notjunk:1;M01:P0:8tiWwe+xUhw=;kjQ/KvnpjL4S7KeZFaeWrPm25gd
 vg1LngtFSQnhCII6v1L3ZmdFjjjCn8GFFWGFNjHHvI8nlmOfHqjViUJFkB6COtwmXbAse/s06
 R+mQ1rPRT5o9+6i/yQoocVZKwUzch31MZg2znoS/tVF4AiPWCW9zQhcdJHlOYt/8GRXZNZQqD
 qeE6jdeZOvXNGvsAdlrILdTRjz3qDPMlVf+ur/Mo+tfLXGU4yBwZgNjM22iGEFdhFb5wLtaSI
 ennVvCpDZtUVj0fO+QIhLIopesgKNVc9on5kqJodYWAlr/H90cknL/JJuTG+aTj9iVhpaN3fb
 OxiItr84OF+eoZQXfW6kYk4Dw1sYTeAMMSg1Ao2zdcWKjtvzIN94/MhUQJ/F8hkX31zNu8rws
 SYrRe9OilK9ttDQn3X+YUnM13FuyNfqMvrub8VDZl+8yhqO2uoE6PBcNj77OdWrHjv4amD/R6
 sZLmBNx+iTizFiBPSrJzT8mQHYU8GRlSRSo76cbfyNXocZzmnJNckBz2v4IxV2jlWiOfgIele
 J62fFh4UBCvtFa+6/DUecPZx8Q9MnnNVxVME4HGiNnQmYpUXLp++D2ZQTnmWX2ttqlggeRFRq
 VA70Ka1BWC0ZoYHRkk9W8123kJSX12BQr+e5SzdKVDPNuPJ+K9BdE59sNmZLa03vQtxrwC6S/
 EMrxk3YcPk8EMAgG+Zn2z1Oo8+lA52KeIOHgHFw+UadlX5I0ozb2z6VkZm6fg+GhJDmruTbwJ
 DR5piXVoX4MRy32DaJ20ZmMq4G61hKedzwHKkeZbFwuHYOoWuAt7UhJ3RIEdi4CFf3PRgPwYT
 K6lloZyvv4igF3LYoFHa4bDXRrbXXkUL6HTNwvzlIBUezEhAGj66fwGy+VSYm4JKVQpmKUhmM
 Grre6kOvi4Elf1zOaFTwufeEXT5JYYiF+iMCcvtZH9ha6YAMnle7mv3ph
Subject: [cocci] [PATCH 1/5] media: au0828: Delete a null pointer check in
 au0828_isoc_copy()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1077
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/390c7d54-b027-c6d2-5fb9-d4bfed2e83b1%40web.de>

Date: Mon, 17 Apr 2023 16:05:04 +0200

An extra null pointer check became unwanted for the input parameter
validation in the implementation of the function =E2=80=9Cau0828_isoc_copy=
=E2=80=9D.
Thus omit an if statement at the beginning.

Link: https://lore.kernel.org/kernel-janitors/8153cc88-2cea-0528-9d54-bda7=
2cbaac5b@xs4all.nl/
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
=2D--
 drivers/media/usb/au0828/au0828-video.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/media/usb/au0828/au0828-video.c b/drivers/media/usb/a=
u0828/au0828-video.c
index fd9fc43d47e0..ce25ddc7fc7b 100644
=2D-- a/drivers/media/usb/au0828/au0828-video.c
+++ b/drivers/media/usb/au0828/au0828-video.c
@@ -500,9 +500,6 @@ static inline int au0828_isoc_copy(struct au0828_dev *=
dev, struct urb *urb)
 	unsigned int vbi_field_size;
 	unsigned int remain, lencopy;

-	if (!dev)
-		return 0;
-
 	if (test_bit(DEV_DISCONNECTED, &dev->dev_state) ||
 	    test_bit(DEV_MISCONFIGURED, &dev->dev_state))
 		return 0;
=2D-
2.40.0

