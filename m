Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48455E77188
	for <cocci@archiver.kernel.org>; Tue, 14 Jan 2025 17:45:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=Wp8pJihuQw9NfEdwEFR61XfFi4KLXNYEDnc5C6WNB2I=;
  b=o8t7zBxE7kqP7huq/OuJjFdB8HJ2P0DwM9c77hzoYD1rSG/m5KqVEKu1
   VpPMzdL/p7Eyn6lr0I2wwCkWmRjJJrdPd0O4LFp12IpVaAayj286v7gpY
   YuZEUCC+xkps2rqz287Q6x9Xa5dzFtQQ5DR7Y9Wgle+f+gnF+a3NQQ8B0
   g=;
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
   d="scan'208";a="203120609"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Jan 2025 18:45:31 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 4306CE00A5; Tue, 14 Jan 2025 18:45:31 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 01458E0077
	for <cocci@sympa.inria.fr>; Mon, 13 Jan 2025 13:40:55 +0100 (CET)
IronPort-SDR: 678509d7_onLWH4KsfvLcT5vanEHeJqJSdfDwu4ouwa4TaYYr2A7LEFo
 oDY8jXzx48eBr9+R1ZQ//WU3Emztg0h0VAjuyxw==
X-IPAS-Result: =?us-ascii?q?A0E3AQBuCYVnjwujxsBaHgEBCxIMgggLgkSBVjEDBAtIj?=
 =?us-ascii?q?VKIcgOeGIFAPg8BAwENQQECBAEBAwSBTIM0Aop1Ah4HAQQyBw4BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBAQEBATkFSYV7DYJiAYEkXgcJO?=
 =?us-ascii?q?AEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BHgEBAQECAUABATcBDwsYC?=
 =?us-ascii?q?SUPAUYGE4MBgkIjA7MlgiyBAYIMAQEG3B+BZAmBSIVrgmMBhgaDYnonD4FVR?=
 =?us-ascii?q?IQ/PosHgjdLgSiCNIEMiXWCXIRDgVuDDIhfUnscA1ksAVUTFwsHBYEpHysDg?=
 =?us-ascii?q?RQlgScFNUE6ggxpSToCDQI1gh58giuCIYI7hEeEU4VkghSBZQMDFhABgylLH?=
 =?us-ascii?q?UADC209NxQbBpxdPINoRFEBgSYlJTMnWJJAsxw0B4QegV0GDJ9xM6pTiBqQY?=
 =?us-ascii?q?qNfhU6BbgEygVwzGiODN08DGQ+OIRmDYbcjRDI8AgcLAQEDCYVGAQGKGmtgA?=
 =?us-ascii?q?QE?=
IronPort-PHdr: A9a23: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
 Dw6eERI/OX40A==
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:6CIsDKh6MjTu/CNPYHkdt/jJ8nBQXhoji2hC6mlwRA09TyVXrb
 HJoB17726LtN91YhodcL+7SdS9qB/nhPpICMwqTM+ftWrdyRSVxeNZnPffKu3balbDH4dmvM
 8PAs1D4Z/LfCJHZK3BkXCF+rgbsb662ZHtr93zi11qSgZnYbxh6QBWNia3e3cdJTVuNN4SLr
 bZwtBIiQaBVB0sA6SG7z4+Lov+Ttvw+P2WAyI7Ow==
X-Talos-CUID: =?us-ascii?q?9a23=3AXp6Mr2iHPxvZRfMKprDJ4YNa2DJuUyfa6jCKO3S?=
 =?us-ascii?q?CF0VrVoOoanPLoJNunJ87?=
X-Talos-MUID: =?us-ascii?q?9a23=3A48ib3A9C3ejdiXrce0NB2+eQf+Yy2auKD1AfrdI?=
 =?us-ascii?q?5vs+gbxIoKz7eth3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,310,1728943200"; 
   d="scan'208";a="106192373"
