Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6498C54EAA
	for <cocci@archiver.kernel.org>; Mon, 30 Jan 2023 10:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=szcUtWFmGv5Csmnb9YCsPAanOGAP1ceAVcnPL5fcg2s=;
  b=lHij5jaXZ2DjKDoJpZKMZ6VFxWWnDBC7LMuMmgHZSV9i08LHG9KGURCA
   HkD5FQFkULsVe7h08s9OqJ8aEDtGBPadzLefiuahJSfW/pqwECTvQPikO
   4Ofti9y8Cd5/Y7vxwhAvqkkc84kPiRIJThjk1m0SvPqY8bEZw9kNwoQB8
   s=;
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
   d="scan'208";a="90055168"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 30 Jan 2023 11:59:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0027BE743E; Mon, 30 Jan 2023 11:59:31 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 59ABDE743F
	for <cocci@sympa.inria.fr>; Mon, 30 Jan 2023 11:59:29 +0100 (CET)
IronPort-SDR: 63d7a311_D5iRktqWzHfG0Gi4P+lXO8kE44j/CUHZgAr2iU1qF7YEWo2
 6W7v4PxIlxbO4RW9aMp8/tXYZXLbWNKPLDYN1gg==
X-IPAS-Result: =?us-ascii?q?A0HBAgC5oddjjEYpCbBaHgEBCxIMQIFEC4ItgV4rAwQLh?=
 =?us-ascii?q?RSIfogkEZ8qDwEDAQ1EBAEBhQcChSYeBgYzBg4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAEBAhABAQEBQEWFdYI3KQGDfwECAyNWEAkCGAICJgICV?=
 =?us-ascii?q?waDEYMjBwGNP5wXgTKBAYRzmmaBZ4EULAGJEIgVQ4INgRWDKj6IHIJnBJtpC?=
 =?us-ascii?q?oE5d4ElDoFGgQ8CCQIRSCxANwMZKx1AAws7Mgo/NQsLShAbGhsHgQYqKBUDB?=
 =?us-ascii?q?AQDAgYTAyICDSgxFAQpEw0nJmkJAgMiXwUDAwQoLQkgHwcVESQ8B1Y3AQUCD?=
 =?us-ascii?q?x83BgMJAwIfT3IuERMFAwsVKkcECDYFBhs2EgIIDxIPBiZDDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA1CBTgQvgWIGKSagSoIwogehZIN/gVKfGDKBRKByhnmXT6gTgXgkgVwzG?=
 =?us-ascii?q?ggwgyNOAxkPjjmWKT9vAgcBCgEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:J7TpqKG2vavhxvB3pLqE18eALOsnbusQ8zAXPo5KJiC9Ffbo9f
 xG/c5rtiMc5wx+ZJhNo7290ey7IE80lqQFhbX5X43JYOCOggLBR72Kr7GD/9SKIVyHygcy78
 tdmuRFebjN5EBB/KHHCRODYrAdKce8gdmVuds=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.97,257,1669071600"; 
   d="scan'208";a="90055163"
X-MGA-submission: =?us-ascii?q?MDGalJdb2Hi619qA57XOE8qsogRlT6zaTvbYCd?=
 =?us-ascii?q?vqWog378YLmbG39JB5Z0slel/vk2nnFh0QHxarEmj4QL6Bkrso0m7Cw5?=
 =?us-ascii?q?dY1SeJq00qDKaqyEVz/lYqSPLF6j9JWlcZO9sZLENVIinX1MZeHjIEv0?=
 =?us-ascii?q?LvG++DjRHgjohcrBwQJMGapA=3D=3D?=
Received: from paleale.coelho.fi (HELO farmhouse.coelho.fi) ([176.9.41.70])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2023 11:59:28 +0100
Received: from 91-155-255-60.elisa-laajakaista.fi ([91.155.255.60] helo=[192.168.100.137])
	by farmhouse.coelho.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <luca@coelho.fi>)
	id 1pMRsk-0060IU-5i;
	Mon, 30 Jan 2023 12:59:27 +0200
Message-ID: <9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel@coelho.fi>
From: Luca Coelho <luca@coelho.fi>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr
Date: Mon, 30 Jan 2023 12:59:24 +0200
In-Reply-To: <4ce77f5f-2433-bb99-9270-f66267a84432@inria.fr>
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
	 <99bb02f6fdcb711102ef0b544fd6cf5a5dd90f97.camel@coelho.fi>
	 <4ce77f5f-2433-bb99-9270-f66267a84432@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
Subject: Re: [cocci] Searching for special function implementations with
 SmPL
Reply-To: Luca Coelho <luca@coelho.fi>
X-Loop: cocci@inria.fr
X-Sequence: 854
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-01/9f4c958a4bf370f7eb5fe49ac2be380ada6d9ac5.camel%40coelho.fi>

On Mon, 2023-01-30 at 11:47 +0100, Julia Lawall wrote:
> It doesn't find the file with the definition.  You may need to give more
> paths.
>=20
> I have the impression that the result is improved with
>=20
> -I drivers/gpu/drm/i915
>=20
> Maybe -I drivers/gpu/drm/i915/display is necessary also.  If you add the
> argument --relax-include-path then just -I drivers/gpu/drm/i915 may be
> sufficient.  With that option, it will just hunt around in and under the
> various include paths for a unique file that has the required name.

Alright! That _does_ improve things! Now I can see lots of DPLL matches
in that file!

Thanks again. =F0=9F=99=82

--
Cheers,
Luca.
