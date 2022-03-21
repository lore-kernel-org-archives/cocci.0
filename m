Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA725C433F5
	for <cocci@archiver.kernel.org>; Mon, 21 Mar 2022 20:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=lPrn22I6E4T7+ln1QysR4PZ76w/YGtovNYj161vfCYM=;
  b=rJpeoqN2yGauCXmS7dKcqJRKykc5lr2EXgP4FP4WmSNoTD/gGQnqdYyS
   qWbvzvL2Ziq8eCxK9YlOFl6BnZoSVRrETg37dykSQF8DW11YbMBSPk1Qn
   oyURTAmtPysGt/Y9NzqW+uIvaiN5YXel7DYWrWwYwEA4F/mFr4wKZeuFs
   A=;
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
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="27317191"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Mar 2022 21:48:18 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69820E0210; Mon, 21 Mar 2022 21:48:18 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C16BBE0069
	for <cocci@sympa.inria.fr>; Mon, 21 Mar 2022 19:57:41 +0100 (CET)
IronPort-SDR: piv0jsocp5X06mPVseizboyeN8m5WJEiwe+SLdXCAVXcVrMYE9Yl+Avh6og2C9ShqSd2ilc9mT
 JXBN+odHxo0/+nzv8rAOx2dLpYfdodC5tfw7ZBADMA+2us5KQZ32VWMMoz2nY7bJmqcZwHr6Df
 ixUeFHVCJ2YtM48m6UtcaR37IRIKxO77NrFclckfXsoYwn55V/kA3TmuGQQnDA1VJBWZdC4ELb
 EXBv+xfhIUjdAGijHBCaL9gXPqL0i19fesxpPWqwKGGg++sLUN4odtaGT6Bqa51lUwneDHe6jB
 WlEUeI3cITYK5odA7OW+dEMJ
X-IPAS-Result: =?us-ascii?q?A0ABAAA7yjhih100N8BaGgEBAQEBAQEBAQEDAQEBARIBA?=
 =?us-ascii?q?QEBAgIBAQEBQIFGBQEBAQELAYIngVQBAScDBAsXLYx6YIVtgiicY4F8CwEDA?=
 =?us-ascii?q?Q1BBAEBgU4BgzgChDwCHQYGMAkOAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECA?=
 =?us-ascii?q?QECBAQBEwEBAQELDQkFCBEOEAU7AWMBZwGBTgGBeQYEMA2CNSkBg2MBAQEBA?=
 =?us-ascii?q?wwmAQ0BATcBDwsVAy4QRwYTgwSDF6xmeIEzgQGCCAEBBodiCYE8AY1OeieCK?=
 =?us-ascii?q?YQ/PoFTiHGaYK8lkm0Hg0yfczOWWpFkLZYuplIwgWGCFTM9UIJpTgECAQIBD?=
 =?us-ascii?q?AECAgECAQIBAgEIAQECAY4cGYNZimA/AQIxAjYCBgEKAQEDCZFyAQE?=
IronPort-PHdr: A9a23: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
 TV4NUhKq+/IhR4=
IronPort-Data: A9a23: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
 k09ut5C/qGtaaNoplLw
IronPort-HdrOrdr: A9a23:K/dULa/SbuDUrrFd9TVuk+AFI+orL9Y04lQ7vn2ZhyYlFvBws/
 re5sjzsiWE9Qr5OUtQ4uxoXZPqfZqyz+8X3WB8B8bBYOCighrVEGgA1/qb/9SDIVyZygc178
 4JH8kfNDSzNykCsS+Q2njeLz9P+qjjzEnuv4jjJnFWJ2wFV4hQqz5wFwybDEtsRk1mBZ0lfa
 DsmfZ6mw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.90,199,1643670000"; 
   d="scan'208";a="9182912"
X-MGA-submission: =?us-ascii?q?MDGh0SQGI+J4ReTNKyBfMSaWzytO6l0ezWfkWS?=
 =?us-ascii?q?HUNzAdBZsVBZfP2K60/jIbS6oG4EoyjzFSmRuYPPNNOVBItE+gfXsNWr?=
 =?us-ascii?q?GLV9a5oljvtk4WwLl3Wr68hWq3EkRjFANz9GYP9L5Q15ygxlaMYIyEFd?=
 =?us-ascii?q?MmjebCb9/5aC9jGjEWoScgzQ=3D=3D?=
Received: from mga11.intel.com ([192.55.52.93])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 19:57:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647889059; x=1679425059;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Ckrgnk3SgL+THhKR8whyX6XMslOeejmcUKdmRZ08zW8=;
  b=A8aAqgiocsvH9Okx8/+doL160nE3nDPGW9NUlLU2PGO8OJ10k+ig5ZM6
   1AXyJu7z0i4tvC+pKcoJnYJrw2N8+zLVGyuMYabt7BQ2ig7EWNReMB4Lx
   srGiaTWE3dD24edIu6mKhFB1UkVa5LEaMvCjcHjJzHr/7lmKi1hWEIlOY
   z8Df86PHCylZ2X6iw+xzYnCTqLIlAvh6g5hy+gcPVdEmM5osczheYNQCV
   DH/vv+c82UuEkdf0SfHAkFi77ZuGdWbuBDEdcamU/KIkUq2okf9YewU0u
   +7S557CooTkAiYaD9MVOjUQOah8vveFBCtwD9HRgimdq57jCaHTlhmwiH
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10293"; a="255191504"
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="255191504"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2022 11:57:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,199,1643702400"; 
   d="scan'208";a="551824699"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.61])
  by fmsmga007.fm.intel.com with SMTP; 21 Mar 2022 11:57:34 -0700
Received: by stinkbox (sSMTP sendmail emulation); Mon, 21 Mar 2022 20:57:33 +0200
Date: Mon, 21 Mar 2022 20:57:33 +0200
From: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr
Message-ID: <YjjKnUbcJRpcoxoI@intel.com>
References: <20220218100403.7028-1-ville.syrjala@linux.intel.com>
 <20220218100403.7028-19-ville.syrjala@linux.intel.com>
 <877d8upbsp.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877d8upbsp.fsf@intel.com>
X-Patchwork-Hint: comment
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [Intel-gfx] [PATCH 18/22] drm/i915: Use drm_mode_init()
 for on-stack modes
Reply-To: Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 280
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-03/YjjKnUbcJRpcoxoI%40intel.com>

On Wed, Mar 16, 2022 at 10:00:06AM +0200, Jani Nikula wrote:
> On Fri, 18 Feb 2022, Ville Syrjala <ville.syrjala@linux.intel.com> wrote:
> > From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> >
> > Initialize on-stack modes with drm_mode_init() to guarantee
> > no stack garbage in the list head, or that we aren't copying
> > over another mode's list head.
> >
> > Based on the following cocci script, with manual fixups:
> > @decl@
> > identifier M;
> > expression E;
> > @@
> > - struct drm_display_mode M = E;
> > + struct drm_display_mode M;
> >
> > @@
> > identifier decl.M;
> > expression decl.E;
> > statement S, S1;
> > @@
> > struct drm_display_mode M;
> > ... when != S
> > + drm_mode_init(&M, &E);
> > +
> > S1
> >
> > @@
> > expression decl.E;
> > @@
> > - &*E
> > + E
> >
> > Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> I wonder if that cocci could be added to scripts/coccinelle or something
> to detect anyone adding new ones?

Maybe.

Julia & co, would you be open to having drm subsystem specific
coccinelle scripts? If so where should we put the?
scripts/coccinelle/drm perhaps?

-- 
Ville Syrjälä
Intel
