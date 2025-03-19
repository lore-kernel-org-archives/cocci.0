Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C21C36007
	for <cocci@archiver.kernel.org>; Fri, 21 Mar 2025 13:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=pR1kgF7JkakLCyR0CWer+t+qtkaz2a3Ty5fgCi/Ih4I=;
  b=cSwFflPNbKRx+sdj4DFJQ0X9424U3U3cUioCYND2cOy8LIOHS6vQwCbv
   Evi8dJLPGDStaQuIfWigZj5ejXvS8s35ps97MyH8IDe0TZStg8Kqr9rzO
   5sRV0z+AGeW8He6X8lPinVnYxctL87NR+5CmvCorjqwrCgcbinJoBB2WI
   8=;
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
X-IronPort-AV: E=Sophos;i="6.14,264,1736809200"; 
   d="scan'208";a="214140810"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2025 14:45:07 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 048E4E0D24; Fri, 21 Mar 2025 14:45:06 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id BD209E007A
	for <cocci@sympa.inria.fr>; Wed, 19 Mar 2025 22:30:22 +0100 (CET)
IronPort-SDR: 67db376e_K/z6jnI30G2DIlZ6H0HKmw4apBAJfyiu2VnADaTLVGAaw+O
 gabVAWNnkZmwqr1SKFBoDL/okOYPxE2l5O6s3AQ==
X-IPAS-Result: =?us-ascii?q?A0EBAADsNttnhdlUsotaGQEBAQEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?RIBAQEBAQEBAQEBAQFAgT8EAQEBAQELAYJDgVczBAtIjHNfhlSCJJJMi0iBf?=
 =?us-ascii?q?g8BAwENRAQBAQMEhQACiyECHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEQAQEFA?=
 =?us-ascii?q?QEBAgEBAgQGAQIQAQEBAUBJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BA?=
 =?us-ascii?q?QEDJxMGAQE3AQ8LGC5WBoMVgmUDr32BATOBAYIMAQEG3CCBZQmBSAGFbIJjA?=
 =?us-ascii?q?YYwgxQleicbgg2BFYMqPohYgi+CM4Fpg0GJTohUmCNSexwDWSwBSwoTFwsHB?=
 =?us-ascii?q?TkoSEMDgQ8jgSIFNDQOOCmBY2lJOgINAjWCCBNdH4IogheCNoQ+gy+BEIFlg?=
 =?us-ascii?q?2uCEYFcAwMiAYIwb3UcgxOBKj2EYC1QgjMdQAMLbT03FBsGpDWEcCsjE4I5E?=
 =?us-ascii?q?luTIY9SgiCfSIE+hCWBY6AyE4E4lXuTES6YUKkzgWc6gVwzGggoCIMiTwMZD?=
 =?us-ascii?q?44hGYh0sUQjNTwCBwsBAQMJkByBSwEB?=
IronPort-PHdr: A9a23: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
 8LJmaa1Ly1NoYq8wA==
IronPort-Data: A9a23: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
 bjLq6dhLoxYNrH/eUfkhj7xvZJJNA==
IronPort-HdrOrdr: A9a23:bjDV+6NfTC+8CsBcTs6jsMiBIKoaSvp037Dk7SFMoDhuA6ulfq
 GV7ZAmPHrP5Qr5N0tNpTntAsa9qDbnhPhICOoqTNKftWvdyQiVxehZhOOIqQEIWReOlNK1vp
 0BT0ERMrPNMWQ=
X-Talos-CUID: 9a23:6piWRmPrvKzlxe5DZTNN6XEvIpwecULA/nmLOn2+WFdvcejA
X-Talos-MUID: =?us-ascii?q?9a23=3AFVKFIg3GLfaTYPTzy05CvGfRYzUj/KS+V18Oycg?=
 =?us-ascii?q?/5e6FMwheIjC6qhfrXdpy?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,259,1736809200"; 
   d="scan'208";a="213788094"
X-MGA-submission: =?us-ascii?q?MDHBLawBFBF+nOPJm5FiP2pfIWvdjU4HT3ed1a?=
 =?us-ascii?q?aKRXpZEBdYyLeyyREZBCARKR9lAdVGWSOWswViE+qrbc/+GgBqBXWxrg?=
 =?us-ascii?q?OMpIejKyX2BuT8DFgdsY49WhGTCy5kis7lC2d+8JlpOIc6a0JJSs6b5O?=
 =?us-ascii?q?i9XzMZPqrnukRXGoYFhB0NIw=3D=3D?=
