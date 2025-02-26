Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02EB9C021B8
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=NxcvzVHb6QGpX5vTNhZx0AQWnfqeFMf8w/1AJrtRJqA=;
  b=LVto8/6uZmSru4k4W2pjyQIf/H/b0im8c6D91oISomSqu2IaNfzZ5RGX
   +Xn2p2jJDabiFiI8GNUaOvfL5pkvsvt1DapVhLVOXEsuKuUhsNwZj/le9
   s8ZMOWRlKeqP/lY6s++RK3vNJVPXBcc5DEB29DzW115jgiKpQA2DYUB5t
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="asc'?scan'208";a="211070282"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:59:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09681E1775; Tue,  4 Mar 2025 10:58:48 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 71F95E0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 12:30:10 +0100 (CET)
IronPort-SDR: 67befb41_PVV729V3q+NDOzgiAUtAQmu+sJZIBe5RKBLMzbJM+EH6cIk
 yK9AqMACcCWBuXNEb3ryXI22hn1M+hRqlg7rHZg==
X-IPAS-Result: =?us-ascii?q?A0FNAAAv+r5nj9lUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDgVczBAtIjVKGU10GgREwi3OSIYF+CAcBAwEIBUQEAQEDBIUAA?=
 =?us-ascii?q?osSAh4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBA?=
 =?us-ascii?q?QEBATkFSYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBA0ABATcBDwsOC?=
 =?us-ascii?q?i5WBoMVAYJkA699gTSBAYIMAQEG3X4HCYFIAYFXhmwLAYFahBGDfXonG32BE?=
 =?us-ascii?q?IE8CwOCdT6LB4Qhgz6oEVKBFwNZLAFVExcLBwVhSEgDgQ8jgSMFNAo3OoILa?=
 =?us-ascii?q?Uk6Ag0CNYIefIIragQFgSqCN4RDXC8DAwMDgyqFUoIRgWADAxYPAYIwb3cch?=
 =?us-ascii?q?H+EBR1AAgELbT03CQsbnVEafINOhDaCPIFPkm6DUAGwA4QlhG+cXgYPBBsUg?=
 =?us-ascii?q?3ATjQeGOpMRLodlkGqpMIFpAjaBXDMaCCgIgyJPAxkPjiEZiHTFUkM1PAIHC?=
 =?us-ascii?q?wEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23:SSVpehy0LIX/87bXCzLEwFBlVkEcU1XcAAcZ59Idhq5Udez7ptK+Z
 xaZva0m3AOVAc3y0LFttan/i+PaZSQ4+5GPsXQPItRndiQuroEopTEmG9OPEkbhLfTnPGQQF
 cVGU0J5rTngaRAGUMnxaEfPrXKs8DUcBgvwNRZvJuTyB4Xek9m72/q99pDdfQlEniaxba99I
 Bi1ogjcucYbipZ+J6gszRfEvnRHd+NKyG1yIl6dgwjy7dqq8p559CRQtfMh98peXqj/Yq81U
 79WAik4Pm4s/MHkugXNQgWJ5nsHT2UZiQFIDBTf7BH7RZj+rC33vfdg1SaAPM32Sbc0WSm+7
 6puVRTlhjsLOyI//WrKkcF7kr5Vrwy9qBx+247UYZ+aNPxifqPGYNgWQXNNUttNWyBdB4+xa
 ZYEAegcMuZCt4TzqVsAowWgCAexB+3vxDBHiWPr0qI4yOkhHh3K0RY6Et4SrHjYstP4P7oSX
 +Cvy6nIyC3OYfRM1jfn64jDbw0soeuLXbN+d8ra1E4iGBjfjlWXrozlOTKV2foWvmiY8eVgT
 +SvhHAjqw1rpTiv3Mgsh5DPi4kIxV/K6T93z5wpJd2kVkF7e9ikHYNRuiyaM4Z7TN8uTmF1t
 Cg017ALtp+2cicExpk7yRPSduKKfoeI7x7/SeudPDN1iG5ldrywmhq8/1Ssx/DgW8S01ltBs
 ylLksHUu3wQ2RHe7tKLRuZ/80qiwzqC1A/e5vtaLUwpl6fXM4MtzqIsmpYJs0nOHjX6lUHog
 KOMdkgp+e6l4Pn5b7Xiu5+cLJN0hR/kMqozm8y+APo3PxASU2Wd5O+yzqfs/VfjT7VPlvA2k
 rfWsJTdJckDu6G5DQFU3pw46xa4EjemysgXkmcdIFJGZh2HlY7pNE/KIPziCve/mVusnC9qx
 /DAILLhHo3AImXNnbrlZ7px9kxRxQkpwd1c6J9YEK8NLO/xV0PpsdzXFB45Mwi6w+b9D9V90
 5sTVnmVAq+eN6PSt16I6fw0LumPeoAVojD9JOYh5/L0in85g1AdcbGv3ZQMcH+4BOhpI12FY
 XrwhdcMCXkGshIkTOP2kF2CTSJTZ3GqUqI4/D46BpipDYPHRo22gb2B3SK7EYZMZm9cEFyME
 HHod5+FW/gWci6SLNVhniQeVbe9U48hyQ2utAjixrV7Kerb5jEXtZP42dhu5+zTkAky+iZuA
 8Sc1WGNVWB0kXkSSz84xqAs6XB6n3qKyrdxmbR4HMZS5/pTWwFyYZPVz+VgCtD7cgbAeMqZD
 lOnSc+hGjY/UpQ6xNpYMGhnHND3qxnZ3GKAGbgKkfTfDoYz9aTd0lDyKtx7xnKA07Mu2Qp1C
 vBTPHGr0/YsvzPYAJTExgDAz/7CncU02SfM8D3G1m+SpARCVwU2V6zZXHcZb0+QrNLj50qEQ
 aX9Qa8/PF5nzsiPYrBPdsWvlU9PEf35P9PYYm+ZmGqqAxuMgLSWY9miYH0TiR3UE1NMiAUP5
 TCDPAk6CD2mpjfUFjtpE1PiS0Dh6+9zrDW8VEBnhxqSYRhH0Ly4sgUQmeTaS/4X2eccvzw9r
 jxvAFun997YFJyboBd7d6gaYt4n5lpDk2XDuGSRJ7SGKKZvzh4begVz5Qb10glvT59Hmo4sp
 W8rywx7LeSZ1klAfnWWx8K4PLqfMWT08B21DsyekljDzNab/LsO4/Ukuh3iug+uDE8r73Rg1
 ZFczXKd4pzACAdaX4j2Vw478B1zpreSZSdYhcuc32drNq+1vxfB1sgvCe9jzQyvPp9ePK6CC
 A7uApgCHcH9YOcumlWvclcFJLULr/9yZpz2MavanvTyY7UF/nrul2lM7YFj31jZ8iN9TrSNx
 JMZ27SC2QDBUT7gjVCnu8SxmIZeZDhUEHDsrEqsTINXeKB2ep4GTGm0JMjijN9kgJnrWnNw9
 1O5AV4CnsizdlDBCj61lR0VzkkRrXG9zGGy1TtzlTAkhqmSxirDx6LlbhVNaSZbAWJli1nrO
 429idsXCVOpYwYenxyg/U/mxqJfqcyTNkHrSFxTN2jzJmBmCO6rs6aaJtRI49UuuDlWV+K1Z
 RabTKT8ql0UyXGrE2xbzTE9Pzak3/ex1xZgj2WbLXtbr3fDf8x0gxDF65TQSOVQ0TwPWCRjw
 WCMVx7lYInvrYnSzc6c+umlH3qsTJhSbTXmwebi/GOg6GtmDAf+1/G/l9v7EBQrhCry1t1kT
 yLN/173Zojm0bj/MPoyJxI5Qgaju4wqRscky9Rj4fNYkWIXjZiU43cdxGL6MNEBnLn7cGJIX
 zkAhdjc/Ani3kRnaHOP3YPwEHuHka4DL5G3ZH0b3iUl4oVEEqCRufZOhyxypFu1hQHce/5wm
 nEa0/Rkuxt4y6kZ/REgyCmQGOVYF1NfOirtmjyL4sq4oaERY3ygO+v4xA91mtavC6uHqwdXV
 SPie5ssKiR36912LFPG1HCgj+OsMMmVd98YsQeY1gvRl+UAYoxkjeIE3GA0cXK4p3AuzPQ3y
 ABjzY3v9pbSMH1jpcfbSlZZLmGnOplVoGyr1P0P2J/Kh8iuBskzQ25aGsK3HbT4THRI7KuvN
 h7SQmRg9zHHQfyBTUnAtSIE5zrOC8z5bi3KYiVBi4o5AkTAbE1H3FJNAGp8wcN/T1Hxgp24O
 EZhumJIuQS+80MRjL4ubUSjNwWX7AawNmVtF8LZdkEKqFsfvQGOaISI5+Z3VUm057WHqwqAY
 iyebgVMVyQSX1CcQkrkNf+o7MXB9O6RAqy/KeHPaPOAs74WUfDA3p+p3oZ8mlTEfsySInlvC
 eE60UtfTDh4HcregTAGVy0QkWrEcceaoB62/iA/oNq49bznXwfm5I3HDLU3U50n4xetnaKKL
 PKdng51JykezZQR33TFjrsSxlgfj2dpbTbsWbUMuCjRTb7Bz69aCxlIDkE7fMBM7q86wkxMI
 ZuC0YKzj+EoyK5pTQ0cCg+E+Inhf8EBLmCjOUmSAU+KMO7DPjjX24TtZqj6T7RMjeJSvhn2u
 DCBEkalMC7Q8luhHx2pL+xIizmWeRJEv4ToOBx3Dm/lTd/OaRChNtJzyzoszvdn4xGCfX5ZK
 jV6f05X+/eI6jhEh/xkB2FbxnZrMq+fnDuD5OSeKZsMt/ZvRCNumKgJhRZyg6sQ5yZCSvtvn
 SLUpdM7uFCqnN6EzT9/WQZPoDJG7GpklUZvI6PU8t9HQ3mWpXrlDE2cBQtMvNx4ENbi/aNd0
 N7CkOT0MjgQq7o8GOMfCtLSJcbBN2AuY0KBJQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:gisvgKr17YYoMPVayHDldo0aV5u1L9V00zEX/kB9WHVpm5Oj+v
 xGzc5w6farsl0ssSkb6La90dq7MArhHP9OkP8s1NKZMDUO11HYSL2KgbGC/9SCIVy2ygc+79
 YGT0EWMrSZYjZHZK3BkWqF+qMbsby6GdeT9IXjJhlWLT1CWuVF1UNUGwybGkp5SE1tHpwiDq
 eR4cJBun6JZWkXRt7TPAhPY8Hz4/nw0L72ax8PABAqrCOUiymz1bL8Gx+Emj8DTjJ0x6s4+2
 StqX2y2kzjiYD39vbv7R6d031koqqu9jKFPr3MtiEhEEShtu9vXvUgZ1TNhkF3nAjl0idTrD
 CFmWZaAy000QKYQoj9m2qR5+HtvQxekUPK2BuWh2Durtf+Qy9/A81dhZhBeh+c8EY4uspguZ
 g7ql5xmqAnfi8oph6NleTgRlVvjA65sHAimekcgzhWVpYfcqZYqcga8FlOGJkNESrm4MR/ed
 Mee/309bJTaxeXfnrZtm5gzJilWWkyBA6PRgwHttaO2zZbkXhlxw8TxdAZnH0H6JUhIqM0k9
 jsI+BtjvVDX8UWZaVyCKMIRta2EHXERVbWPGebMT3cZdE60rL22u/KCZkOlZ+XkcYzvecPcb
 z6ISxliVI=
