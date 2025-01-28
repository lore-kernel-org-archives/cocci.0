Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E0B5C0218A
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 18:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:date:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/EWqXlZOyaOm4g59VS89I2uqnGTUPl37w71b9X7s02o=;
  b=cc4SMgdUoAZE4mCFjByHCKlBj3UJWlCG0RZO7COLKBcM22oo8sEgyEpm
   jaTp5WApX/i9VxvMNsdzqsaMwnI6WGo6BXnbAmlGCW+G/mVp4dCPkbTON
   WVTL9/mXDORKPbzKCvKihuT7zWSKe3885ppSnjBUYjlVDm66YHVrC31RI
   4=;
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
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205449957"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 19:22:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43958E0D7F; Tue, 28 Jan 2025 19:22:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id E8D92E0D1E
	for <cocci@sympa.inria.fr>; Tue, 28 Jan 2025 19:22:01 +0100 (CET)
IronPort-SDR: 67992049_ezedAm953D8bitl2O0SujiQu+pTiKMvSrVNe1nUJvhYbxyq
 Cxj7NSvwL+t/sQijrKwdP+mTaEUcFrl1fG2hZKQ==
X-IPAS-Result: =?us-ascii?q?A0EgAACtH5lncraaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T8HAQELAYJDgVczBwhIhFaIHZVJkE+BVhSBLD4PAQMBTgECBAEBAwSBTIM0A?=
 =?us-ascii?q?op1Ah8GAQQwCQ4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAGBD?=
 =?us-ascii?q?IV7DYJiAYEkUQ1IAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEQINXgEBHgIBA?=
 =?us-ascii?q?xESBBkBATcBDxkMAiYCAkYQBgESgwKCZQYCojIBh2ABAQKJcoExfzOBAYIMA?=
 =?us-ascii?q?QEGgmfZOIFkCYEaLgGITQGBbIN/OwmDOXonG4FJRIEVNYMzhARUg0aCaYIzg?=
 =?us-ascii?q?UWDb4ZmhCyCbJMfCT+BBRwDWSwBVRMNCgsHBWRVOAMgCwsMCxQcFQIUHQ8GE?=
 =?us-ascii?q?ARtRDeCR2lJNwINAjWCHiRYgR2BDoRchEVgLwMDAwODOIJFVIJEghR6gReGQ?=
 =?us-ascii?q?h1AAwsYDUgRLDcGDhtDAW4HnF08hAOBDoEnFpQmhBmNSaFuhCWhYAEyqlMuh?=
 =?us-ascii?q?2SQaiKoWoIYOoFcRgcjFYMiTwMZD4gAhiGDeo89AboLQzU8AgcLAQEDCYVGA?=
 =?us-ascii?q?QGKHQQwgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:2WIlSamn+jfepGthPgp6EJno5gwaIkRdPkR7XQ2eYbSJt1+Wr1Gzt
 xJKXmyFPv2LZWv2etskbN+/p08H75DTmtJnQQA9+StkRVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvymTrSs1hlZHWdMUD0mhQ9oh9k3i4tphcnRKw6Ws
 LsemeWGULOe82Ayazl8B56r8ks14ayr4mNA4jTSWNgS1LPgvylNZH4gDfrpR5fIatE8NvK3Q
 e/F0Ia48gvxl/v6Io7Nfh7TKyXmc5aKVeS8oiI+t5uK3nCukhcPPpMTb5LwX6v4ZwKhxLidw
 P0V3XC5pJxA0qfkwIzxWDEAe81y0DEvFBYq7hFTvOTKp3AqfUcAzN1UIQJoH7cb9NpNDCJN+
 tEEcB01dDq60rfeLLKTEoGAh+wnLc/2LMUau3p6yireA+pgSpfGK0nIzYYDmmhvwJkTQbCHN
 5BxhTlHNHwsZzVCM1ceEpM+lc+sh3/iY3tdqVmPorEw7XSVxwt0uFToGIONJYHaFZ8IwC50o
 ErH3n3dMx8lLuWdxDbf8CuW2fL1tDzkDdd6+LqQraUw3AL7KnYoIBkfSlK/pdGri0u0QdsZK
 koO+yNoo7Ja3EesRdL8dwappWaN+B8aQdtZVeMggDxh0YLQ4gCEFi4BTzVbb8chutNwTjsvv
 rOUoz/3LQZC8+O3c3GTyo2Z7jC9FDRNAFcYTxZRGGPp/OLfiI00ixvOSPNqH6i0ksD5FFnML
 9ai83VWa1I70pBj6kmrwW0rlQ5AsXQgc+LYzgHWWH+1qAZ4b5SifIum9R7Q6vMowGelorup4
 iZsdyu2tblm4XSxeMqlGrRl8FaBvKntDdEkqQQzd6TNDhz0k5JZQahe4StlOGBiOdsedDnib
 Sf74FwKtMcLZiT0MPMrOepd7vjGK4CwRLwJsdiEPrJzjmRZKlTdpkmCmGbMgT+wyBRyzcnTx
 7/HL5n9Uy9y5VtbIMqeHLxHjeBDKtEWwGLYX5fgyBq7mbGZfmb9dFv2GArmUwzN14va+1+92
 4gEaKO3J+B3CbGWjt//qNJLdQhiwLlSLcyelvG7gcbaclA2Qjt6VKaIqV7jEqQ895loei7z1
 inVcidlJJDX3xUr8C3TMig9OoD8F41yt2w6NiEKNFOlkSprK4W24atVM9N9cbA7/aYxhbR5X
 tsUSfWmW/5vczXg/yhCTJ/fqIc5Sg+nqzjTNAWYYR8+XaVaeSr3xvHecDDCygwyHwuslM5no
 7SfxgLRGpUCYAJ5DffpUvGkznLvnH0NgOh0YRfsJ4BLSR7O7oMwein9paI1KZtUKDHo5DiT5
 yCJCzg2+MjPpI4U9oHSpKam9o2GLcp3LnB4LUL6s4mkEDb8xXWy57NAXMKjXyHvZEmt9IqMP
 exqnuzBatsZl1N0gq9AOrdMz5NmweDwprVfnz9WLF+SY3uFUrpfc2S7h+9Rvahwx5hciwu8e
 mSL3vJ4YbypGsfUIGQ9FTofTNao9K8rw2HJzPEPPk/Fyjd9/+OHXWVsLhC8snFhA4UvArw14
 9UKmZAw0BO+uCoII9zdryFz9kawFFIifZgjlKknBN7MtlJ25HBEOYfRGw3n0qGpMt9sCHQnE
 hWQpajFholf+Hb8TmoOJSDN8NdZ1Lszu0Fs7V4dJl62tMLPqd0p0TZwrzkmbARn4S9W8uB0O
 2JEM1B5FaqT9QhshsNGDnKmQTMZIBi/5EbK6kAokVfBRBKCTV39L2waOMeM8nsG8mlaQCNpw
 bGAxEvhUhfoZMvUzAJrfWJE8tvNFcdQ8C/Gk+CZR/W1JYEwO2fZs/X/dFg2pAvCKuJvok/+/
 M1B3vt6MI//Pg4u+5wLMZGQj+kseUrVNV55YK9T+Y0SFjvhYxC04z+FLn6xdu5rJ/Dn9UyZC
 dRkFvlQViaRhTq/kTQGOZEie7NEvuYlxN4nSIPZIWQrt7i+rD0wlLny8iP4pnEgQvQwsMIbB
 77SSQm/ET2rtSMJo1POkchKAXrnQN8mYAan4vu53t9UHL0+scZtU3oI7J2Kg1uvPjFaoi2k5
 DH4W/eOzshJ65hdoI/3I6ASWyS2MYzSUcqLwiCSsvNPT8jGDpqXuihItlDYGRVcZp0PadJOi
 IXX4cLW3VzEjpkyQWv2i5mMLIgXxMSQDc58ENP7E2lepgSGAPTT2hok/3uqDLB0i/Zf25WXf
 BS5Y86OatIlYddR63lLYSx4ERxGKaDIQor/hCG69dKgNwM81FHZEdaZ6nPZV2FXWSsWMZnYC
 AWvmfKP5MhdnbtcFi0/GPBqLJ9pEmDNAZJ8WYXKigCZKW20jnepmLjoz0Mg4A6WLEi0Kp/x5
 JadSyXucBi3hrrz8+hYlI5PpTwSMmd2hLghX0Aa+uMusQuAMkw9Eb0/P6kFW7ZuqQ6j5KGgM
 XuJJCEnBD7mVDtJTQTk7Z6xFk2DD+gJIZHiKiZv40qQbDysCZidBKd6sB1t+GpyZiCp2dTPx
 QvyIZEsFkPZLlBVqecvCjiTheZh2+Ocw3MD40fmlMLuRR0ZBN3mEVR/SRFVW3Wv/97lzS32y
 aodHAiog31XjWb1EMB9azhQGRoDuyjowSluZiCKqDoak5vO1/VOkZUTJMmquoDur602yHomQ
 XLxWnvL5mGdwHsIvqU1/dkuhMeYzB5N8teSdMfeeOHZo018BqnL8S/PcerjgfzOIDJiLm4=
