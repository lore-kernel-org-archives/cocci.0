Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AADEB64D7
	for <cocci@archiver.kernel.org>; Fri, 16 Jun 2023 09:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:cc:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=q1pG4oYpIIOv8uGSYr9Gxh/iOwuc8Lz36JFlfHDG9wk=;
  b=U6g9N5QvZUoBJtLKh8uX5g7LeAh0gj8UHT8fvjMDIgkf5mpQp7WD4Mis
   PV0kNNip0CyUpwWcgodYVizetodEpkYgCg0T9MX7sqYez1SpFSGEEFsEJ
   qvYccHpd1H4Xyw+SEz20/HyWGg6KvdYh3URFfgng3buUBmlYdj4ioxsIW
   k=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="113202041"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Jun 2023 11:55:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9C876E03AE; Fri, 16 Jun 2023 11:55:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 2CF2CE0157
	for <cocci@sympa.inria.fr>; Fri, 16 Jun 2023 11:49:07 +0200 (CEST)
IronPort-SDR: 648c3012_H4imzbfzC8l2EGVv0CxPxVoZSRzPqsRvPUXvv3PFjFQejyA
 csAOw3dwXD8/qXBlWXSv0gok+zp7b0YBEP7OU4g==
X-IPAS-Result: =?us-ascii?q?A0FpAAByLoxk/z4rTJBaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YIuelAuAwcIR4RSiHyIVQOdb4F+DwEDAQ1BAQIEAQEDBIFMgzMChX4fBgEEM?=
 =?us-ascii?q?gcOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAUBAoEGE4VoDYI3KQF1g?=
 =?us-ascii?q?QgBAQEBAQEBAQEBAQEBAQEBAQEBFgIIXgEBHQEBAQECASMdAQE3AQQLCxgCA?=
 =?us-ascii?q?iYCAlcGhUsjA7AceoEygQGCCAEBBoJmmmqBXwmBFS0BiTmIJkKCDYRAPoREg?=
 =?us-ascii?q?1uCZ44tkG6BKG+BHoEifwIJAhFBJoEICF+BcUACDVQLC2OBHIJUAgIRKRMUB?=
 =?us-ascii?q?TwReR0DBwOBBRAvBwQyHwkGCRgYFyUGUQctJAkTFUEEg1gKgQ0/FQ4RglotN?=
 =?us-ascii?q?j8bVIE3NwMZKx1AAwttPTUUH0opgVcwgUcKJCSjdBNMMEE0CDh1oUeiQIQSg?=
 =?us-ascii?q?V2fcIFKgjeTIzaRfZgXqDeBagMzgVkzGggmCoMiTwMZD44giE2LIkIxOwIHC?=
 =?us-ascii?q?wEBAwmFRAGGAwEB?=
IronPort-PHdr: A9a23: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
 TfTqdh15VerjrvWogc=
IronPort-Data: A9a23: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
 D3eFrDN0sCN/6xU
IronPort-HdrOrdr: A9a23:gkRdRaNRBFZRcMBcTuijsMiBIKoaSvp037Dk7SFMoHtuA6ilfq
 GV7ZEmPHrP4wr5N0tBpTntAsa9qDbnhP1ICOoqTNGftWvd1VdARbsKheHfKn/bak/DH4VmuZ
 uIHZIRNDS9Nykcse/KpA2xFsgp29XC+6i6je/Epk0dND1XVw==
X-Talos-CUID: 9a23:z5fqDW3WW/YwmKU2DC+k+LxfHsoKLy380i/pPmToDWdTFaPLc2W65/Yx
X-Talos-MUID: 9a23:FB0q/wUoYdS4JsTq/B/HiQM8JZtM2vW/LWMm0ro7i+SEBTMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.00,247,1681164000"; 
   d="scan'208";a="58900510"
X-MGA-submission: =?us-ascii?q?MDGWZhrFXm9mAT/G+A30TaupvU/F07NvY872oL?=
 =?us-ascii?q?LrEGa55RaAi7B0HlpX77Axa7oiNkB1nsXRyJo/vqg42EOUQcs0CL6ap1?=
 =?us-ascii?q?ZI/7WtTkrbTW1qMkUFjd1igVX0zXxb2AxEoxhI1AVbid2RAYPIG6ldYU?=
 =?us-ascii?q?D1/vssbnHZnnBVCqGtLll31g=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([144.76.43.62])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 11:49:06 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=q1pG4oYpIIOv8uGSYr9Gxh/iOwuc8Lz36JFlfHDG9wk=;
	t=1686908946; x=1688118546; b=yGBg3AAobsZHK3RxPwEju7zOgqBEZi03U3e46BJ/i7NIzeE
	4bbkNhQvI5GtmNto1RPyuXqmWW3Ajbc+oUnSUGi0y/d8cKrFr78RSsePXyZR8h14FtOfrfT1lWU6O
	BiPbMxbOHFbnKBN0k4ny7wL80FqAf+dQ/+hpZfQMV0kcoTDOLNUdgAcrEv+aRazz3zkTvknKYXdYU
	xxDbM80hofxKpu6GPO2fqWKuEWYy1/1t5agcgXc7OUtNlwgD8/WgjIebGhKl2VYwommLbEKPmyylL
	E0S9ImQLnV6Wj00z4aUSURb72y9zfJPGxLgDqDqDf6ZAcIN/VvjadW6dzAgDrqyQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qA64n-008J2N-0t;
	Fri, 16 Jun 2023 11:49:05 +0200
