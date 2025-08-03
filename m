Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A97DC87FCA
	for <cocci@archiver.kernel.org>; Sun,  3 Aug 2025 07:56:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=FJVscIIJzHIVipyLWpo5hr61qxYrnL6LOAi7K0VHsNA=;
  b=NIFIwtqVhdj125guSjVWX3/F0qeRp+BeGHaPN0klmJNYrbKvODByfeVQ
   XL0Dh8eKWw+wWbsTBYHJhL/578By+kBEXUeN6CTxTazeTGKqQsaan52Ly
   8ntg8Jel1TLMgut/TnoqnvyE09We9qGpYPHMxmYBvOnBDkxDg+aJ72O8Q
   g=;
X-CSE-ConnectionGUID: GRGfQQGkR7mCwJ6Lcggspw==
X-CSE-MsgGUID: xp1GLIGGT+O8jKxmjz5Qyg==
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
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233998271"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Aug 2025 09:56:21 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F2C7E0264; Sun,  3 Aug 2025 09:56:21 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 237CDE0171
	for <cocci@sympa.inria.fr>; Sun,  3 Aug 2025 09:56:14 +0200 (CEST)
X-CSE-ConnectionGUID: qkl3hbS/RvaLEAZDwjZ23g==
X-CSE-MsgGUID: Pv75/AjGR+q2Fh+dXoBbtw==
IronPort-SDR: 688f161d_Ldq5NDE3U8cNQ3Q8qwgUX5xJiJdzMF47PRxhTEvzrFKy3Et
 mG2OCrXlA7QRQtG1BIGphzXfZDLtBABPRhhTciA==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0EaAQCIFY9ogAMP49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UEFAQELAYJDgQZUMwQLSYRVj1CCJIQ7hzyHVYh5gVWBfQIPAQMBDU4BAgQBA?=
 =?us-ascii?q?QMEhQACjBoCHgcBBDIHDgECBAEBAQEDAgMBAQEBAQEBAQENAQEFAQEBAgEBA?=
 =?us-ascii?q?gQGAQIQAQE7Bw4KMYV7DYJiAYEkgSYBAQEBAQEBAQEBAQEdAkdEAQEBAgEjH?=
 =?us-ascii?q?QEBESYBBAsLGgImAgJWBgEUAQGCfoIiAQYQAQMOJAevaYEygQGCDAEBBtpeH?=
 =?us-ascii?q?ywiWYFkCYEbLgGFbIJkAYYng0J6Jw+BVUSBPIJSMT6IHoJpgiaBFoNjlXVSe?=
 =?us-ascii?q?BwDWSwBVRMXCwcFgSBDAyo0MSNLBS0dgSd9gw2BDoQoK0+CInWBeUEZP4NTH?=
 =?us-ascii?q?gZtDwaBFRoeLQICAgUCQ0WBYBkGGkACAQttPTcJCxsGPZNVhTaYOo4noUU0B?=
 =?us-ascii?q?4I4gWeBZAyfbAYTL4NxAZNgDgaTBZkGIqkfgW8DMIFcMxokgzZPAxkPjiGEM?=
 =?us-ascii?q?7x/QTU8AgcLAQEDCYVGAQGMN4FLAQE?=
IronPort-PHdr: A9a23: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
 klRqVsdBZsePMv31h46AmQ=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:3T2b9KvGepJbuYsJ+MDXg/my7skDotV00zEX/kB9WHVpmwKj5q
 KTdYcgpHvJYVEqKQkdcLG7SdC9qBbnnqKdjrN/AV7PZniAhILsFvAF0WKA+VPd8k/FmtK1vJ
 0IG8VD4Z/LfD1HZK3BgDVQfexQo+WvzIDto/vCxHFwSgxQZ7hn9BoRMHfnLqQ7fmh77YFSLu
 vm2iOrnUvbRZydA/7QOkU4
X-Talos-CUID: 9a23:6RnxOG6oLOGB7oZ5B9ss7U0QQcAvSTrn0n70DmaKJXlreufORgrF
X-Talos-MUID: =?us-ascii?q?9a23=3ACs5zPw1NNd+YGDMdQTVE3qeczTUj27rxVQckk7o?=
 =?us-ascii?q?8+NDeGywzNweapj6rXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.17,258,1747692000"; 
   d="scan'208";a="233998266"
X-MGA-submission: =?us-ascii?q?MDFkeKgQonTTGRaFn07+e7Lx8rd6F4aIkmKp+Y?=
 =?us-ascii?q?765+SSzVfo9AqN7TQ6iKhtZM9O8YYTCc61WKUFqz59+IXXkS1KZhIWii?=
 =?us-ascii?q?bVuWi/TWunbpN6zPUiTxtqHfS3ib9zN0onQ1tVSuyiK2MD1bjFxlB3w9?=
 =?us-ascii?q?xCTKaeCw8SydodhPGPDcCXuw=3D=3D?=