IronPort-HdrOrdr: A9a23:XxeKsatOoRY5MRECBJFpHwq/7skDTNV00zEX/kB9WHVpmwKj5q
 aTdZMgpHzJYVcqOE3J+7i7UpVoJEmwyXcb2+Ys1NuZMDUO/VHYSL2KjrGC/9SfIVydygc178
 4JGJSWSueAaGSS5vyV3ODXKadG/DD+ytHQudvj
X-Talos-CUID: =?us-ascii?q?9a23=3AlqTGw2jpXPGhq045Bk7y7vqUojJuSFCeklXqIEG?=
 =?us-ascii?q?EM2sqS7K4VQe9wLlOqp87?=
X-Talos-MUID: 9a23:iHijcwRRastGMP60RXTtpShGBclX+Z2sBUxXk8w85NS+HDNvbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107588256"
X-MGA-submission: =?us-ascii?q?MDG5prLuaR/Hc90UAUzKeGKF9kOCRtrdjxeZwM?=
 =?us-ascii?q?iHJK+ObFwEDmlcdP1fvjaeVwMKAn/G/GHgE6ZxtpKryDyu1/2fqdnnFv?=
 =?us-ascii?q?s9KFac519TEO4w7t3gTvQ/0pB610OV28spCzIGrX+7ASW83HvA5IHxK1?=
 =?us-ascii?q?Eb78RrjZ/HqAn2oIVQ6nJf/w=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail3-smtp-sop.national.inria.fr with ESMTP; 28 Jan 2025 19:22:01 +0100
