Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5108CE8E8D
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 15:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=2e51yeMIIf6oE3y1Fd8aVM75upvKn31BUSZp2+MKGCU=;
  b=dL+z0m7rKS41YdzNsoTNAP3cx4a0D28mx6qAMQYFRzhlrEGrBnso0pmy
   GUcj/uGK+Cm8VFW4PlktE8gorfC3VCsW+sACwN56TLOAHe02wF5+UoaCf
   o5qKQ/XpQ4Q1oY15IHDOhX3tu2zpEXpqUhW/KWVpzPO9Rm7cys0pZ0CJa
   w=;
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
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190599543"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 17:50:51 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AE7ABE0133; Thu, 24 Oct 2024 17:50:50 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id B941FE0133
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 17:50:46 +0200 (CEST)
IronPort-SDR: 671a6cd6_Qhn7Oj+WHKECYcyrg7x3Jo9kMNvH7VAG86ABLf3zY0ejmY4
 +t6lH8ak/F96vWY02H0MxUiXzcMpPLK4y7yw1cA==
X-IPAS-Result: =?us-ascii?q?A0GFAwCRaxpn/xOg6VVagQmBU4JEB3ZaMwcISIRWg0+OI?=
 =?us-ascii?q?p4UgX4PAQMBDTUPBAEBAwEDggyCdAKKJAIfBgEEMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBARABAQUBAQECAQECBAYBAoEKCAuFNUYNgls7ghYsDX4BAQECASMVRgsLG?=
 =?us-ascii?q?gImAgJWGwEBgn0BgkEjAwSwI4EygQGDHNsXgWYGgRouhWqCYgGKYBcQFQaCD?=
 =?us-ascii?q?YE8CwOCPTg+hRCDDoJpBJIFhWBthR0lTVaIDJFiUnscA1khAhEBVRMXCwkFi?=
 =?us-ascii?q?TUKgxyBbiaEEYEzEgGDX4FnCWGIQoEMgT6BWQGDOEqDTIFhBThJgk1qTjcCD?=
 =?us-ascii?q?QI3giSBAIJPgSUEBYM8gSkdQAIBC209NQkLG0Ore4FZR4J5eScEe6AohV2ha?=
 =?us-ascii?q?YQkjBaVLgYPBC+EBZM7FJJ4mHeCVqZKgWc9gVlNNASDIlILDg9YkUPKXUI1O?=
 =?us-ascii?q?wIHCwEBAwmPIYFLAQE?=
IronPort-PHdr: A9a23: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
 jbR/IYGng==
IronPort-Data: A9a23:X8/XCasXzbH5unrVzKf9tlM9tOfnVGNfMUV32f8akzHdYApBsoF/q
 tZmKW6GP6mDamvzeYxwb9vi8htVvJ+DmtY1TQJur3g3Ri5GgMeUXt7xwmXYb3rDdJWbJK5Ex
 5xDMYeYdJhcolv0/ErF3m3J9CEkvU2wbuOgTrSCYEidfCc8IA85kxVvhuUltYBhhNm9Emult
 Mj7yyHlEAbNNwVcbCRNsspvlDs15K6u4WtC4gRkDRx2lAa2e0c9XMp3yZ6ZdCOQrrl8RoaSW
 +vFxbelyWLVlz9F5gSNz94X2mVTKlLjFVDmZkh+A8BOsTAezsAG6ZvXAdJHAathZ5plqPgqo
 DlFncTYpQ7EpcQgksxFO/VTO3kW0aGrZNYriJVw2CCe5xSuTpfi/xlhJGAdHNJGwLcmPThH+
 NgVMxUrLTWjvf3jldpXSsE07igiBNLuIJtZunZ70SqfBvFgXJOrr6fitYIehmxrwJkQRbCHN
 qL1ahI3BPjESxFCIFoUIJE4m/yviD/0dHtFqzp5oIJusjCOnV0si+GF3Nz9e/KKZNhp3Uik/
 kXk80XkKRAnFcSh8G/Qmp6rrqqV9c/hY6oZE7az99ZxkViLzyoSDgcXXB21u5GEZlWWQNdDM
 woU/TEytu458wq2TbERQiGFnZJNhTZEM/I4LgHwwFjlJgf8um512kBsov99hN0aWAseXjk2z
 hmJmMj1Hnpkt/uIShpxM5+K+CiqN3F9wXAqPEc5ockturEPY73fSjrMSNF4F6DzhdqzBDKYL
 /Wisn0ln7tK5SIU//zTwL0E6g5AYrDKSAku4QuRVWXj8wARiEtJoWC3wQCz0Mus57p1grVMU
 LboViReAC0z4UmxqRGw
IronPort-HdrOrdr: A9a23:0iP3IqgfKsBRD12bTxX4OnSXJnBQXrUji2hC6mlwRA09TyX4ra
 CTdZsguyMc5Ax9ZJhCo7G90cu7K080nKQdieIs1NyZMzUO1lHFEL1f
X-Talos-CUID: =?us-ascii?q?9a23=3AEcv14mn6RA+R9lVV46kyC4ZtQA3XOVz27SiOGR7?=
 =?us-ascii?q?pNT9gRZmYUnq2u4ZEqdU7zg=3D=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3A8xLwfQ+vtIfyBUvJlk5WHGKQf8ZG44WzNAMDrc0?=
 =?us-ascii?q?hmcWlKAdxBhaFsg3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="190599531"
X-MGA-submission: =?us-ascii?q?MDHZIL+1gkFqYTANHKf6O/EJyf5ro+gszol3uN?=
 =?us-ascii?q?7nEPdaoQN/o9BcUUFo3C/+kiaLvdt7Yz+LPmAMz3TLcpDdbfKQmGmM5X?=
 =?us-ascii?q?aXjHFt/wo1rFEWBCJGrXzvM2d4AXQTw2YnCjihOY6WSaWVJGhGQ8QVgX?=
 =?us-ascii?q?XnzFGdXvhOy99yXiU54byMaQ=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:50:44 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t406d-000000003hh-7x9w
	for cocci@inria.fr;
	Thu, 24 Oct 2024 16:50:35 +0100
Message-ID: <3d11c8fb-6503-4a29-8889-03a91ca14088@knosof.co.uk>
Date: Thu, 24 Oct 2024 16:50:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
 <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241728210.3352@hadrien>
 <4872cc2f-3ca3-4bfe-b48a-ebbe5ab8a534@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <alpine.DEB.2.22.394.2410241736480.3352@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1926
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/3d11c8fb-6503-4a29-8889-03a91ca14088%40knosof.co.uk>

Julia,

> ... when exists
 >      when any>
> might be faster than what you have now.  But it will still b slower than
> necessary.

Just tried
... when exists
on a couple of files that timed out after 600s.
The reported time was 0.209s, so it's a lot faster!

I will kill the run that has currently taken 16 hours, and
still going.

> Every position variable contains complete information about the enclosing

Thanks.  This will simplify the scripts.
The OCaml source for the location declarations used such similar
meaning names

I found the slide deck
Introduction to Semantic Patching of C programs with Coccinelle
by Michele MARTONE
was a very useful update for me on Cocinnelle

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