Received: from mout.web.de ([212.227.15.3])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2025 09:56:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1754207766; x=1754812566; i=markus.elfring@web.de;
	bh=FJVscIIJzHIVipyLWpo5hr61qxYrnL6LOAi7K0VHsNA=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=N4Z1Z0vqb2sKiC5e5DBOO7Tul7azxJyitrpjeihCAH2f8aBk//WlOvYtTSEC7HXC
	 ps0NMUABH8hTrQ8DW+946TbUc/eRQudmyY1ewq8EU+RPgMg0R0IiNBLKfWhgxw/2N
	 4vA4NretEDmNsPyQpt14q3PkrcJ5J26xghc1yfdGV9lqM5idd3/TIShPcCI1B7R2A
	 lj4uefV44/STyEU+j6QUp7pkX/3DNFaqfc9eulGdekYNZKuLr8AE7q0cFkwB+Svnz
	 Z+VfYzT0Rjiu8bnjbDr++JXDRJTWKZ66qoo+RbvqZvNlo/fMsw/kNL3TpXdyMB9II
	 8QQ5lBchX8EszW1lBA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.186]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Mvsln-1uP9bV1WLv-015Ijk; Sun, 03
 Aug 2025 09:56:06 +0200
Message-ID: <9d52dc57-7d0f-47ff-bc59-d5b4ce244d8b@web.de>
Date: Sun, 3 Aug 2025 09:55:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Cc: Erick Karanja <karanja99erick@gmail.com>
References: <6daf83a9-abbf-45f7-b82e-c6207364fd8b@web.de>
 <alpine.DEB.2.22.394.2508021326250.3428@hadrien>
 <7560a81f-ba29-4b16-b8ed-95cb4d72f3f4@web.de>
 <alpine.DEB.2.22.394.2508021353080.3428@hadrien>
 <e0519749-0043-4cb0-a12d-6a34e2076f58@web.de>
 <alpine.DEB.2.22.394.2508021409080.3428@hadrien>
 <c5042d2d-43df-4276-9611-da4f30763940@web.de>
 <alpine.DEB.2.22.394.2508021502250.3428@hadrien>
 <6239d52e-3213-4083-8d97-9b1f59d2d5b4@web.de>
 <alpine.DEB.2.22.394.2508021745180.3428@hadrien>
 <2130ab11-8ec0-4e57-9a73-5e1ac9e41f7f@web.de>
 <alpine.DEB.2.22.394.2508021803360.3428@hadrien>
 <51664351-746c-4d7a-ae45-2a610ba45176@web.de>
 <alpine.DEB.2.22.394.2508021822490.3428@hadrien>
 <5e8e1f8a-6832-49af-bca5-41d2a13b1322@web.de>
 <alpine.DEB.2.22.394.2508021935250.3428@hadrien>
 <a86ce687-61a5-4e52-92fa-6a0d53db9360@web.de>
 <alpine.DEB.2.22.394.2508022111230.3428@hadrien>
 <74b74c33-22d9-4282-bb2c-1c475d715e5d@web.de>
 <alpine.DEB.2.22.394.2508030730570.3678@hadrien>
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <alpine.DEB.2.22.394.2508030730570.3678@hadrien>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:X4ANsPrKDEEpo2e9ZJrH8VbLKMtua1z2WoNs8bnF0Yz8/BOsl0X
 /DiuLaUh45NWEvob4TSf0cQEgD00Y6mRk/UUYzNxc8AJLGVawzhLSOuqa56FAkHHL8oUHlt
 rPDtYb0pFyIrJ5y7gSoPQaHqxDNxLpknieNJ7NyQph5LuZbqT1OVM9M3cvhsPb1/U5csHiH
 3g3hJmeBLv75n2NZRg0/A==
UI-OutboundReport: notjunk:1;M01:P0:AvawTDa04pQ=;PSYMnJj/cTCLOYQomLsLIMtGx4t
 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
Subject: Re: [cocci] Searching for lock calls without unlocking (with SmPL)?
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2955
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-08/9d52dc57-7d0f-47ff-bc59-d5b4ce244d8b%40web.de>

>               Coccinelle works bottom up.  It finds all nodes that match
> some pattern, then all nodes that are connected to that one, etc.  There
> is no notion of first one.

Do you take care of data processing for sequences also together with
the means of computation tree logic (and linear temporal logic)?

Regards,
Markus
