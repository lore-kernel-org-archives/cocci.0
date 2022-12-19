Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2602FC4167B
	for <cocci@archiver.kernel.org>; Mon, 19 Dec 2022 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=7Yurm8sk1WgPSCtRdPMUGbKAd6dgTPkOz/W0HY30pe0=;
  b=CeQKfVIwG4+CwUaLd2iLxwvQ4AbCqVuczJrdwmMjEXq8wSR6bwBGx07w
   MfqCH7ODR6YqJGdQFhcRKVPvZuAFDpCkXoO4pOmszFBcQn/mxuQmVfmtQ
   8MvE5wndc5yKD6AGyUBIzWXo7pueRU13I0bQAW1MmPKk0I5w9iF43IyXI
   M=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="5.96,255,1665439200"; 
   d="scan'208";a="84093599"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 Dec 2022 09:44:43 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 22283E0145; Mon, 19 Dec 2022 09:44:43 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 39EECE0128
	for <cocci@sympa.inria.fr>; Mon, 19 Dec 2022 09:44:41 +0100 (CET)
IronPort-SDR: 63a02477_/O3vjSnKB/a6c3dzXQ8mAzRz9OP8gJcT0wrF/1LdfIrnft0
 +REEjJx4C1ffO75jQMoKZu3DPUVz/GXaWdD/Stw==
X-IPAS-Result: =?us-ascii?q?A0EUBQAyJKBjmFg0N8BaHgEBCxIMQIFRgiuBXCwDBAtFh?=
 =?us-ascii?q?E+IfodzMYQrmQ6BPz4PAQMBDUQEAQEDBIR+AoUOAh0HAQQ2BA0BAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEBAQEBARUJGQUQDgUihWgNg?=
 =?us-ascii?q?jgpAXVKCTUBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBEAINUlgBHgEBAQECA?=
 =?us-ascii?q?SMPAQUIAQE3AQ8JAhgCAiYCAlcGDQgBAYJ6gwAjA5wumx16gTKBAYIIAQEGn?=
 =?us-ascii?q?UeBXgmBFC2QKHonEIFVRIE8DIJ3PoRZg0KCZ5hZCoE9gQCBJSUEDgMZKx1AA?=
 =?us-ascii?q?gELOzIKQzUJAgxMKxobB4EKKigVAwQEAwIGEwMgAg0oMRQEKRMNKSZrCQIDI?=
 =?us-ascii?q?WEFAwMEKC0JIR8HFREkPAdWNwEEAwIPHzcGAwkDAh9ScAIuERUFAwsVKkcEC?=
 =?us-ascii?q?DYFBhw2EgIIERIPBiZDDkI3NhMGXAEqCw4TA1CBTwQvgV4KBikonT8IlSMuj?=
 =?us-ascii?q?lGNWJNFNAeDcYFKBgyebwYPBC6pJJdCmTuOEjCBfAsVgVwzGiODN08DGQ+OI?=
 =?us-ascii?q?BmDWYpfQzE7AgcBCgEBAwmMIwEB?=
IronPort-PHdr: A9a23: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
 d2dzMrO
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:GB4Trq1SnoQwvHhAxfoPZgqjBJ8kLtp133Aq2lEZdPWaSL3gqy
 ncpoV96faSskdvZJhAo6H9BEDkexjhHPFOkOos1NuZLXLbUS6TXfxfBOjZsl/d8k/FltK1BZ
 0QCZSWYeeYZTQasS+52njBLz9K+qjizEnHv5a5854gd3AOV0hn1W0VZWimLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,255,1665439200"; 
   d="scan'208";a="84093588"
X-MGA-submission: =?us-ascii?q?MDFT3pWEFHFReuwu3NwCkWDCVjyN1wRQ7v7vDY?=
 =?us-ascii?q?Q9GWdVHaeyBAP1HjwDZ1tL7zdNWJwqt2rO/8xOiKNxyEb5TxPNNJq8kg?=
 =?us-ascii?q?/a9Gk9Wdifz5oEP0vYbq/1luBgMYQgJ4zk3I3LMQwRVdVZKgh4iKAuoN?=
 =?us-ascii?q?5S0TGsO0+ssCCkGeMSZuGJYg=3D=3D?=
Received: from mga01.intel.com ([192.55.52.88])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 09:44:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671439478; x=1702975478;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nSwaYWoKAH9YO5ZeF3eXxQ2W4eZSMII5wzfwinktwvE=;
  b=bMI12yArsl6bMhPQ82l9bXBX+ninJriZjo9aPlUkZ8teZ1BObufIrGpE
   yj/OWKfw/d+G31Ctm5Oc3yWOZAGyHGLFIzdKIh//oX6G87zlvBMgEQamF
   PaIxUCZhKIpbZU5DgHrwNstkwmVbZL9ldOtdcTP2Mc9lQLsjHjbGLPliL
   H8ywEcnvPoteM7JkvoXAhSgDwU6XfU4212sl0q6GgX7CgJNtWAAhkE0hT
   /Vh1KNu0w4tpb2B3NMWN+wSJjinb6fKWUp8rWLMUXdMaEpexr3aLWPQWw
   DeHy2LQKC4k7yZOCIoLk3j9yaI36k1OPDVT1aIdZ75KiCLBbGSathLdqG
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="346393083"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="346393083"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 00:44:35 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10565"; a="652619115"
X-IronPort-AV: E=Sophos;i="5.96,255,1665471600"; 
   d="scan'208";a="652619115"
Received: from mszymcza-mobl.ger.corp.intel.com (HELO [10.213.16.42]) ([10.213.16.42])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Dec 2022 00:44:34 -0800
Message-ID: <f9322697-5e78-1679-6dbb-ffe2bbc1e046@intel.com>
Date: Mon, 19 Dec 2022 09:44:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
 <alpine.DEB.2.22.394.2212181712570.37242@hadrien>
From: Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <alpine.DEB.2.22.394.2212181712570.37242@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Another space oddity
Reply-To: Andrzej Hajda <andrzej.hajda@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 781
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/f9322697-5e78-1679-6dbb-ffe2bbc1e046%40intel.com>



On 18.12.2022 17:13, Julia Lawall wrote:
>
> On Wed, 14 Dec 2022, Andrzej Hajda wrote:
>
>> Hi,
>>
>> I have found another strange space/newline behavior when changing iterator
>> loops:
>> Following script:
>> @@
>> iterator name for0;
>> @@
>>          for0()
>> -       {
>>                  0;
>> -       }
>>
>> @@
>> iterator name for0;
>> @@
>>          for0()
>> -               { 1; }
>> +               1;
>>
>> @@
>> iterator name for0;
>> @@
>> -       for0() { 2; }
>> +       for0() 2;
>> -----------
>> On file:
>> int f() {
>>          for0() {
>>                  0;
>>          }
>>
>>          for0() {
>>                  1;
>>          }
>>
>>          for0() {
>>                  2;
>>          }
>> }
>> Produces output:
>> int f() {
>>          for0()
>>
>>                  0;
>>
>>          for0() 1;
>>
>>          for0 ()
>>                  2;
>> }
>> ---
>> Ie. in cases:
>> 0 - it adds extra line,
>> 1 - removes existing line,
>> 2 - produces correct output, but modifies iterator header (I would like to
>> avoid, extra space between for0 and '('.
> To avoid the space, you can use the argument --smpl-spacing.  Then it will
> follow the spacing strategy found in the semantic patch.

Thanks for the hint.

Regards
Andrzej

>
> julia

