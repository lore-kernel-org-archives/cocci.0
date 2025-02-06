Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526F9C0219B
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:content-transfer-encoding:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=+jypH/AYMtiXi8G3F/DW3HA1IUr6IA9m590PAI5cB1o=;
  b=Jnf7iHlBdQddDw2U2bJjmpdiMl4gnmzDgMwywh4I4sY25rmXvYP/XSdD
   fGCWUv/xVwsZYUX5tsygc1msWdJMQ24EGaAJyyD0bAVTQjez8Hzv3YOtG
   vgAU4fTnwqjgjE1hOSQZ7br5/pfOlmfuGZN1AFr+Z1kX77DTEdtiPE6cB
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206877129"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 10:31:14 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7B8C9E0D1E; Thu,  6 Feb 2025 10:31:14 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 451A0E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 10:31:13 +0100 (CET)
IronPort-SDR: 67a48160_HyIVeLzR4xfbpoFTQmeiwjnBrzzuzIJUJyMpTpSqoTvTSV3
 YGhbuKNru9ITzxg1NNrG9WVI7y2FbNyyDEHCgVA==
X-IPAS-Result: =?us-ascii?q?A0HQAgDWgKRnhRAmd6haHQEBPAEFBQECAQkBFYFTAoJCf?=
 =?us-ascii?q?Vk0BwhIhFaDT4UtiHSeF4F+DwEDAQ0UAgECDhIIAQIEAQEDAQOQBCAGAQQwC?=
 =?us-ascii?q?Q4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJbO?=
 =?us-ascii?q?4IWLAhjSQQZAQE4NAImAl6DFQGCZAMRBrAPfzOBAYIMAQEGgQiBYdk3gWUDB?=
 =?us-ascii?q?oEaLgGFa4JjAYFsg34BG4Uegg2GAgGHGIJpgjNKhGWJa4hvkBwJgUQcA1ksA?=
 =?us-ascii?q?VUTFwsHBYFxA4ERgUZEN4JHaUk6Ag0CNYIefIIrhFqEQ4RNhVuCEoIOiCUdQ?=
 =?us-ascii?q?AMLbT03FBufBz2FJiwgD4E2GJQksmqEJYFjoDCBS6kHmHyOBJsqgWc6LoEuM?=
 =?us-ascii?q?xoIJgqDIk8DGQ+OOAKIOcNSRTICOgIHAQoBAQMJhUQBimyBSwEB?=
IronPort-PHdr: A9a23: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
 nK6Rj9GuFC+ie6L1yZmVxxV7DBGmNDS1Xg=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:2oRWWatQPO8Tcw8xSCjNmfBJ7skDcdV00zEX/kB9WHVpm6uj5q
 OTdZUgtSMc7Qx7ZJhOo7G90cW7Lk80lqQFhLX5X43OYOCOggLBRr2KhrGP/9SPIUPDH6JmpM
 VdWpk7DNX0E1BggYLw6BqxG81I+qjizJyV
X-Talos-CUID: 9a23:KjK0kWwRoM/EFJk3vwGeBgU3H+l8b032wUvXKk+zMGw3FuGtexiprfY=
X-Talos-MUID: 9a23:L5OwYwp+nOerXSE0ShUezzdiKfpp5pn+MgMutKgvqpSHLAFuGA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206877118"
X-MGA-submission: =?us-ascii?q?MDH22WE4Y9PwPU1DAGlInOS2C6Ht1dci/1le7O?=
 =?us-ascii?q?6dwjSsWcrqDAE5Srm7cqgkQKmTD1vO3dCYAUAr5vDViXDkQhSJVPHSK2?=
 =?us-ascii?q?Yeue19L8l4Qs/R+9W0UuNs1HbeWB2yKHfqS1FFUN01Ql/8Y+nKAqDD2p?=
 =?us-ascii?q?voK4khbKEz/7otYFglXkLFnw=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 10:31:12 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:Date:To:From:Subject:Message-ID:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=+jypH/AYMtiXi8G3F/DW3HA1IUr6IA9m590PAI5cB1o=; t=1738834272; x=1740043872; 
	b=DzS1NoLs5lnlxUGXtijidYpUNXubpfBDTk27i8OSEU8sdbGSgfldMgqq1vlifCpC84qm+hIUiLr
	5uNbJVNxODmkvEWzHnboHouLz2rc/3HDg7LlAwgLuDORXZjxtMI7K0DjtF5XKuvS4t4y0wdtDrI9X
	GQopdi55CWwbPkj0EiPQ8y6/G+ZGMvxr4ojbusTA8e02oWxQDxFKL35NSrz7gs0upxST8plzHmoID
	u5EkA+mC1MRrhpe2nU4P3U3uSc7nWoqQIMcvZBDcCy2JjpvqbdFUwfFpBBMA11iNXbogsdxr5jmz4
	j6Fe/uGXfJKL51JLiKj6ohTyA/K3iA3RD7tQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfyE3-00000004x9S-2B5i
	for cocci@inria.fr;
	Thu, 06 Feb 2025 10:31:11 +0100
Message-ID: <381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: cocci <cocci@inria.fr>
Date: Thu, 06 Feb 2025 10:31:10 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2351
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/381b5a9cb89cc068ca13546f69636291874010b3.camel%40sipsolutions.net>

Hi,

We have an spatch (fragment) like this:

@@
identifier wiphy, dev, peer, link_id, action_code, dialog_token, status_cod=
e, peer_capability, initiator, extra_ies, extra_ies_len;
type u8;
@@
int ieee80211_tdls_mgmt(struct wiphy *wiphy, struct net_device *dev, const =
u8 *peer,
-int link_id,
u8 action_code, u8 dialog_token, u16 status_code,
u32 peer_capability, bool initiator,
const u8 *extra_ies, size_t extra_ies_len);


that should remove the link_id argument from the function declaration in
the Linux kernel in net/mac80211/ieee80211_i.h (for some backport
purposes, [1]).

With "spatch version 1.1.1 compiled with OCaml version 4.14.2" this
works just fine; however, we're trying to upgrade our dependencies and
now with "spatch version 1.2 compiled with OCaml version 5.2.0" it
doesn't match anything any more? I can't seem to figure out why, I
thought maybe the types didn't match - not sure why we had added type u8
to that, but pretty sure it was needed - but adding more types didn't
really help either.



There's a second issue: we have this
spatch:=C2=A0https://p.sipsolutions.net/765e55f2b951326c.txt
It's not pretty, but it's intended to (again for backport reasons)
manipulate some code in net/mac80211/cfg.c (see also [1]). We run all
our spatches with --include-headers, and this one when running on
net/mac80211/ieee80211_i.h, goes into some kind of infinite loop? I.e.
just

spatch --include-headers --in-place --sp-file /tmp/765e55f2b951326c.txt net=
/mac80211/ieee80211_i.h

never finishes?


Any thoughts?

Thanks,
johannes


[1] there's another fragment that removes the variable from the function
but I think net/mac80211/cfg.c really only gets parsed properly when we
first patch out the CFG80211_TESTMODE_CMD/CFG80211_TESTMODE_DUMP lines
from the struct cfg80211_ops mac80211_config_ops declaration. Anyway,
the above is already an issue.

