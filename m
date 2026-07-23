Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0880DC53209
	for <cocci@archiver.kernel.org>; Fri, 24 Jul 2026 08:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6aFnQXEm9TrsdDTj1E/xgPwhwGan4/+djoVhNQoCfeE=;
  b=KFvrWO8N2Pn9wannQjhiFQgI6GJHlv4GGo1QnhEz0TvxrbSjnpMm+myy
   OVj5GeCiHPPniuMzR5O9L8qRH1nXl9ab//75KJB7GgjZ4T1hhrNFQEDyU
   HlMibkfuucGOngrfR2HPwiB1QXe/BzTYx/i3eTap+zxvnLCm332tngKI1
   4=;
X-CSE-ConnectionGUID: +vnrQUYZTYGSuJ5x9jLx8g==
X-CSE-MsgGUID: qG7iIsJeRNuuc9smnar3Sw==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.27 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
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
X-IronPort-AV: E=Sophos;i="6.25,182,1779141600"; 
   d="scan'208";a="287734391"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Jul 2026 10:54:53 +0200
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 2F1A2803FA; Fri, 24 Jul 2026 10:54:53 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id E2F668003A
	for <cocci@sympa.inria.fr>; Thu, 23 Jul 2026 22:24:24 +0200 (CEST)
X-CSE-ConnectionGUID: uR2CljhgQWqCAJ5lhagn9g==
X-CSE-MsgGUID: 4WMww9oIQUyPvnJ0sv5/RQ==
IronPort-SDR: 6a627877_XdKHw1gU3G9XRb2zf2IcOnkAe1uFlWTRFvl8WFEnOThxuvl
 HpFaxzt3/nJIPJwzsNtIRm9oBsVBtiXX+YwARDg==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0FiAQAQd2JqhZh8DMpaglmCQYFoNAcISYRYkXMDi2SQY?=
 =?us-ascii?q?oFVgXwCDwEDAQ1RBAEBAQIBA4R+Ao1gAh8GAQQwCQ4BAgQDAgMBAQEBAQEBA?=
 =?us-ascii?q?QEBAQsBAQEEAQEBAgEBAgQDAQEBAQIQAQEBAUBJhk8NgmIBM3GBJQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEdAggFXgEeAQEBAQIBIwQLAQ0BATcBBAsLGAICJgICIDYGE4MCg?=
 =?us-ascii?q?iMBBhEDECcCwkR6fzOBAYIMAQEG2zINgTeBJAkUAYEKLog8BBwBc4UEhHwng?=
 =?us-ascii?q?iiBFYMrPoIfhX8ZIYIwgiaBDJIuUhdhHANZLAFVExcLBwWBI0MDgQYjSwUtH?=
 =?us-ascii?q?YEjIR0XFh5YGwcFEiAqQUUjA0EmEDgLQwWBVgKBeD8jHwM5f4EvdUp3LWkBA?=
 =?us-ascii?q?hAXSjgkg0kCgTcDC209NxQZBI8eI4FOHlQBgQ5aIYEtFzoplhibC5QmcQeEI?=
 =?us-ascii?q?JUChl2FfARJl1GTG5kIkhORV4VZgWg6gVyEJ1ADGQ+OLQ0Jg2CGQMUKRTI+A?=
 =?us-ascii?q?QcCBwEMBIFzT49lgUwBAQ?=
IronPort-PHdr: A9a23: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
 Y0D6M0dE5KsllrVf56PEQ==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2t6GbaFSAIf2VNkVpLqEAceALOsnbusQ8zAXPo5KOHpom+ij5r
 yTdZMgpGDJYVcqKQwdcLW7VcW9qBznhPtICPYqTNSftWXdyQ+VxcRZnPXfKl7balfDH4xmpN
 9dmsFFYbWaZykZsS+52njCLz9K+qj/zEnHv5a4815dCSVHL5h66RZoYzz6LmRGAC1rQaMjEo
 uNouBOuyCtEE53Uu2LQl0oG9POrdHKi57qCCRpOzcXrC2jyQml77P3CHGjsSsjbw==
