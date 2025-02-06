Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E9FFC02194
	for <cocci@archiver.kernel.org>; Thu,  6 Feb 2025 10:01:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0h23ZxxDa6aWcubRN85TU3TD4mWRcmPB60HCKl06mI8=;
  b=ifa3vrA5ADgQGHhWNgTBJICcnAgveqdVMV5hIDyDEjC27Zid6I8fatsR
   XO/sO/WObs3UlZCINjxzSvdKfeAdVC7K1eihnGN+lV/uH/qaZN2lp3G4U
   cVBljRv5ZTx8pLEd5X0lOC1QUx/CPJ32CRF4AQfvIWfVIOGm+jkl3HlKp
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
   d="scan'208";a="206885355"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2025 11:01:21 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id C9F5BE0D1E; Thu,  6 Feb 2025 11:01:20 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id D6102E0260
	for <cocci@sympa.inria.fr>; Thu,  6 Feb 2025 11:01:17 +0100 (CET)
IronPort-SDR: 67a48855_bzBkUul2qSjg/pyEPtTAFAzfw76HETtjTRbNy7IwVfDqOI+
 8BkmUHoqq6oc8hsymh/ePf96HHOYMJDg13JluMg==
X-IPAS-Result: =?us-ascii?q?A0HBAQD/h6RnhRAmd6hagQmBUwKCQn1ZNAcISIRWiHyId?=
 =?us-ascii?q?AOcPoFWgX4PAQMBDTsGAQIEAQEDAQOFAAKLAiAGAQQwCQ4BAgQBAQEBAwIDA?=
 =?us-ascii?q?QEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQFASYV7DUkBEAGCBwEzcYElAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBARcCCAVeAR4BAQEBAgEjBBkBATgPCxgCAiYCAlYGA?=
 =?us-ascii?q?YMUAYJBIwMRBq8Oen8zgQGCDAEBBoFXQlDZN4FlAwaBGi6FbIJjAYFsg34BO?=
 =?us-ascii?q?4Q8QoINhD8+gQUBgUQXAoFIGINbgmmCM4Fvg0CGTIMfiG+QHAlJexwDWSwBV?=
 =?us-ascii?q?RMXCwcFgSlIAyo2MSOBIwU1Cjc6gg1pSToCDQI1gh4kWIIrgiCCOoRDhE2FW?=
 =?us-ascii?q?4ISgWIDAxYQAYMhehyDbR1AAwttPTcUG58HPYMldIE5cSqBIjqTKrJqhCWBY?=
 =?us-ascii?q?4o1lXuBS6kHmHwijWKbKoFnOoFcMxoIJgqDIk8DGQ+OOAKDYYRYw1dFMgI6A?=
 =?us-ascii?q?gcLAQEDCYVEAYIviD2BSwEB?=
IronPort-PHdr: A9a23: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
 QBOx77kf9x7Cw==
IronPort-Data: A9a23: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
 E4bjFdhL4xbNrL/dEfpVx8UbXdINM+2
IronPort-HdrOrdr: A9a23:uLxEXalpsc+zY5z30BqvZnKBsK7pDfIf3DAbv31ZSRFFG/Fw8P
 re+cjztCWE6gr5PUtKpTnuAsi9qB/nmqKdpLNwAV7AZniAhILLFuxfBOLZqlWLJ8S9zJ8/6U
 4KScRD4bPLY2SSwfyKhDWQIpIlyNyY+LulwezX3H9kVmhRGsdd0zs=
X-Talos-CUID: 9a23:s3BL8mF7fQuRDXuPqmJ3/kIxJ4cAf0H73VjKO1eAEFkubK2sHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AZeIbBAzGFlgXlZWq8KRdim66oFOaqKivOk4Hkpg?=
 =?us-ascii?q?th8y/CzUtJBWQqzKlSYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,264,1732575600"; 
   d="scan'208";a="206885165"
X-MGA-submission: =?us-ascii?q?MDHODk6RDOXvt2a1xX685SHdMzUCKNdwpp3h73?=
 =?us-ascii?q?GV+fnGTC6TW8kp6X67ZvuaJtBBdSjW11Z64DaV2TukXuD47KDxMHCr8B?=
 =?us-ascii?q?7utkkeZ2JDHg007Gi7YszQmvhp4/5eIELSDn1n5TYmk/9dAtUZpqK3r5?=
 =?us-ascii?q?LadMEBL89hjFJozFeJ09jNWg=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2025 11:00:53 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0h23ZxxDa6aWcubRN85TU3TD4mWRcmPB60HCKl06mI8=;
	t=1738836053; x=1740045653; b=gL1I/pM4mEcQRY0fRh/gxD0M9/hdP/1CpGCC8R0omapI5oZ
	lb+I6D9oU+Fz7W9V+akJO0kKWVOhVa9TWljFLIhhpLlFViAzg7XguUwtXWyO3DQMSoCPOZNGsP38m
	p84wOc2qRD8BM3heWSp57YoT9Xh0Zc7SRHVDbReRXsp6hMpU5qr6zEGWuTTiBiNn2DBLUOx86ou5r
	XJyPbkjYWwxQOMBgHUaeZVc2dFpDSChGcKwen1IwWPtnapqxa4fFdO8k0Z0qUW8JAz0JWx3U5rn9t
	J+v9ob5eKRqZq8wXIt5sVp04XPRs+ePWTZdyvdHA2Ihzqarmz6l0aoyp1usYl2hQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tfygm-00000004yMn-1YOQ;
	Thu, 06 Feb 2025 11:00:52 +0100
Message-ID: <02480ae10c7b29f524668f69282603a4f2bdb307.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Victor Gambier <victor.gambier@inria.fr>, cocci <cocci@inria.fr>
Date: Thu, 06 Feb 2025 11:00:51 +0100
In-Reply-To: <4ed80c12-f83f-4d4f-aac9-166218943535@inria.fr>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
	 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
	 <4ed80c12-f83f-4d4f-aac9-166218943535@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: Re: [cocci] possible regressions in 1.1.1 -> 1.2
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2355
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/02480ae10c7b29f524668f69282603a4f2bdb307.camel%40sipsolutions.net>

On Thu, 2025-02-06 at 10:53 +0100, Victor Gambier wrote:
> > With "spatch version 1.1.1 compiled with OCaml version 4.14.2" this
> > works just fine; however, we're trying to upgrade our dependencies and
> > now with "spatch version 1.2 compiled with OCaml version 5.2.0" it
> > doesn't match anything any more? I can't seem to figure out why, I
> > thought maybe the types didn't match - not sure why we had added type u=
8
> > to that, but pretty sure it was needed - but adding more types didn't
> > really help either.
> We don't officially support OCaml 5.2.0. Could you let me know how you=
=20
> installed/built Coccinelle?

Heh, funny. I didn't even really think about it; it's the nix package
from their 2024.11 release:
https://github.com/NixOS/nixpkgs/blob/nixos-24.11/pkgs/development/tools/mi=
sc/coccinelle/default.nix

> > I stand corrected, I wasn't patient enough. On a machine _much_ faster
> > than my laptop (server CPU), it finished (with warnings about
> > inconsistent modifications) after a bit more than 10 minutes.
>=20
> Glad to hear! We know there's been a performance regression in 1.2 and=
=20
> we are looking into it. It's a little faster in 1.3.0, but still slower=
=20
> than 1.1.1. It's unclear at the moment to what extent the performance=20
> has been degraded because of necessary fixes that perform unavoidable=20
> additional work.

OK. I guess we'll have to stick to 1.1.1 for the time being, it does
what we need, we check the output, and this probably more than triples
the overall runtime :)

johannes