X-MGA-submission: =?us-ascii?q?MDHITNshV70+SVvuiYvd/qgk1JQMHEU0A2KwCD?=
 =?us-ascii?q?sFCYeS/uMOImd5+VQ0egsMKpOdhOIz5XDqy1RB/SkMl8pSrDuvhnrMI0?=
 =?us-ascii?q?4PIe59R7heqhDJj07TEtlkYX0ivO3ZHSKTU7owk7UiaJPlRynlf27Qz1?=
 =?us-ascii?q?dFqrEs3KhRus7KPvZRolpDSg=3D=3D?=
Received: from mgamail.intel.com ([192.198.163.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 13:40:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736772055; x=1768308055;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=PeqAb4H0Uvofh6rgJDlHb62DI9GE8KDVfRVH3poFgTE=;
  b=KtTqoNPZTori8P7mMXhSwyCFcjURekxPdieQfT0EpGudPIH9+djw4RyE
   CLovwhkPCII47yFJl4Jaoo883ly2JzWkab+xEO7o0BXgt3POPmo5Ij0Ca
   4mkc2kENTxNaJw8aJoinYOH8m+8WbLNyQonFi9exDuWD82XFaXCTkjWPt
   yfweQd4d5gDR2mu//FHymWOY5Hrw/3tH1Snf/cx7wJmm8ygHc6CuPik5X
   7igRxw7MxG29Es4FKmnnFrKqAx1nZr8a2Q0nOJVXimtlYIEyN2yo1fHFs
   VKTvQdn6ybcOh7cc5oUnsaFA3hsPoccfiMOSQW65r9PwZth8d1jYQ4cSv
   w==;
X-CSE-ConnectionGUID: HKVLIsU8Q+GBLma1NGiqvw==
X-CSE-MsgGUID: B9FAWBUsRLSvcqkwO6ZJdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47608510"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47608510"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:40:50 -0800
X-CSE-ConnectionGUID: St4KkdFnRba/4Kxci6GSzQ==
X-CSE-MsgGUID: +oVKaaHwRba3uLWYQKWQ6A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="104982981"
Received: from klitkey1-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.246.145])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 04:40:49 -0800
From: Jani Nikula <jani.nikula@intel.com>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
In-Reply-To: <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <87plkrhqu9.fsf@intel.com>
 <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr>
Date: Mon, 13 Jan 2025 14:40:46 +0200
Message-ID: <87frlmj38x.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] spatch #include statements and include search path
Reply-To: Jani Nikula <jani.nikula@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 2202
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/87frlmj38x.fsf%40intel.com>

On Mon, 13 Jan 2025, Julia Lawall <julia.lawall@inria.fr> wrote:
> On Mon, 13 Jan 2025, Jani Nikula wrote:
>
>>
>> I want to use a non-trivial match rule in multiple other rules, in
>> multiple .cocci files. I'm trying put the match rule in a separate file,
>> and #include that in the other files, to avoid duplication. (I'm
>> referring to the "include_cocci ::= #include string" usage of #include,
>> not transformations.)
>>
>> It works when the current working directory is the same as the file to
>> be included, but I seem to be unable to make it work from another
>> directory.
>>
>> It doesn't matter if the .cocci files are all in the same directory or
>> not, it doesn't seem to matter what I pass as -I to spatch on the
>> command-line. I see #include mentioned in the SmPL Grammar as well as
>> some tutorials, but I can't find any proper, working examples for it.
>>
>> How is the #include and the search path supposed to work? There seems to
>> be some conflation in the documentation about include_cocci in .cocci
>> and #includes in the .c files.
>>
>> Specifically, I'm running spatch in my kernel repo, and I keep the
>> .cocci files in a separate directory outside the kernel repo.
>
> I don't think there is any search path for .cocci files.

Oh, so it's always relative to the current working directory? That's a
bit of a bummer.

Thanks, though.

BR,
Jani.


>
> I see an example in tests/gadget_soa_defs.cocci that contains
>
> #include "tests/gadget_match.cocci"
>
> There was a problem about the files coming in the wrong order in the case
> of multiple included files.  I've pushed the recent changes out to github
> just now, so that fix should be there.
>
> julia

-- 
Jani Nikula, Intel
