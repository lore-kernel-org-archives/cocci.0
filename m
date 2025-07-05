Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71320C8303C
	for <cocci@archiver.kernel.org>; Sat,  5 Jul 2025 19:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=4dZsOgMtVH9hal+PQ0KXGtli9p4909SOgUvns7kes2E=;
  b=I8gVqj5yIpcvfeDUek0J6JVr2B5JxPlvbro3zWMX7ASzF9Q6f4eCY3MU
   w5BlfzsC/kcoJjp4KcoM8SgTs08f6Aeu+InQDcSHBZYAWgVr8KveDX0An
   3qQmW6lMvVItpALs9Tb8tb9Io/TnbOxPW8IhgNIY6fAHiAZNbgvcKHEV9
   4=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="230464983"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Jul 2025 21:16:23 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CC86CE02E4; Sat,  5 Jul 2025 21:16:23 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 984CFE0131
	for <cocci@sympa.inria.fr>; Sat,  5 Jul 2025 21:16:21 +0200 (CEST)
IronPort-SDR: 68697a05_7iOXocl+Pagx+Ja9YkzFGVy6KNdrKfJTNdpLYWxaBwl6lko
 dXcuD94IYtz1nGs9pWelL8IpUk4fiSgDMYG/P8Q==
X-IPAS-Result: =?us-ascii?q?A0EQBACseWlog07ASNlaHQEBAQEJARIBBQUBQIFTgkSBB?=
 =?us-ascii?q?lQzBAtJhFWPUIIkhDuHPIdTiHiDUgIPAQMBDU4BAgQBAQMEggyCdAKLegIeB?=
 =?us-ascii?q?wEENBMBAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAToHDjuFe?=
 =?us-ascii?q?w2CYgGBJIEmAQEBAQEBAQEBAQEBHQJHRAEBAQIBIx0BAREnDwsaAiYCAlYGA?=
 =?us-ascii?q?RQBAYJ+giIBBhABAw4kB601gTIUbYIMAQEG2l4fLCJZgWUJgRsuhW2CZAGGJ?=
 =?us-ascii?q?4Q8Jw+BVUSBPIJSMT6IHoJpgiaBFoR5k2JSeBwDWSwBVRMXCwcFgSBDAyo0M?=
 =?us-ascii?q?SMPPAUtHYEngksagwyBDoQpK0+CInWBeUEZP4NTHgZtDwaBHRtMAgICBQIaQ?=
 =?us-ascii?q?AIBC209NwkLGwY9knCDLIN4xjU0B4I4gWeBZAyfawYTL4Nxk10OBpMCmQYiq?=
 =?us-ascii?q?RuBfyOBXDMaJIM2TwMZD44hGSWDdcEvQTU8AgcLAQEDCYVGAQGLPIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 VQIeF0=
IronPort-HdrOrdr: A9a23:LpC0o60E4UdYgpTgZgtDaQqjBGwkLtp133Aq2lEZdPUnSL38qy
 nIpoVj6faUskd2ZJhEo7u90ca7Lk80maQFhbX5eI3SOzUO21HHEGgB1+ffKlTbckWSygce79
 YDT0EUMr3N5DZB/KXHyTWZV/A93dKA7KekvuvGyWxxJDsaEZ2Ioz0ZNu6BeHcGPDWu6KBJb6
 Z1bad8zQadRQ==
X-Talos-CUID: 9a23:3i3XcW7H/5pVqoaAYdss8FdPNZsaNXDh9HLdO0WHFH5GT5mLcArF
X-Talos-MUID: =?us-ascii?q?9a23=3AoYcwmQ65vAsneuToRqgvT/ftxoxYx7+hU3tQlKw?=
 =?us-ascii?q?2kM+gCh5tZAuXjT64F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.16,290,1744063200"; 
   d="scan'208";a="120758347"
X-MGA-submission: =?us-ascii?q?MDF4ZYWE75OWPODS1jty0e6j9/Ky2EtvI+pqxK?=
 =?us-ascii?q?5E+Gsv1LemOaFkhO23/8MnONsZWQvu88dUhePB8bPQ8PzoBzknSNX+BT?=
 =?us-ascii?q?hkxmhB5mZ+aN5n8VMnRgE2DkyKkuS6s6dYakWhl8aiY/cagD1yxtTJOi?=
 =?us-ascii?q?J/DjvceKJzH+tS8NLdhjK19w=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2025 21:16:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1751742979; x=1752347779; i=markus.elfring@web.de;
	bh=4dZsOgMtVH9hal+PQ0KXGtli9p4909SOgUvns7kes2E=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=ItrTB2zfPZ9tKCPSwycYwHZMzgZGyjg0ZWYjccFREbJdlszs1MyEncGfG7giOryg
	 hVD8mlX3CkJffW5ydpd3uOizPygG//8ZDL1lukx2sDYfoJqU9qzOCQith5JOzkoHK
	 fzme9PYpNWYgDuY5lITIP8fSyQacGyB7bZQNHNVjnpOAiWbS/3gRb9G4OXpxxnHph
	 FT9jXhNaV2Rwax4MP6mAgAWQDSa/IDh7NeZoyKG+tJoGeQXKvRhjejPw/CBxZ5Syu
	 SJxIFOnIOJfRDmc8eD9e5al9LqU6WXc/V6kW3YamXh7ZJeuz4FUAwBIHX7gX7tuSc
	 hxjv2bcM7XAQq+NSQg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.92.242]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MzTLO-1uuBX926BU-015kjL; Sat, 05
 Jul 2025 21:16:19 +0200
Message-ID: <dce7dc18-7bd6-47c1-a67d-628c0c07bdca@web.de>
Date: Sat, 5 Jul 2025 21:16:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
References: <866027f2-598a-4aff-80ad-f9067ee2a951@web.de>
 <alpine.DEB.2.22.394.2507052110070.14317@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2507052110070.14317@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:uXX5EC7/IfZp4Ck9vIMiy/zxkT7dQXMxLQaJ5W1obC3QbW8LIRX
 wTrd0M5LL6FgxTf2+duvcJGQ1YQ1VTpCtrA0Oz0Rt+xvNNB9/4Ttp3y32cNo1iDHSUfN1RF
 qhCSaCNALpamBZo+G4MJw6e9RhAeeFB5XBSDe9y9jX3I5YtzcqdACyQeziRo66lOzs1Wr26
 /xLKN4aQt6ljaPiUZXhCA==
UI-OutboundReport: notjunk:1;M01:P0:zh5/PC23MMM=;PYrK7bx7OrMJYoy4RG9gmKG4lka
 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
Subject: Re: [cocci] Support for position variables on comparison operators
 with SmPL isomorphisms?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2858
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-07/dce7dc18-7bd6-47c1-a67d-628c0c07bdca%40web.de>

>> Will any more software adjustments become desirable accordingly?
>=20
> No.  If you want the position of something, it seems that you want the
> position of that thing, not something else.  So the position variable
> prevents the isomorphism.

Can the change tolerance be adjusted anyhow also according to
mentioned transformations because of SmPL isomorphisms?

Will positional extensions become helpful?

Regards,
Markus
