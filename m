Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABA5606A32C
	for <cocci@archiver.kernel.org>; Sat,  7 Nov 2026 10:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=Vp39dxAG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=6OMoQFhSD9uPr1PAtpO6dxNv49H72Shafoz2GMV/oD4=;
  b=Vp39dxAGm14w0FBeWi1yWbp75TAT0gZZikfMS3NECtqT0lfadqJ1U2QG
   BJ7OpbBmHqxWMIaQoQ0q26Aq1VdRXDn0T3qs8T/FzeTHtT9G1GZ9ttlPC
   02HLs3YDf+w+4rcDr3Y/BVlx4mWu5f6pLMY/SxHPf/4foClfXLL0uyzGS
   M=;
X-CSE-ConnectionGUID: m3hQaefbRmuLuRxnuvSYpw==
X-CSE-MsgGUID: OKBXZJZkRKmcG/VFeZOveQ==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,200,1787004000"; 
   d="scan'208";a="304323441"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Nov 2026 11:59:21 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 6EA8681B6C; Sat,  7 Nov 2026 11:59:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 43A0281C37
	for <cocci@sympa.inria.fr>; Mon,  2 Nov 2026 14:24:24 +0100 (CET)
X-CSE-ConnectionGUID: cTG1mg4oRomi5M145nrB7Q==
X-CSE-MsgGUID: eUYD39OAR+2BtzggJ+ZKfQ==
IronPort-SDR: 6ae88f07_F5oZAaarPnYmo/r2WKnKEbIMCJU0xQRw1sO0/FSGBc8omQh
 hB6OCv3a/XIKixaBkWgLiEsK3vlVzA/Whd/+XlQ==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HCAgCMjehqgwosKNhaHgEBCxIMghKCP4ELYDQHCEkEh?=
 =?us-ascii?q?FSIeoh9mD6EDINTDwEDAQ1KBwQBAQECBIR+Ao4eIAYBBDQTAQIEAwIDAQEBA?=
 =?us-ascii?q?QEBAQEBAQELAQEBBAEBAQIBAQIEAwEBAQECEAEBAQE5B0mGTw1JAYlIAYIHA?=
 =?us-ascii?q?YEkgSYBAQEBAQEBAQEBAQEdAg1+AQEBAyNWEAsYAgImAgJWBgESgwIBgnQDB?=
 =?us-ascii?q?Qy7boEygQGEf9lKgW4GFYEKLoVygm0BgXGEQ4RCQj+BToRAPoJDBxcEGIFGg?=
 =?us-ascii?q?1yCagSDLpZ7CUl4HANZLAFVExcLBwWBJUMDKi8tI0sFLR2BIyEdDwgRHlgbB?=
 =?us-ascii?q?gUSICpBQ1uBEoEHXYErKF0BAh9GLRWBdgKCUYEjXQIBSUEOB0VTCSVDEkckI?=
 =?us-ascii?q?ggSCQETGiwKgRo1PAkmQRUMZAsaBRpICAILAgx2KBEQEx0gJjAFHSYdbT03F?=
 =?us-ascii?q?RkEkyuESYF9NaVwoQ+EKYFnijyWB6pwLodmkHQji22BepVbhV8BgX4jgVxNI?=
 =?us-ascii?q?xWDIhIBPQMZD44uDQmIc8lIJjICAQEBOAIHAgcOAwuHTIpQgUwBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 TBdeF2oi31XhaI8/QiMtpKV9NwkUOvT8ggV
IronPort-HdrOrdr: A9a23:u+M2UK6+ogSQv07LIAPXwFrXdLJyesId70hD6qkQc3dom6uj5q
 OTdZUgtSMc7Qx6NU3I9urwXpVoPkmskaKdjbN8AV7AZmjbUQmTXeZfBOLZqlXd8kbFmNK1u5
 0OT0CrYOeAaGRSvILc5hS5HMZl5NWc6qiniaP/4h5WPGNXQpAl1B1hAgKXVmV9WQlBAvMCZe
 ehz/sCnCC4cXAbKvymCmUIG8jPzue77K7OUFo8HQcu7ATLtz+y97LgeiLopCv2Wgk/uIsKwC
 z+igT86+GZv+umzwK07R6p06hr
