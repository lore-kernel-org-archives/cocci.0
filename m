Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D1AFC77B76
	for <cocci@archiver.kernel.org>; Mon, 17 Apr 2023 17:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=L6N+6eC0dUoEXNRJhBmXzAaSfKfs5dR4mQ7BJbl+g9w=;
  b=bCYjF6qLdgYyu0MRD4YFXRUVr3UN1voFJHVGx/mVsEc3NL9noSe6xe7D
   FF2N7FqNgsVbsWPRegzpjCDcb9iCrSdCh54mvG80YWvQKhHWIGrN0EGYb
   QAsyFgL639XPYWHs71gI6enQym0anwzewzeqEm9T1+CbYTgl5VJMm7UXE
   0=;
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
   d="scan'208";a="103476092"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 17 Apr 2023 19:00:26 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4878AE0297; Mon, 17 Apr 2023 19:00:27 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E973CE00A8
	for <cocci@sympa.inria.fr>; Mon, 17 Apr 2023 19:00:21 +0200 (CEST)
IronPort-SDR: 643d7b24_DLhv4uR37JmjR0RsgQdGdhoF3XQ1ZRGEIcylXXrt119rp20
 sdQ50+wa+GCD7EeMg652eWb0tm0oMbEiph9yxBQ==
X-IPAS-Result: =?us-ascii?q?A0EqAABhej1khwMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?TsHAQELAYItgUsvBAtGhFOIHohkLgOEMIV1gTmHPohqgVaBQD4PAQMBDUEBA?=
 =?us-ascii?q?gQBAQMEOIRHAoU8Ah0HAQQwCQ4BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBA?=
 =?us-ascii?q?QIEBQECEAEBARoJFwcOEAUihWgNgjcpARFkgQgBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBARICRz4DAyMdAQERJgEPGQYGAiYCAlcGAQwIAQGCeoIoAQMxB61cg?=
 =?us-ascii?q?TKBAYIIAQEGnAsfLCJUgV4JgRQtAY0KgzZ6Jw+BVUSBPINChAuEFIJnmluBN?=
 =?us-ascii?q?HaBIA6BPIEEAgkCEWuBEAhrgXlAAg1kCw5vgUljTIF7BAIURA4cJQQOAxkrH?=
 =?us-ascii?q?UACAQs7Oj01BgMLHwZWawIJIxETBQMLFSpHBAg4Bhw0EQIIDxIPLEQMQjczE?=
 =?us-ascii?q?wZcASkLDhEDTYFGBIELgQEGASYknx8BAXoTlV+cVJQBNAeCK4FWgVkMnw0GE?=
 =?us-ascii?q?y+DahOTDA4GkiWXdyCCLqAwhSGBYzqBXDMaJIM2TwMZD44gGYQMj0g/ND0CB?=
 =?us-ascii?q?wsBAQMJhUYBAYMkglkBAQ?=
IronPort-PHdr: A9a23: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
 xZamdvF
IronPort-Data: A9a23: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
 vlGkkDN0tONLl2FiArdCjFXQQuq+x8C+k81xA==
IronPort-HdrOrdr: A9a23:kx3MG6ucNrMBNtZWmleqUmv37skDotV00zEX/kB9WHVpmwKj5q
 WTdYcgpHzJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfDxHZK3BgDVQfexQouWvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:/yRKJ2CAdFePXob6EwRpr0NKCtEAS33+l2eNGwj/KW84SpTAHA==
X-Talos-MUID: 9a23:kaEvvQrCuat59Bn5K7MezzRJGJZjoJmMMUUig8pFverHbChABA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.99,204,1677538800"; 
   d="scan'208";a="103476081"
X-MGA-submission: =?us-ascii?q?MDGJh1cpn09pSxK6Wlz7WBaAcZBqzglxrhzgPq?=
 =?us-ascii?q?NT9USHAsUplIUuXPeBl9jze4E9/4BLUv/DRe8QqVH5IG12/UxR+WYDfi?=
 =?us-ascii?q?h0Z7XbbRJAWmiiGbPQI8Lc7am4wwazQwH6GCl1WR2Kg2cVrVRykFVbaZ?=
 =?us-ascii?q?RhA2Y0FZLc6TFCDQaC0fLDEw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2023 19:00:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681750820; i=markus.elfring@web.de;
	bh=uEwotuSiB3diIrYf0Ahg++3SB98gJubeC4c5dyE6x+I=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=kaNHH2K8V4XHFZ73+RSQ/dgM67oppePDn7rno+KAWKEh2XfjbiUJTvYcdU6PviRgD
	 7B/Bu8Yw8Dm056hXbN6iaDa/uQjxtFNu13Ng4XtPESrKtgg+ZbHlu060VqSsqy/0hB
	 +vVz5oCrf/GbOsKJr+UtmmeSNVkmUk6vj3U+Cb7IOOBzcOOdjnatPsBnDSAQdUXrMG
	 mcLTfep+xqs8lTWkWtSIY5TOlSkNTdKSOfywJAP6qXh8DJq+yv4P27Sp1ylLWg98S1
	 lRY6SJpEnyp2Iea5ZCXIVKLiJsZCGEIoYP6+LV+BjRqlz1EVXlBShKE+G9Qsg1WZvF
	 CQtNtO+i8LZOA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.85.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MlsON-1qFEAx0mSR-00j5Lt; Mon, 17
 Apr 2023 19:00:20 +0200