Message-ID: <80a12cb225f9e709e35e4fcf3473c39156a7b2d8.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Date: Fri, 16 Jun 2023 11:49:04 +0200
In-Reply-To: <d4f38fa8-e590-e62b-c311-ab7f6a868070@inria.fr>
References: 
	<a02bbe916c864ebaf407426dda76af34d1bdda6f.camel@sipsolutions.net>
	 <d4f38fa8-e590-e62b-c311-ab7f6a868070@inria.fr>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] macro parsing issue?
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 1185
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-06/80a12cb225f9e709e35e4fcf3473c39156a7b2d8.camel%40sipsolutions.net>

On Fri, 2023-06-16 at 11:44 +0200, Julia Lawall wrote:
> > @@
> > identifier test.fn;
> > type test.t;
> > expression pos, exp;
> > identifier ret;
> > @@
> > t fn(...)
> > {
> > ...
> > (
> > +#if SOMETHING
> >         ret =3D strsep(pos, exp);
> > +#endif
> > )
> > ...
> > }
>=20
> The code parses fine.  The problem is that ... requires that the pattern
> before and after the ... is not matched in the ... region.  You probably
> just want all calls to be modified whereever they occur, so you would wan=
t
> <... ...>.

Hm, yes, I think I want <... ...>, I can never remember this properly
and erroneously tried <+... ...+> and ended up with this ... oops.

Still though, getting verbose output shows it's mismatching some macros?

ERROR-RECOV: found sync end of #define, line 37
parsing pass2: try again
ERROR-RECOV: found sync end of #define, line 37
parse error=20
 =3D File "net/mac80211/debugfs_sta.c", line 37, column 1, charpos =3D 1146
  around =3D '',
  whole content =3D }
badcount: 7
bad: #define STA_READ_D(name, field) STA_READ(name, field, "%d\n")
bad:=20
bad: #define STA_OPS(name)							\
bad: static const struct file_operations sta_ ##name## _ops =3D {		\
bad: 	.read =3D sta_##name##_read,					\
bad: 	.open =3D simple_open,						\
bad: 	.llseek =3D generic_file_llseek,					\
BAD:!!!!! }
ERROR-RECOV: found sync end of #define, line 45
parsing pass2: try again
ERROR-RECOV: found sync end of #define, line 45
parse error=20
 =3D File "net/mac80211/debugfs_sta.c", line 45, column 1, charpos =3D 1380
  around =3D '',
  whole content =3D }
badcount: 8
bad: }
bad:=20
bad: #define STA_OPS_RW(name)						\
bad: static const struct file_operations sta_ ##name## _ops =3D {		\
bad: 	.read =3D sta_##name##_read,					\
bad: 	.write =3D sta_##name##_write,					\
bad: 	.open =3D simple_open,						\
bad: 	.llseek =3D generic_file_llseek,					\
BAD:!!!!! }
ERROR-RECOV: found sync end of #define, line 49
parsing pass2: try again
ERROR-RECOV: found sync end of #define, line 49
parse error=20
 =3D File "net/mac80211/debugfs_sta.c", line 49, column 2, charpos =3D 1466
  around =3D 'STA_OPS',
  whole content =3D 		STA_OPS(name)
badcount: 4
bad: }
bad:=20
bad: #define STA_FILE(name, field, format)					\
bad: 		STA_READ_##format(name, field)				\
BAD:!!!!! 		STA_OPS(name)
ERROR-RECOV: found sync '}' at line 84
ERROR-RECOV: found sync bis, eating } and ;
parsing pass2: try again
(ONCE) CPP-DEFINE: inside function, I treat it as comment
(ONCE) CPP-UNDEF: inside function, I treat it as comment
ERROR-RECOV: found sync end of #define, line 447
parsing pass2: try again
ERROR-RECOV: found sync end of #define, line 447
parse error=20
 =3D File "net/mac80211/debugfs_sta.c", line 447, column 1, charpos =3D 122=
10
  around =3D '',
  whole content =3D }
badcount: 8
bad: STA_OPS_RW(agg_status);
bad:=20
bad: /* link sta attributes */
bad: #define LINK_STA_OPS(name)						\
bad: static const struct file_operations link_sta_ ##name## _ops =3D {		\
bad: 	.read =3D link_sta_##name##_read,					\
bad: 	.open =3D simple_open,						\
bad: 	.llseek =3D generic_file_llseek,					\
BAD:!!!!! }



(though with 1.1.1)

I had interpreted that as it getting confused about the macro layout in
the file ... sounds like that was wrong!

> You don't actually need two separate rules for what you are showing, but
> perhaps that is an artifact of the simplification process.

Indeed, the =3D~ line was much more complex, and I needed two modification
rules, and didn't want to duplicate the =3D~ line.

johannes