X-Talos-CUID: 9a23:gkY0SGBzgcoTpmD6EzRdrmUQGMAqS0LE517yfku4AGlvGbLAHA==
X-Talos-MUID: 9a23:pkyRDAVjfaouJUzq/GPToS59ZcBJ2pm/MF4Ls80dpZTDDxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.25,181,1779141600"; 
   d="scan'208";a="152819315"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDGHcYWoTt0Q1gtyaARA/jB8h6f3/zFYF/UdHI?=
 =?us-ascii?q?e4rCt5oigMXhBhcfHjKZAZJGeoc0tz4hb2EzgWCKDczK4+VnjuvICM/j?=
 =?us-ascii?q?PMAqFFYYEjLlcvWyvZjBU9cvLXOBIbKQjJ2wna9j9+rFezfwFswHRjub?=
 =?us-ascii?q?5Ilx3RXq2MhK3/gpdNW13yhA=3D=3D?=
Received: from fhigh-b1-smtp.messagingengine.com ([202.12.124.152])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2026 22:24:23 +0200
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DB9897A0220;
	Thu, 23 Jul 2026 16:24:20 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 23 Jul 2026 16:24:21 -0400
X-ME-Sender: <xms:c3hiam342YGxZhdWLPJ7zpUVuDFw5YtVxXXYwbDKyaG8XkMpVOyRLQ>
    <xme:c3hiagJL2GmU-8-BwhNiiibVfyhMseOhwbj5_3MwZ17cM6QkFxWT1SaOKJwrd2P3q
    Q8GcHovkF5J05NQCoPDp30OAzy0ybeXnz9nfM7-7s-LgyZPlUo>
X-ME-Received: <xmr:c3hiamndHVBET1X4u6SyitEjOwSnGiep7FvBF86jdKeFmFdAi4lR49e8L26hYK9pAswSYkJSpTVQQbSrQhfrK0rR6BF1cnI>
X-ME-Proxy-Cause: dmFkZTGGMEev6dKv4UlCPj6XliuA/xQS1IWIXC6IlxAZ+QnJEaoji/7RoCIeC01ofKpxth
    ohf8Nv+dO5poKFdV4crp0Gr2/tqJtucOlqVWHiFd1a8QjMJVqrlokVXUXIpmig454d2Qo+
    vvmBOz7L7O/QeaMgWDD4JIZ9UyejEPJ4apV7ZEqnQm4E9HSPXbH9Jklc/2Gi6tGLIgQ8CB
    zZG/Zuh2+YzEnhTnumOd//3hHX8puHAQmVpt1mz7x9Lwss76ekv4bgs6plE3vK4w4Z3IEp
    /vM/EESSO7PBegwXKhXAYhh+idjD834+4Q4Ab70bRPVknovFAQYIEudIMzFB5gR3Fzn0PB
    OXSSSutlBs2XxKk8nwGhMF0wZgJXHTe3TCVv7jFXNd5sflKc5ghq5UWFndPYWbcmnqypjf
    oPRKnVgJKqLYzs0g0wH3iTejoLyZ/9GYJlyxLhmhVdbijsXh5C1pYfrX8So+OKUE24W2AS
    DYoJKhIhN3i1TvvjG0uff/YI3iMfh8/TSrjSASgrCBz2I6wukQ8HQ6VesoRdgrfJ4cCD9B
    FX4xFbGHsGX1JIPxJ0aZKPEd/KHAxX9FXNY4d3JoR+fv19acR6gRTPIzFLMtn+rjuDldjB
    sn+f5iuWDcq8NUmTTxQMYI6J1WMLsWtexP0oMDtr/v5gYUlXTV8/TUwohnLw
X-ME-Proxy: <xmx:c3hiauNPfuY0oppbemzAp3CORNwZMGXN3N1U0lDNPl01Z-2sX6PCTg>
    <xmx:c3hialwDjJ1lb9PpOt07VeBUnrYcXykGjKuHLsPtKihqh9wxE4dEiA>
    <xmx:c3hiamnHQ175QGVLQOmcKLn_fmx3lMrUDzZSIiXPa4GfxjfEifIPpg>
    <xmx:c3hiaj9C_4WYsev1fBgHUeC6Wi3TnmwHAipTXhExdFmwHYYKn2cfSQ>
    <xmx:dHhials9WoqpaRiRD7Qay-2oaZx60AJnFVa3cGsRbRp0Y5Mo6NVaqp8->
