Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FFF6C4828D
	for <cocci@archiver.kernel.org>; Tue,  6 Feb 2024 14:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=XBCkVFV2OFAdWM/A6MrQ3sNmq489YdaN+ifVWI6Wc3I=;
  b=iGzckqN8VaoS9NxtV8oQf/Bz2LJdt3ykBbQm3Ga5lHWejsujPB4afDZb
   2PGwMxiw8LSzkOozBzxqY6Ma1e1uxefpVnfu9VWnI9q/xrqg7s6ODHvnp
   zfHkOt12u7H3OPzdmeJtGz8EN66+ZGzGUy6w0MiD9GCVqCVvw1KQSVoqu
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
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.05,247,1701126000"; 
   d="scan'208";a="150576336"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2024 15:48:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1D5EEE0CE4; Tue,  6 Feb 2024 15:48:55 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 58E6CE008A
	for <cocci@sympa.inria.fr>; Tue,  6 Feb 2024 00:36:12 +0100 (CET)
IronPort-SDR: 65c170eb_16r9SPIHvdPo2t6FLQwtSJHiGKeCG/LIW/WOlJldogCu6Ls
 N7o3adNm8n2NCJxfJJpQSGOIknLVc+a1FVj0P2w==
X-IPAS-Result: =?us-ascii?q?A0F7AAAEcMFlkNlUsotaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?T0FAQELAYI4fFYyBAtIjU+GSVwBBoFCi2+HTIpLgUA+DwEDAQ05CwQBAQMEh?=
 =?us-ascii?q?H8Ch1cCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAQEBIB4QDieFbA2CXAEQgQyBHgEBAQEBAQEBAQEBAQEBAQEBARcCDXwBA?=
 =?us-ascii?q?gM6BgEBNwEPCxguVgaDEwGCXwMRBrdkgTSBAYIKAQEGgmWwGQMGgUgBiCUBi?=
 =?us-ascii?q?S96Jxt9gRCBFYMqPoJhAoF1hi6FU4kDjTRUfx0DgQYEXA0bEB43ERATDQMIb?=
 =?us-ascii?q?h0CESI6AwUDBDIKEgwLHwUTQgNABkkLAwIaBQMDBIEwBQ0aAhAaBgwmAwMSS?=
 =?us-ascii?q?QIQFAM4AwMGAwoxMFVBDFADZB8yCTwPDBoCGxsNJyMCLEADERACFgMdFgQ0E?=
 =?us-ascii?q?QkLJgMqBjYCEgwGBgZdIxYJBCUDCAQDVAMhdBEDBAoDFAcLB3iBUTiBPgQTR?=
 =?us-ascii?q?AMQgTSFQYFYA0QdQAMLbT01FBsGI5wzAYQAgQWlRGmgYYQbhGqHHZUXGjODc?=
 =?us-ascii?q?gGTOpJymFaNbZsEgWoNJoFcTTAIgyJPAxkPjiAZg2GFFIsGIDU7AgcLAQEDC?=
 =?us-ascii?q?YkigUYBAQ?=
IronPort-PHdr: A9a23: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
 pVcEtdm
