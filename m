Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB37EC48BEC
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 08:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=fF4CYJosd2iSah9wz4jFtr9h13cemZL0kC1QXjjsWLo=;
  b=rGY6mIHqeyO+FuYfVQkmQI7+x8BI/0c+StPGJwVGy3qzF8++XXnTOoG+
   G4DrI4r1R+W15vL4s69QSLfDE2VztuX2AEfwulebDtwQKv3iXiulDdLfn
   r8xWgCrGrz90oCh4/w4t0A/bRs4JOa7nE8g/BpPt+5GjC/iK8jjdAlmUZ
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152260611"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 09:56:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 26F2BE0CDC; Fri, 16 Feb 2024 09:56:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 146D1E008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 20:34:13 +0100 (CET)
IronPort-SDR: 65ce6734_4hRIZU3EZGBR9mA09eP6p7N3+xFqVnriBWCVLaIK41u2Czc
 lAULzECQNBOTIIA7qeY71/xUX/21CW+Pl2ldkYQ==
X-IPAS-Result: =?us-ascii?q?A0EkAACeZs5lmA5Br8ZaHQEBAQEJARIBBQUBQIE9BgELA?=
 =?us-ascii?q?YI4gVEzBAtIlBeCBSCeBoFAPg8BAwENQQECBAEBAwSEfwKHWwIeBgYyBw4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEBAQEBHhkFEA4nh?=
 =?us-ascii?q?WwNglwBgR5eBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBFAINXAEBHgECAzoGA?=
 =?us-ascii?q?QEeGQEPCxguEEYGgxOCYAOzQ4E0gQGCCgEBBrEegWEJgUgBiCUBiTF6J4Ioh?=
 =?us-ascii?q?D8+iFeCL4E6XIM7lBiFRlR/HQOBBQRcDRsQHjcREBMNAwhuHQIRIjoDBQMEM?=
 =?us-ascii?q?goSDAsfBVQDQwZJCwMCGgUDAwSBMAUNGgIQGgYMKAMDEkkCEBQDOAMDBgMKM?=
 =?us-ascii?q?TBVQQxQA2QfMgk8DwwaAhsbDSQjAixAAwkKEAIWAx0WBDIRCQsmAyoGOQISD?=
 =?us-ascii?q?AYGBl0jFgkEJQMIBANUAyF0EQMECgMTBwsHeIIJgT0EE0QDEIE0hTiEbwyBK?=
 =?us-ascii?q?gNEHUADC209NRQboheBD8hGB4QUoTozg3IBpjAumCqod4FrATKBXHCDN08DG?=
 =?us-ascii?q?Q+OIBmDYY97RDI7AgcLAQEDCYVGAQGBAIJagUYBAQ?=
IronPort-PHdr: A9a23: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
 PIz
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:U63fR6igalsuhSlR4078FYmEX3BQXvMji2hC6mlwRA09TyVXrb
 HIoB0+726ItN9xYgBbpTnkAsK9qBznhPxICOUqTNKftUzdyReVxeJZnPDfKl/balTDHz5mpN
 hdmsFFYbWdbSkYsS+52njBLz9K+qjgzEnHv5a7854rd25XgqdbhWoWazqmLg==
X-Talos-CUID: 9a23:NgSscGMs7F2hxO5DYStIrHBKAs4ZeUbE4Gn3KUygLlRVYejA
X-Talos-MUID: 9a23:klHQhQUbOzi8DWPq/BrU2DQ6ZepE3/qvWWspmNZcu9SaLRUlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,162,1705359600"; 
   d="scan'208";a="152201790"
X-MGA-submission: =?us-ascii?q?MDEN3N7MiHf+qsFOf6OANwIMx2bu1EH8yJ4JzA?=
 =?us-ascii?q?2Njfje1tl0cu0uFiT8P4h3chi9FqzsTuQg4Jci6EJotMgraAFgrCi6uh?=
 =?us-ascii?q?PN8ghmKnZE1stRg5Hnw85JN0SjqRBY70qdKxp+fCy48Hp5Gs//T393XO?=
 =?us-ascii?q?lxoUFziS2k8cALdd4spvOxGw=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 20:34:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708025652; x=1739561652;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uI6p2EeYM8i+aIvLwXONNd+KHjJzBDE6AmusnfGfHWU=;
  b=SNoKtLlfXKvWjMoyEoXhwG0C0/P//gjDGgvMkJV3WkKUyy4c0I8swXjv
   RrMOZ4CZcN9I+W3spalY+ryK+vo0eF2GX2yfwHpa9KQH5cBgQ6ANzWh1t
   aWSCaU3V96KowK8Mmr7GjsEhyk+2YDo0Sy6phfqOK9+oRXzk9ndN9Tlvq
   gMj4+mPEAkVATe1GlAlSy1IZrIcrLSoIMc8KyEbbKcvnDjVxcOGukDvKh
   gbzqVP531YaYeuqN7pTJ8dZunIOuQPdpGjHxY8vX6eHvOz65loJG2tdKn
   Si4HREAPVYWTiQYiu1VTHyImcBc3DdpEkrhN5W7JwCJV4iJ6ChiN87Mlj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5948072"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5948072"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:33:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912217507"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912217507"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:33:34 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahUB-00000004sJI-0qA7;
	Thu, 15 Feb 2024 21:33:31 +0200
Date: Thu, 15 Feb 2024 21:33:30 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-ID: <Zc5nCsE74E33PdD2@smile.fi.intel.com>
References: <20240215180156.work.548-kees@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215180156.work.548-kees@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] cocci: Add rules to find str_plural()
 replacements
Reply-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1560
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/Zc5nCsE74E33PdD2%40smile.fi.intel.com>

On Thu, Feb 15, 2024 at 10:02:00AM -0800, Kees Cook wrote:
> Add rules for finding places where str_plural() can be used. This
> currently finds:
>  54 files changed, 62 insertions(+), 61 deletions(-)

Can we extend this to cover string_choices and call the script probably
str_choices.cocci ?


-- 
With Best Regards,
Andy Shevchenko


