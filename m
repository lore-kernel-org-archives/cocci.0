Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40D35CFD2F6
	for <cocci@archiver.kernel.org>; Sat, 29 Nov 2025 15:56:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:in-reply-to:references:
   message-id:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Ov2cCO5A55iKjQMAvMm1WQOT8nqU/sD0BSzymwoBo8M=;
  b=NE+HLA45pC/8qwfTf/b5W48Rv19hRSI3eC9E7Ih8LYWpxsFPCUG3UdgN
   97KKXxEb8NeSd0vlKJha+ouNhduYx3TNr+fdKEJTdNS8sAt2EfEY04t3I
   8jkJdkhysKU0IgunbKtu8/iPYkwFDNA8jmY928m1Zpr6McegmEJTOCQLf
   Q=;
X-CSE-ConnectionGUID: Esh1g5Z5SQ+1Hsmjlde5zg==
X-CSE-MsgGUID: jgCqHXWsSbCJu/OZwVZ42w==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@posteo.de
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251895416"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Nov 2025 16:56:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A23ECE0260; Sat, 29 Nov 2025 16:56:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BAB3CE0157
	for <cocci@sympa.inria.fr>; Sat, 29 Nov 2025 16:56:00 +0100 (CET)
X-CSE-ConnectionGUID: ojkNODNwQ9a59/OaDll5vg==
X-CSE-MsgGUID: wL55Fp8rTaG9pu0eXeLQow==
IronPort-SDR: 692b1790_YyFYFF7hZNJTTVqg1d3r2AxuDlv/azFsffg6O+LB6nf0CjI
 flJ9F1+7UH2xHcAw9CjlPkSk7q54aGQw/QTZ+zQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0E1CAAqFitpe0IkQ7laHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VACgj6BYDMHCEmNUIh8EZIGjASBfg8BAwENFBMoAgQBAQMEgUxAgnQCjGUCH?=
 =?us-ascii?q?wYBBDcDDQECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBAgQGAQIQAQEiI?=
 =?us-ascii?q?A47hk8NgluBLIEmAQEBAQEBAQEBAQEBHQIsPwEBHgEBAQM4AgYBASsNDwsYL?=
 =?us-ascii?q?lYhhR0CTwcBsUWBNIEBggwBAQbcJYFkCYFKAYVtgmUBhV4rKYQ0Jw+BVUSED?=
 =?us-ascii?q?jE+hFg4hXeCJoEOhiSLb4dDLCZ4HANZLAEPETUTFwsHBYEgQwOBCyMPPAUtH?=
 =?us-ascii?q?YEjIR0YEWA9F0CDSR0GZw8GgREZSQICAgUCQDqBZiIGHBICAwECAjpVDIF3A?=
 =?us-ascii?q?gIEghZ9ggoPiAuBCQUugQ0DCwdmPTcUGwYCAYE1lBJQgiiBAh6BOWwbo2CBN?=
 =?us-ascii?q?qFFNAeCOIFngV4GDJ9vEhwXl2CTC5kGqUGCEgIOgVxNJIM2TwMZD44hDBYcg?=
 =?us-ascii?q?3XEfEM1PAIHCwEBAwmFaROMIoFLAQE?=
IronPort-PHdr: A9a23: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
 xlwhgYsOYwQ
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:/enpVKlnsTHjpkG+e5WXv/P1f6rpDfIl3DAbv31ZSRFFG/Fw8P
 re+8jztCWE7Ar5PUtLpTnuAsa9qB/nm6KdpLNhXotKPzOLhILLFvAG0WKK+VSJcEDDH6xmpM
 VdmsNFaOEYY2IasfrH
X-Talos-CUID: 9a23:hXwk+2NzIAhB1u5DXytk0mk4PN8cI3SAnTD3KmO8DTt3R+jA
X-Talos-MUID: 9a23:F5KXFwpnv6uOPpowYNgezy5GaZpG+/S0NEkiwI0b48S0OAhJPCjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.20,236,1758578400"; 
   d="scan'208";a="251895407"
