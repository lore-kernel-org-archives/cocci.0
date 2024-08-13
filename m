Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AD7FC52D7B
	for <cocci@archiver.kernel.org>; Tue, 13 Aug 2024 06:15:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=9AJiqizORGzQ0RLaxeqNweIgSNNTDXO5rEF3zFUpzTk=;
  b=TmXJzZrW0Rj+oj+xnG2xJwOm5shvUs+URLApviP5LlNEjdFlDcyR0pjS
   57Y6P958aAgdjDf/Gt0tLEJ/bAeqZ4U3g8X/1bK9txHMs6VFvFGSbuqmO
   p7qwF67VyrukTWzMMCpVq3sB9kIWUXb8TGISfRYx6Sf/KkYk7VKn6wESm
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
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="178838180"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 13 Aug 2024 08:15:31 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D39F1E0133; Tue, 13 Aug 2024 08:15:30 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id A1EC4E0035
	for <cocci@sympa.inria.fr>; Tue, 13 Aug 2024 08:15:27 +0200 (CEST)
IronPort-SDR: 66baf9fe_aGgPEe7S850Jh4MaK43N6X5dVwAYcGpXD4dIuYYzFKK6049
 Kk54Tkks5t7TS6zQYVn6CPdVAiAsyyHUB3bpFLQ==
X-IPAS-Result: =?us-ascii?q?A0HxAACF+LpmmApBr8ZagQmBT4JEfVk0BAtIhFaIfIZRg?=
 =?us-ascii?q?XWBGZ0pFIEsPg8BAwENOQgBAgQBAQMEjmUCHgYGMAkOAQIEAQEBAQMCAwEBA?=
 =?us-ascii?q?QEBAQgBAQUBAQECAQECBAYBAhABAQEBAQEBATcFSYV1DYJcgSpeBwk4AQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBFAINXgFIBBkBATgvBQImAnMBAYJ8AYJkAxGuW?=
 =?us-ascii?q?38zgQGCDAEBBoJn2TaBYwMGgRouiEsBglyDUIRWgWREgTwOgkUBgzeBP4EHg?=
 =?us-ascii?q?w6CaZIYi3QliWaJCYFNHANZIRMBVRMXCwkFJgqJEYMpghaEF4FIg1+BZwlhi?=
 =?us-ascii?q?VyBPoFegz5LhVuBA4JZdE4/Ag0CN4E4HUACAQttPTUJCxtDpguBWoI9Pn2md?=
 =?us-ascii?q?qFiB4QXBYwPlSoGDwQvqkGGOYUvjQeNe5sdgWc6gVwzGiNQgmdPAxkPjjqDY?=
 =?us-ascii?q?YUUxnJEMjsCBwsBAQMJhUYBAYVVgUsBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:vZT+k65Oq6R47D6i+QPXwALXdLJyesId70hD6qkDc20vTiX+rb
 HQoB17726JtN91YhodcL+7Sc69qB/nhORICOoqTNGftWvdyQ+VxehZhOONsljd8kbFh5NgPM
 lbAtBD4ZHLfCFHpPe/yjOVV/wnx96K+r2pg+Dx81dBJDsBCp1I3kNSMCreNld5ajVnKPMCef
 qhD4181lmdkHIsAqvLZEU4Yw==
X-Talos-CUID: =?us-ascii?q?9a23=3A2xlpWmsCLq5xV7rOaXNebXrq6Is6XVD8wkXBZHW?=
 =?us-ascii?q?mFDg4QrO4E3Cv3aVdxp8=3D?=
X-Talos-MUID: =?us-ascii?q?9a23=3AocMJLQ8dCK30IoCpbcA03jeQf4BvpL2xORhKq54?=
 =?us-ascii?q?DhMS1Ni5PfBTaoR3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.09,285,1716242400"; 
   d="scan'208";a="93996098"