X-Talos-CUID: 9a23:zerTTW/pZ3JUvO+/hByVv34+H8x/LkWa9mXZP1aBCiFkUJ2wdFDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AkaV4Qg866EX4RBwpBvYqPQqQf/9p37WJKF8kq5E?=
 =?us-ascii?q?Di+6rJHZaGzeSzzviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="asc'?scan'208";a="210153534"
X-MGA-submission: =?us-ascii?q?MDEly/Dowar8VRtHoYBJZiuf7MqgGJXTcKWrB3?=
 =?us-ascii?q?BgHusywDjWeh/ql1cVBy+foXhPCHRtaqZFF3mNM9FeZ0L2vSoC+eZrNu?=
 =?us-ascii?q?Sz7D3n3TPbSm+RW9KWJ11WC0IyfAOXPwN4ZKWoQRoFuCmLtGOoOLqlSt?=
 =?us-ascii?q?nehBVOejl8aRtCw7CvocIAIA=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 12:30:09 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 975A25C273B;
	Wed, 26 Feb 2025 11:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC63AC4CED6;
	Wed, 26 Feb 2025 11:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740569407;
	bh=9WiEqRQ0WC4TcHNEk0++D2oF9/1toQwtlnkrdN1ISFg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIUlTfK2pXqaUDMpw5RIIHnVeByfDlzQfBY3+0E8d5BdAX+TUTVNIwrKJgP/FaBgf
	 IjKKuUXeG5l9Ew8YeRaCGxVo6aYi0aUIrGzgwgY4+2DWcarIPntGz/9GLbyfVSNYfO
	 SW67yeYI3cR0fo8n3xv0/29uJIe3dVQR5PiV8qSEWeCXl+fwqnxdcjjE7DRmUVfiOS
	 9ThhnWpo2ZcFcSSUl0fMoM6tREGrNbzEDH/ikx2VuLf8tYWdUKO61yIk6vUlP6vZME
	 uzwqRVd6q4FA9sQCc3I/OUPF+zTBTE5BD6JsPh7tFiinI8MhEHoSIxhQ9UdEv6t4h/
	 T5prmsk09BN7w==