Received: from eahariha-devbox.internal.cloudapp.net (unknown [40.91.112.99])
	by linux.microsoft.com (Postfix) with ESMTPSA id EE39B203717A;
	Tue, 28 Jan 2025 10:21:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE39B203717A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738088518;
	bh=/EWqXlZOyaOm4g59VS89I2uqnGTUPl37w71b9X7s02o=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qifPuciLp6zYrAFWIRB9lwfoiORDq5Znn6Y1MZg447mRd521rUeXZX4ssO4a3zPi0
	 yIeJx+BuhYKeboGXzAtI2rktLS4vmUes2TtMU1tgSIC4k2CZaQfPx4pU+CBe+A2DVU
	 iFfDndGnNrrUEfvChktnE0Qma+AmmL/g2NBtRY68=
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Date: Tue, 28 Jan 2025 18:21:49 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
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
Subject: [cocci] [PATCH 04/16] ALSA: ac97: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2276
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128-converge-secs-to-jiffies-part-two-v1-4-9a6ecf0b2308%40linux.microsoft.com>

Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
secs_to_jiffies().  As the value here is a multiple of 1000, use
secs_to_jiffies() instead of msecs_to_jiffies to avoid the multiplication.

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
 sound/pci/ac97/ac97_codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/ac97/ac97_codec.c b/sound/pci/ac97/ac97_codec.c
index 6e710dce5c6068ec20c2da751b6f5372ad1df211..88ac37739b7653f69af430dd0163f5ab4ddf0d0c 100644
--- a/sound/pci/ac97/ac97_codec.c
+++ b/sound/pci/ac97/ac97_codec.c
@@ -2461,8 +2461,7 @@ int snd_ac97_update_power(struct snd_ac97 *ac97, int reg, int powerup)
 		 * (for avoiding loud click noises for many (OSS) apps
 		 *  that open/close frequently)
 		 */
-		schedule_delayed_work(&ac97->power_work,
-				      msecs_to_jiffies(power_save * 1000));
+		schedule_delayed_work(&ac97->power_work, secs_to_jiffies(power_save));
 	else {
 		cancel_delayed_work(&ac97->power_work);
 		update_power_regs(ac97);

-- 
2.43.0

