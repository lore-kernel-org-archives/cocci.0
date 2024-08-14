Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35A52C3DA4A
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2024 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=tfenmm/HIm7zTkOkfNGpGWbvYq9xBbgtCUL21xwL68E=;
  b=ABUyAMYGLdOjYipRkxS8BJLQVe2MrR4lwwBOMLJhmTyFnZQyCZrroz0E
   NVy28GWZMmBxJXU/ZRl52FbGu0PYEb2RL0SUwq+IMNE1q6tqSU6Tr4BgC
   oFSWYl4TYIouMc3oR/HnabDXfUuYS7IBPwEpUQnk/N9tKo42PKIEv3DeT
   w=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="178961211"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Aug 2024 09:58:06 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 13550E013D; Wed, 14 Aug 2024 09:58:06 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 16A36E0035
	for <cocci@sympa.inria.fr>; Wed, 14 Aug 2024 09:58:05 +0200 (CEST)
IronPort-SDR: 66bc638b_dmGdXLZNnIk9CzReEB0CWvQFE7O3ZhRz9KnLM4VDtWw8uqI
 AW7glpwNQUhFJBn0zrY+Puliji2JoSuA5AJi0BQ==
X-IPAS-Result: =?us-ascii?q?A0GhAAAzY7xmmA5Br8ZaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CRH1ZNAQLSIRWiHyIRi0DhDubFz4PAQMBDTkIAQIEAQEDBIR/AolkAh4HA?=
 =?us-ascii?q?QQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQAQEBAQEBAQE3B?=
 =?us-ascii?q?Q47hXUNgmMBgSJeBwk4AQEBAQEBAQEBAQEBAQEBAQEBAQEBFAINXgEBHQEBA?=
 =?us-ascii?q?QECASMPAQUIAQE3AQ8LGAICJgICVgYVAQGCfAGCQSMDEa1oeoEygQGCDAEBB?=
 =?us-ascii?q?twdgWMDBoEaLohLAYlheicPgVVEgTwLgXaBAj6CSoIOg0aCaY50gySKeHwlT?=
 =?us-ascii?q?YccgX2JQlJ7HANZIRMBVRMXCwkFiUEKgx8pgUcmhBeBMxQBg1+BZwlhiE+BD?=
 =?us-ascii?q?YE+gV4Bgz1Lg1yBfwV+gll0Tj8CDQI3ggYdQAIBC209NQkLGwY9pjaBWoION?=
 =?us-ascii?q?YENARsQIIEAJZNpg0quIoEKNAeEF4FdBgyKJZUqBg8EL6pBmG+Ne5YChRuBf?=
 =?us-ascii?q?iOBXDMaI4M3TwMZD44hGYNhhRTHPEQyOwIHAQoBAQMJhUYBAYVagUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:JWaDsa7GyvqLJKV4zQPXwDrXdLJyesId70hD6qm+c20uTiXqrb
 HToB19726GtN9xYgBRpTnkAsK9qBznhPlICOUqTMiftUzdyRqVxeJZnO3fKl/baknDHz5mpN
 ldmsFFYbWffD1HZITBkXSF+r0bsaG6Gc6T9JzjJjtWPHhXQpAlxT1UTiycFUp7ThRHA50WKL
 qwj/AsxgaISDA8VOj+ImMKcdTiirTw+fLbiFk9dn0aAQ+14VzYioLHLw==
X-Talos-CUID: 9a23:cWis8W7Z9hHwQID9ltss9HFXHdE1MWzh6WbQPWWbVG0wWb+ZVgrF
X-Talos-MUID: =?us-ascii?q?9a23=3A839yfAwxohiG7hlka6eIZDjRAPGaqIa1CEUSl41?=
 =?us-ascii?q?Zh+qnLjVTHx2DsC6eHLZyfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,288,1716242400"; 
   d="scan'208";a="94069228"
