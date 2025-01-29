Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BAA4C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 00:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FRie99yEZrhjpO7yvVL8KcKSrVHlVFaikakzBOXXXLw=;
  b=rmbJfbUbEREh55ch7w5hNgMu5Dhk11FeEyfkGxKuGl34I/CdsJV22hcF
   JVnsLIAUg+G7UW567bJ0OOb3TF/mhaULm0h6JeXF54fwsqvbNjw/VnClC
   8Cmk9A4McU5XhQtZwqyGslgbCcrWrQeS/w3fxZv/BUfhrCLW8LhBONHk4
   s=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux-foundation.org
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205474506"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 01:16:54 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A02CEE0D20; Wed, 29 Jan 2025 01:16:53 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B28E0E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 01:16:50 +0100 (CET)
IronPort-SDR: 67997371_fy77UVFbBexENFKNZrfu3T6sqoOzcFeN+w61wDEMSFq5Nxi
 cnoYR2zh4wdSTSPbHw0yV/d7sIdu4dVXyMelmOg==
X-IPAS-Result: =?us-ascii?q?A0FYAwAMcplnhVvBS5NagQmBUwKCQoFXMwQLSI1ShlNbA?=
 =?us-ascii?q?QEGgT4Di3OSJYF+DwEDAQ1EBAEBAwEDhQACinUCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAUBJhXsNSQEMAYILATOCFiwNf?=
 =?us-ascii?q?gEBAQIBOgYBATcBBAsLDjhWBhODAoJCIwO1IYE0gQGCDAEBBtwfgWQJgUiIT?=
 =?us-ascii?q?gGFa4N9eicbfYEQhD8+iweEJoNAoTZICnt4LAFVEw0KCwcFYUhIAzUMCzAVI?=
 =?us-ascii?q?4EmBTUKNzqCDWlJOgINAjWCHnyCK4IhgjuERWAvAwMDA4M2hVuCFIFlAwMWE?=
 =?us-ascii?q?AGCNXJ4HIInHUADCxgNSBEsNxQbRG4HnG88hAIygTlJgVGSbYNPAY4Sa6EDh?=
 =?us-ascii?q?CWhRk2XRJMPLodkkGqpLYFnOoFcMxoIKAiDIk8DGQ+OLQ0JiGvFCiI1PAIHC?=
 =?us-ascii?q?wEBAwmNQIJlamEBAQ?=
