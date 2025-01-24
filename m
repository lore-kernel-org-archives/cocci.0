Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95132C02193
	for <cocci@archiver.kernel.org>; Tue, 28 Jan 2025 09:13:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=qIMgPCSrDgaMamlGemIE3nBhxxyHtySj7aOSGxfdsQ8=;
  b=ZMnpmSVmHmdWGThqlQIgIOX3Gu5f3YchnayjK7DHfdpgWvVeSbehiIR5
   EhN6MFFGD+LdGlkh5F9ICUCI/7OyRZzdzFywIQ5nYBveiphH0FlZH05rF
   K0GCY7sgKh1w3xJ4axELcUmgzGzVquR6TUoQHtkET8dzrc9d+nTheeBmo
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@kernel.org
X-IronPort-AV: E=Sophos;i="6.13,240,1732575600"; 
   d="asc'?scan'208";a="205325178"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 28 Jan 2025 10:13:15 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 164DCE0D80; Tue, 28 Jan 2025 10:13:06 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B555FE007A
	for <cocci@sympa.inria.fr>; Fri, 24 Jan 2025 18:15:21 +0100 (CET)
IronPort-SDR: 6793caa8_TQKDIdI2MdiOVzhVOYuzImpotgqg5yusIrY8iwl1pu0unHE
 LpKeQvQnijANuJ5t0C4s61rB1Lml5pziL4VGC/w==
X-IPAS-Result: =?us-ascii?q?A0GIAgB+yZNnj1vBS5NagQmBU4JEgVczBAsZL41ShlKBd?=
 =?us-ascii?q?DCGaYUKkiWBfggHAQMBCAVEBAEBAwSFAAKKdQIeBwEEMAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CYgGBJIEmAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBHQINfgEBAQIBQAEBNwEECwtGVgaDFAGCQSMDuXqBNIEBgQmBA?=
 =?us-ascii?q?wEBBt17BwmBSIFYhmsLAYFahBGDfXonG4INgRUnCwOCdT6BUok1ghwXgXSDQ?=
 =?us-ascii?q?Ihvl09SgRcDWSwBVRMXCwcFYUhIA4ESI4EmBTUKNzqCDWlJNwINAjWCHnyCK?=
 =?us-ascii?q?2sEBYErgjuERYRThVuCFIFlAwMWEAGCNXJ7H4EsHUACAQttPTcJCxuZXBx7g?=
 =?us-ascii?q?yiDHIIUKoFCVzySZIMrsAGEJYRvnFwGDwQbFJdEkw+YfKMrhgKBZzqBXDMaC?=
 =?us-ascii?q?CgIgyJPAxkPjjofiFbAckM1PAIHCwEBAwmQI4FLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 dvZUKpdT5B6etcpSfmSe8n3fmC6PPw=
IronPort-HdrOrdr: A9a23:17o8EqvmY5YkdV410Z/vKt5G7skDS9V00zEX/kB9WHVpmwKj9v
 xGuM5rsiMc6QxhPE3I/OrsBEDuex/hHPJOjrX5eI3SOjUO21HYSb2Kj7GSoAEIcheWnoU26U
 4jSdkdNDSaNzhHZKjBjjWQIpILxt+E8KzAv5am80tQ
X-Talos-CUID: 9a23:fk5lhmG2UCLdNy+2qmJ+/mkyHPB5dUbAwSb8OXeHEjhxFKa8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3ABsEMUw4lwWi8ImImjFgcGNwMxoxD75WEEXwdja4?=
 =?us-ascii?q?PlIqeMQVsBRXatCuoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,231,1732575600"; 
   d="asc'?scan'208";a="107305495"
X-MGA-submission: =?us-ascii?q?MDHVp6IPGVRqv6wpENzBNuefDprL5amxIclRk2?=
 =?us-ascii?q?C5E557/f6tghw1PHrVaA6KXue8mV8RyINzg4YsrIZ4bZzfI7fU+8ivEk?=
 =?us-ascii?q?8kXRS/2qS/M3qYsHRI+r0Ev6fqusIftwK6Ud5XC9R6AVlSV+/yCEwsRZ?=
 =?us-ascii?q?aBL4SoovHIujOgwiUMb0CqAg=3D=3D?=
Received: from nyc.source.kernel.org ([147.75.193.91])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 18:15:20 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id BA009A41BB0;
	Fri, 24 Jan 2025 17:13:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6371AC4CEDD;
	Fri, 24 Jan 2025 17:15:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737738917;
	bh=hL1Pnok4pk95DWthMJhdLv7Et5KDH2Cy8/6CclGJc9Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SSN2fOABQtjXvmiTLONv3E5DCykDu/bFTGc31Xg8GgV5eKQ04JksLBEqXsDzVJxqY
	 z5qztk2HfbPkKXSSwazOdAf+ycsArGwhNg4tLhoKuPjnDsnb1yCJG2vjSMcRG7oKe2
	 h6n4FvivW5VYzE51ri70tPB0RcgtNAeO1kBsLwOMI1vEy46IunkcwLdP85LugXFIZH
	 AA8fRZpJqnZyq3X97VgiwZflyo1EtgLQ6EohugVPVIehUf4BMHR6MXShD/NjTzAoHP
	 fOXdVnOOmijyEkR80A7n51X31yCWilr+Baluhf3ZjhCHl8YV/pB78pjgjpMaVZxKDE
	 XyzsmKa52srBQ==
