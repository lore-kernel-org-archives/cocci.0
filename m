Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25C92C02185
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2025 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=tpIivLA+TlS9gIokxiMztBespUvsp0nPLovcTLluDCQ=;
  b=nnmdgYGqPZNIjBOjCv76aqRMdWCk81wEcKM73fxpDrWa/Pj5Bl4/fhnv
   wGzGizLsbPq09pp+/ImdrjX9qzzjuvmq+SzXUVfKXdPWwpFKRWSCH8VNn
   1BWvTDABQTuN8axaOBuxAqeVa2+85tUvJZuPiM4u+ZMD8x6RzXdKwjrG3
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.12,314,1728943200"; 
   d="scan'208";a="203120633"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jan 2025 18:45:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 009C8E0077; Tue, 14 Jan 2025 18:45:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 98D76E0077
	for <cocci@sympa.inria.fr>; Mon, 13 Jan 2025 17:59:16 +0100 (CET)
IronPort-SDR: 67854664_3h8/ZQYcqH6So8Uq28VHvcAGBeLOk5GzJBpS8NJGL1SCtav
 xV7SiLdITAkQlwYx9cey1gA0yHXyDXrHKpiASmg==
X-IPAS-Result: =?us-ascii?q?A0HyAAAuRYVnjw5Br8ZaHgEBCxIMgggLgkSBVjEDBAtIj?=
 =?us-ascii?q?VKIdZ4YgUA+DwEDAQ1BAQIEAQEDBIFMgzQCinUCHgcBBDAJDgECBAEBAQEDA?=
 =?us-ascii?q?gMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBAQEBOQUOO4V7DYJiAYEkXgcJO?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHwEBAQNAAQE3AQ8LGAklD?=
 =?us-ascii?q?wFGBhODAYJlA7VngQGCDAEBBtwfgWQJgUiFa4JjAYloeicPgVVEhD8+iweCN?=
 =?us-ascii?q?4Fzg0CJdYh6i25SexwDWSwBVRMXCwcFgSkfKwOBFCWBJwU1QTqCDGlLNwINA?=
 =?us-ascii?q?jWCHnyCK4Ihgj2ER4RThWKCFIFlAwMWEAGDKU0dQAMLbT03FBsGnF48hC1Sg?=
 =?us-ascii?q?iOTY5AJom80B4QegV0GDJ9xM6pTiBqQYqktgWc6gVwzGiODN08DGQ+OIRmDY?=
 =?us-ascii?q?bkFRDI8AgcLAQEDCYVGAQGKGoFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:KFs/RapYmVycNFg6yiUeYEAaV5rreYIsimQD101hICG9vPbo8f
 xG/c5rqyMc7Qx7ZJhOo6H8BEDtewK5yXcx2/hoAV7AZniYhILLFvAf0WIz+UyaJ8SWzIc0u9
 YET0E9MqyLMbEQt7eC3ODXKadG/PC3tIqTqaP1yXBrQQt2a6dmwTtYJ2+geCxLbTgDL6AUUL
 6H6OR6hxfIQxl2Ui39PAhnYwHEnbGl5fDbXSI=
X-Talos-CUID: 9a23:5oyD1GDCbINWcKn6E25d60AxBdogTkLA5VDiMXSWJ1tXUbLAHA==
X-Talos-MUID: 9a23:be0LswuYDL9Jm2UvvM2n3glGMOx03oOXA0Epi5MB4eSYNHcpEmLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="106228197"
X-MGA-submission: =?us-ascii?q?MDFjxMxWuEcgqHlJWLa6Pl/JdE5kpOX8ipApK0?=
 =?us-ascii?q?oUztJcqv2cKsaUnq34U+mEe41dN6a1YMVGtoIbPMjDbMgBTDmXFFCzgd?=
 =?us-ascii?q?Uc9pNaKv4kBc4ppQ5p9O0bSw12gkhfSV6M0Ei37fwvCYImYtGSxwBCzu?=
 =?us-ascii?q?gTYvwGwzd9LM3YbI4LGIWRdA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 17:59:15 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736787556; x=1768323556;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=erkrTMvwZsseuxLaVFVCAOfMnSrwDdxZOu35PaTRnng=;
  b=DlTzkM9348JPQiA/ZDwunTspIowFf69B4aMMx9zfPEI97HGXuJ/kCo45
   Nv6QRriZ8J9UBECK6+VyMyFzGu0fsZ6bj27yJqDd3OSyNnFetfRgfh4KG
   H7hkIwF+G63FIy99pxDspESSUhdt+MzGMnT4vcNN88R76D5WRa1qT+PzH
   vVe1OB0lmQps0KxX3NUNIhRd3gXsNaz5IBT3+4HrmJzN6kDGvILAsCwgD
   IuMm22QS5yeKi2fID7AKSVvqkpDVGm11FWN5HflNcEwo3rsB1r77ONqJ8
   sw/mJOHekfT/1xWCsP7ucqgk/JFG56fqizj2L0dbeC4Qy41XGE7aO7zP/
   Q==;
X-CSE-ConnectionGUID: IBznu2ZwSNy33a2m/BmBmg==
X-CSE-MsgGUID: HxKi3rOFT7+q3/qv8avCxg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="40827901"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="40827901"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 08:59:14 -0800
X-CSE-ConnectionGUID: Q3tcsuH+S6W10fxOaswhLQ==
X-CSE-MsgGUID: L3E3O9StSEmJLguqH/hGdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="105041838"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.145])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 08:59:11 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
In-Reply-To: <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87plkrhqu9.fsf@intel.com>
 <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr> <87frlmj38x.fsf@intel.com>
 <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr>
Date: Mon, 13 Jan 2025 18:59:08 +0200
Message-ID: <877c6yirab.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Jani Nikula <jani.nikula@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2203
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/877c6yirab.fsf%40intel.com>

On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
> On Mon, 13 Jan 2025, Jani Nikula wrote:
>
>> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
>> > I don't think there is any search path for .cocci files.
>>
>> Oh, so it's always relative to the current working directory? That's a
>> bit of a bummer.
>
> It's not a well developed feature.  If an include path for it would be
> useful, we can add that.

It might be. Or do you have any other ideas for reusing match rules or,
say, "iterator name" lists, without duplicating them into all .cocci
files?

So I guess I can try working around not having include search path by
running spatch outside of my kernel repo. Does spatch otherwise handle
that scenario well, or any caveats there?


BR,
Jani.


-- 
Jani Nikula, Intel
