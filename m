Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16566CCFA13
	for <cocci@archiver.kernel.org>; Sun,  9 Nov 2025 12:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=rDEOPMBrXo5X+CO1/39F+gRi6czAnQmGjvtC0iylfx8=;
  b=qJXDqs21LRcPlNyOtamL7hZqEO59zEKmSKl3Sy8srJAq473gcYlz368K
   xFuK9rR6efBEYdEnXlnEwkHNOIG4AwettoBV5sOoDY1nvFPgdziN1NVAx
   E+mjPZ+EM2R9dPiQWhWv6CH47dPBH6mEA4kpdUv9JXvy+4/CfZ1Hze8Cc
   g=;
X-CSE-ConnectionGUID: YL1RiU8uQJ2OT52MI0ehnw==
X-CSE-MsgGUID: OJ1DKpjyTOeoNt41ajsKNw==
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="248358176"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Nov 2025 13:10:33 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 2715BE0264; Sun,  9 Nov 2025 13:10:33 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 739C1E0171
	for <cocci@sympa.inria.fr>; Sun,  9 Nov 2025 13:10:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rDEOPMBrXo5X+CO1/39F+gRi6czAnQmGjvtC0iylfx8=;
  b=iXihX2zqHPJUxnKxypu6U9DGAau1BiOhObFQRB1IRshi43xy2UW2A3jT
   WMvO3U4tm33pTmap3vm43CkVPP2oKw+XlFveKVt2kIRdX1UhWKW/Y20kU
   65aFnPT0z36lN1mJmOyOXfJzXgdYoWJxWelbZEXNuQRuhBWZLNolCtjzu
   s=;
X-CSE-ConnectionGUID: YFSusD8kTBy4ZbG39uoDEA==
X-CSE-MsgGUID: yxUcn/86SiuON+VTsEtvSw==
X-IronPort-AV: E=Sophos;i="6.19,291,1754949600"; 
   d="scan'208";a="130372411"
Received: from c-174-179-106-199.hsd1.va.comcast.net (HELO hadrien) ([174.179.106.199])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2025 13:10:29 +0100
Date: Sun, 9 Nov 2025 07:10:27 -0500 (EST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Markus Elfring <Markus.Elfring@web.de>
cc: cocci@inria.fr
In-Reply-To: <f32da236-a8bf-4ff9-a18f-f8536ac5d5a3@web.de>
Message-ID: <1ccd768a-a1c8-2858-e084-b42f764cd6f@inria.fr>
References: <f32da236-a8bf-4ff9-a18f-f8536ac5d5a3@web.de>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1120254527-1762690230=:3407"
Subject: Re: [cocci] Restricting information search for header files
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 3151
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-11/1ccd768a-a1c8-2858-e084-b42f764cd6f%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1120254527-1762690230=:3407
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Sun, 9 Nov 2025, Markus Elfring wrote:

> Hello,
>
> I would like to extract some information also from header files.
> It would be nice if a file search can be restricted accordingly.
>
> Some information was provided for the clarification approach “Source code
> analysis for header files”.
> https://lore.kernel.org/cocci/alpine.DEB.2.10.1501071549410.3328@hadrien/
>
> Did interests evolve any further also for such a development topic?

You can also use script code to exit if the file name is not suitable.

julia
--8323329-1120254527-1762690230=:3407--
