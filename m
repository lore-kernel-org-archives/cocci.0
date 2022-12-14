Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF69C4332F
	for <cocci@archiver.kernel.org>; Wed, 14 Dec 2022 22:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=e2FQhcRPf8+y0BBXNlwBAKydymXGglFVRi/4W85chIc=;
  b=JWCbOs5IqHu+pUjTu0XutsNxpP/Bh3WRuL8ZRHwi9HrLiDRwWrN8ibdZ
   3+ZEBZhL+9uvTlHtyHwXXMDYf1cuw4yO8R6Qu7d7oaUoqsBwcpQgbxLEN
   Gc3PpcA3aYGdyrvxpqp2aXh6DN5M5aD+DQO64DnJLNXtSMznA/yJKEG9z
   E=;
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
X-IronPort-AV: E=Sophos;i="5.96,245,1665439200"; 
   d="scan'208";a="83462841"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Dec 2022 23:41:58 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 69085E0146; Wed, 14 Dec 2022 23:41:58 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BF58BE0128
	for <cocci@sympa.inria.fr>; Wed, 14 Dec 2022 23:41:57 +0100 (CET)
IronPort-SDR: 639a5135_BLIJg3+N1ON4FYJiZuFD33hMx670MaIl4/eC2YFmaPSbtcs
 0Sll7N8+IJ3aRbZX2m2sWLlk8DyxEUEBApPn+zw==
X-IPAS-Result: =?us-ascii?q?A0F8AQCIUJpjmIg0N8BaHgEBCxIMQIN8gVwsAwcIRYRPi?=
 =?us-ascii?q?H6IIoQrmks+DwEDAQ1EBAEBAwSEfgKFDQIeBgEENBMBAgQBAQEBAwIDAQEBA?=
 =?us-ascii?q?QEBAwEBBQEBAQIBAQIEBAEBAhABAQEBAQEBARUJGQUQDgUihTsGJw2COCkBd?=
 =?us-ascii?q?UoJNQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEQAg1SWAEeAQEBAQIBIw8BB?=
 =?us-ascii?q?QgBATcBDwkCGAICJgICVwYNCAEBgnqDACMDlgibHXqBMoEBgggBAQadR4FeC?=
 =?us-ascii?q?YEULJAmeicQgVVEgTwMgnc+hFmDQoJnmC8KgUGBAlslBA4DGSsdQAIBCzsyC?=
 =?us-ascii?q?kM1CQIMTCsaGweBCiooFQMEBAMCBhMDIgINKDEUBCkTDSkmawkCAyJhBQMDB?=
 =?us-ascii?q?CgtCSEfBxURJDwHVjcBBAMCDx84BgMJAwIfUXACLhEVBQMLFSpHBAg2BQZRE?=
 =?us-ascii?q?gIIERIPBiZEDkI3NhMGXAEqCw4TA1CBTwQvgWAKLSidD5UpLo5PoRw0B4Nwg?=
 =?us-ascii?q?UoGDJ5sBg8ELqkfl0KZOo4SMIF5I4FcMxojgzdPAxkPjA6CEhmDWYpfQzE7A?=
 =?us-ascii?q?gcBCgEBAwmKbQEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:0abBvqwHulvxqfzgxM6/KrPwAb1zdoMgy1knxilNoNJuA7Wlfr
 OV7ZMmPHjP+UkssRAb6Ky90cy7Kk80mqQFgrX5UY3SJzUO/VHYUb2KjrGSoQEIeRefygeM79
 YbT0EWMrSZYTlHZITBkXGF+r0bsb26Gc6T9IHjJjtWPGRXgqdbhWoXZDqmLg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,245,1665439200"; 
   d="scan'208";a="42677470"
X-MGA-submission: =?us-ascii?q?MDHj2LNGNKkzgPkZhEScBKVr4cpjzoJs2iEvgd?=
 =?us-ascii?q?n4f4Km2dG/I262Yku3EwUY7va78/2+eaahYgcqJlLq51B67imtW3nE/R?=
 =?us-ascii?q?qsokgQiKBXE9rnxKZ5wRbaJOPU8+jH4y1/qIrfhCFEiAceZzgcANXMVr?=
 =?us-ascii?q?LTGC/7TeNP7kGSTxNy+zagVg=3D=3D?=
Received: from mga12.intel.com ([192.55.52.136])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 23:41:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671057716; x=1702593716;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j8jI69/zLI8wvBHG5I0U35dBbtMESLI/0YAdFjO+oKM=;
  b=TKQ8KrHa59TRLrFqys5qgG1+PfNPl0qm9D1qOgjZhHiymI2X522YCaAU
   UuE4OEMWIxVBM5cTPTuBUZFjAb77UG3K+rYPWdcWp89E0eRFfKuUUnGHd
   5TfzJfDDygdkL41B1jC4bMnYH6QDycrTxLb7pxR5ras2c/jQhubAeCA+A
   iuolLWNAI1X25fbsq9AHs5TDm2SN3OE5FRE3gQow+qzhZltamkUR6Clm3
   OUAnp37vhzbPlOT4/ZjGwY/yGOOqUg0hTbLyIOEnKBQxcQl/vHWUAkHon
   9AodCZJOZPYzw6M8/b3MkvYrR+tSnbgO8p92znqyBN1ucuYYP8NrhDCSk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="298204265"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="298204265"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 14:41:53 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="717769559"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="717769559"
Received: from mkacprza-mobl.ger.corp.intel.com (HELO [10.213.30.231]) ([10.213.30.231])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 14:41:52 -0800
Message-ID: <c12455e9-7627-1a80-b2c6-caadfc101bb8@intel.com>
Date: Wed, 14 Dec 2022 23:41:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Content-Language: en-US
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
 <alpine.DEB.2.22.394.2212142146140.2928@hadrien>
From: Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
In-Reply-To: <alpine.DEB.2.22.394.2212142146140.2928@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Another space oddity
Reply-To: Andrzej Hajda <andrzej.hajda@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 779
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/c12455e9-7627-1a80-b2c6-caadfc101bb8%40intel.com>

On 14.12.2022 21:46, Julia Lawall wrote:
> 
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
>>
>> I would expect 0 and 1 produce correct indentation in 0 and 1, is it possible
>> to fix it?
> 
> Thanks for the report and the nice small examples.  I will look into it.

Surprisingly this performs nicely spaced transformation, even without 
adding space after for0:
@@
iterator name for0;
@@
-       for0() {
+       for0()
                 0;
-       }
--------

Andrzej

> 
> julia

