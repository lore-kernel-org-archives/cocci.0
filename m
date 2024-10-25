Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12504D0C600
	for <cocci@archiver.kernel.org>; Fri, 25 Oct 2024 11:54:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=RBb82RelZXIBIjhaRp2R6MBj11YXcztSFT2NXnjA+rg=;
  b=uHo8LBNypk8sXsrgbYP67KseO/G4NA9YPmC6+cqryqz8ZvELabcn8+bU
   rGuPGXe9IB1NjZSr6ObPeYYyblR5aPnB7E1wsxQzQylUCsfcV1+45HgpC
   QrYCUfCIzLxna0SAbe8n/RcJQDSX4GVlleLhfNvyBeie2/twOJnPIEakm
   o=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
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
X-IronPort-AV: E=Sophos;i="6.11,231,1725314400"; 
   d="scan'208";a="190730406"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 25 Oct 2024 13:54:07 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20888E0D1E; Fri, 25 Oct 2024 13:54:07 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 297E7E00B7
	for <cocci@sympa.inria.fr>; Fri, 25 Oct 2024 13:54:06 +0200 (CEST)
IronPort-SDR: 671b86dd_Znq+OtjGlGm8C+rJO806O6oH75PLVTOdvRz8tOFYpqdgAKz
 CwrEcxV3OgJy7q4Aujgo1zUyIl/cCZtuocACUGA==
X-IPAS-Result: =?us-ascii?q?A0ExBQDthRtnjhOg6VVaHQEBPAEFBQECAQkBFYFVgkJ9B?=
 =?us-ascii?q?lQzBwhIhFaDT5AiQppQgwAPAQMBDRQCAQIODg8EAQEDAQOCDIJ0AoonAh8GA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO?=
 =?us-ascii?q?4V7DYJbO4IWLA1+AgEDIxVRCxoCJgICVhsBAYJ9AYJkAwSvQoEygQGDHNsXg?=
 =?us-ascii?q?WyBGi4BhWmCYgGKXwEXEBUGgg2BPA6CPTg+gmeCKYMOgmkEjSqEW4tqJYkvk?=
 =?us-ascii?q?mlSexwDWSECEQFVExcLCQWJNQqDHIFuJoQRgTMSAYNfgWcJYYhCgQyBPoFZA?=
 =?us-ascii?q?YM4SoNMgWEFOEmCTWpONwINAjeCJIEAgk+BJQQFgzyBex1AAgELbT01CQsbQ?=
 =?us-ascii?q?6wvgVlHhB8Be6YFoWmEJIwWlS4GDwQvg3KBaZFlFJJ4mHeNfYdUk0+BfiOBX?=
 =?us-ascii?q?E00BIMiCUYDGQ+OOoNhh3rCZ0I1OwIHCwEBAwmPHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:OBRNTK+Fp7bllPZsaUluk+DbI+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+sjztCWE7wr5N0tMpTntAtjjfZqYz+8Q3WBzB9uftWvd0ldA/LsSiLcKqgeIc0bDH6xmtZ
 uIGJIRNDSfNzlHZIrBjzWFLw==
X-Talos-CUID: 9a23:AaWtkGCwOqZsN4P6E3hf2W5TIJAcSE/Y51iLBBGFEnhLS6LAHA==
X-Talos-MUID: 9a23:7eCGWQWMOz2rvpHq/DnmiihEMvVz2aOrJ0MHwLQK5vKlbxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,231,1725314400"; 
   d="scan'208";a="100040870"
X-MGA-submission: =?us-ascii?q?MDGJThR+dVbm/OazkwCzS3CEcV29NuMl7SAEkD?=
 =?us-ascii?q?UIK9kgNGK6/WxII4gDggg2VNuStGIarDY05NYCdTSuI6WCmLaGakgWrN?=
 =?us-ascii?q?yUqRNJI1XB0yAm0+dErHjVUIA8O9s5Rnw5qGuzQL1vBJ1iV4pPhEoFHb?=
 =?us-ascii?q?fvoyNlh8caWljB1MX22IMZkQ=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2024 13:54:04 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t4ItI-000000007Zg-2CkQ
	for cocci@inria.fr;
	Fri, 25 Oct 2024 12:54:04 +0100
Message-ID: <c28a562e-dcc2-4cc9-a9e3-39f3ea5b3619@knosof.co.uk>
Date: Fri, 25 Oct 2024 12:54:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
 <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
 <6534a8d0-78e8-48ef-b80c-a9fd3b80f562@knosof.co.uk>
 <ce176aaa-4ce2-4cd3-a943-527724957f9c@web.de>
 <d32d5bc4-3299-4977-bb0a-a3b0a53c829e@knosof.co.uk>
 <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <582c1098-213f-4c6f-ab35-4a7fb508c2a6@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1938
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/c28a562e-dcc2-4cc9-a9e3-39f3ea5b3619%40knosof.co.uk>

Markus,

> * Do you plan to analyse any function implementation sizes (according to your statistic approach)?

Some weekend reading for you (chapters 4 and 7 to start).
My book Evidence-based Software Engineering
discusses what is currently known about software engineering,
based on an analysis of all the publicly available data
pdf+code+all data freely available here:
http://knosof.co.uk/ESEUR/


-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

