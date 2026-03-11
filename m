Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA1CD1049516
	for <cocci@archiver.kernel.org>; Wed, 11 Mar 2026 09:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:sender:subject:reply-to:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=G+5qjaihAOE3Wva2YLY8jATPGvyCa7CiJLk7V/SbO+c=;
  b=a19Wn+n0eZ3SqjV+MGfJKA/yEk8XSE1Vqlz+c9TTDyFEhAGshlL+EWA7
   /TPr/OXTnwL/f92b0IoyGjxoh8BTk5mlDXi4twB+hCmV/NhiLlSFW+zpA
   8ZoKKgaMrIq+rBJJd2L3WrYkkiT+US9tNyMFu50VTR9C4GGmcGakB90mh
   s=;
X-CSE-ConnectionGUID: uU2rf+UgShK+9DptN1vi7A==
X-CSE-MsgGUID: M/VjP3iXQEey3KWJQarYOQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
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
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267245695"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 11 Mar 2026 10:46:08 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 892AC818F5; Wed, 11 Mar 2026 10:46:07 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 4FBC780F45
	for <cocci@sympa.inria.fr>; Wed, 11 Mar 2026 01:16:19 +0100 (CET)
X-CSE-ConnectionGUID: S58KnuRQSymKExgzAEkxvQ==
X-CSE-MsgGUID: gKp9N8lASaCtR1WbNTl+Gg==
IronPort-SDR: 69b0b453_GZ4tmmhY4hgEJIT6CDfOXQfSkv/injWINPyIb789Qa/xFFR
 wE7LYNarbTalwAT7YHTr8E7tUWzPCgz9w5TxSJA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HQAwDvs7BpctoeIE5aHgEBCxIMQIFFC4FuU4EHXjQEC?=
 =?us-ascii?q?0mUK1kBAQEBBoFBgROfBBEBAwENPREBAgQBAQMEkiUCHgYGMwYOAQIEAQEBA?=
 =?us-ascii?q?QMCAwEBAQEBAQEBAQ0BAQUBAQECAQECBAYBAhABgQyGTw2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgEFOgYBATcBDwEKDgouEEYGgxaCKUoEAw2uB4E0gQGCD?=
 =?us-ascii?q?AEBBt4RAwYUAYE4iFQBhVoahHonG32BEIEVgnI4PosHgzSJCooZUngcA1ksA?=
 =?us-ascii?q?VUTFwsHBYEjQwOBBiNLBS0dgSMhHRcUH1gbBwUSISqBSXiCAQ+GankDLl4aD?=
 =?us-ascii?q?iICOlxKPgtaBYJIAwttPTcUG48tPoI1ej+CAkyWQAGwHwqEHKFyM6prLodlk?=
 =?us-ascii?q?HOjcIVRgX4kgVxRMASDIk8cD44hi3nBCEYyPAIHCwEBAwmFRgEBjFaBSwEB?=
IronPort-PHdr: A9a23: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
 EZetw==
IronPort-Data: A9a23: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
 Yl2x0Ac9SRdDn2kqSj/KxB7bSpaKivm+081
IronPort-HdrOrdr: A9a23:zuT8Na1XwdHwknD+LAaC2gqjBLckLtp133Aq2lEZdPWaSK2lfu
 SV7ZMmPH7P+VIssRQb8uxoV5PtfZqxz/FICMwqTNGftWrdyQ6VxeNZnOjfKlTbckWVm9K1l5
 0QEZSWJ+eAdGSS5vyb3ODXKbgd/OU=
X-Talos-CUID: =?us-ascii?q?9a23=3AUcPNWmugCsTP+Xok8oiArc6q6IseLy3+ymrqGnS?=
 =?us-ascii?q?pDEVEWLKHYHKT6L1dxp8=3D?=
X-Talos-MUID: 9a23:jeHQAgv/mLFAO1CJbs2nixJ6ZeE4542VAWsRq8w5se+4MW9fNGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,113,1770591600"; 
   d="scan'208";a="267189466"