IronPort-PHdr: A9a23:Dxe9QhZ2mValhLZrfmr3p9//LTEg2YqcDmcuAnoPtbtCf+yZ8oj4O
 wSHvLMx1wWPBd2Qsq4Uw6qO6ua8AjVGuc7A+Fk5M7VyFDY9yv8q1zQ6B8CEDUCpZNXLVAcdW
 Pp4aVl+4nugOlJUEsutL3fbo3m18CJAUk6nbVk9Kev6AJPdgNqq3O6u5ZLTfx9IhD2gar9uM
 Rm6twrcu8cIjYd4Nqo91hTFrmZHdulV2GhkIU6fkwvm6sq/8pNv7j5ct+49+8JFTK73Y7k2Q
 btEATspNGw4+NfluR7fQwWR+3ASSH8Wkh1GAwjE6BH1QJL8uTbku+R+xSeXI9T4Qag7Vjq+4
 ahrTgToiDocOD4i7G7XkM1wg7lFrx+nuhdy3pTbYICRNPp5Y6PdYdYXTndPU8pNSyBMBJ63Y
 pARBOQdI+lXs4j9p0MPrRSgAwmsGPjvwSJMinPvwKE2z/gtHQTA0Qc9HdwBrW7Uoc37OqkST
 +640rTGwzbBYPNY3jny55THfB86rPGQX799a9bdx0szGw/biFibtIzrPymS1uQIq2WW8+xgW
 v+1i2E5pQB6vz+hxsA2ionVgYIVzE3P+CJjz4Y2Pd24TVV2YdqlEJtWqiGbOJJ6Qs0lQ2F1v
 iY116cJuYK6fCgNzpQr3Rnfa+aIc4WR5B/oSemeLytiin1/ZLK/mwi98VKmyuDkSsW63lRHo
 CVBn9XQt30D2BPe5MaER/Z54EqtxzSC2g7O5uxYIU06lbbXJoAhz7IskpcdsVjOEyvrlUnqj
 aKbckMp8fWr5eT/erjqu5CROo1uhgz8MqkigNGzDOA2PwQUW2WX5Pyw2KD/8UHlWrlHjP07n
 rPdvZzEP8gWpq20DglI2Ys97xa/Eiym0MgGknkdMVxFeROGgJbxNl3SJv3zEO2xjE62kDhxw
 vDLJr3hDYvJLnjEiLrhe7Z85FJGxAooytBf+ohUBa0fL/7pWU/+qsbYDhknPAyw2ernD8991
 owGVWKOBK+WLr/SvEeV6u8gIeSAfo0YtTbnJ/Q44/Pjg2U1lFsAcaWx2JsYcnG4HvBoI0WDZ
 nrsh88MHn0JvgomSeznk1mCUT9VZ3avUKMw/z87CIW7DYfFW4+imqCB3Ca8Hp1QfGxGDUqME
 Xjwe4WCQPgDcDiSLdN5kjwYSbihTJcs2Q+2uA/g17VnNvbU+jEftZ/70Nh6/ePSmgs29TxwF
 Mmc0mCNT2RvkWMSXTA6xqF/oUpnyleCy6d0mfJYFcZL6/NTTgg6LYLcz/B9C93qRg3BecuGR
 0qnQti9GjEwTtcxw8cUbEpnGtWiiArD3yuwDLMPmbyLHs98zqWJ8nHqOM9ng1bPzqghhkMvR
 IMbOGSmj7R+9wH7A4/PjlXfkqehb6MH2yDRsmyEyDzdkltfVVtZV6nfUG9XQ0zMsdP/rhfLT
 KerIbAmNBZRjMCFN61GY8HoilMAQ+3sboeNK1mtknu9UE7bjoiHa5DnLiBEhH214CkslgkS+
 S3DLg0iHmK6pHqYCjVyFFXpakeq8O9kqXr9QFVnhxqSYRhH0Ly4sgUQmeTaU+kai7sHoCIJr
 zRyAUb40dXLDdaJuwtmeuNbe9xuqExf2zfhvhdmdoelM7gkg1cfdwptuEa73hZvD61EkM43v
 DYkyxd0JauE0VRHMTSC0sO4IaXZf0/1+h3ncKvKwhfe3dKRr78I8+g9ok7/sRuBEFsptW5gz
 sNe3j2f64/MAQ5UVoj+Oqou3z59obySIiw05oePkGZpLbHxqTjandQgGOoizB+kOdZZKqKNU
 gHoQYUcAIC1JeomlkLMDFpMNf1O9KMyI8KtdueXkK+tMuF6mTu6jGNBqIlj20OI/iB4R6bGx
 ZEAi/2f2wKGUX/7gjLD+oj+mphBTTUTGHevjCbjGYhdb7FzeoBNDn2hYoW2yth4m5/xSitA7
 lfwYjFOkMSteBeUcxn8xVgJiRtR/iHhwHrjiW0twFRL5uKF0SfDwvrvbk8CM29PHyx5iEv0Z
 JOzl5YcVVSpaA4gkF2k41z7zu5VvvcaTSGbTEFWcizxN2wnXLG3s+/Ias1X7bsssCNKQKGyZ
 k2cRrfhohwclST5ECENoVJzPyHvoZj/kxFg3SiUL252hH7Yf9xggBnY+drQTOJQ2TxAQzN3w
 2qyZBD0L5yi+tOakI3Gu+a1Wje6V5FdRiLsyJuJqCqx4WAC7QSXp/mogZWnFAE71XS+zNx2T
 WDTqw66ZID31qO8OOYhf09yBVa65dAoUo15l4IxgtkX1x14zt2c/mICuWPyN8hLnKz5cXwBT
 CIKxNiT5xLqkEFuNXOGwYvlW27Vm5c+IYbnJDpHgWRstohDE8L2pPRckDFwo0akoA6ZevV7k
 joHiLMv5HMcn+AVqV8oxySZDKoVGBoQNijtmhKUqtGm+fwLOyDwLP7phRE4zInyadPK6htRU
 3v4ZJo4SCp578EkdUnJzGW28Yb8Pt/ZcdMUsBSQ1RbGlelcbpwrxZ9ozWJqP3zwuXo9xqs1l
 xtriNuzv5CCA2Fs+r+pRxBfKzv5bt8S/TerirxR1JXzvcjnDtB6FzMHUYG9B/urCDc6sfXhK
 hbLHjohrHuSBbvYG0mY8kgs/BetW9i7cnqQInce19BrQhKQcVdejA4jVzI/hpclFwquyZ+pY
 AJj6zsW/FK9tgpUx7ciKUzkSmmG7lTNCH98WN2FIRFR9A0H+0rFLZnU8LdoBy8Btpy58F7Qc
 CrBOkIRVjBPAxDcT1H7Yuv3voiGqrfIQLriaaGXPtDs4aRfT6vanM7ylNc+uWjccJrSdnh6U
 69ihhcFASg/RJ+fxmhHSjRLxXuRMIjE+VHlq3Yx/5nakryjWRqxt9HRU+cAaI4/o0Lq3//aZ
 ePI3HQrbmgEnpIUmy2SluBDjgdJ23k8K2GgSOZc5XaVHvCXxPMybVZTajstZpEWt/5uh1IdY
 ZyH1I+shLUl1qZnWRAbCRTggp/7P5JSfzPkbwOfVhrWOO3UKDaTm5OlJv3gLN8YxPNdsxn60
 dqCO2nkODnL1zzgVhT0dPpJkDneJxtG/oe0bhdqD2HnCtPgcByydtFt33UwxvUvi3XGOHR5U
 3A0el5RrrCW8SJTg+luU21H4H1/KOCYmiGfp+DGI5cSuPFvD2x6jeVfqHg9zrJU6mlDSpkX0
 GPKqcVypli9juSV4jx2W1xVrStRj4/Nvkh4P6jdsJ5aVjeM/R4A63mRFwVfp9ZhDY6K2egYw
 dzOmaTvbTZapouIoo1DWo6NeZnBYSNyVHihUCTZBwYEUzOxYGTWhkgG1eqX6mXQtZ8i7J7lh
 JsJTLZfEl0zDPITTEp/T7lgaN96WC0plbmDgYsG/327+VPYR91flpTGUO+CRPvoNTCVhKVFY
 B1Oxqn3Z9d2VMWzywl5Z192kZ6fUVLXRsxIqzZ9YxUcplRGtmN5U3c41gTmZxmr7XtVEuS71
 E1T6EM2caEm8zHi5E0yL1zBqX4rkUU/rt7ihCiYbD/7KKrYtW5+Dyvyqlh0PJTmRQp8cQy1m
 wpjLjiWHtq5bpNmZGstkwjBo5BCX/1RV6tJZFkX3/7FP53ANHxYqyO61QpJ4vbDBZJ+lQwsN
 5m2oCAYsz8=
