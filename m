Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8510C87FD1
	for <cocci@archiver.kernel.org>; Mon,  4 Aug 2025 12:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=hOc1q4h2DdgZveLq/ie+ow6+3RIYzRAV3p05yW0fvLU=;
  b=koCQ7Yo2ftcao+A028TjU946RRGGSWHZfAGMn3r8/o2L+aKa2qxpEgHh
   hBIo9Ad/4XMKwryRJXG1RGKMtrOdl84IQyHieYqmK0YnhpUPuNuMBZxkF
   +gPGrM82INAzTXWgbv+Mfe/6I3N4jTeZthHmJmqFFH7P04YzzJ3BMvLFr
   Y=;
X-CSE-ConnectionGUID: qt2HxPLXSZ2qAA49u3sNYw==
X-CSE-MsgGUID: yhVMIHAXTY+uBgvFakh96g==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@ti.com
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="234104669"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Aug 2025 14:01:10 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C55B7E0CF1; Mon,  4 Aug 2025 14:01:08 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 63075E0171
	for <cocci@sympa.inria.fr>; Thu, 24 Jul 2025 08:55:07 +0200 (CEST)
X-CSE-ConnectionGUID: LovwtSTRSjWBS4hZl2Ou6A==
X-CSE-MsgGUID: fm0CIzq2SuS/DtlczI8mDw==
IronPort-SDR: 6881d8cb_stjxOWBhVO9f+dlzUY7ffajdKKBkTKISeP795ehh2YyPS9s
 YzE5Fb02BC7MSuXPa4Zr/Yg0NmOQAKNqNVIDAfQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EsAAAG2IFog/UTL8ZaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgVk0BwhJhFWIHIlVA4Q7mAiBVYFAPQIPAQMBCwEBUQQBAQMEhQACjBYCH?=
 =?us-ascii?q?wYBBDAJDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEBA?=
 =?us-ascii?q?TkHDjuFew2CYgGBJF5IAQEBAQEBAQEBAQEBAQEBAQEBAQEBFAIIYwEBHQEBA?=
 =?us-ascii?q?QECASMdAQE3AQQLCw4KAgImAgJWBgEKAwcBAYJ+giIHIiQDtAx6gTKBAYIMA?=
 =?us-ascii?q?QEG3ggJgRsuAYhQAYFtg387g0J6JxuBSUSBPIMDPogegkcigiZEUoNlNoIzi?=
 =?us-ascii?q?hyIMQlJeBwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd9hBuEJytPgiJ1gRBpW?=
 =?us-ascii?q?j+DUx4GbQ8GgRgaSgICAgUCQ0WBSEACAQttPTcJCxuTWIMmdRALL4EBQJN4g?=
 =?us-ascii?q?1KOJmihD4QmoVsGQpdmkwWFPJNKIqhyAgICAgkCGIFoOoFcTSODN08DGQ+OI?=
 =?us-ascii?q?RmDZ8AgPjI8AgcLAQEDCY95gUsBAQ?=
IronPort-PHdr: A9a23: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
 l1qCywzQFrO1OL+
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:VPTMxaqo8wG3WDwCpeJkMSQaV5oCeYIsimQD101hICG8cqSj5q
 eTdYcgpGbJYVEqKQwdcLG7SdO9qBbnn6KdjrNwAV7PZnifhILsFvAY0WKA+UyCJ8SdzI9gPM
 5bGsAUZbGeY2SSz/yKhjVQeOxQpeVvnprY4ds2g00dLz2DWMxbnntENjo=
X-Talos-CUID: =?us-ascii?q?9a23=3A3fU+pWih29NLkTsrUCoXjROqvDJuVnrD02vrH3W?=
 =?us-ascii?q?DC1lDc+GVe1vK3746up87?=
X-Talos-MUID: =?us-ascii?q?9a23=3ABkUAWw+ZN4zH/oa+M2RcNxyQf8ltu4+PGllXqog?=
 =?us-ascii?q?9/OWYMSdiGmeYoCviFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,336,1744063200"; 
   d="scan'208";a="232890540"