Feedback-ID: i80c9496c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Jul 2026 16:24:19 -0400 (EDT)
Date: Thu, 23 Jul 2026 22:24:16 +0200
From: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
To: Sang-Heon Jeon <ekffu200098@gmail.com>
Cc: Julia.Lawall@inria.fr, Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Manish Chopra <manishc@marvell.com>,
	Rahul Verma <rahulv@marvell.com>,
	Shahed Shaikh <shshaikh@marvell.com>,
	Sabrina Dubroca <sd@queasysnail.net>, cocci@inria.fr,
	GR-Linux-NIC-Dev@marvell.com, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org
Message-ID: <20260723202416.GD2273555@ragnatech.se>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
 <20260723184538.3888637-8-ekffu200098@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260723184538.3888637-8-ekffu200098@gmail.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH 07/36] net: ethernet: remove conditional return
 with no effect
Reply-To: Niklas =?utf-8?Q?S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>
X-Loop: cocci@inria.fr
X-Sequence: 3636
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Unsubscribe: <https://sympa.inria.fr/sympa/signoff/cocci>, <mailto:sympa_inria@inria.fr?subject=SIG%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-07/zQHkievXpDRVJIuOtulGVQ>

Hello Sang-Heon,

Thanks for your work.

On 2026-07-24 03:45:09 +0900, Sang-Heon Jeon wrote:
> Both branches of the check return the same value, so the check has
> no effect. Remove it and return the value directly.
> 
> This is the result of running the Coccinelle script from
> scripts/coccinelle/misc/cond_return_no_effect.cocci.
> 
> Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
> ---
>  drivers/net/ethernet/amazon/ena/ena_netdev.c          | 6 +-----
>  drivers/net/ethernet/aquantia/atlantic/aq_macsec.c    | 6 +-----
>  drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c   | 6 +-----
>  drivers/net/ethernet/freescale/gianfar.c              | 6 +-----
>  drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c    | 7 +------
>  drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c | 6 +-----
>  drivers/net/ethernet/renesas/rtsn.c                   | 7 +------

For rtsn.c,

Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>

