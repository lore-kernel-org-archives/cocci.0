Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A8D9CE8E8A
	for <cocci@archiver.kernel.org>; Thu, 24 Oct 2024 15:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=EJnEomuYApr5UhRRzNEsIMmb0Me/sfqdeuzpn5eCJWU=;
  b=pOg4ldn++rt4igpoffhLykqTKIl4YYqv612aD2stlJesaf4+H+qZUy1A
   ory2YTIPBHo/m4qqz8MPUh52CYqB6f9T3k8AGHvsXq1tVCah1TcrcJFt+
   ++z8SzGHIrvfMCuT0UG/Sw8z0MjfABmL+d4QinIiQITG03fclKmqrH3+n
   k=;
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
   d="scan'208";a="190593402"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Oct 2024 17:23:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7AB06E0133; Thu, 24 Oct 2024 17:23:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 4C29FE013D
	for <cocci@sympa.inria.fr>; Thu, 24 Oct 2024 17:23:20 +0200 (CEST)
IronPort-SDR: 671a6667_avRO9ldT9U12+uMaNMsKB65vQyAD/dio8Fomrfn3yf6dbOK
 +BbhBnDB44VdZtTqBuTBgMJzkclMN0DxGfZ3Zwg==
X-IPAS-Result: =?us-ascii?q?A0EUCgDcZRpneROg6VVagQmBVYJCfVozBwhIhFaDT44in?=
 =?us-ascii?q?hWBfQ8BAwENNQ8EAQEDAQOCDIJ0AookAh8GAQQ2BA0BAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBEAEBBQEBAQIBAQIEBgECEAEBQg47hXsNgls7ghYsDX4BAQECASMVUQsaA?=
 =?us-ascii?q?iYCAlYbAQGCfQGCQSMDBLASgTKBAYMc2xeBZgaBGi+FaYJiAYpgFxAVBoINg?=
 =?us-ascii?q?TwOgj04PoUQgw6CaQSSBZU+gkCPIFJ7HANZIQIRAVUTFwsJBYk1CoMcgW4mh?=
 =?us-ascii?q?BGBMxIBg1+BZwlhiEKBDIE+gVkBgzhKg0yBYQU4SYJNak43Ag0CN4IkgQCCT?=
 =?us-ascii?q?4ElBAWDPIEpHUACAQttPTUJCxtDq3uBWUeEHXumBaFphCSMFpUuBg8EL4NyA?=
 =?us-ascii?q?ZNNFJJ4mHepIIIBBxmBXE00BIMiTwMZD5Ibyk9CNTsCBwsBAQMJjyGBSwEB?=
IronPort-PHdr: A9a23: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
 iDV6MNt8QjOrw==
IronPort-Data: A9a23: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
 E4=
IronPort-HdrOrdr: A9a23:QBafRaDZJ8Cl/kvlHemv55DYdb4zR+YMi2TDpHoBKiC9Ffbo8f
 xG/c5rsiMc5wx9ZJhNo6HjBEDEewK5yXcX2+Us1NWZNjUOaFHYSb2KhLGKq1bd8m/FltK1vp
 0PT0ERMrzN5BRB4vrH3A==
X-Talos-CUID: =?us-ascii?q?9a23=3Ako2XumtdaypjFezZm2PuOn7/6Is4Ynne/n3wKHS?=
 =?us-ascii?q?xGEx5FaC3VXKtu6Fdxp8=3D?=
X-Talos-MUID: 9a23:Yw7sdgrkt0up42mGRf0ezzA4CclC3fyKMxwmj6ge5vPbCXdZYzjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.11,229,1725314400"; 
   d="scan'208";a="99970784"
X-MGA-submission: =?us-ascii?q?MDElAulWtBs7VVkskIlL+/wTOHolSrEvZq68/b?=
 =?us-ascii?q?HkI5rCXcPwbktDdLavZmbmA5t74bwbRSjyNjxdHctN05nbbyxJ5AFSfc?=
 =?us-ascii?q?SUgkSC7qElDHmzMX8jNX/1NxjpgAq5mN0VEuRGiodGxvsR2iqJcBGtsm?=
 =?us-ascii?q?xdVCzKASKBaG40U6J1xQHfyw=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2024 17:23:19 +0200
Received: from [137.220.76.70] (helo=[192.168.1.187])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1t3zgD-000000003lF-9Gvf
	for cocci@inria.fr;
	Thu, 24 Oct 2024 16:23:17 +0100
Message-ID: <de874a79-09cd-49cd-bfe4-b5efff4b7e57@knosof.co.uk>
Date: Thu, 24 Oct 2024 16:23:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <11e0e0d6-a20f-4740-adb0-2f72b79df5e8@knosof.co.uk>
 <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
Content-Language: en-US
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <alpine.DEB.2.22.394.2410241646040.3352@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Multiple returns significant performance impact
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 1921
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-10/de874a79-09cd-49cd-bfe4-b5efff4b7e57%40knosof.co.uk>

Julia,

>> Is here a way of improving performance, given that I am
>> not interested in the returns?
> 
> I don't think it's multiple returns, just multiple code paths.

Ok.

Is there an option that reduces the overhead, or perhaps
an alternative way of writing the pattern?

-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com

