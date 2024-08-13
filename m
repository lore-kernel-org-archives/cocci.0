Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85080C52D7B
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2024 11:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BOk+zOFNxcJta3TFTFu6OT7PfInB63LsdDMgXlRCNQE=;
  b=uBLytRKlCfkZPkqbj9TeA0Hz9GVlSDT4ZsFymoy2PHmjxwJCR8szKGT0
   l0oIBX8MwwmoCBj/hkHsPSvkvLKrDJwigrDwUcktZcwGrvwobFX3Q0ayU
   no4CbtX2mLDSYjerTbXI5FbDVsfkflB/43ObMMaPQyCgvQbwNAbJcHHrD
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="178875233"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Aug 2024 13:05:32 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 6A085E0CD0; Tue, 13 Aug 2024 13:05:31 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A6314E0133
	for <cocci@sympa.inria.fr>; Tue, 13 Aug 2024 13:05:23 +0200 (CEST)
IronPort-SDR: 66bb3df2_H498aVztgMaHdGUo5vpQD7yY4tYZvWsyRfPX6h8h5aJBBlc
 FeOvyQwgZBo4eMIxKagqyDSM7XTeSfElIo/Dq7w==
X-IPAS-Result: =?us-ascii?q?A0FWAACPPLtmmBFBr8ZaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBT4JEfVk0BAtIhFaIfIZRgXUtA4Q7mWuBLD4PAQMBDTkIAQIEAQEDB?=
 =?us-ascii?q?IR/AolkAh4HAQQ0EwECBAEBAQEDAgMBAQEBAQEIAQEFAQEBAgEBAgQGAQIQA?=
 =?us-ascii?q?QEBAQEBAQE3BUmFdQ2CYwGBIl4HCTgBAQEBAQEBAQEBAQEBAQEBAQEBAQEUA?=
 =?us-ascii?q?g1eAQEdAQEBAQIBIwQLAQUIAQE3AQ8JAhUDAgImAgJWBgESAgEBgnwBgkEjA?=
 =?us-ascii?q?xGSGZs8en8zgQGCDAEBBtwdgWMDBoEaLohLAYlheicPgVVEgTyDAz6CSoE/T?=
 =?us-ascii?q?4NGgmmSGIVjcYQkfCWHaYF9iQlSexwDWSETAVUTFwsJBYlBCoMfKYFHJoQXg?=
 =?us-ascii?q?TMUAYNfgWcJYYdtYoENgT6BXgFJgnRLg1yBfwV+gll0Tj8CDQI3gTgdQAIBC?=
 =?us-ascii?q?209NQkLGwY9pguBWgGCCTM+UhsQIFslJaN8oVmBCjQHhBeBXQYMiiWVKgYPB?=
 =?us-ascii?q?C+qQZhvIo1Zmx2BfiOBXDMaI1CCZ08DGQ+ISoVXGYNhhRTHEEQyOwIHAQoBA?=
 =?us-ascii?q?QMJhUYBAYVVgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:8vFbJqBFkNtYgJPlHele55DYdb4zR+YMi2TDGXoBMyC9Afbo6/
 xG+85rpiMc6QxhKE3I/OrqBEDuewK6yXcY2/hvAV7mZniWhILKFvAF0WKB+UyFJ8QvzJ8i6U
 4IScEXZqyUMbE5t7eG3ODSKadZ/DDoytHSuQ6T9QYVcShaL4tbw0NSDAGdHkdqRA9AK6YYOf
 OnjKt6jgvlU046KuCgCFc4f8WrnbCqqHugW29kO/cg0mXg/FGV1II=
X-Talos-CUID: 9a23:U2/Kq29dhs8yK2lUxJCVv28IIcd+bmXZ9XzRekbiMX5gV5fWb0DFrQ==
X-Talos-MUID: 9a23:+mtvwQVoarIde3jq/BvegQtHK/d437ajNnwKnpEd4tG8DyMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="94016389"
X-MGA-submission: =?us-ascii?q?MDHfsxxLX3mSLLdwDX4vBThIyli0rqn5ZXKy55?=
 =?us-ascii?q?Ag9dmRElujWqvgdSRlLApPLr+ttkh8vZAMpmhbeQ3TtgVyC4aL4Bky0S?=
 =?us-ascii?q?g7ODGHzasE1FRFnnp6Fgj9S/sU3JZOagDoTxWUBjgUeDKmUcewAMoaYN?=
 =?us-ascii?q?eF4D2N8VeyNQ2UGMfjnUxQEA=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.17])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 13:05:21 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723547123; x=1755083123;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NmRyBU9w4xh3li3KHsRzrOD5m6uRFEOjlo+LJXERxHk=;
  b=UbVCVVSdcyXKz4rbvm48xfg0U1QdKY89mb7JLAfWmAdFIOY/VuiuihwC
   s1NCpIz8hmFTOgV13TuqzjygyjvKPFxzGchynmRYZhZja5eQCCm0qgNp1
   +aWpxCWKr1Wv8VByPw6g33aAGUWbReq261ZW6fmOP2iuHT3JCQ4aq6ORo
   n+lRdFzLTK1XxBljf22e1jUdOkihEfCK03cXNk9gpohZFnON8fz+wZGU0
   brBnIIZdDwE3r3MTq/ezDe7EhnxO+xzF7KRXLWPcS/rtbanSroR4WuN84
   gwiH8nzoXZmYQSpddlNX4NQ+gPemQ4ZqBEHTs3LlnQ1fXwaBftLOwefVP
   g==;