IronPort-Data: A9a23:ZWWs/KJCnztRLxMWFE+RPJElxSXFcZb7ZxGr2PjKsXjdYENS0TBSz
 DMeXmzTa6mJZ2D9L94nYI3k9R4Eu8XQyYQxHAEd+CA2RRqmi+KVXIXDdh+Y0wC6d5CYEho/t
 63yTvGacajYm1eF/k/F3oDJ9CU6j+fSLlbFILasEjhrQgN5QzsWhxtmmuoo6qZlmtHR7zml4
 LsemOWBfgf4s9JIGjhMsf7b8ksy5K6aVA4w5zTSW9gb5DcyqFFOVPrzFYnpR1PkT49dGPKNR
 uqr5NlVKUuEl/uFIorNfofTKiXmcJaKVeS9oiY+t5yZv/R3jndaPpDXmxYrQRw/Zz2hx7idw
 TjW3HC6YV9B0qbkwIzxX/TEes3X0GIvFLLveBCCXcKvI0LuK3XM5vxrDW8NOJwkpcheXUxrx
 b8FAWVYBvyDr7reLLOTRudzwN8kMdPgMcUct2tmwDWfCuwpKXzBa/yRtJkBg2d21pwIR6+BD
 yYaQWIHgBDoYABFM38UBYg4kePugWPwG9FdgA3F9fNsuzWCpOB3+Kngd4LwcOWmf8hEklaG+
 Tia+T79WzhPYbRzzhLeryry1rCW9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GRjkehUtZbA
 14V/yA0pO4z8laqR5/zRXWFTGWsshADHcFXDvcx5UeOx7DS7gLfAXILJtJcVDA4nJc4ZRkj0
 16npNb4OWNBmeG4bELe657B+FteJhMpBWMFYCYFSy4M7N/ivJw/g3rzojBLTPDdYjrdRW+Y/
 tyakBXSkYn/miLi6klW1VzJnHS3oYXTRQNz5QjNWG+hqARja+ZJhrBEC3CEvJ6sz67AHzFtW
 UTofeDFs4ji6rnWxUSwrB0lRu3B2hp8GGS0baRTN5cg7S+x3HWoYJpd5jpzTG8wbZ5bIGGxP
 hCI5lwPjHO2AJdMRfEqC25WI5pxpZUM6fy4CJg4k/IfOMEvLGdrAgk1PhP4M5/RfLgEyvxnZ
 8fEKK5A/F4XELlmyjumD/wQy6EqzS0ljWLVTtaT8vhU+eT2WZJhcp9caAHmRrlgvMus/l6Pm
 /4BbJTi9vmqeLGiCsUh2dVJdgFiwLlSLcyelvG7gcbZe1A4Qzp5Va6OqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C3bNSgxW6ClRptls3MwMAolOFviiTBpYp+i4O1bP9E7dKUuvr4rh/Nlb
 eg3S+PZCNR2SxPD52s8a7v5p9dcbxiFv1+FEBekRzkdRKReYTL11OXqRSbVzxlWPBGL7ZM/h
 5aCyjLkRYEyQlU+LcTON9Oq4VCDnVkcv+NQRXn4AMRhR1rx+tNILQ3wkf4FDMUeIjrTxjah9
 li3ADVJgcLvsoMK4N3yqqTclLiQEsx6BVt8I2nXyZ2UJBvq1DOv7qEYWdnZYA2Hcn3//ZuTQ
 Nl8ztb+AaUhp0lLuY8tKIRb5/syyPW3roAL0zk+OmvAammqLbZSInOm+81rnY8Vz597vTqGY
 G6+yuN4C56oZvy8SEUwITA7ZNutzfsXwznezcokKXXAuRNYwuC1blVwDTKt1gpmM7pHAKE0y
 7wAuekXyTCFpDgED9Kkth1QpkOwdiEucqN/rZwLIp7ZuixywHF4XJHsICvX4paOVtZyDncXM
 gKk3JTlubAN6XfBIlwSFGfM19VznZ4hmg5H535cKkWrmujqvO4W3hpQ+G4JXw5Q8A5j1rNiC
 HlKLGxwH72FpB1ztfhAXketOgBPPwKY8UrP0Gk0lHXVYk2rd27VJkg/BLq9x18Y+GdiYTRrx
 rGU52L7WzLMfsuq/C8NdWN6iv7kF/pdyxbjnZ25IsG7AJUKWzrprauwb24uqRG8I8cQhlXCl
 NZ67tRLdqz3Gi4BkZIVU7DA++wrdymFA2heTdVK3qADRzjccQ7v/wm+ERm6f8cVKsHa9UO9N
 ddVGftOcBaDzweLkCEQAP8dAr1zncNx3uE4RJHQGTckvYec/x1Ti7CB0gjlhWQufcdirtZlF
 KPVaAC5MzKxgVl6pjbzifdqa0uCXMk8RQzj3eqK3v0DOLAdvcpNL0wj8LuGkE+EEQlg/iC7j
 ljnYYnIw9xAy7ZXwpHeIodeNTqrNNmoduKp8R+ygftKf9jgIcfDjCJLi1jFbiB9H6odZMRzr
 puJ6OXI5ULiuK0ndVzZl72qNbh71e/rUMV5asvIfWRnxw2cU8rS0j4/0mGfK60RtuhC58OiF
 jCKWOHpefE7A95ilWBoMQ5AGBMgCoPyXKfqhQW5i9+uUhE98wj2HOmLxE/TT1NwV3E3YsXlK
 wrOpfyRyMhSr91MCD86FvhWOcJED2G5a5Q2Ve/alGe+NXapsGOgq7G5tBsH6BP3MFemPvv+w
 6r4QknZSEzvloDOld1Xitkn9FlfRnNwmvI5cU8h6sZ7wWLyRnIPKeMGd44KENdImyj1z4v1f
 yzJcHBkMyjmQDBYal/p1bwPhOtE6jAmYb8V5wDF/n94rw+6CpzGG7x87CxtpXR7YD3uyKegM
 952Frgc+PSu6skBeArRzqXTbSRbKjfyxX8S/0351cvoDH7yxJ0UgWd5ElMluTPvSqnweYaiG
 YTxbWNJWke2TQj2C8kIl7u53v0GlGuH8gjEphtjDDoSV0t3AQGAJDDC1znP74A+
