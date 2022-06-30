Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3523C43334
	for <cocci@archiver.kernel.org>; Thu,  7 Jul 2022 09:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:message-id:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vDnuLLCFQnK/ak2ZiySLZHFYhD1XVCmcAVtpq5RFaJ0=;
  b=gkcrx2oxsVroXIH7SYqOJZhzi8I1SrjqhYtTmyYby8Zv3NGbR1R7IHly
   wSy3+yiIqRIV6esBw6nVs41fLw2zurq/lhImxtppPT2RoFQM6Y2PVElDN
   9Pq1EgcNjdmTFfWT+SsJk+RwmdO9sgOl6m39DPPHOZ/e2MFNrmr320aCj
   0=;
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="5.92,252,1650924000"; 
   d="scan'208";a="44643627"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Jul 2022 11:24:04 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 04EB9E034D; Thu,  7 Jul 2022 11:24:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 9C063E0092
	for <cocci@sympa.inria.fr>; Thu, 30 Jun 2022 10:08:32 +0200 (CEST)
IronPort-SDR: nhDjysqk6U8y5K0zLbcmy7wRYfTjWsbKoYHKbEED9WRDmUMWYoNGz/FEc9r5CKa7wQGJiBgJoz
 kqJaDhWrGWQfP6Q5bAhHiSnwqdAngR9QYGDvFzaSWnAR/Wlx3WnUIpxs5b4CCXYG54VW4iMFzG
 gdi21rkn2rUIiRuQVwn9Ja++ZtanxMu6Mk5pGk2fbeQJmUPDfs+/7vnm1NtC/KwjKoNOv1+tTR
 VfELjZlx6nXt8SqhKwGRiZV04nBSrxYr4NAJb+EVxTCj2/ZJkz9TVaAGIhCUVN36yUeQKh7vE1
 IQLGTb3ei9ULbPA//PHTIfLT
X-IPAS-Result: =?us-ascii?q?A0BCAwDXWL1ihxiIhoZaHgEBCxIMQINzgVYvBAtEkzWBd?=
 =?us-ascii?q?y6ecgsBAwENQgQBAYpQAh0GBjQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBEwEBAQENCwkFCAoHDhAFOwFjAWcBgU4BgXkGBDANgjUihCwGAQE4h?=
 =?us-ascii?q?E2DGQOsUYEzgQGCCAEBBoJehQgJgT2PHoIpgRUnD4hDhW6aEzkDRy8SgSBuA?=
 =?us-ascii?q?QgGAwMHCgUwBgIMGBQEAhMSUxwCEgwKGw5UFwwPAxIDEQEHAgkSCBUrCAMCA?=
 =?us-ascii?q?wgDAgMrAgMWCQcKAx0IChwSEBQCBBEeCwgDGR4sCQIEDgNACAsKAxEEAxMYC?=
 =?us-ascii?q?RYIEAQGAwgvDScLAxQNAQYDBgIFBQEDIAMUAwUkBwMhDyYNDQQiHQMDBSUDA?=
 =?us-ascii?q?gIbBwICAwIGFQYCAm4uDQgECAQ3JA8FAgcvBQQvAh4EBQYRCAIWAgYEBQIEB?=
 =?us-ascii?q?BYCEAgCCCcXBxMzGQEFWRAJIRwKHxAFBhYDIW4FRQ8oNDY8LB8bCoEaLCsWA?=
 =?us-ascii?q?wQEAwIGGgMDIgISKQY3AxYGKyicQ3oOBYFxeBEskgmQPQGBNZ0NB4NRoAEGD?=
 =?us-ascii?q?wQtg3WTJZFKlnOiC4UIMIF4gX5wgzhOAQIBAgEMAQICAQIBAgECAQgBAQIBj?=
 =?us-ascii?q?hwZg1mKYUExOwIGCwEBAwmPBQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 r/sSg8=
IronPort-HdrOrdr: A9a23:POJG9qhp892HTJYGiJOlOgyc2HBQXsUji2hC6mlwRA09TyX4ra
 uTdZEgvyMc5wxwZJhNo7+90dC7MBDhHMdOkOss1NSZMTUO2lHFEGgK1+KL/9SKIUzDH4Bmu5
 tdTw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,233,1650924000"; 
   d="scan'208";a="18153739"