Date: Wed, 26 Feb 2025 11:29:53 +0000
From: Mark Brown <broonie@kernel.org>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Yaron Avizrat <yaron.avizrat@intel.com>,
	Oded Gabbay <ogabbay@kernel.org>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>,
	James Smart <james.smart@broadcom.com>,
	Dick Kennedy <dick.kennedy@broadcom.com>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>, Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	Jens Axboe <axboe@kernel.dk>, Xiubo Li <xiubli@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Sebastian Reichel <sre@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
	Frank Li <Frank.Li@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
	Selvin Xavier <selvin.xavier@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>,
	Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	cocci@inria.fr, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-sound@vger.kernel.org, linux-btrfs@vger.kernel.org,
	ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
	linux-ide@vger.kernel.org, linux-xfs@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-nvme@lists.infradead.org,
	linux-spi@vger.kernel.org, imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	platform-driver-x86@vger.kernel.org,
	ibm-acpi-devel@lists.sourceforge.net, linux-rdma@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Carlos Maiolino <cmaiolino@redhat.com>
Message-ID: <79b24031-5776-4eb3-960b-32b0530647fb@sirena.org.uk>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZCSMnIMPvhXPgIqW"
Content-Disposition: inline
In-Reply-To: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
X-Cookie: I've been there.
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 00/16] Converge on using secs_to_jiffies()
 part two
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2523
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/79b24031-5776-4eb3-960b-32b0530647fb%40sirena.org.uk>


