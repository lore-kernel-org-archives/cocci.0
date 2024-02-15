Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D829AC48260
	for <cocci@archiver.kernel.org>; Fri, 16 Feb 2024 08:56:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=sd6SNGl4BoZWz4f77IgbL9cTsj6QBuPdWD0YGHLZF+E=;
  b=KDXMSZ1V0XJeExx4jY/ycUl11l/buJ6ijBavi4XWvsbxNdJo18nlWdaT
   V/kJbSIAI/acW/O+MTKUYAwhyzuikkkxKpmVJswlKwutuSJVOeDoifTs1
   YYRQtXxEHoKvL3D72Eu9uN19clVCnpCiXSKwwGJ9CtRTljtZopkNDbzcq
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.06,164,1705359600"; 
   d="scan'208";a="152260641"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 16 Feb 2024 09:56:28 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5B0E6E0CEE; Fri, 16 Feb 2024 09:56:27 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 24BC4E008A
	for <cocci@sympa.inria.fr>; Thu, 15 Feb 2024 20:34:34 +0100 (CET)
IronPort-SDR: 65ce6749_Op4u9vHNR83zylUbvLLl6CGuN2YUp21/fsLJ3hrQY6PCWgl
 rFu0cg8EbhWSvMB5qRo9q2OpMr9Xl5HYhG1G36g==
X-IPAS-Result: =?us-ascii?q?A0EZAACeZs5lmA5Br8ZaHQEBAQEJARIBBQUBQIE8BwELA?=
 =?us-ascii?q?YI4gVEzBAtIlBeCBSCeBoFAPg8BAwENQQECBAEBAwSEfwKHWwIeBgYxCA4BA?=
 =?us-ascii?q?gQBAQEBAwIDAQEBAQEBCAEBBQEBAQIBAQIEBgECEAEBAQEBAQEBHhkFEA4nh?=
 =?us-ascii?q?WwNglwBgR5eBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBFAINXAEBHgECAzoGA?=
 =?us-ascii?q?QEeGQEPCxguEEYGgxOCYAOzQ4E0gQGCCgEBBrEegWEJgUgBiCUBiTF6J4Ioh?=
 =?us-ascii?q?D8+iwaBOlyDO5QYhUZUfx0DgQUEXA0bEB43ERATDQMIbh0CESI6AwUDBDIKE?=
 =?us-ascii?q?gwLHwVUA0MGSQsDAhoFAwMEgTAFDRoCEBoGDCgDAxJJAhAUAzgDAwYDCjEwV?=
 =?us-ascii?q?UEMUANkHzIJPA8MGgIbGw0kIwIsQAMJChACFgMdFgQyEQkLJgMqBjkCEgwGB?=
 =?us-ascii?q?gZdIxYJBCUDCAQDVAMhdBEDBAoDEwcLB3iCCYE9BBNEAxCBNIU4hG8MgSoDR?=
 =?us-ascii?q?B1AAwttPTUUG6IXgQ/IRgeEFKE6M4NypjEumCqod4FmATeBXHCDN08DGQ+OI?=
 =?us-ascii?q?BmDYY97RDI7AgcLAQEDCYVGAQGBAIJagUYBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 b4bh4dA3oxO5kEuhA==
IronPort-HdrOrdr: A9a23:b8v1qaiFTwrJ9eeWMbtxCzsXP3BQXvMji2hC6mlwRA09TyVXrb
 HIoB0+726ItN9xYgBbpTnkAsK9qBznhPxICOUqTNKftUzdyReVxeJZnPDfKl/balTDHz5mpN
 hdmsFFYbWdbSkYsS+52njBLz9K+qjgzEnHv5a7854rd25XgqdbhWoWazqmLg==
X-Talos-CUID: =?us-ascii?q?9a23=3AZMk55WufUmje3d7MqNbOUgN+6Is8bHyGlTSAAna?=
 =?us-ascii?q?8V0Z4aZuYaWTJ5qJ7xp8=3D?=
X-Talos-MUID: 9a23:l7LSLQtkZHrERbnutM2noW57Msg1vYeSFnsikLIrnNCNOSx5NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.06,162,1705359600"; 
   d="scan'208";a="79768606"
X-MGA-submission: =?us-ascii?q?MDFXDL9McjXn0jepVt7bihhianJny19bivTB6Z?=
 =?us-ascii?q?jHwZMYpV6d0GqF33LGobaoD2le/Qpp+zl1AzYq6nWQnA3YXAlHv+PT9c?=
 =?us-ascii?q?L3eQsIZmOXvjst5GgGbrYzHeIrkfIqCMr5oQmcJLEcgEIAQPfsgiVh5I?=
 =?us-ascii?q?J9GXe1aO4Xz8IoR+6c56X26w=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 20:34:32 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708025673; x=1739561673;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DpX+QLqMpXLedN4ugddvfd9mbmUiqpJiSZRn+YSTau8=;
  b=DssF6EGilfHx5Per40GcEOixNXgWO650YtWKcx0aCWgvQDyPLntBF3GF
   qRvHJkEEJAZjmdgCVvT9K1+/BfR1yempbNElNuP8xOqjKRm0sxNkhbL/2
   DSqdSOqLeSFylKJWlNr7fN6SNeqifAdUTyvXXZs/CcCbLPBJeY6MNCxrB
   sX2Sefc7FWT+lhFZYT3uzc2nklz/g4K9e0wlj5afhXaY3zrrrVY7sXkRV
   jwB3DAEpP7FeypmPUTztkbL+ARgXPKGZhoVsiANxmR8UbBxbZPr0Zd4Rp
   hfEqcIyPtHIsOoWS2VdcfRTWz5J1VvO4CvZZm49u+F5GOc/0kiljEJbDi
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="5948278"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="5948278"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:34:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10985"; a="912217578"
X-IronPort-AV: E=Sophos;i="6.06,162,1705392000"; 
   d="scan'208";a="912217578"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2024 11:34:04 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1rahUf-00000004sJi-3y0g;
	Thu, 15 Feb 2024 21:34:01 +0200
Date: Thu, 15 Feb 2024 21:34:01 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Kees Cook <keescook@chromium.org>
Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	Julia Lawall <Julia.Lawall@inria.fr>,
	Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Message-ID: <Zc5nKZezYhg3Khtr@smile.fi.intel.com>
References: <20240215180156.work.548-kees@kernel.org>
 <Zc5nCsE74E33PdD2@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zc5nCsE74E33PdD2@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] cocci: Add rules to find str_plural()
 replacements
Reply-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1561
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-02/Zc5nKZezYhg3Khtr%40smile.fi.intel.com>

On Thu, Feb 15, 2024 at 09:33:31PM +0200, Andy Shevchenko wrote:
> On Thu, Feb 15, 2024 at 10:02:00AM -0800, Kees Cook wrote:
> > Add rules for finding places where str_plural() can be used. This
> > currently finds:
> >  54 files changed, 62 insertions(+), 61 deletions(-)
> 
> Can we extend this to cover string_choices and call the script probably
> str_choices.cocci ?

(And add it to MAINTAINERS?)

-- 
With Best Regards,
Andy Shevchenko


