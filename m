Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F3C1C18E7C
	for <cocci@archiver.kernel.org>; Tue, 25 Feb 2025 20:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ho1p9T+EgqW5ri+TziTR9nEBpqCpp/MEy1wgOMQmOKY=;
  b=PS83QHJBoJ/hPBBPdD72dFVawA8IJc4EggyFtlL4VC2lxaNSIf927Fde
   nNG/06mW4+eQau7GZ4LAoNOBtI+kHtyiKaBW4h5PlDd5NPVJo7b8swu9v
   HB4Ff1xc10mgRJ4WMqrwsT5qpaAiBq3G6Am9qoAlzbLF0xzTtWWE5oa5A
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210044176"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:28:17 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDE11E0E33; Tue, 25 Feb 2025 21:28:04 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 3CA56E0D20
	for <cocci@sympa.inria.fr>; Tue, 25 Feb 2025 21:17:28 +0100 (CET)
IronPort-SDR: 67be2557_OYozl5lMMScn/ngl5DnwacqytAI8aW3bm74GIvlcaBQdkKM
 2kdFEqPwF/e2QjVhS7x5agTSigEeRZVH6pR50sg==
X-IPAS-Result: =?us-ascii?q?A0ELAAAjJL5ncraaTQ1aGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDgVczBwhIhFaIHYlpi2CQS4FWgUA+DwEDAU4BAgQBA?=
 =?us-ascii?q?QMEhQACixICHwYBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGA?=
 =?us-ascii?q?QIQAYEMhXsNgmIBgSRRDUgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eA?=
 =?us-ascii?q?QEeAgEDERIdAQE3AQ8ZDAImAgJGEAYBEoMCgmUGAp0sAYdgAQECiyOBMoEBg?=
 =?us-ascii?q?gwBAQaCaNk4gWUJgRouAYhOAYFsg387CYM5eicbgUlEgUqDM4QKToNGgmmCM?=
 =?us-ascii?q?4FAg2yIZp57CT+BBRwDWSwBVRMNCgsHBWRVOAMgCgsMCxIcFQIUHQ8GEARqQ?=
 =?us-ascii?q?zeCRWlJOgINAjWCHiRYgR2BDoRUhENcLwMDAwODKoI/UYJCghFxgRqJMoNjH?=
 =?us-ascii?q?UADCxgNSBEsNwYOG0MBbgegJTyEO4EOgSeUPYQajUuhb4QloWIBMqpVLodlk?=
 =?us-ascii?q?GoiqF2CGDqBXEYHIxWDIk8DGQ+IAIYhDBYWg0KPPQG8M0M1PAIHCwEBAwmFR?=
 =?us-ascii?q?gEBiiAEMIFLAQE?=
IronPort-PHdr: A9a23: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
 9yooOfyRfV/1Q==