--ZCSMnIMPvhXPgIqW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 08:17:14PM +0000, Easwar Hariharan wrote:
> This is the second series (part 1*) that converts users of msecs_to_jiffi=
es() that
> either use the multiply pattern of either of:
> - msecs_to_jiffies(N*1000) or
> - msecs_to_jiffies(N*MSEC_PER_SEC)
>=20
> where N is a constant or an expression, to avoid the multiplication.

Please don't combine patches for multiple subsystems into a single
series if there's no dependencies between them, it just creates
confusion about how things get merged, problems for tooling and makes
everything more noisy.  It's best to split things up per subsystem in
that case.

--ZCSMnIMPvhXPgIqW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAme++zEACgkQJNaLcl1U
h9BKXgf/Ybq0e4qGEIKGWBa7OUYTknbVxMBC/99e3FVQ0Dwf4IPl8bDlEvGCxai/
A2UYH2niNzqAGOIs0IYUzaMIbok+phK2ifRcVyNdM2KciC1B2jGROzQplIYaq0bH
aEBWCAEyWMlRAMVwWL66KhB7d9asaNrv9v4WCNfcV9F4pThna3PAti9AF+sX6sQh
kvQleuahMD/hHAdTIrgBuJGgtox61kBDTFMibaWt2Moq01Wsp8YDQS3JtnnLyiE0
Rc67if2Uvg1ZMAyO3Fvm80flyFkMHhuiaq0uTFCLt1YiqCLfzk2w+QExnv0DRECR
mx63KFPW0WMILQcbYwjzaGgaLuTDWg==
=UO5r
-----END PGP SIGNATURE-----

--ZCSMnIMPvhXPgIqW--