IronPort-Data: A9a23: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
 gWR3kU=
IronPort-HdrOrdr: A9a23:JOQgy6p4YsR51ron1fFEkwQaV5oueYIsimQD101hICG9vPb4qy
 nIpoVj6faUskd2ZJhEo7290ca7LU80maQb3WBVB8bBYOCZghrKEGgS1/qE/9SIIUSXnYRgPO
 VbAs1D4bbLbWSS4/yV3ODBKadF/OW6
X-Talos-CUID: 9a23:cga3HWClw6dvden6Ewg993AZKvs4Szr2wnToGBCcVlpNVpTAHA==
X-Talos-MUID: 9a23:zfdMjgSR2N1GxtaYRXTpnCtAaNs1456hMwcyrYRZsviYaQJZbmI=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="107600773"
X-MGA-submission: =?us-ascii?q?MDFfzjWAwnjC2ugVh9AsMFEDIInaN2BEYjRCzX?=
 =?us-ascii?q?V78rScS3dBWXT6GmO+LSTyPndxpGEcZJqTpDP3tkKlV2JpXyRDcdSnMX?=
 =?us-ascii?q?sSADXCqnwZ5sok4JXmqiXfpC9+vNKJRKSuOO+z4JAPRScxxCrkg7WAb7?=
 =?us-ascii?q?mUIB0/ZKZLO0vH7C3dYAE7vw=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 01:16:49 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id DBB26A41602;
	Wed, 29 Jan 2025 00:14:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994C4C4CED3;
	Wed, 29 Jan 2025 00:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1738109806;
	bh=zZU6hynWCHp+6F/RCQmfqyOYkRbiqQZ0uQFQk367ytg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AS2j4JP5RIAisJwaJPGo5rdD+WQkiOVOSd2qjWS7o62PB/KfGo+AtIeEIRlVi8ca4
	 DcFpL5pMszZR4AoEDS94lZdMmpR+YhI7fvUGwBGQGj85DpwI7Ag5fgschNnRNtAEJ5
	 EXSOU+Vpu5p468XbHO3vy3GdYQe6R4CubgmVMLqk=
