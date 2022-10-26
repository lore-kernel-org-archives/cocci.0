Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CE42C433FE
	for <cocci@archiver.kernel.org>; Wed,  2 Nov 2022 17:11:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HOXeMERZiIWatd6+bU1vv+JXuqML/2GyixOeq4YxUes=;
  b=GL4sMprcZZjUKG3kOfK2NVjj/9pdAOVzLOq4xoTkAh/do6d6+LASXHDF
   Ab8AMXkK8bkOnVk0nt/FlwDLIsiJRKfXYwYDK5AtKA4Pfm5pV3U5oHxsT
   GOio9A5D2gBURFogSXjjUSfwXCxOO7rysFxjGUm/v4yaf5lqr1AJ29Sdq
   g=;
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
X-IronPort-AV: E=Sophos;i="5.95,234,1661810400"; 
   d="scan'208";a="72700815"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 02 Nov 2022 18:11:27 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4C450E010F; Wed,  2 Nov 2022 18:11:27 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 021F9E01CC
	for <cocci@sympa.inria.fr>; Wed, 26 Oct 2022 15:17:14 +0200 (CEST)
IronPort-SDR: 63593359_BDMtVuBplF9ot6tVNWkxCnoyEQZhOuKngaC0DrXTJW3RUTd
 e8RQnAKMuAyo36gcaRAoC9w6cSifgrzf0LhFSuw==
X-IPAS-Result: =?us-ascii?q?A0DHAwAOM1ljex+IhoZQCoEJg3yBAVUsAwQLRY1Mh30eA?=
 =?us-ascii?q?58cDwEDAQ05CwQBAYRARQKEeR4GBjQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAQBEwEBGgkYBg4QBSKFaA2CNSkBg2QBAgM6BgEBHhkBDwsYLhBHB?=
 =?us-ascii?q?gGDDwGDIAMQqkSBNIEBgggBAQaBQAELAYRBgV0DBoE9j216glCEPz6CVoFBh?=
 =?us-ascii?q?mqBC44EhnA4A0QdQAMLOzIDClAcWA4JHxwOFw0FBhIDIG4FQQ8oL2crHBsHg?=
 =?us-ascii?q?QwqKBUDBAQDAgYTAyACDSkxFAQpEw8tByNxCQIDIWUFAwMEKCwDCUAHJSQ8B?=
 =?us-ascii?q?1g6AQQDAhAiPAYDCQMCIhNGgSQmBQMNFyUIBU4ECDoCBQZTEgIKEQMSDwYmR?=
 =?us-ascii?q?w5KPjkWBidEATQPDhYDYpd5ghE0fQgIgUWBMpU7jUOfEgeDZotFlQIyqRItl?=
 =?us-ascii?q?ncgjSGaAzCBeSOBW3CDAwEzTgMZD45XgzuEWYYIQTE7AgYLAQEDCYZHhBQBA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 jAgvKbyLipStdPS4cYYQcPTLZDfWEc=
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:Np2Qb6lcuaY1c+imj1cTPHIS86npDfIF3DAbv31ZSRFFG/FwWf
 re+8jz8SWE9Qr5OUtQ4+xoXZPqfZqyz+8W3WB8B8bGYOCighrVEGgA1/qY/9SDIVyGygeM79
 YeT0EWMrSZYTgK7voSojPIa+rIq+P3lpxA692uq0uFCjsEV0hn1W0VZGemLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,214,1661810400"; 
   d="scan'208";a="71662457"
X-MGA-submission: =?us-ascii?q?MDHLRyIkPFe41XoOjVEhe00nFKBckuWxpyILGd?=
 =?us-ascii?q?QKr0qFruspWJpzRiGitukElBy6fu+yfn4e99hvezaobhJgpOskPfZUhY?=
 =?us-ascii?q?ux50dUHsbE+AHOAciR2lqt0m8oxQFuJh3jpV8ypkgcbyYM9zysStX0yv?=
 =?us-ascii?q?P2jCugpHTmszF9XjdV/gJw5A=3D=3D?=
