Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37103C02188
	for <cocci@archiver.kernel.org>; Mon, 27 Jan 2025 16:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=/OONmgFXDxsObJkLHMwDykg8J5QdwqC1PXvAEOGVVEk=;
  b=TLsaEolhFd0aWPv/SwlwK4/+ABkBA08V+309hdNVNgO/CdJv0JKz86J+
   ohkixSIMRtSbpzrkQUYR+JB50oIs8H81EHFjXcy4gCcNHVXAnrb8oPXUN
   SOWymIaagr3oM1xZqIJ/jfhloJCzDq7iO1FiX07bRD/D9uP/ZQMhpqYmI
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.13,238,1732575600"; 
   d="scan'208";a="205238209"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 27 Jan 2025 17:17:16 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 008F5E0D1E; Mon, 27 Jan 2025 17:17:15 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id B17CEE007A
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 14:21:56 +0100 (CET)
IronPort-SDR: 67924274_/tJEUL76dJtwziWZX9WbPvqRobocwvHypEvKSAzqg3hxm5+
 cL05oXtE4rSaEdkKgoToRbIuKqfOhqthyfQwu4A==
X-IPAS-Result: =?us-ascii?q?A0EQAAAiQpJnjw2jxsBaHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgVY0BAtIhFaIHYlVkiyKFoFWgUA+DwEDAQ1BAQIEAQEDBIQPcQKKdAIeB?=
 =?us-ascii?q?wEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5B?=
 =?us-ascii?q?UmFew2CYgGBJF4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQERAg1eAQEdA?=
 =?us-ascii?q?QEBAQIBIx0BATcBDwkCGAICBSECAg8BRgYBEoMBgkIjA5o1m0t6gTIaAmWCD?=
 =?us-ascii?q?AEBBtwfgWQJgRouAYFphAGCYwGGBiCDQnonD4FVRIQ/PoRYg0aCaYIzS4Epg?=
 =?us-ascii?q?jSBDIlzgUaBFIRBgVyDC4oUUnscA1ksAVUTFwsHBYEpSAMtNjEjgSYFNUE6g?=
 =?us-ascii?q?g1pSToCDQI1gh4kWIIrgiGCPYRFhFGFW4IUgWgDAxYQAYMneR+BAh1AAwttP?=
 =?us-ascii?q?TcUGwadSjyENCcqAYIjf5JkkAmibzQHhB6BXQYMn3Ezl24DAZJhiBqQYiKpC?=
 =?us-ascii?q?4FnOoFcMxojgzdPAxkPjiEZg2HAeUQyPAIHAQoBAQMJhUYBAYpOgUsBAQ?=
IronPort-PHdr: A9a23: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
 ICnfE3bKTFe/taS9swZVZG8FQ==
IronPort-Data: A9a23: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
 U7Kq6CxD6x6F5DdVWbFez7kvEOsNc+2Iw==
IronPort-HdrOrdr: A9a23:wTKIQqkd8QK5Q55e9O/sMnqncaXpDfLq3DAbv31ZSRFFG/FwWf
 re+sjzsiWE+Qr5OUtQ5+xoXZPqfZqyz+8J3WB8B8bHYOCighrREGgA1/qc/9SDIVyDygeM79
 YaT0EWMrSZYykesS+52njDLz9K+qj/zEnHv5a4815dCStRR+VL6QB/BgyHEktwajVnKPMCfv
 uhz/sCjQCNPVAMYOqGJlRtZYWimzSNruOEXfcBPXJJmWuzsQ8=
X-Talos-CUID: 9a23:7BTt2m1K4FVZM4l3E2uj/bxfI/ALfWDUkkbre0bgF0BNdpyUVwHJwfYx
X-Talos-MUID: 9a23:M87OaAmopctbiX03O9B/dnp6a+k1xrvpKXsty9JXvu+tBDdBNW202WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="107168059"
X-MGA-submission: =?us-ascii?q?MDGomOJIEJbhsSlGMcCpfq0zSqUtDDX8zeeBz+?=
 =?us-ascii?q?GSPEZ29gKpDKgNhKAuNk3nEI0cjqSXNAbPfb46/TV2DWOJUJf4ZW9NJE?=
 =?us-ascii?q?BrxePYZpEYqnM8mxoZNH2OfA9mu0kbzi8U2xuA8slgoHpDHQygyYVKlR?=
 =?us-ascii?q?RuD0HCpRrOIz7P7++2qSaYVQ=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.13])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 14:21:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737638515; x=1769174515;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=+8w0a9k258gwUbNssq53M4QURbL2ce98oEnEu0VEsUo=;
  b=IIAWwxTBEmK4BFUqhbk8PUH1ZyFm0hQ9w0frqEuVbqgPqBDgtLu24xOc
   aVzyGx3o5EMFBxBXNvxN9IhC8hBvingtUAvzBi25Lit2aEIiVBmRZrhQ4
   rrSGGjvGhP/lLncvtW8vTGl64HRH70vLBN1+AT3viEVDUD5Enz7cgXUHf
   tdDwxAyx2+ZKf/LtqhYJ2/pIZWSNWyjDrEKFY0q8+SffW6EM/TaZep677
   8HKAqI6+Pe3rtG86a5qZO9467oo5KcSFd9DeNXzkf6DUExhz7Y4Q/mHV9
   64oxQeG/ig8HUOMjarMeSRQ8YRYq1UQxIJ5MPwvq4D/4fCbFhyVcA7sZj
   A==;