X-MGA-submission: =?us-ascii?q?MDEM29JsH9NjzeeyGJXijEdhASaqf4bM4H2aKs?=
 =?us-ascii?q?Yzxk//xBFU8bAJGq202PGaaXkxWYOREcOuZ7TNBZhnf1T3lR0A2RXE+m?=
 =?us-ascii?q?AjoD6XukXcMVWN+KGvIAREs1eZ/iBJRHUB8ur0sFdBH5dv7k6Qyf9OOm?=
 =?us-ascii?q?GQvWQ695VgfdQUZXyfhzmc9w=3D=3D?=
Received: from mgamail.intel.com ([198.175.65.10])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2024 08:15:26 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723529727; x=1755065727;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=nkZki/gpurODsfq4YVgj1aX3/WSL9PfvW1tGSDEIbkY=;
  b=RymgQkFTrJ/5u7uDJ/pAMlO3kvOyrOwPbHz8Smdavo18c9Jnz1j+2XTu
   34arGlYgxMHDJu99Wn5eiA5zS7LhTh+z8ICH5IfPXfrhyDWlgCYmVmLiQ
   MHaZ9Ym53qE5pUUouW5KOpzsxx7P2nHBMKVUzAnG5CaeGGyF+SqBWrnqz
   w5tF6Leqnj9YowAySo9zN4J7NJkxK0N57ilG2An3GuUrNOB2bN8vtq4p5
   48gSX9Xk1+Rf+z/QLf1gxm8ECK5eMdkmO+dJC0sS6akycg5DqcTtWYOxx
   rNKcabToJjn6apwgPXS3FSm062oJ2DhHLqLk/dXuTpjC1L1f4+uUKytF5
   w==;
X-CSE-ConnectionGUID: SI/MMlQoTUKOO1kWWGUCMQ==
X-CSE-MsgGUID: a3UaRdl7SgusEX9etxJJtA==
X-IronPort-AV: E=McAfee;i="6700,10204,11162"; a="39119876"
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="39119876"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:15:23 -0700
X-CSE-ConnectionGUID: s94mi69LRxObb9WBWnqhRw==
X-CSE-MsgGUID: +kGa9uaXRpyZf9XfoPDBYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,285,1716274800"; 
   d="scan'208";a="58426181"
Received: from rajritu-mobl2.ger.corp.intel.com (HELO [10.251.219.98]) ([10.251.219.98])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Aug 2024 23:15:22 -0700
Message-ID: <25273c09-ded5-4f43-82ee-956f66a8cd0e@linux.intel.com>
Date: Tue, 13 Aug 2024 08:15:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-US
From: Peter Senna Tschudin <peter.senna@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: [cocci] Iterator macros
Reply-To: Peter Senna Tschudin <peter.senna@linux.intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 1847
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-08/25273c09-ded5-4f43-82ee-956f66a8cd0e%40linux.intel.com>

Dear List, 

I am trying to make changes to a macro iterator from igt-gpu-tools*, and I am failing to use Coccinelle. My current attempt only captures about 1/2 of call sites, and I am not really sure how to ask Coccinelle to make the changes I want. Here is the pattern I am trying to change: 


From: 

const struct intel_execution_engine2 *e2; 
... 
for_each_ctx_engine(i915, ctx, e2) { 
    execbuf.flags = e2->flags; 
    gem_execbuf(i915, &execbuf); 
} 


To: 

struct intel_engine_data ied;
... 
for_each_ctx_engine(i915, ctx, ied) { 
    execbuf.flags = ied.current_engine->flags; 
    gem_execbuf(i915, &execbuf); 
} 

Changes I want: 
1. From `const struct intel_execution_engine2 *e2` to `struct intel_engine_data ied`. 
2. Replace the last argument of for_each_ctx_engine() following the change on previous step. 
3. Change references from `e2` to `ied.current_engine` inside the iterator statement. 

Here is my starting point that finds about half of the call sites: 

@r1@ 
iterator I =~ "for_each_ctx_engine"; 
statement S; 
@@ 
* I(...) 
S 

I assume that I should create other rules and import I from r1 as the core of the changes I want. Can you point me to an example to help me here?

Thank you,

Peter

* - https://gitlab.freedesktop.org/drm/igt-gpu-tools 