Message-ID: <bd1878d9-7c10-084f-cf73-711b577af5eb@web.de>
Date: Mon, 17 Apr 2023 19:00:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-GB
To: Hans Verkuil <hverkuil-cisco@xs4all.nl>, kernel-janitors@vger.kernel.org,
 linux-media@vger.kernel.org, Devin Heitmueller
 <dheitmueller@kernellabs.com>, Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <622ed461-059b-455f-8a7b-7200a834bdc4@web.de>
 <8153cc88-2cea-0528-9d54-bda72cbaac5b@xs4all.nl>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <8153cc88-2cea-0528-9d54-bda72cbaac5b@xs4all.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fJ2XAC7iQ7teyqrkORGhXbT+OfbS/OEhwoItNf7ztFAtVzcfb89
 0CSCwBRH9DlGz6PBrUZNkYXb0LnJN+LJsG2WAY+idFtpTc/iTrksnY876qTEPwWxdlb3bHv
 xtqARrg9p4vAdrtv9F86f+HevCXfbpakRsvlR2PjtnwUBQz/TX3ukP98idP7/FOeZN5tH+7
 xTqxGqcZ7deA+Mn8YcJUw==
UI-OutboundReport: notjunk:1;M01:P0:YdTIt0h5/B4=;OaOGis3rM8gSxzGPLOg0n7xsyY4
 REjEG1St/DXy1xu/1BxrH8HV0py70CxEXIuGv6x5/L0wdATlfOCfPxM2kfMIWGEMmtsNeiCx5
 PbXyfbq4QFU/An6cVC44HWwYUS2XvWiUHVvmWs6NHke7HyLBjpcujdenfL4dttXUy8ZCyFe0U
 a5OxJnTs/Lu5Gti3hUfTOdoomMVea7IsaNoenr5q/ECp7N8UMGFBX96eatC14ySTQtL68Z1UG
 AvU0+jnIIel68agzEVn+A8BwFo1fF2BTEFJz0bQ2ezc1+4T/R4wG3HO0qGTUhQCwJ+PAJypRp
 GQn/YOS18BaXZS5wvf6GrB1cC9JCFiNgGXfjRea5JN0J03C5vCkSZxJeaGgk3sygjoJKVow7D
 /JpFja8t0+pgc4G8CKtOY3V210NU51nEM9J9uEJOl29/NyERjYOORlPVVnxFZ3+2NlXP6TcUW
 Vf4PhfbGwtGSBrkPJqdhyiU3OOsjIkuIUmgCrA1iNzfLS3SCX+mMSD2TLxcYKNjQXMKbWCwhT
 2wQ6H1Jqs/Ze5aAH+41sFQegO8kGxJ4J2F9rsrEPvaFpYm9L4IVVaq9ENVpG+U0qYHRjTsMkV
 Vg6TBuh0TLwAcZL9A3Mai2fKqSUspA6Q/GHka0Qi9weYjVdT3gfn5Bhy5eS/dmBLgEIJM9Iw1
 odLyhnx3yZ+ErfiZ71IAj56Xu4wXIN547QiEF33OGec+59d0v46VkY6XD5a0DnjA0QFoE9bUY
 SRQCWKlbvJ19qkgapSH6xMR/vyw2tc0TERc1DLAioAkM/0clQj80DtIFej3YOXoXeo9giw2ec
 aOi+x3tTg88Zb1Bc2dRIlNcAkCUU/R/gEsqsfPxdtu0rVCcyZwvikS1vViwv+TVrAtg1ejaHt
 1/7thHzWDXlII+t6ahi3RzkmWh23RyxS/Tr6Q9QPpPcMV9X1aTAVnR0mH
Subject: [cocci] [PATCH 0/5] media: au0828: Adjustments for four function
 implementations
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1076
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/bd1878d9-7c10-084f-cf73-711b577af5eb%40web.de>

Date: Mon, 17 Apr 2023 18:32:28 +0200

The deletion of an if statement was requested by Hans Verkuil.
This update triggered further change possibilities.

Markus Elfring (5):
  Delete a null pointer check in au0828_isoc_copy()
  Move variable assignments behind condition checks in au0828_isoc_copy()
  Return a status code only as a constant in au0828_isoc_copy()
  Delete an unnecessary return statement in two functions
  Use common error handling code in au0828_init_isoc()

 drivers/media/usb/au0828/au0828-video.c | 40 +++++++++++--------------
 1 file changed, 17 insertions(+), 23 deletions(-)

=2D-
2.40.0