X-MGA-submission: =?us-ascii?q?MDEgdoZghIg9PxXrf8ow1SmzhNtZXlcDShacam?=
 =?us-ascii?q?n2UmqC+3cyXEIvX07Jlp3bhIRE2CSG46ZVFCibps8B3uJ6w2HZ0i6bx2?=
 =?us-ascii?q?mbQwtvIDSIdSGytfD42lhLEGIaydT+W+T4ZOsF6D0yyIwbaSwYVF5SOh?=
 =?us-ascii?q?0jpUzDTF1zXTR6WOdIYAqV1A=3D=3D?=
Received: from pandora.armlinux.org.uk ([78.32.30.218])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2026 01:16:18 +0100
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55974)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w07FF-000000005dP-41aF;
	Wed, 11 Mar 2026 00:16:14 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w07FB-000000005hj-1vhz;
	Wed, 11 Mar 2026 00:16:09 +0000
Date: Wed, 11 Mar 2026 00:16:09 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Philipp Hahn <phahn-oss@avm.de>
Cc: amd-gfx@lists.freedesktop.org, apparmor@lists.ubuntu.com,
	bpf@vger.kernel.org, ceph-devel@vger.kernel.org, cocci@inria.fr,
	dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
	gfs2@lists.linux.dev, intel-gfx@lists.freedesktop.org,
	intel-wired-lan@lists.osuosl.org, iommu@lists.linux.dev,
	kvm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-btrfs@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-clk@vger.kernel.org, linux-erofs@lists.ozlabs.org,
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-gpio@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-leds@vger.kernel.org, linux-media@vger.kernel.org,
	linux-mips@vger.kernel.org, linux-mm@kvack.org,
	linux-modules@vger.kernel.org, linux-mtd@lists.infradead.org,
	linux-nfs@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-phy@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-rockchip@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
	linux-security-module@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-sound@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-trace-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	ntfs3@lists.linux.dev, samba-technical@lists.samba.org,
	sched-ext@lists.linux.dev, target-devel@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, v9fs@lists.linux.dev,
	Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Michael Chan <mchan@broadcom.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Taras Chornyi <taras.chornyi@plvision.eu>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Iyappan Subramanian <iyappan@os.amperecomputing.com>,
	Keyur Chudgar <keyur@os.amperecomputing.com>,
	Quan Nguyen <quan@os.amperecomputing.com>,
	Heiner Kallweit <hkallweit1@gmail.com>
Message-ID: <abC0Se_cstwTWp9r@shell.armlinux.org.uk>
References: <20260310-b4-is_err_or_null-v1-0-bd63b656022d@avm.de>
 <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260310-b4-is_err_or_null-v1-38-bd63b656022d@avm.de>
Sender: cocci-request@inria.fr
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 38/61] net: Prefer IS_ERR_OR_NULL over manual
 NULL check
Reply-To: "Russell King (Oracle)" <linux@armlinux.org.uk>
X-Loop: cocci@inria.fr
X-Sequence: 3390
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-03/wAliJCEnsF2BncfFeVwByQ>

On Tue, Mar 10, 2026 at 12:49:04PM +0100, Philipp Hahn wrote:
> diff --git a/drivers/net/mdio/mdio-xgene.c b/drivers/net/mdio/mdio-xgene.c
> index a8f91a4b7fed0927ee14e408000cd3a2bfb9b09a..09b30b563295c6085dc1358ac361301e5cf6b2a8 100644
> --- a/drivers/net/mdio/mdio-xgene.c
> +++ b/drivers/net/mdio/mdio-xgene.c
> @@ -265,7 +265,7 @@ struct phy_device *xgene_enet_phy_register(struct mii_bus *bus, int phy_addr)
>  	struct phy_device *phy_dev;
>  
>  	phy_dev = get_phy_device(bus, phy_addr, false);
> -	if (!phy_dev || IS_ERR(phy_dev))
> +	if (IS_ERR_OR_NULL(phy_dev))

As noted in reply to your cover message, the check for NULL here is
incorrect - get_phy_device() returns either a valid pointer or an
error pointer, but never NULL.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