IronPort-Data: A9a23:U69XwKCIxtguKBVW/4Tnw5YqxClBgxIJ4kV8jS/XYbTApGwgg2ABm
 jAZCDqFPf6IYGqgedl+O47jpkICsJaDm4drOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYzdJ5xYuajhJs/jZ9Us11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc52PsKlqx2NVSNm83FIId/+9bM01f5
 ONNfVjhbjjb7w636La6TPR8wMEiJ9PsJ4QRpjdryjSx4fQOGMuFHPqMvIIEmm5g3KiiHt6GD
 yYdQTdmbB3aYh1GElMWDo8u2uKpjWP4aDpWtBSeoq9fD237llUpiOS2aIWNEjCMbZx1vG2Ur
 37JxH7WJz0KGYOUyRWh1n3504cjmgugA9hOS9VU7MVChFSMz2gXIA8XUFGhqL+4jFS/UpRRM
 SQ88S0lpqka712uVtC7XhuioXfCsAR0ZjZLO+k77hydjK/V6ByeHW8KUnhKb9lOWNIKqSIC+
 HXQvo7yJQBVnry8RneY/5umgSKjJn1ARYMdXhMsQQwA6tjlhYg8iBPTU9pueJJZaPWqSFkcJ
 BjV/UADa6UvsCId60msEbn6b9+EopnPUx5z4wTcRGW+6Q1lIoWiYuRECGQ3D94ecu51rXHY5
 RDofvRyCshSV/lhcwTRGI0w8EmBvartDdEmvXZhHoM66xOm8GO5cIZb7VlWfRg1appUIWCwP
 BSN6Wu9AaO/2lP7NcebhKrhWqwXIVTIS4W8CZg4k/ISPMcsLFPZoEmCm2bJhT6zzxhx+U3AB
 XtrWZ33VypFYUiW5D+3TP0ayrgl2mg1wnnLLa0XPDz2uYdykEW9F+xfWHPQNb9R0U9xiFyJm
 /5FKdCwwglSOMWmJHS/HXg7dAxSdSBT6FGfg5A/S9Nv1SI9RDl9Vq6Pnul+E2Gn9owM/tr1E
 riGchcw4DLCabfvcG1ms1g6MOuxD6Vs52k2JzItNluO0n0uK9TnpqQGepd9OfFt+OV/xLQmB
 7MIaueRMMRpEz7nwjU6aYWijYpAcB/wuxmCERD4axcCfrlhZTfzxPnaQiXV+hIjMA+LpOolg
 rj51grkUZsJHAtjK8DNacOQ9VC6vFlDuediR0HOHIV3fRz0wdNINSer3/o7CJwOI0+bxx+x9
 QWfMTEHr8bj/q4399jog/ifjoGLSuFRIGtTL1P5352XaxbI23WF+pBRdtqIcRT2dnLGyI/7a
 cp7l/jDYeA6xnBUuI9CIpNX5KMZ5eq3gYRFzw5hTU75X37yBpxOenC5jNRy7ItTzbpkuCyza
 EKF2v9eHZ6rYMrFMlogFDAJX9S598M/u2fttKwuAUDA+iVI0qKNUhxSMzmymSVtFuZJH71/8
 9gxmvw9ylKZsQUrAOaknyoP1mWrL148aYsFmKweIrfWjlsM9gkfT73aUjT78bOeWeVqa0MKG
 AKZtIDGprZbx3fBTUYNKGjw7bJjoqoK6T93zw4kBlWWm9D6qOc98z9P/B8WEAlE7BV1/NhiG
 2psNkdaIbiCzzh1jvdHXWupShNLXi/B3knX1VEytXb4SnOwXTfnN1wNOueq/WEY/VlDfzNdw
 qqq9Wb9XRvuf+DzxiEXS2c8j9DCFPtfrhbjnuKjFOS7R6gKWyLv2PKSVDBZuinZDtMUr2yZg
 +tTpcJbS7DxbAwUqI0FU7iq76waEk24FTYTUMNa3f07GE/Hc2uPwhmIEUe6f/1NK9Hs8UOVD
 89PJNpFZy+h1RSh/ywqOqoRH4BaxPIZxsIOWrfOF140t7GyqjlIspWJ0gPcgGQtYctlkOdjC
 4f3Wg+BLFethipvqzeQlPVHB2u2WslbRQve2Ovuzv4FOaheu85RcGYz8ICOgVOrDCVd8Sm5h
 jjzP53t87Q6yKBHvZfdLaFYNgDldfLxTLup9S6wgfRvbPTOE9zHiF5Mp3K6Iw1pG6obAPJpp
 7K0re+tjV/kvak3YU/diZKuB6lE3uTsfet1Y+bcDmhWojuGY+DouyA8wmGfLYdbtf9g/eyle
 leIU9SxftsrRNtt/n1ZRCxAGRI7Ca6sTKPfiQ6ijvaLUD4x7BfmKY65yHrXcm1rTC8EFJngA
 AvSufz1xNR5rpxJNSAUFcNdHJ50D1/ya5QIL+Srm2GjMVCppVeetp/Jtxkqs2jLA0bZNvfK2
 8vOQxymeSmivK3N8spijLVzmR8qF1d4v/g7exMM2txxig3iNlU8E8YmDcwkBK1XwwvI77OpV
 AGVOSFmQW/4UC9feBrx3MX7U03NTqYSM9P+PXoy81nSdy6yA5iaDaB88jt7pU17YSbn0PrtP
 OR2Fqcc5fRt6soBqScvCv2HbSNPwvLc22JO/EH2icvpBBgCR74N0RSN2SJTADffHZileFrjf
 AAIqaJsGSlXinId1e5kenhICFccvTj1yC4vYzvJy9Ha02le5PMV0+XxYokfzZVaBPnn59cyq
 bffQ2qL/nDQ330Yo6wyvNw1x6RzDJpn2yR8wLDLHWUvok171ojr0w7uU8bCoAHONTOzy2/gq
 wQ=
