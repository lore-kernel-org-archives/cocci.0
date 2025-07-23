Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEE0BC87FCF
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 12:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lK/u5QmNJ/xVV+UgxuGjbMFb2y4kYKJIBagP32LTVTA=;
  b=XD0kOCSwkU0wMNAyDyE9vSxr/AXKdRwv/CYSq78byv5i5hFee1lwAeci
   BM1z83uBUoRSOhEjbDYJpQFVkBYq1LGAdtjxjU4MZoj2FigTkyhVk2sR1
   JTPqMyO96/+JrZavYtgLpaXo3nOxLo75CBKJIKaAfyyVLx46aGa6pj2/w
   M=;
X-CSE-ConnectionGUID: RBrleuy6SfiVkOt3/SAkyA==
X-CSE-MsgGUID: N2yjebjPRm+Hh64bc/3OCA==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234104589"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 14:01:08 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1A92BE0C55; Mon,  4 Aug 2025 14:01:08 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id EC522E0171
	for <cocci@sympa.inria.fr>; Wed, 23 Jul 2025 15:49:06 +0200 (CEST)
X-CSE-ConnectionGUID: 3n2I+EEYQcuFAcx9dd6a0A==
X-CSE-MsgGUID: prWRpjkJQ9G49iOUQ+KyHQ==
IronPort-SDR: 6880e851_NZ1demZImQiZWfv1IV4al2xu4RcRRMrYtDUWf7V+JlNz7Gv
 mDEqJ+18Z9z1GR88znauR6nkOABX3zOqhT4q2UQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EIAAAX54Boj/4EaaxaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBQQQBAQELAYJDgVozBAtJjVCGVVwBBoE+A4t0kE+BVYF9Ag8BAwENU?=
 =?us-ascii?q?QQBAQMEhQACjBQCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBA?=
 =?us-ascii?q?gEBAgQGAQIQAQEBAQEBOQVJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDOgYBATcBDwsYLlYGAYMUgiIHRgOwUYE0gQGCDAEBBt4ICYFJAYhQAYVsO?=
 =?us-ascii?q?4NCeicbfYEQhD8+hFiGDSKCJoEWhBuCM4ociB9SeBwDWSwBVRMXCwcFW0VDA?=
 =?us-ascii?q?yo0MSNLBS0dgSd9hBuEJytPgiJ1gXlaP4NTEQ0GbQ8GgRgaSgICAgUCQ0WBK?=
 =?us-ascii?q?UADC209NxQbBpM9gyV1EAsvgQFAk3iDUo4ma6EMhCaEcJxmGjOXUpMZhTyTS?=
 =?us-ascii?q?iKpHYFvBC+BXE0wCIMiTwMZD44hGYh6uy0jNTwCBwsBAQMJjzOBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Hc9YmK+xzZ5yVRcsHqxuk+DXI+orL9Y04lQ7vn2ZhyY1TiX+rb
 HJoB17726StN91YhwdcL+7VJVoLUmyyXcx2/hyAV7AZniDhILLFvAA0WKK+VSJcEfDH6xmpM
 JdmsNFaOEYY2IVsfrH
X-Talos-CUID: 9a23:OqTK4GGDJvv+dTU8qmI88hQ1We0IQ0TW0Vn5KF/pBWo3QeW8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ADMTqfw3G284g+gPaAOU/YaXjxTUj+76RMlgPkrc?=
 =?us-ascii?q?/6ubYZC1XBg7eryWXe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,333,1744063200"; 
   d="scan'208";a="122034722"
X-MGA-submission: =?us-ascii?q?MDG87ILsFWjZbrvkywcn7pOQJEMKlFs50rCSuR?=
 =?us-ascii?q?/8Lxn3YmCt8hUAKgFl2iU2D92RKGXIZVBVbH/6z4MQNWegcc+JqZGH3R?=
 =?us-ascii?q?9UnPNdIBnlbKm0TY5GM0EWQZWowUAJW9SA5GqGpNlynEbdW8feHSJ5ZS?=
 =?us-ascii?q?5ZnHtHVpWnWTA35w6o1+FvOQ=3D=3D?=
Received: from tor.source.kernel.org ([172.105.4.254])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2025 15:49:06 +0200
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9A7DE601D1;
	Wed, 23 Jul 2025 13:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F177C4CEE7;
	Wed, 23 Jul 2025 13:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753278543;
	bh=gpofvUdCvafEi9/Yz7WQuqJNoF8dDZ2uzd6/+Lg4OuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eqG+yF9vGnyPwsKROpDhc4vfaUIwMNG9rE6vCOfRZVVpYeEE2bUgWTYDUlJOi99MA
	 +EBJt3gVHRkRBksLk+Lje0BQC5Ua1wtHXeKtWLK8LtqCvl55M9bBHXtu3TiYReajNa
	 f6RaOgTW6k3KEGmidaDlRwc7biL2cF94l/CbwSfQMo2dl7fbfEDIf/JzO41V3zHTg8
	 CCjmuzrn4jhTgA/QpGfQWCyjsJHo464cpB4tGF15NDc4b+K3kXcYDHDdshUfiUNWhw
	 dmBimZQ8TDdYTJH3h0DUzHOIem1prD3+ipds1isrmNp2ngbxhRaZe8bzdn60Gt7R2x
	 uxlaHyrY2zwlw==
Date: Wed, 23 Jul 2025 06:49:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: MD Danish Anwar <danishanwar@ti.com>, Julia Lawall
 <Julia.Lawall@inria.fr>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Mengyuan Lou <mengyuanlou@net-swift.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Fan Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>,
 <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, cocci@inria.fr, Nicolas Palix
 <nicolas.palix@imag.fr>
Message-ID: <20250723064901.0b7ec997@kernel.org>
In-Reply-To: <20250723080322.3047826-2-danishanwar@ti.com>
References: <20250723080322.3047826-1-danishanwar@ti.com>
	<20250723080322.3047826-2-danishanwar@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation
 for RPMSG-ETH Driver
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2958
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/20250723064901.0b7ec997%40kernel.org>

On Wed, 23 Jul 2025 13:33:18 +0530 MD Danish Anwar wrote:
> +   - Vendors must ensure the magic number matches the value expected by the
> +     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
> +     source).

For some reason this trips up make coccicheck:

EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst

If I replace the brackets with a comma it works:

   - Vendors must ensure the magic number matches the value expected by the
     Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
     source.

Could you make that change in the next revision to avoid the problem?

Julia, is there an easy way to make coccinelle ignore files which
don't end with .c or .h when using --use-patch-diff ?
-- 
pw-bot: cr