X-MGA-submission: =?us-ascii?q?MDGor2wkZetF05xSUBZy4eaPUTVh3mQkj4iZSL?=
 =?us-ascii?q?5rYLoOo39I3dI5lJC7RfPJzQiJ5+CbKD9ipAbEjx5TbHKdFf9qRl4+5A?=
 =?us-ascii?q?5GiWlNB8kgSxFmLtF7oitXmHxHVqNH32hLgoeU6lgHRojQj89mNME6aY?=
 =?us-ascii?q?6x7no8yzVoqHvZEfVhdav/FA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 09:58:02 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723622284; x=1755158284;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=qfHsWwWNFRdbHwu8aPwBugC0/2x8/mBkwpwx+Rjxnl0=;
  b=S9uHtyDYwdli6KgqeR90vYjTdDD5fsmoLgM4LIxv5cBj6uCHa+MHTQp7
   hdFghLOSEa6iMmAWSn8PXbvuQ4/OGWYMYhKK4LaqkyXrun334a2Frjdke
   5raAMq4YKzGIzO5Vwel7AvgSyhQkAH62TnY9mWdy/cjrAuz0XW7miyY8Q
   1ah9cVz1EZIUUWTXHfMn88My3aXJTxFeW9Zl+V1Xlo1QbWhk3dtmI3iej
   2ofEY5zDrHXuN0VHHVy8uE4k9/Gt933eanUiaY5rfPR7LVlzsDfUzKs5X
   ob8mk2KAEutEy4c4UmNK/6Zf21bpSp+ioAxMvEFPoj+QkvZyaEkU2RuEa
   Q==;
X-CSE-ConnectionGUID: VndmA382TTG4PbGb6DiTJw==
X-CSE-MsgGUID: +CZsdLbwTQSDCKzwAJHnxw==
X-IronPort-AV: E=McAfee;i="6700,10204,11163"; a="25623172"
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="25623172"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 00:57:58 -0700
X-CSE-ConnectionGUID: cHvWPbpzQxKj49au7LbvUQ==
X-CSE-MsgGUID: yqW93qZRSG+R626LhIweNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,288,1716274800"; 
   d="scan'208";a="63589344"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.246.30.61]) ([10.246.30.61])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 00:57:55 -0700
Message-ID: <ed88cfd5-2501-4c5c-bbb8-56e30e29b87b@intel.com>
Date: Wed, 14 Aug 2024 09:57:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>
Cc: Peter Senna Tschudin <peter.senna@gmail.com>,
 Peter Senna Tschudin <peter.senna@linux.intel.com>, cocci@inria.fr
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
 <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr>
 <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com>
 <1e637cb0-24cd-dc10-9178-69f314598ce@inria.fr>
 <03d047e0-577c-4c39-b75e-6f8fb998ae57@intel.com>
 <4aed4763-9b3c-c21f-693a-e7d4281f8384@inria.fr>
Content-Language: en-US
From: Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <4aed4763-9b3c-c21f-693a-e7d4281f8384@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Iterator macros
Reply-To: Andrzej Hajda <andrzej.hajda@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1856
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/ed88cfd5-2501-4c5c-bbb8-56e30e29b87b%40intel.com>



On 14.08.2024 09:19, Julia Lawall wrote:
>> I guess the issue here could be a problem with parsing igt code (it is also an
>> issue with kernel drivers using iterators).
>> Cocci quite often does not recognize automatically iterators or other
>> constructs, and does not scan them at all.
>> Try run for example:
>> $ spatch --parse-c tests/intel/gem_ctx_exec.c
>> ...
>> NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
>> nb good = 385,  nb passed = 19 =========> 3.12% passed
>> nb good = 385,  nb bad = 204 =========> 66.45% good or passed
>>
>> As I understand, lines marked as "bad" are skipped during cocci pass, am I
>> right?
>> Some workaround is to define iterators by hand in the script or include files.
> The following file:
>
> #define igt_main int main ()
> #define igt_simple_main int main ()
>
> #define igt_fixture
> #define igt_subtest_group
> #define igt_dynamic(x) YACFE_ITERATOR
> #define igt_dynamic_f(x) YACFE_ITERATOR
> #define igt_subtest(x) YACFE_ITERATOR
> #define igt_subtest_with_dynamic(x) YACFE_ITERATOR
> #define igt_subtest_with_dynamic_f(x) YACFE_ITERATOR
> #define igt_subtest_f(x) YACFE_ITERATOR
> #define igt_until_timeout(x) YACFE_ITERATOR
> #define igt_while_interruptible(x) YACFE_ITERATOR
> #define igt_list_for_each_entry_safe_reverse(x) YACFE_ITERATOR
> #define igt_list_for_each_entry_safe(x) YACFE_ITERATOR
> #define igt_list_for_each_entry(x) YACFE_ITERATOR
> #define _Atomic(x) x
>
> managed to parse over 98% of the lines in
>
> https://gitlab.freedesktop.org/drm/igt-gpu-tools
>
> Command line spatch --parse-c . --macro-file-builtins igt.h
>
> I'll check on the driver file you mentioned.  Thanks.

Wow, great.

I wonder if it would be possible to issue warning if spatch encounters 
lines which it is not able to parse, to avoid confusion.

Regards
Andrzej


>
> julia