>  7 files changed, 7 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amazon/ena/ena_netdev.c b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> index 5d05020a6d05..ea89619039d8 100644
> --- a/drivers/net/ethernet/amazon/ena/ena_netdev.c
> +++ b/drivers/net/ethernet/amazon/ena/ena_netdev.c
> @@ -2303,11 +2303,7 @@ static int ena_open(struct net_device *netdev)
>  		return rc;
>  	}
>  
> -	rc = ena_up(adapter);
> -	if (rc)
> -		return rc;
> -
> -	return rc;
> +	return ena_up(adapter);
>  }
>  
>  /* ena_close - Disables a network interface
> diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
> index 3ca072360ec7..fd4ee6212234 100644
> --- a/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
> +++ b/drivers/net/ethernet/aquantia/atlantic/aq_macsec.c
> @@ -735,11 +735,7 @@ static int aq_set_rxsc(struct aq_nic_s *nic, const u32 rxsc_idx)
>  	sc_record.valid = 1;
>  	sc_record.fresh = 1;
>  
> -	ret = aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return aq_mss_set_ingress_sc_record(hw, &sc_record, hw_sc_idx);
>  }
>  
>  static int aq_mdo_add_rxsc(struct macsec_context *ctx)
> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> index 33e7a99d3e49..79d4a77f72bd 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch.c
> @@ -3935,11 +3935,7 @@ static int dpaa2_switch_port_init(struct ethsw_port_priv *port_priv, u16 port)
>  	if (err)
>  		return err;
>  
> -	err = dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
> -	if (err)
> -		return err;
> -
> -	return err;
> +	return dpaa2_switch_port_trap_mac_addr(port_priv, ll_mac, ll_mask);
>  }
>  
>  static void dpaa2_switch_ctrl_if_teardown(struct ethsw_core *ethsw)
> diff --git a/drivers/net/ethernet/freescale/gianfar.c b/drivers/net/ethernet/freescale/gianfar.c
> index 89215e1ddc2d..cf636fc5aafa 100644
> --- a/drivers/net/ethernet/freescale/gianfar.c
> +++ b/drivers/net/ethernet/freescale/gianfar.c
> @@ -2877,11 +2877,7 @@ static int gfar_enet_open(struct net_device *dev)
>  	if (err)
>  		return err;
>  
> -	err = startup_gfar(dev);
> -	if (err)
> -		return err;
> -
> -	return err;
> +	return startup_gfar(dev);
>  }
>  
>  /* Stops the kernel queue, and halts the controller */
> diff --git a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
> index fff8dc84212d..e96a268067f2 100644
> --- a/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
> +++ b/drivers/net/ethernet/qlogic/netxen/netxen_nic_hw.c
> @@ -2478,7 +2478,6 @@ static int netxen_parse_md_template(struct netxen_adapter *adapter)
>  static int
>  netxen_collect_minidump(struct netxen_adapter *adapter)
>  {
> -	int ret = 0;
>  	struct netxen_minidump_template_hdr *hdr;
>  	hdr = (struct netxen_minidump_template_hdr *)
>  				adapter->mdump.md_template;
> @@ -2486,11 +2485,7 @@ netxen_collect_minidump(struct netxen_adapter *adapter)
>  	hdr->driver_timestamp = ktime_get_seconds();
>  	hdr->driver_info_word2 = adapter->fw_version;
>  	hdr->driver_info_word3 = NXRD32(adapter, CRB_DRIVER_VERSION);
> -	ret = netxen_parse_md_template(adapter);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return netxen_parse_md_template(adapter);
>  }
>  
>  
> diff --git a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> index 45ed8705c7ca..47cd9ec665ee 100644
> --- a/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> +++ b/drivers/net/ethernet/qlogic/qlcnic/qlcnic_83xx_init.c
> @@ -1618,11 +1618,7 @@ static int qlcnic_83xx_check_hw_status(struct qlcnic_adapter *p_dev)
>  	if (err)
>  		return err;
>  
> -	err = qlcnic_83xx_check_heartbeat(p_dev);
> -	if (err)
> -		return err;
> -
> -	return err;
> +	return qlcnic_83xx_check_heartbeat(p_dev);
>  }
>  
>  static int qlcnic_83xx_poll_reg(struct qlcnic_adapter *p_dev, u32 addr,
> diff --git a/drivers/net/ethernet/renesas/rtsn.c b/drivers/net/ethernet/renesas/rtsn.c
> index ee8381b60b8d..f7beeb73eb16 100644
> --- a/drivers/net/ethernet/renesas/rtsn.c
> +++ b/drivers/net/ethernet/renesas/rtsn.c
> @@ -685,7 +685,6 @@ static void rtsn_set_rate(struct rtsn_private *priv)
>  static int rtsn_rmac_init(struct rtsn_private *priv)
>  {
>  	const u8 *mac_addr = priv->ndev->dev_addr;
> -	int ret;
>  
>  	/* Set MAC address */
>  	rtsn_write(priv, MRMAC0, (mac_addr[0] << 8) | mac_addr[1]);
> @@ -702,11 +701,7 @@ static int rtsn_rmac_init(struct rtsn_private *priv)
>  
>  	/* Link verification */
>  	rtsn_modify(priv, MLVC, MLVC_PLV, MLVC_PLV);
> -	ret = rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
> -	if (ret)
> -		return ret;
> -
> -	return ret;
> +	return rtsn_reg_wait(priv, MLVC, MLVC_PLV, 0);
>  }
>  
>  static int rtsn_hw_init(struct rtsn_private *priv)
> -- 
> 2.43.0
> 

-- 
Kind Regards,
Niklas Söderlund