Received: from dfw.source.kernel.org ([139.178.84.217])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 22:30:21 +0100
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 17C3E5C6467;
	Wed, 19 Mar 2025 21:28:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B624FC4CEE4;
	Wed, 19 Mar 2025 21:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742419817;
	bh=W/8afd0byL4mI229XJiGplLqx+bn/cCc8Kez6tUEGr8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mEH7o5UW5v/6RwMMpfua/i5l5IesNXBbKbQfobSWw1N/o6S1hL9gPfRkiGfz3HRC0
	 bonXu7sfnoPdPTTFouK32+3BiCTzj0VJ2qZgyNGnx9k+tKHJmF+MClEiaMKRoZEtXc
	 VbgELaAJZOa1Itd+a3yH7no+IqjmmV+zrj9u8nvcz8/twxQCCLXI8haAyufacYblOl
	 gzYWeGm5N43g/jGUBVSNn/pZbufiXyhWyzB6UDqF9DrgmrBpNwHITi2tmMgKMAc1tn
	 LX9D+znPi3fNKj53jE1p2emcq2CaKkah2Zdn9mjl1BOZI1fijW7kIO/ZhLL7j8t3VR
	 L2PvQnMFtNkPw==
Date: Wed, 19 Mar 2025 14:30:14 -0700
From: Kees Cook <kees@kernel.org>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
Message-ID: <202503191424.2FA8A7E@keescook>
References: <202503180924.2135CF8FD@keescook>
 <F7BB5789-F9F2-4D17-986A-AD7BC976F18B@inria.fr>
 <202503182023.D7C4D91@keescook>
 <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8714afb-4938-9beb-9f0-4a4972f4b81@inria.fr>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] __free() attribute inhibits matching?
Reply-To: Kees Cook <kees@kernel.org>
X-Loop: cocci@inria.fr
X-Sequence: 2670
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/202503191424.2FA8A7E%40keescook>

On Wed, Mar 19, 2025 at 08:44:38AM +0100, Julia Lawall wrote:
> On Tue, 18 Mar 2025, Kees Cook wrote:
> > On Tue, Mar 18, 2025 at 06:56:40PM +0100, Julia Lawall wrote:
> > > I think you want
> > >
> > > Expression *m;
> > >
> > > A->@m b
> > >
> > > B would be an identifier
> >
> > But how does "B" get correctly type restricted? (Or in my example,
> > "NAME"?)
> >
> > I tried:
> >
> > @direct depends on !(file in "tools") && !(file in "samples")@
> > type TYPE;
> > TYPE *P;
> > TYPE *MEMBER;
> > TYPE INST;
> > identifier NAME;
> > expression COMP;
> > identifier ALLOC =~ "^kv?[mz]alloc";
> > fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
> > @@
> >
> >        \(\(P\|COMP.@MEMBER NAME\|COMP->@MEMBER NAME\) \& VAR\)
> > -       = ALLOC((\(sizeof(*VAR)\|sizeof(TYPE)\|sizeof(INST)\)), GFP);
> > +       = ALLOC_OBJ(*VAR, GFP);
> >
> > This parses, but don't match (from crypto/asymmetric_keys/x509_cert_parser.c):
> >
> > 	cert->pub = kzalloc(sizeof(struct public_key), GFP_KERNEL);
> >
> > But does match (via "P"):
> >
> > 	cert = kzalloc(sizeof(struct x509_certificate), GFP_KERNEL);
> 
> What is the command line, eg --all-includes?  You can try
> --verbose-includes to see what is happening with #include "x509_parser.h"

Okay, my hiccups continue.

I do not seem to be able to mix a "type" metavariable with anything else.
For example, instead of these rules repeated:

@direct depends on patch@
type TYPE;
TYPE INST;
identifier PTR;
expression GFP;
expression TYPED;
identifier ALLOC =~ "^kv?[mz]alloc$";
fresh identifier ALLOC_OBJ = ALLOC ## "_obj";
@@

(
        TYPE *PTR
-       = ALLOC((sizeof(*PTR)), GFP);
+       = ALLOC_OBJ(*PTR, GFP);
|
        TYPE *PTR
-       = ALLOC((sizeof(INST)), GFP);
+       = ALLOC_OBJ(INST, GFP);
|
        TYPE *PTR
-       = ALLOC((sizeof(TYPE)), GFP);
+       = ALLOC_OBJ(TYPE, GFP);
)

I wanted to write it as:

        TYPE *PTR
-       = ALLOC((sizeof(\(\(*PTR\|INST\|TYPE\) \& TYPED\))), GFP);
+       = ALLOC_OBJ(TYPED, GFP);

But this doesn't let me even put "TYPE" in the \( \) at all, much less
put it into the TYPED expression:

minus: parse error: 
  File "scripts/coccinelle/api/kmalloc_objs.cocci", line 55, column 34, charpos = 1235
  around = 'TYPE',
  whole content = -     = ALLOC((sizeof(\(\(*PTR\|INST\|TYPE\) \& TYPED\))), GFP);

How do I collapse these three into 1 rule?

-- 
Kees Cook