X-CSE-ConnectionGUID: +HZT9HZDQ6iSoAk0fnl+8w==
X-CSE-MsgGUID: 2l8ciVfRSTaERi/J6Nee8g==
X-IronPort-AV: E=McAfee;i="6700,10204,11324"; a="40959860"
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="40959860"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 05:21:52 -0800
X-CSE-ConnectionGUID: FmiaEJlKToGXh+Vc/Mii8g==
X-CSE-MsgGUID: MxO09wa9R/eUV6qL5PCzfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,228,1732608000"; 
   d="scan'208";a="107563623"
Received: from unknown (HELO localhost) ([10.237.66.160])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 05:21:51 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Victor Gambier <victor.gambier@inria.fr>, Julia Lawall
 <julia.lawall@inria.fr>
Cc: cocci@inria.fr
In-Reply-To: <19e808d6-9c84-4582-88db-7917ccec96ee@inria.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87plkrhqu9.fsf@intel.com>
 <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr> <87frlmj38x.fsf@intel.com>
 <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr> <877c6yirab.fsf@intel.com>
 <19e808d6-9c84-4582-88db-7917ccec96ee@inria.fr>
Date: Thu, 23 Jan 2025 15:21:48 +0200
Message-ID: <878qr1mzrn.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Jani Nikula <jani.nikula@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2225
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/878qr1mzrn.fsf%40intel.com>

On Wed, 22 Jan 2025, Victor Gambier <victor.gambier@inria.fr> wrote:
> Hi Jani,
>
> Could you give me a precise example of what you're trying to do? The=20
> following works on my end (commit 8aa44ca):
>
> .
> =E2=94=9C=E2=94=80=E2=94=80 A
> =E2=94=82=C2=A0=C2=A0 =E2=94=9C=E2=94=80=E2=94=80 cocciincludemain.c
> =E2=94=82=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 cocciincludemain.cocci
> =E2=94=94=E2=94=80=E2=94=80 B
>  =C2=A0=C2=A0=C2=A0 =E2=94=94=E2=94=80=E2=94=80 cocciinclude1.cocci
>
> (...)/A $ spatch --sp-file ./cocciincludemain.cocci ./cocciincludemain.c
>
> Absolute and relative includes in=C2=A0cocciincludemain.cocci both work:
>
> #include=20
> "/home/vgambier/Documents/git/coccinelle/playground/B/cocciinclude1.cocci"
>
> #include "../B/cocciinclude1.cocci"

This is what I'm trying to do:

+- A
|  +- main.c
+- B
   +- main.cocci
   +- include.cocci

$ cd A
$ spatch --sp-file ../B/main.cocci main.c

With main.cocci having:

#include "include.cocci"

Currently spatch looks for the include in the CWD only, not next to the
.cocci being processed, nor does -I help in specifying where to look for
the include.

BR,
Jani.

>
> Thanks,
> Victor
>
> On 13/01/2025 17:59, Jani Nikula wrote:
>> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
>>> On Mon, 13 Jan 2025, Jani Nikula wrote:
>>>
>>>> On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
>>>>> I don't think there is any search path for .cocci files.
>>>> Oh, so it's always relative to the current working directory? That's a
>>>> bit of a bummer.
>>> It's not a well developed feature.  If an include path for it would be
>>> useful, we can add that.
>> It might be. Or do you have any other ideas for reusing match rules or,
>> say, "iterator name" lists, without duplicating them into all .cocci
>> files?
>>
>> So I guess I can try working around not having include search path by
>> running spatch outside of my kernel repo. Does spatch otherwise handle
>> that scenario well, or any caveats there?
>>
>>
>> BR,
>> Jani.
>>
>>

--=20
Jani Nikula, Intel