Received: from mga06b.intel.com (HELO mga06.intel.com) ([134.134.136.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 15:17:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666790233; x=1698326233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hIbMjk472qjMcR6jrGfkylFFiMP/jDat0gI5PwpO4rw=;
  b=iO+FtFMIqvAS7YS8GXwLKA7EkDjAn1zHFUG/5ycUG3u/EbDyC8zLKjtI
   8dwjNFykoYf2A5+mtntcF13rKDWwZ4EwOjwrfsJGy+e9TU3AnohT8x0Z6
   7JZV1y5jOaUKbnW1TSDLrdTLgaIp5k3xIaULx1NiZjwfvAZeuCbnCIDHa
   onXQwKZUot63y8i411XzSkYnJYvXI4p9rSkm/LgFx1U74VWerNI5is/f6
   HM6eDXuCOzkdUTpb/DbOYJw4pQMz+p7W328TOr/9i/WyJnPMnZMQqS6yA
   5B30DA8bimboztokghEefYQ+kwhkT0zszj2gB6VUU4tEbL9moHYkxnFmL
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="370009527"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="370009527"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2022 06:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10512"; a="632000787"
X-IronPort-AV: E=Sophos;i="5.95,214,1661842800"; 
   d="scan'208";a="632000787"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 26 Oct 2022 06:17:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1ongHJ-002f4J-0g;
	Wed, 26 Oct 2022 16:17:05 +0300
Date: Wed, 26 Oct 2022 16:17:04 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc: Kees Cook <keescook@chromium.org>, cocci@inria.fr,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alexey Dobriyan <adobriyan@gmail.com>, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org,
	masahiroy@kernel.org, gregkh@linuxfoundation.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <Y1kzUMzFdMiHpEnF@smile.fi.intel.com>
References: <20221020000356.177CDC433C1@smtp.kernel.org>
 <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook>
 <Y1iSYddi3BpP8gvf@zx2c4.com>
 <Y1ku+jfRAyezq6Nz@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y1ku+jfRAyezq6Nz@zx2c4.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH -mm] -funsigned-char, x86: make struct
 p4_event_bind::cntr signed array
Reply-To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 696
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-11/Y1kzUMzFdMiHpEnF%40smile.fi.intel.com>

+Cc: Rasmus as he has done a lot regarding library stuff and optimizations and
     he knows Coccinelle (to some extent as far as I can tell).

On Wed, Oct 26, 2022 at 02:58:34PM +0200, Jason A. Donenfeld wrote:
> On Wed, Oct 26, 2022 at 03:50:25AM +0200, Jason A. Donenfeld wrote:
> > The traditional objdump comparison does work, though. It produces a good
> 
> Another thing that appears to work well is just using Coccinelle
> scripts. I've had some success just scrolling through the results of:
> 
>     @@
>     char c;
>     expression E;
>     @@
>     (
>     * E > c
>     |
>     * E >= c
>     |
>     * E < c
>     |
>     * E <= c
>     )
> 
> That also triggers on explicitly signed chars, and examining those
> reveals that quite a bit of code in the tree already does do the right
> thing, which is good.
> 
> From looking at this and objdump output, it looks like most naked-char
> usage that isn't for strings is actually already assuming it's unsigned,
> using it as a byte. I'll continue to churn, and I'm sure I'll miss a few
> things here and there, but all and all, I don't think this is looking as
> terrible as I initially feared.
> 
> I'm CC'ing the Coccinelle people to see if they have any nice ideas on
> improvements. Specifically, the thing we're trying to identify is:
> 
>   - Usage of vanilla `char`, without a `signed` or `unsigned` qualifier,
>     where:
>   - It's not being used for characters; and
>   - It's doing something that assumes it is signed, such as various
>     types of comparisons or decrements.
> 
> LWN wrote a summary of the general problem, in case that helps describe
> what would be useful: https://lwn.net/SubscriberLink/911914/f90c2ed1af23cbc4/
> 
> Any nice Cocci tricks for this?

-- 
With Best Regards,
Andy Shevchenko