X-MGA-submission: =?us-ascii?q?MDGEVBhsC/T0RBJTbyzkCZKKKcVuL5DdUhXvK5?=
 =?us-ascii?q?KhWpi75fVTvcCA1cZQavmr6ig/whHIZOUQf5swvtbcPiqj8r/VVdXyka?=
 =?us-ascii?q?2U5veOAPJbHH5fd5liX/zA2uIbg9xC+dR8cq1Cvf1wWgjo0+2JlDiDCt?=
 =?us-ascii?q?61TVZT1Rxp9Qj6Mna/jchdNg=3D=3D?=
Received: from mout02.posteo.de ([185.67.36.66])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2025 16:56:00 +0100
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id F3E15240101
	for <cocci@inria.fr>; Sat, 29 Nov 2025 16:55:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.de; s=2017;
	t=1764431758; bh=Ov2cCO5A55iKjQMAvMm1WQOT8nqU/sD0BSzymwoBo8M=;
	h=MIME-Version:Date:From:To:Subject:Message-ID:Content-Type:
	 Content-Transfer-Encoding:From;
	b=D6veIvsh3L+0x6HcQBrEeT4QQ0goaFTXbI2a7hna78yd+cdg0HCn9uwTaoE4No4oW
	 CDCG6yUBmTtwc6tCnI9RG112QtL11CVD4FU7AGJXtZJJH6aUhtPeJLe06iwYCFVBCm
	 ZVnt8NiMuGw9UzbvKpGQa8JR8p4VTjZHYQYv/l2403AXI1y0E5nrFCwGY6ohKQnlgA
	 noWCx8NCsk6I7Wm5HjbUCyP+3n3B+fqH1FqG9fU/CKves71Do0xXzLdMvoiLHEJRmZ
	 hR/F6yJKGwtZQacsi8cEGkRte8duN+tib8uhu6ipU5gbjtOr7hJoq5nxM8NJmO+41W
	 xSLJf5D728CXQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4dJZWy3N7Wz6v1C
	for <cocci@inria.fr>; Sat, 29 Nov 2025 16:55:58 +0100 (CET)
MIME-Version: 1.0
Date: Sat, 29 Nov 2025 15:55:58 +0000
From: Tobias Deiminger <tobias.deiminger@posteo.de>
To: cocci@inria.fr
In-Reply-To: <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
References: <4f6e259891de0666aa1fa10b810a5dd3@posteo.de>
 <b4884a21-4a59-c549-8466-164a20a76abe@inria.fr>
 <2897bda0c438111e967017f6bb3422f0@posteo.de>
 <caf02577-eee9-d55d-1f42-7b1f3bd2f60@inria.fr>
Message-ID: <3ae5bc93f8cae1f28a068d89d3d1b070@posteo.de>
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Can we match a known macro by macro name instead of
 expanded function name?
Reply-To: Tobias Deiminger <tobias.deiminger@posteo.de>
X-Loop: cocci@inria.fr
X-Sequence: 3212
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/3ae5bc93f8cae1f28a068d89d3d1b070%40posteo.de>

Am 29.11.2025 14:51 schrieb Julia Lawall:
> On Sat, 29 Nov 2025, Tobias Deiminger wrote:
>  [...]
> The return type for the function is required in this case:
> 
> @r@
> attribute a;
> identifier fn;
> types t;
> @@
> 
> * t a fn(...) { ... }

@Julia
Thanks, almost there...

The rule with return type you suggested works when I put the expanded 
form directly in my.c

   asmlinkage unsigned long __SYSCALL_DEFINE0 mysyscall(void) { return 0; 
}

*and* additionally add '#define __SYSCALL_DEFINE0 MACROANNOTATION' to 
standard.h. Without MACROANNOTATION I would get semantic error.

But if I put the macro form to my.c (which is my original use case)

   SYSCALL_DEFINE0(mysyscall) { return 0; }

and add either only this

   #define SYSCALL_DEFINE0(func) \
         asmlinkage unsigned long __SYSCALL_DEFINE0 func(void)

, or additionally the MACROANNOTATION hint to standard.h, I always get 
parse errors, even with return type. Any ideas what's going on?


@Markus
> You might point remaining improvement possibilities out for this 
> evolving software.

Thanks also for your pointers. I've started learning about Coccinelle 
yesterday evening and think I'm not in a position to make improvement 
suggestions :D What Julia suggested would suite my case, once it works.

Tobias