IronPort-HdrOrdr: A9a23:fQTxy6EpSc80m+mQpLqE0seALOsnbusQ8zAXPo5KOHpom6uj5q
 OTdZUgtSMd6l4qMk3I/OrsBEDuexzhHPJOjbX5eI3SODUO21HIEGgd1/qB/9SIIUSXndK1l5
 0QFpSWY+efMbEVt7ec3ODBKadY/OW6
X-Talos-CUID: 9a23:z8egjWPB4wViIu5DdgM+1RMPOvwfXHz0w3LVKmOKJXd4V+jA
X-Talos-MUID: 9a23:2++AlQRuxroC7lMZRXS1pBNJOM507J+0J2UhgbhZsMmrEQh/bmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210043070"
X-MGA-submission: =?us-ascii?q?MDEfxiwq5MWppZP0FCz3Nw45CG0/3aQ3pUU+iP?=
 =?us-ascii?q?eWsfjUmJ6mIp/eGMHqK/0EHoB5i6ulGmOZMkepRE4CP4fNEig07OJaFg?=
 =?us-ascii?q?HyXN5GqczLopo5wAUCLHIrPyhLto+Q5EUz28/N0AMhFfGaGY6cRaiSXy?=
 =?us-ascii?q?2i+u3Y20v9Hw+qTrMQ1cCAEw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 25 Feb 2025 21:17:27 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2959A206ADE3;
	Tue, 25 Feb 2025 12:17:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2959A206ADE3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740514642;
	bh=ho1p9T+EgqW5ri+TziTR9nEBpqCpp/MEy1wgOMQmOKY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=G9tFph11Fv4vR4hm6scJe7fKKxiuuiHwgM5dUJa9rcD0K6DazlUazY3gwz7F4CLY0
	 n+x+Wn7TB7JHxrIDrlWf5FrXGMkHRBYm+gG42H30XGodgn7ZLnsU4+T9bbNcR1j28/
	 i/uGrozSqAqsXekEKsNJKYeqEFawNklWw2krWhmI=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 25 Feb 2025 20:17:29 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88@linux.microsoft.com>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
To: Andrew Morton <akpm@linux-foundation.org>, 
 Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay <ogabbay@kernel.org>, 
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>, 
 James Smart <james.smart@broadcom.com>, 
 Dick Kennedy <dick.kennedy@broadcom.com>, 
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, 
 David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>, 
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens Axboe <axboe@kernel.dk>, 
 Xiubo Li <xiubli@redhat.com>, Damien Le Moal <dlemoal@kernel.org>, 
 Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>, 
 "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel <sre@kernel.org>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, Frank Li <Frank.Li@nxp.com>, 
 Mark Brown <broonie@kernel.org>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, 
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
 Hans de Goede <hdegoede@redhat.com>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>, 
 Selvin Xavier <selvin.xavier@broadcom.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>
Cc: cocci@inria.fr, linux-kernel@vger.kernel.org, 
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org, 
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org, 
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org, 
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org, 
 linux-spi@vger.kernel.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org, 
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org, 
 Easwar Hariharan <eahariha@linux.microsoft.com>
X-Mailer: b4 0.14.2
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] [PATCH v3 15/16] platform/x86: thinkpad_acpi: convert
 timeouts to secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2446
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/20250225-converge-secs-to-jiffies-part-two-v3-15-a43967e36c88%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication

This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
the following Coccinelle rules:

@depends on patch@
expression E;
@@

-msecs_to_jiffies
+secs_to_jiffies
(E
- * \( 1000 \| MSEC_PER_SEC \)
)

Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 drivers/platform/x86/thinkpad_acpi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index ab1cade5ef231e9a9a520bc0cca82384c911a331..d269e791f7fbc2a8ccf96f28cb476beccb57c9a7 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -8512,7 +8512,7 @@ static void fan_watchdog_reset(void)
 	if (fan_watchdog_maxinterval > 0 &&
 	    tpacpi_lifecycle != TPACPI_LIFE_EXITING)
 		mod_delayed_work(tpacpi_wq, &fan_watchdog_task,
-			msecs_to_jiffies(fan_watchdog_maxinterval * 1000));
+			secs_to_jiffies(fan_watchdog_maxinterval));
 	else
 		cancel_delayed_work(&fan_watchdog_task);
 }

-- 
2.43.0

