Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D81CFC27C65
	for <cocci@archiver.kernel.org>; Mon, 10 Jun 2024 09:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M74Sdy6D5IMUcptqdAeWWX8GwBKPFU/FA7tr2eAg5QY=;
  b=mQ2eyje/cyeAw31AYv8J/uBIcAHAMwARqpRIeBCIEQYqmqnFgO3M+Fb/
   A/VLTE+cc6FQ61AVjXmAXZej/4R61CqW7V2go55Ua83H2IUcF3uq1VIQW
   17Ycqj8+RakRgdDxji7nFh3aiftxwKNibo4MtBvgv9vJIkAjz4pQU3Lqy
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="169825976"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Jun 2024 11:42:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 15B39E0145; Mon, 10 Jun 2024 11:42:32 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id DBD7BE0035
	for <cocci@sympa.inria.fr>; Mon, 10 Jun 2024 08:57:34 +0200 (CEST)
IronPort-SDR: 6666a3de_XoPp45cHCxN7AK97DFf0Ics5OaBdl03xYEdmNs96p0e39Q3
 bkLfcNTk3m5y46Aw5C9Ilov/sOfmXvOBId2moVQ==
X-IPAS-Result: =?us-ascii?q?A0HPAwBiomZmfRAmd6hagQmBT4JEgVU0BwhIhFaIfIhxo?=
 =?us-ascii?q?AoPAQMBDUEBAgQBAQMEhH8CiGcgBgEEMwYOAQIEAQEBAQMCAwEBAQEBAQgBA?=
 =?us-ascii?q?QUBAQECAQECBAYBAhABASQ8J4V0DYJngR+BJgEBAQEBAQEBAQEBAR0CCGEBH?=
 =?us-ascii?q?gEBAQECASMdAQE3AQQLCxgCAiYCAlYGhVUjA60ReoEygQGCDAEBBoJn2TaBY?=
 =?us-ascii?q?wmBGi6IMQGBWYQFhF5Cgg2EPz6EQ4NbgmmZWYV2coUyJgtDiiAJS30cA1khA?=
 =?us-ascii?q?hEBVRMXCz4JFgIWAxsUBDAPCQsmKgY5AhIMBgYGWTQJBCMDCAQDQgMgcREDB?=
 =?us-ascii?q?BoECwd2gXGBNAQTRAIBgTeJcQyDLymBSSeEGktshAKBawxhg0mFKYEQgT6BZ?=
 =?us-ascii?q?gGDVFGBSh1AAwttPTUUG6xeCIFZW0o5xjqEHYFioByBTahsmGWpCoF7JIFcM?=
 =?us-ascii?q?xoIJgqDIk8DGQ+OLRaIMcc2RDI7AgcLAQEDCYVEAYNdgUgBAQ?=
IronPort-PHdr: A9a23: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
 YIVTbtGSF0yEOhcDEl5ToVqHQ==
IronPort-Data: A9a23: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
 U7Keg==
IronPort-HdrOrdr: A9a23:T8AR36HJohUjCbjIpLqEwceALOsnbusQ8zAXPo5KKCC9Ffbo8/
 xG/c5rsCMc7Qx7ZJhOo7C90cW7Lk80sKQFgrX5Xo3SOjUO2lHEEGgK1+KLqQEIWReOlNK1vp
 0NT0ERMrPN5BRB/KHHyTj9F94k3tGd/OSijfTXx2wFd3ASV51d
X-Talos-CUID: 9a23:j12FhmNgkBkXy+5DdgVtr2kJBuMZSif3zmvsD0q6Dlk2R+jA
X-Talos-MUID: 9a23:lgS/mwgkakBeAyqdohoXOMMpb/hz7KWeJGA2n7osmsWdDG9AFWnCpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.08,227,1712613600"; 
   d="scan'208";a="89234697"
X-MGA-submission: =?us-ascii?q?MDF84VWJXyLS3Uko5ZFkC2LYzs4wKUuTTGNRx6?=
 =?us-ascii?q?fI+F9TgRI2Ww38ND8NkVTrXKuCyA62wvUIMi2MFjVi144nmosV5GlR7v?=
 =?us-ascii?q?zWoafCy6nlIy9BOnRKaiRCfCMirN1BUc39n53qQG8henFJidm8ivAHtA?=
 =?us-ascii?q?7F0FE5PjIicA9EWebWEiVSDA=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 08:57:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=M74Sdy6D5IMUcptqdAeWWX8GwBKPFU/FA7tr2eAg5QY=;
	t=1718002654; x=1719212254; b=Snocj9cCmcuFseNlyPRd0fIFywulqJq+OsQP2NEnTXaDuqO
	urlSILwr1eCbvxT6yuxHM76dOQwexlS3UORBHjHAA14Z39ch35e88rsjAxj0znZRJk63ZUl5qBtuV
	xVkMM9NumXC5zLbPUOYWxyzLGywAWPirBaJuykbVg7Ocb9F1hxenfYxVqGiaxTZjBBp374tkxZc9P
	AYVwlrpd5ygNQSmebIdGL6cV3KWaltoHsrTikrFlVVDj9FkjwGjzqJmLqokQladxJE/Q1N+Gtg7ny
	yDV314l++POlhfCAa0Lz1WtVQ5I68NJ9s8jSMU+VoDtNbrFkUB66sRLGCMnRoHiw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sGYyC-00000006KUP-3rBI;
	Mon, 10 Jun 2024 08:57:33 +0200
Message-ID: <a01e8d2f2f5d90373fa094a8514ea2f5736db8dd.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Date: Mon, 10 Jun 2024 08:57:32 +0200
In-Reply-To: <f0ad5ab5-d3ea-ac6-3c6e-dd1be07f4e41@inria.fr>
References: 
	<9c981025522250c68c8cca83a2fa3e32097bae3b.camel@sipsolutions.net>
	 <f0ad5ab5-d3ea-ac6-3c6e-dd1be07f4e41@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] strange braces behaviour
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 1789
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-06/a01e8d2f2f5d90373fa094a8514ea2f5736db8dd.camel%40sipsolutions.net>

On Mon, 2024-06-10 at 08:49 +0200, Julia Lawall wrote:
> >=20
> > void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_i=
d)
> > {
> > }
> > }
>=20
> This problem is fixed.

Cool, thanks a lot! :-)

Do you have a pointer to the code or something by any chance? We might
be building spatch anyway (need to check, but at least have an easy
option to with nix packages), so I might be tempted to pick that fix up
before release for our internal automations.

Also, I'd like to check against the similar issue I had with removing a
whole switch statement ("-switch(...) {...}")

> Even though it's just one extra brace, it was a
> serious problem.

This was also the more simple test case - in other functions I could
actually make it leave more closing braces, I think if you had multiple
inside the function.

Thanks,
Johannes