X-MGA-submission: =?us-ascii?q?MDHOwsr2RSb7fhBlCd4JhYDMekNiVGU8EHRdut?=
 =?us-ascii?q?h+GQfIquQU7hVmk8cRuZQY4TXNQCFSvQxJqPid2Bl+OUxIbKVKpNo3k6?=
 =?us-ascii?q?/TPINKBQ0fVbAhjWK07/TaM7uYTAo++3BdYFBzeeZXsZEEXOkyC3SM1n?=
 =?us-ascii?q?NxTfiLM59BlO3thQOH56iHwg=3D=3D?=
Received: from fllvem-ot03.ext.ti.com ([198.47.19.245])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 08:55:05 +0200
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTP id 56O6sRss1439614;
	Thu, 24 Jul 2025 01:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1753340067;
	bh=hOc1q4h2DdgZveLq/ie+ow6+3RIYzRAV3p05yW0fvLU=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=N2kX8jwuYkhgzG6LEy5g1tNb05z48U8jpcmbH2yHHGPpXqOVJHPaxvqF/BIOdCJLe
	 yWvdC/2jho+huPaN3rCxyQjMPcOyaMi9dZgnT3IZCCq75cR+ehkRL6lsjpKpxPJEio
	 npQVk7/rRn79EG1drE+bfpWDIVimcyA/yckGsECU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 56O6sRpN3359445
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Thu, 24 Jul 2025 01:54:27 -0500
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Thu, 24
 Jul 2025 01:54:26 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Thu, 24 Jul 2025 01:54:26 -0500
Received: from [10.24.69.25] (danish-tpc.dhcp.ti.com [10.24.69.25])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 56O6sK9K033297;
	Thu, 24 Jul 2025 01:54:20 -0500
Message-ID: <db4e65a7-bdb6-4e96-b9d0-eda4b30e4e71@ti.com>
Date: Thu, 24 Jul 2025 12:24:19 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jakub Kicinski <kuba@kernel.org>, Julia Lawall <Julia.Lawall@inria.fr>
CC: "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        Simon Horman
	<horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Lunn
	<andrew+netdev@lunn.ch>,
        Mengyuan Lou <mengyuanlou@net-swift.com>,
        Michael
 Ellerman <mpe@ellerman.id.au>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Fan
 Gong <gongfan1@huawei.com>, Lee Trager <lee@trager.us>,
        Lorenzo Bianconi
	<lorenzo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Lukas
 Bulwahn <lukas.bulwahn@redhat.com>,
        Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>,
        <netdev@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <cocci@inria.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <20250723080322.3047826-1-danishanwar@ti.com>
 <20250723080322.3047826-2-danishanwar@ti.com>
 <20250723064901.0b7ec997@kernel.org>
Content-Language: en-US
From: MD Danish Anwar <danishanwar@ti.com>
In-Reply-To: <20250723064901.0b7ec997@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH net-next 1/5] net: rpmsg-eth: Add Documentation
 for RPMSG-ETH Driver
Reply-To: MD Danish Anwar <danishanwar@ti.com>
X-Loop: cocci@inria.fr
X-Sequence: 2959
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/db4e65a7-bdb6-4e96-b9d0-eda4b30e4e71%40ti.com>

Hi Jakub,

On 23/07/25 7:19 pm, Jakub Kicinski wrote:
> On Wed, 23 Jul 2025 13:33:18 +0530 MD Danish Anwar wrote:
>> +   - Vendors must ensure the magic number matches the value expected by the
>> +     Linux driver (see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
>> +     source).
> 
> For some reason this trips up make coccicheck:
> 
> EXN: Failure("unexpected paren order") in /home/cocci/testing/Documentation/networking/device_drivers/ethernet/rpmsg_eth.rst
> 
> If I replace the brackets with a comma it works:
> 
>    - Vendors must ensure the magic number matches the value expected by the
>      Linux driver, see the `RPMSG_ETH_SHM_MAGIC_NUM` macro in the driver
>      source.
> 
> Could you make that change in the next revision to avoid the problem?
> 

Sure. I'll do this change in v2.

> Julia, is there an easy way to make coccinelle ignore files which
> don't end with .c or .h when using --use-patch-diff ?

-- 
Thanks and Regards,
Danish