X-CSE-ConnectionGUID: +4xI4UKqSvKyyQja6Cb59g==
X-CSE-MsgGUID: vWcj0tN1RWWovSI3Y/pYMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="21837018"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="21837018"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:05:18 -0700
X-CSE-ConnectionGUID: Q7/LR/MTS12Uey4C5hO2bw==
X-CSE-MsgGUID: Wn2uORyFRhajg0ZogANryw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="81858077"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.246.30.61]) ([10.246.30.61])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 04:05:16 -0700
Message-ID: <03d047e0-577c-4c39-b75e-6f8fb998ae57@intel.com>
Date: Tue, 13 Aug 2024 13:05:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Julia Lawall <julia.lawall@inria.fr>,
 Peter Senna Tschudin <peter.senna@gmail.com>
Cc: Peter Senna Tschudin <peter.senna@linux.intel.com>, cocci@inria.fr
References: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
 <a474269f-f8b9-e7eb-90c5-fdbc4f3495a4@inria.fr>
 <CA+MoWDqM33yLEsm2YB8WJeGmUunHaHXDHsT56pEOhLWK5-RHAQ@mail.gmail.com>
 <1e637cb0-24cd-dc10-9178-69f314598ce@inria.fr>
Content-Language: en-US
From: Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <1e637cb0-24cd-dc10-9178-69f314598ce@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Iterator macros
Reply-To: Andrzej Hajda <andrzej.hajda@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1851
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/03d047e0-577c-4c39-b75e-6f8fb998ae57%40intel.com>



On 13.08.2024 08:34, Julia Lawall wrote:
>
> On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:
>
>> Hi Julia,
>>
>>
>>
>> On Tue, Aug 13, 2024 at 8:19 AM Julia Lawall <julia.lawall@inria.fr> wrote:
>>
>>
>>        On Tue, 13 Aug 2024, Peter Senna Tschudin wrote:
>>
>>        > Dear List,
>>        >
>>        > I am trying to make changes to a macro iterator from
>>        igt-gpu-tools*, and I am failing to use Coccinelle. My current
>>        attempt only captures about 1/2 of call sites, and I am not
>>        really sure how to ask Coccinelle to make the changes I want.
>>        Here is the pattern I am trying to change:
>>        >
>>        >
>>        > From:
>>        >
>>        > const struct intel_execution_engine2 *e2;
>>        > ...
>>        > for_each_ctx_engine(i915, ctx, e2) {
>>        >     execbuf.flags = e2->flags;
>>        >     gem_execbuf(i915, &execbuf);
>>        > }
>>        >
>>        >
>>        > To:
>>        >
>>        > struct intel_engine_data ied;
>>        > ...
>>        > for_each_ctx_engine(i915, ctx, ied) {
>>        >     execbuf.flags = ied.current_engine->flags;
>>        >     gem_execbuf(i915, &execbuf);
>>        > }
>>        >
>>        > Changes I want:
>>        > 1. From `const struct intel_execution_engine2 *e2` to `struct
>>        intel_engine_data ied`.
>>        > 2. Replace the last argument of for_each_ctx_engine()
>>        following the change on previous step.
>>        > 3. Change references from `e2` to `ied.current_engine` inside
>>        the iterator statement.
>>        >
>>        > Here is my starting point that finds about half of the call
>>        sites:
>>        >
>>        > @r1@
>>        > iterator I =~ "for_each_ctx_engine";
>>        > statement S;
>>        > @@
>>        > * I(...)
>>        > S
>>        >
>>        > I assume that I should create other rules and import I from r1
>>        as the
>>        > core of the changes I want. Can you point me to an example to
>>        help me
>>        > here?
>>
>>        Are you just looking for
>>
>>        iterator r.I;
>>
>>        If you have only one iterator name, you don't need the regexp.
>>        Just put
>>
>>        iterator name for_each_ctx_engine;
>>
>> Thank you! This is much faster but captures one instance less.
> You can use multiple names like
>
> (name1@I|name2@I|name3@I)(...) S
>
> The you can use r.I in your other rules.  name1 etc would be iterator name
> and I would be iterator.

I guess the issue here could be a problem with parsing igt code (it is 
also an issue with kernel drivers using iterators).
Cocci quite often does not recognize automatically iterators or other 
constructs, and does not scan them at all.
Try run for example:
$ spatch --parse-c tests/intel/gem_ctx_exec.c
...
NB total files = 1; perfect = 0; pbs = 1; timeout = 0; =========> 0%
nb good = 385,  nb passed = 19 =========> 3.12% passed
nb good = 385,  nb bad = 204 =========> 66.45% good or passed

As I understand, lines marked as "bad" are skipped during cocci pass, am 
I right?
Some workaround is to define iterators by hand in the script or include 
files.

Regards
Andrzej

>
> julia
>
>>   
>>
>>        julia
>>
>>        >
>>        > Thank you,
>>        >
>>        > Peter
>>        >
>>        > * - https://gitlab.freedesktop.org/drm/igt-gpu-tools
>>        >
>>
>>
>>
>> --
>>                           Peter
>>
> >