IronPort-HdrOrdr: A9a23:2hLovK8tas5YVErzb0Vuk+DXI+orL9Y04lQ7vn2ZhyY1TiX+rb
 HJoB17726StN91YhwdcL+7VJVoLUmyyXcx2/hyAV7AZniDhILLFvAA0WKK+VSJcEfDH6xmpM
 JdmsNFaOEYY2IVsfrH
X-Talos-CUID: 9a23:gwXSs20YWKpt0UlHVDvxZbxfQs4FV3TYzVnrJl6EVkhAFJCweRyN0fYx
X-Talos-MUID: 9a23:PzCiRgtv52iwcpzJLc2nlTwlbOJi2oiUBVEBgYtZ4ZWCbygpEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.05,245,1701126000"; 
   d="scan'208";a="78813059"
X-MGA-submission: =?us-ascii?q?MDFgy2Av6eOLRzJLtVgueoTOmBVQiTJLfG4Z47?=
 =?us-ascii?q?5DxRs4tp36KiLQ+4+brvQx9So64pddOKxXG74dhFem21784gBSRoMgae?=
 =?us-ascii?q?OjrYSqhODfk+VXsI9fYSu0ApR/F5feEzwdvdg485JFqZeZyyRPSxgm+Y?=
 =?us-ascii?q?nxqkyM8tOWwgKbaJDWAoRsGg=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 00:36:11 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E4BEC6118D;
	Mon,  5 Feb 2024 23:36:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74E1DC433F1;
	Mon,  5 Feb 2024 23:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707176168;
	bh=j+BdWC7F0R6em6haqJKwL80V83uTHI9TzZoyC9g7qHA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BjQMKPRCcFTaeAbbEyFASNypXw1GjgeebgrUhDNDQOBflWClUm9vCV3q+oFJNMm/V
	 AiRcIsqlsfC8LSxCtpf122mVLyRKTH6+EQqBk1MDA3zaqaZzUyEQb1wa3EenlTSf97
	 pa8Wz1TYqV4oI/xYXDI96ZBx9IqXqeLml+F9I1/N2Phz8Rc2y8TaK3Z8IK2MczjSTM
	 620LSFhUXmmLEYYJKcO4ldRdx5o5oS7QHoMF1YkDNJ+DsrTCndf2IBHnoXQP0WSZUv
	 WSMtLLi6vsOnMBbbWUBwiq4byFHR64m7GG+ONpg4CLjX5akZZMSeTsCWwneYUnNgLd
	 /w7GHsFxER4Yw==
Date: Mon, 5 Feb 2024 15:36:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <20240205153607.46fc6bdf@kernel.org>
In-Reply-To: <alpine.DEB.2.22.394.2402052336420.44759@hadrien>
References: <20240205095637.54f3f450@kernel.org>
	<alpine.DEB.2.22.394.2402052336420.44759@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch --use-patch-diff broken?
Reply-To: Jakub Kicinski <kuba@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 1505
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/20240205153607.46fc6bdf%40kernel.org>

On Mon, 5 Feb 2024 23:37:30 +0100 (CET) Julia Lawall wrote:
> > FWIW the git hashes are from this tree:
> > https://github.com/linux-netdev/testing.git
> > (probably best to clone that thing with --depth $number)  
> 
> What number do you suggest for the depth?  I tried 1000 but I
> don't have these hashes,

1000 is enough, but the hashes don't exist on the main branch
so you'll also have to specify --no-single-branch when cloning.