X-Talos-CUID: 9a23:0DlwFW0QyhOSZ0ubj0RCCbxfEfwKK3jSkHDqJEq5VEMwFOCTU3XPwfYx
X-Talos-MUID: 9a23:ABZ7wgW15pnI0sbq/DLRtR05ZeBB2ef0Ilwfnpok+PunOxUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,191,1787004000"; 
   d="scan'208";a="303368400"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDEtWybqbwOjXZOnmuHSCvySzj8QUrpZ5SfzKL?=
 =?us-ascii?q?cPHQsUR+gv2C6QKajIpnJwNkPAcSgMjZRwGkTXrvUTSA/SxkMzkpKtIG?=
 =?us-ascii?q?X3a4UTB/YCBecsQDL+s90p9xqo/VEhGW5MO8m2LbjKH9EbrrcK+aWW4b?=
 =?us-ascii?q?7mkAT+o6k8hYdy1dmuGHiHsA=3D=3D?=
Received: from smtprelay0010.hostedemail.com (HELO relay.hostedemail.com) ([216.40.44.10])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2026 14:24:23 +0100
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 5555F40D21;
	Mon,  2 Nov 2026 13:24:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf07.hostedemail.com (Postfix) with ESMTPA id BBB802002D;
	Mon,  2 Nov 2026 13:24:12 +0000 (UTC)
Message-ID: <0df76d1a6ef8fc5b68fbb316eb6f3c5cc22f0472.camel@perches.com>
From: Joe Perches <joe@perches.com>
To: Kees Cook <kees@kernel.org>, Julia Lawall <julia.lawall@inria.fr>
Cc: Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
 Linus Torvalds <torvalds@linux-foundation.org>,
 driver-core@lists.linux.dev, Nicolas Palix <nicolas.palix@imag.fr>, 
	cocci@inria.fr
Date: Mon, 02 Nov 2026 05:24:11 -0800
In-Reply-To: <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org>
References: <9b55b3e3269ef43ede64fff34f42121f7aa47979.camel@perches.com>
		 <1a6026c4-3e19-a1a9-e637-f1842172482b@inria.fr>
	 <E7A57F75-AB90-4B41-B942-55D65F2B65D8@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-3.fc44) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: rspamout08
X-Stat-Signature: dk57tc4uaibxtmhkbsjwrtw87pinejyp
X-Rspamd-Queue-Id: BBB802002D
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/fG62APAOp1gzsVmFy0AZGqLx5uKO3JxI=
X-HE-Tag: 1793625852-693149
X-HE-Meta: U2FsdGVkX1//Sn46R+Ih4ThsuJzgmL6hpjmCdzMad3WkAY86mnJHsXub6FBf2vmSMEAtIm7phF/I12tokv0R9AzlYnXlaTXTOTg0jJuaLRdtNGXz2a/s76wt4rTI80YzGcBepa7WA4JBoqqJdQ3vrh+Okv+yHfGUQ1H40mwfcUG+w0fIEt9ZD3neIirm1aXxRv2bcAxdCyUySSlIMWKg35gVZ4DKXE/p0y2CAkCUz8v2vD+xcoa91m/KZoXv9IfroUmvc6tzit5GnAwwxyeBz9Us/epXn2EIChfVHhqxbEX0gWnyR+p6zjmGo64B6vXXXXHr9geXYHzMQsfwUmxsbX7x1ieADxktOL3/CnDiACGNiy38G/23AW2u/wyndR+dmnT04wK8leh/Ik4X02BqJkyupg2/n9r9S+apMPCAZ73RcG63nzCma6/gf168nsgLRsrdmxKpExQ=
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [resend PATCH] coccinelle: Add devm_kmalloc_objs
 conversion script
Reply-To: Joe Perches <joe@perches.com>
X-Loop: cocci@inria.fr
X-Sequence: 3774
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/HMRr-pq11QJcC31437NaQA>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 2026-11-02 at 00:52 -0800, Kees Cook wrote:
> On November 1, 2026 3:51:53 PM PST, Julia Lawall <julia.lawall@inria.fr> =
wrote:
> > On Sun, 1 Nov 2026, Joe Perches wrote:
> >=20
> > > Like commit bdc5071d7f7b ("coccinelle: Add kmalloc_objs conversion sc=
ript")
> > > with commit 1c7bbaeed110 ("coccinelle: kmalloc_obj: Remove default GF=
P_KERNEL arg")
> > >=20
> > > Finds and converts sized devm_kmalloc-family of allocations into the =
typed
> > > devm_kmalloc_obj-family of allocations.
> >=20
> > Applied
> ease don't send this. I already did this. See the PR I sent for rc1:
> https://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git/log/?h=3Df=
or-linus/v7.4-rc1/devm_kmalloc_obj

Kees, I cc'd you back in June on my first attempt for 7.2-rc1

https://lore.kernel.org/lkml/eed0c57a2c897e34d411229c3de41c5402791894.17815=
75297.git.joe@perches.com/
