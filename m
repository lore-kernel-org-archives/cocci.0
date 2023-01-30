Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671D1C54EED
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 09:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=M9yDS0xO3NfpUbRtIZL4sF0kFD0u0fDH0tpsFxgAgKw=;
  b=VyCgoJwfUcG7VEYTZQWrFTdEuw1Xjml31euYfCL6h/DqLOE6Ja2EjMNk
   /ylHgTuJjS2qOso4gP9QtsdyL4BTXsFOSVmiyUAnUA+qXgyNL3BSNVb7y
   SOvn3eoyQKkxgmedaI4I7DuOxKHt9/ehDL3JUVQcH/El+SJhygpLy96uZ
   g=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90030551"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 10:52:06 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id BAAC5E7442; Mon, 30 Jan 2023 10:52:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 50B12E743E
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 10:52:05 +0100 (CET)
IronPort-SDR: 63d79344_wtlYaCtBh+goE0G7HGDq13x4E1Gke1f9naEj0KoSMl7iySp
 DGBKI7PLcln1O2iPnia5CYxVQOW6a+0S9CQsNpw==
X-IPAS-Result: =?us-ascii?q?A0GVAABIktdjjEYpCbBaHQEBAQEJARIBBQUBQIE+BQELA?=
 =?us-ascii?q?YIsgV4rAwQLhRSIfogkEZtWg1QPAQMBDUQEAQGFBwKFJh4GBjMGDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEDAQEFAQEBAgEBAgQEAQECEAEBAQFARYV1gjcpAYN/AQIDI?=
 =?us-ascii?q?1YQCxgCAiYCAlcGAYMQgyMHAalLgTKBAYRzmmaBZ4EULAGJEINlhDBDgg2EP?=
 =?us-ascii?q?z6IHIJnBJtpCoE5d4ElDoFGgQ8CCQIRSCxANwMZKx1AAws7Mgo/NQsLShAbG?=
 =?us-ascii?q?hsHgQYqKBUDBAQDAgYTAyICDSgxFAQpEw0nJmkJAgMiXwUDAwQoLQkgHwcVE?=
 =?us-ascii?q?SQ8B1Y3AQUCDx83BgMJAwIfT3IuERMFAwsVKkcECDYFBhw2EgIIDxIPBiZDD?=
 =?us-ascii?q?kI3NBMGXAEpCw4RA1CBTgQvgWIGKSaiPVrDUIN/gVKfGDKBRIIiARKlNpdPI?=
 =?us-ascii?q?IItpUaBeCSBXDMaCDCDI04DGQ+OOZYpP28CBwsBAQMJjCMBAQ?=
IronPort-PHdr: A9a23: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
 rzI7M6cAT1f25cMwjnGyepHtGM=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0p4NIqoTLE4vhBgg4sAnWhEaV5oUeYIsimQD101hICG9vPb2qy
 nIpoV46faUskdzZJhOo7690cW7LE80sKQV3WBzB8bHYOCFggGVxehZhOOI/9SjIU3DH4VmpN
 9dmsZFZOEYQWIK6PoS+DPIdOrI2uP3lpxAm92utktQcQ==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="46335335"
X-MGA-submission: =?us-ascii?q?MDEuOAhV1E6hIlvXaPfZS0RkM7OlzYEmXuvqjs?=
 =?us-ascii?q?v2u82VHsCeYvg9EQAZFHx0gtoF/FauUWCfrIFkCyAMr7xE9XTH8kVZ7q?=
 =?us-ascii?q?UJ1bMokSz5z2tWrLFTCC6Xx+KBWKS8vJT132rQC03UjkSBzGrM/pr734?=
 =?us-ascii?q?gragrJIVN9WtV/ScbzZBipKQ=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 10:52:05 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMQpV-0060Cz-TF;
	Mon, 30 Jan 2023 11:52:03 +0200
Message-ID: <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
 <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Mon, 30 Jan 2023 11:52:01 +0200
In-Reply-To: <079efecb-91da-e111-1a28-2c883b69af7b@web.de>
References: <df710cc39e1da39521f09827f5528703887e9bce.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301272148570.4094@hadrien>
	 <add79b45c4369d40ced6ae5fb43535e14a7aa792.camel@coelho.fi>
	 <808cd549-f96d-872d-a4db-30ea33095207@web.de>
	 <alpine.DEB.2.22.394.2301281048270.2822@hadrien>
	 <8f3f48170bab688aff69571913dbe27fc195fe1f.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301281432120.2822@hadrien>
	 <a1eed78f1f3f24c20fc11bb7328c3cb05db1611c.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301291826510.2852@hadrien>
	 <543612938885a445d33ca5ae6d04a06a753c1caf.camel@coelho.fi>
	 <2338a91ffe751ceb6325e76bc526b84ca85fc4c8.camel@coelho.fi>
	 <alpine.DEB.2.22.394.2301292109320.2852@hadrien>
	 <3f376cb31e9050d005417809a9fa51d92cdc57d6.camel@coelho.fi>
	 <dc9d939d-e1bb-8447-e950-deacc7a3645a@inria.fr>
	 <13bf65ac8504fa5ebcaf69539422fcd38bf157d1.camel@coelho.fi>
	 <23ba4681-0b9e-cf60-5422-64526cdf462a@web.de>
	 <e1ebf2b582bd97d42e8573471fac83578d47ef17.camel@coelho.fi>
	 <079efecb-91da-e111-1a28-2c883b69af7b@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 850
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel%40coelho.fi>

On Mon, 2023-01-30 at 10:50 +0100, Markus Elfring wrote:
> > I don't think the problem is in the rule, since this works on an
> > isolated version of the function and macro definitions.
>=20
>=20
> Would update candidates be found by using the SmPL asterisk
> functionality?

Sorry, I don't think I'm aware of this functionality.

--
Luca.