X-MGA-submission: =?us-ascii?q?MDGuzN02aLXK22rv7LdEaYpDlss8c0QS1YRkMy?=
 =?us-ascii?q?9Fros97vX2ZRCy1ulhnkOF93gG4vd0LMUi3J+1a7KRIrbs5u7Qlqb2rv?=
 =?us-ascii?q?QFneUKgMfIeH3FjMIH1Oz92zdEsjW7lh+uDzteaxuE8e5biWNHcxhYGW?=
 =?us-ascii?q?HanNloH0boBm0k004vAGrCRg=3D=3D?=
Received: from mga09.intel.com ([134.134.136.24])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 10:08:31 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656576511; x=1688112511;
  h=date:from:to:subject:message-id:mime-version;
  bh=4ueVebIY0by+fItkuMt37gEtEiSHSdnS5szoyOeFI5A=;
  b=TE7qZ/UspSSJRxH0h1YtDSNjWC3Dt9v19hi1ZKlWVpDPdvT+cJLNBF58
   vyiSvEC//iDkGXom8IVj2w5rX6CjcYlMuVGgeSzTNJPea1k5STnBwygTe
   EQrtIXAHMgV7nbf3FGLHYg7O7HJYEPwAMJIoJuuEmUvPueBmwWKCePhcI
   P8+8M0MI+jmfL+zOay21hsniUudDjrK13YlUeCEWSye6RM0K/fzwNpsxT
   e/KlG6/p4m/0FIeMTr57dakMMg8ClRwoNQBwWp0pyouh5fS5lay89gEkO
   hQeWpVS39V1azUw5dwKoVy4bn08/OAl9pcWIlYPYOwARVPf65t/DTs+ir
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10393"; a="283015682"
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="283015682"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 01:08:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,233,1650956400"; 
   d="scan'208";a="647786690"
Received: from emontau-mobl2.ger.corp.intel.com ([10.249.42.178])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 01:08:25 -0700
Date: Thu, 30 Jun 2022 11:08:18 +0300 (EEST)
From: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: cocci@inria.fr
Message-ID: <7d52b5cd-9b7a-e966-ee3d-f3343c8dcfb6@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Validation-by: julia.lawall@inria.fr
Subject: [cocci] spatch errors out with "not supported"
Reply-To: =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 483
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-07/7d52b5cd-9b7a-e966-ee3d-f3343c8dcfb6%40linux.intel.com>

Hi all,

I tried to find a particular pattern with coccinelle, but it seems to give 
me an error. Here's a trimmed down version highlighting the problem:

$ make C=2 MODE=patch CHECK=scripts/coccicheck COCCI=scripts/coccinelle/cleanups/write_verify2.cocci drivers/ata/sata_mv.o
  CHECK   scripts/mod/empty.c
/usr/bin/spatch -D patch --very-quiet --cocci-file 
scripts/coccinelle/cleanups/write_verify2.cocci -I ./arch/x86/include -I 
./arch/x86/include/generated -I ./include -I ./arch/x86/include/uapi -I 
./arch/x86/include/generated/uapi -I ./include/uapi -I 
./include/generated/uapi --include ./include/linux/compiler-version.h 
--include ./include/linux/kconfig.h scripts/mod/empty.c
not supported
coccicheck failed
make[1]: *** [scripts/Makefile.build:250: scripts/mod/empty.o] Error 255
make: *** [Makefile:1199: prepare0] Error 2
$

Here's write_verify2.cocci:

virtual patch

@@
identifier writefunc =~ ".*write.*";
identifier readfunc =~ ".*read.*";
identifier rval;
expression wval, reg;
@@
-       do {
-               writefunc(wval, reg);
-               rval = readfunc(reg);
-               udelay(...);
-       } while (...);

If I comment out those do and while lines, coccinelle picks up the 
relevant fragments (but the loop is important part of the full construct 
I'm looking for). Why does it fail with do {} while ()? I've checked the 
grammar and according to it "do single_stmt while (dot_expr);" should be
a valid construct.

$ spatch --version
spatch version 1.1.0 compiled with OCaml version 4.11.1
Flags passed to the configure script: --prefix=/usr --sysconfdir=/etc 
--libdir=/usr/lib --enable-ocaml --enable-python --enable-opt
OCaml scripting support: yes
Python scripting support: yes
Syntax of regular expressions: PCRE
$

I feel I've seen that "not supported" other times too. I don't know if 
it's easy to make it more verbose where things go wrong (I could find any 
option which would have told me more than that). Such an error message 
isn't that helpful like you can imagine.


-- 
 i.