Date: Fri, 24 Jan 2025 17:15:03 +0000
From: Mark Brown <broonie@kernel.org>
To: Jarkko Sakkinen <jarkko@kernel.org>
Cc: Nikolai Kondrashov <Nikolai.Kondrashov@redhat.com>,
	Vignesh Raman <vignesh.raman@collabora.com>,
	kernelci@lists.linux.dev, linuxtv-ci@linuxtv.org,
	dave.pigott@collabora.com, mripard@kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kselftest@vger.kernel.org, gustavo.padovan@collabora.com,
	pawiecz@collabora.com, spbnick@gmail.com, tales.aparecida@gmail.com,
	workflows@vger.kernel.org, skhan@linuxfoundation.org,
	kunit-dev@googlegroups.com, nfraprado@collabora.com,
	davidgow@google.com, cocci@inria.fr, Julia.Lawall@inria.fr,
	laura.nao@collabora.com, kernel@collabora.com,
	torvalds@linuxfoundation.org, gregkh@linuxfoundation.org,
	daniels@collabora.com, helen.koike@collabora.com,
	shreeya.patel@collabora.com, denys.f@collabora.com,
	nicolas.dufresne@collabora.com, louis.chauvet@bootlin.com,
	hamohammed.sa@gmail.com, melissa.srw@gmail.com, simona@ffwll.ch,
	airlied@gmail.com, Tim.Bird@sony.com,
	laurent.pinchart@ideasonboard.com, leobras.c@gmail.com,
	groeck@google.com, rdunlap@infradead.org, geert@linux-m68k.org,
	michel.daenzer@mailbox.org, sakari.ailus@iki.fi
Message-ID: <023598a3-7fe5-4882-87a1-e8ec2a5f6c81@sirena.org.uk>
References: <20250123135342.1468787-1-vignesh.raman@collabora.com>
 <D79RU9MHGKJ8.1HG89ZJS4Q5FC@kernel.org>
 <a77f2eea-1793-4e83-92b0-92b5bbd23a5e@redhat.com>
 <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Huwn+Ta6PtLsEoK9"
Content-Disposition: inline
In-Reply-To: <D7AG4810MH9U.3SA2YT8ZPY6QF@kernel.org>
X-Cookie: Earth is a beta site.
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v2 0/5] kci-gitlab: Introducing GitLab-CI
 Pipeline for Kernel Testing
Reply-To: Mark Brown <broonie@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2257
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/023598a3-7fe5-4882-87a1-e8ec2a5f6c81%40sirena.org.uk>


--Huwn+Ta6PtLsEoK9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 24, 2025 at 06:32:07PM +0200, Jarkko Sakkinen wrote:

> Can we then agree that any CI changes can be sent untested to LKML if
> a patch set needs to reflect on those? It's not reasonable to except
> local runs Gitlab from individuals for patch sets. It makes our lives
> more difficult, not easier.

I think the theory here is that this more shared building blocks for
people who want to set something up using gitlab rather than the one
true CI system that everyone has to use.  Even with people who do end up
using gitlab there's going to be issues with things like hardware access
and just realistic resources which mean that not everyone can test
everything.  We generally have an expectation that people will make a
reasonable effort to test things, not that they're going to cover
everything, and I don't see why this should be different.

> All maintainers I know test their patches for the most part with
> BuildRoot, distro VM's and stuff like that. Not claiming that they
> don't exist, but never heard of kernel maintainer who uses Gitlab
> as their main kernel testing tool.

There's a huge diversity in what people are using for their CI
infrastructure, gitlab instances are definitely in there already.  The
last time I looked at the implementation the clang testing was driven
through gitlab, AIUI the DRM and media systems also have something.  One
of the ways gitlab is handy is that it's something that companies are
likely to have set up anyway which helps with getting things
provisioned.

> > Sure, a script could be contributed too, but the value of this contribution is
> > a ready-made integration. And we want to make it easily discoverable, and
> > easily contributed to.

> This is definitely NOT "lots of flexibility".

> Are you dead seriously claiming that DevOps engineers could not handle
> well defined CI scripts and bind to whatever CI makes sense to them?
> o_O

There's going to be an audience out there for people who aren't
specifically devops people and would find it helpful to have something
to look at when getting started, and even where people are capable of
doing the work it seems helpful to pool effort on the more common stuff.

--Huwn+Ta6PtLsEoK9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmeTypYACgkQJNaLcl1U
h9AeIggAhJ8K56ckeB6tRwQTWAXxPyLs0G04D366IiHS9x4Wi98nBmIngSKwwVq7
utqbsL2LMNZyjC2PnRnNHePvVRBLLjZ+h3xRw/TSqCm/XZZdo/oyTjSZ5QvjnBt1
9BKrJ186Q8TG9xm72Oa6d6BQGpueFVhGbjsZcLRwEsLzXrvIubUEDnypRAIF9S2c
FO7tWZXjZ9gHl6nEJonyAJiiVEY+lSwggJpN77cyxcy3Z9uGBrWwzJjNfCGUYsck
byfTCKi03bXXtCt1bJCRpN/B/MPec5L4tEnT73aVeeLuRCNqjyRl8S5AZbhVp5+O
GX21rf6JPygUXusD9FYHAiCjTHRhmA==
=bKno
-----END PGP SIGNATURE-----

--Huwn+Ta6PtLsEoK9--