Date: Tue, 28 Jan 2025 16:16:43 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Yaron Avizrat <yaron.avizrat@intel.com>, Oded Gabbay
 <ogabbay@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
 <nicolas.palix@imag.fr>, James Smart <james.smart@broadcom.com>, Dick
 Kennedy <dick.kennedy@broadcom.com>, "James E.J. Bottomley"
 <James.Bottomley@HansenPartnership.com>, "Martin K. Petersen"
 <martin.petersen@oracle.com>, Jaroslav Kysela <perex@perex.cz>, Takashi
 Iwai <tiwai@suse.com>, Chris Mason <clm@fb.com>, Josef Bacik
 <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>, Ilya Dryomov
 <idryomov@gmail.com>, Dongsheng Yang <dongsheng.yang@easystack.cn>, Jens
 Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>, Damien Le Moal
 <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Carlos Maiolino
 <cem@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>, Sebastian Reichel
 <sre@kernel.org>, Keith Busch <kbusch@kernel.org>, Christoph Hellwig
 <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, Frank Li
 <Frank.Li@nxp.com>, Mark Brown <broonie@kernel.org>, Shawn Guo
 <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, Pengutronix
 Kernel Team <kernel@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Hans de Goede
 <hdegoede@redhat.com>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, Henrique de Moraes Holschuh
 <hmh@hmh.eng.br>, Selvin Xavier <selvin.xavier@broadcom.com>, Kalesh AP
 <kalesh-anakkur.purayil@broadcom.com>, Jason Gunthorpe <jgg@ziepe.ca>, Leon
 Romanovsky <leon@kernel.org>, cocci@inria.fr, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-spi@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, platform-driver-x86@vger.kernel.org,
 ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org
Message-Id: <20250128161643.289d9fe705ef2fdba0b82a52@linux-foundation.org>
In-Reply-To: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
References: <20250128-converge-secs-to-jiffies-part-two-v1-0-9a6ecf0b2308@linux.microsoft.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [PATCH 00/16] Converge on using secs_to_jiffies() part
 two
Reply-To: Andrew Morton <akpm@linux-foundation.org>
X-Loop: cocci@inria.fr
X-Sequence: 2294
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/20250128161643.289d9fe705ef2fdba0b82a52%40linux-foundation.org>

On Tue, 28 Jan 2025 18:21:45 +0000 Easwar Hariharan <eahariha@linux.microsoft.com> wrote:

> This is the second series (part 1*) that converts users of msecs_to_jiffies() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
> 
> where N is a constant or an expression, to avoid the multiplication.
> 
> The conversion is made with Coccinelle with the secs_to_jiffies() script
> in scripts/coccinelle/misc. Attention is paid to what the best change
> can be rather than restricting to what the tool provides.
> 
> Andrew has kindly agreed to take the series through mm.git modulo the
> patches maintainers want to pick through their own trees.

I added patches 2-16 to mm.git.  If any of these later get merged into
a subsystem tree, Stephen will tell us and I'll drop the mm.git copy.

