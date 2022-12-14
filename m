Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5ADC4332F
	for <cocci@archiver.kernel.org>; Wed, 14 Dec 2022 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=bqGezbHOSmIZqGqKXIYvCJW3gSAHF+Fyl9NTh7NU4d4=;
  b=fShm/qhu3eBbLSO4ZYNYSyaKGLk73MlFkz/51Kx7m3ohP+xQ4d1ylKlG
   WyaW71p8lRjg+tOHyTOomagesO8akbCGA3V3UvV0Q313P0X0qOJ4wyu9r
   Bn6gf2QToI5fn0pO1vsBtBelYkreeVnDJ7u7YpdR9REc+WyWYvKS9EWIw
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@intel.com
X-IronPort-AV: E=Sophos;i="5.96,245,1665439200"; 
   d="scan'208";a="83444495"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Dec 2022 19:24:55 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 232C1E0138; Wed, 14 Dec 2022 19:24:55 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id F1825E0128
	for <cocci@sympa.inria.fr>; Wed, 14 Dec 2022 19:24:50 +0100 (CET)
IronPort-SDR: 639a14f2_YgdpEmUQdkuvmG/IKQCVIIRePkZqaXRhqu6gEkdpn+5zNz0
 6YO5PauekVueunLPRUF9Y2xTOEvIxgNEGGZIlSw==
X-IPAS-Result: =?us-ascii?q?A0EvCADJE5pjh3M0N8BagQmBT4ItgVwsAwQLRYRPiH6Hc?=
 =?us-ascii?q?YRcmks+DwEDAQ1EBAEBAwSEfoUPAh0HAQQzBg4BAgQBAQEBAwIDAQEBAQEBA?=
 =?us-ascii?q?wEBBQEBAQIBAQIEBAEBAhABAQEBGQkXBw4QBSKFaA2COCJ9Sgk1AQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBARACDVJYSQ8BBQgBATgYHAImAmwIAQGCeoMjA?=
 =?us-ascii?q?5YYnBeBMoEBgggBAQadR4FeCYEULZFGEIFVRIE8glQBhUU4gwqCZ5c2cYFBg?=
 =?us-ascii?q?QI/JQQOAxkrHUACAQttCkM1CQ5MKxobB4EKKigVAwQEAwIGEwMiAg0oMRQEK?=
 =?us-ascii?q?RMNKSZrCQIDImYDAwQoLQkhHwcmJDwHVjwDAg8fOAYDCQMCH1FwAi4RFQUDC?=
 =?us-ascii?q?xUqRwQINgUGURICCBESDyxEDkI3NhMGgQcLDhMDUIFPBIIPClacdJUpLo5Po?=
 =?us-ascii?q?Rw0B4NwBYFFBgyebAYPBC6pH4YNkTWZOo4SMIF4JC6BLjMaI4M3TwMZD445g?=
 =?us-ascii?q?1mKX0MxOwIHAQoBAQMJim0BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 T3Tx5EoAiWM/w==
IronPort-HdrOrdr: A9a23:ga7xPq6H1xULFnL/xwPXwPPXdLJyesId70hD6qkDc20zTiX+rb
 HVoB17726OtN91YhodcL+7Scq9qB/nhPhICOoqTNWftWvd2FdA/LsSlbcKqgeIc0Geygc379
 YYT0ERMqyVMbE3t7ee3OC/KbxMr7e6zJw=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,245,1665439200"; 
   d="scan'208";a="83444489"
X-MGA-submission: =?us-ascii?q?MDFBpIH5PBmtFJI1diwWEaeGlgEt4cbMO9qzMq?=
 =?us-ascii?q?gRFB5jL77H9Rsql7+XdFPUPJXA4tNVdjf2IxHUQbX6AqJuE42I1UhruJ?=
 =?us-ascii?q?alQ4hR4ROcTJfJJ+QYHzKSjhvubti77BXV+byyN//VWjpzXRpgPETRvt?=
 =?us-ascii?q?TAM4ArHE4GQ76M7ZZrg7VhEw=3D=3D?=
Received: from mga14.intel.com ([192.55.52.115])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 19:24:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671042290; x=1702578290;
  h=message-id:date:mime-version:to:from:subject:
   content-transfer-encoding;
  bh=VoVsPgtIRVNbNl59Ka/IyIHIVag2Xlpnl4ef+P5M21E=;
  b=jls15jrVL3t7302Na9iDAnb9aZwMkf9+/p11z85ISJ1+2B7ft/vbAMRo
   uoENA1LQEwTpupuUgTGo5eaBsFkEZevuySTzwqMbEuopftbfW8Ew0eYT+
   3kTkGjvfHA5h4s48juFu0g97/JLq8aGdIxx+2oliy1IChB1fH1QNTZivC
   ZHdayLPgEX73kUFgkq/fiDUHjVTctuvtzd6UVFa60iifDogJ3A3DY5+IT
   MwGYXlppJ/QIbEG3c4e7phYAFQD6fWTNM/tQiy5AVOgON5GUN/0JPmYax
   ITwuamPaBxUdtmyDyKkY/Tnx+/JeLawLEIpYxA/sSE0oYmo6Vq2hkuME8
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="318526037"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="318526037"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 10:24:47 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10561"; a="823384224"
X-IronPort-AV: E=Sophos;i="5.96,245,1665471600"; 
   d="scan'208";a="823384224"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.9.83]) ([10.213.9.83])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2022 10:24:46 -0800
Message-ID: <c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11@intel.com>
Date: Wed, 14 Dec 2022 19:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
To: cocci@inria.fr
Content-Language: en-US
From: Andrzej Hajda <andrzej.hajda@intel.com>
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: [cocci] Another space oddity
Reply-To: Andrzej Hajda <andrzej.hajda@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 777
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/c2cb22fd-81aa-a27b-7ac7-77ee8bf74e11%40intel.com>

Hi,

I have found another strange space/newline behavior when changing 
iterator loops:
Following script:
@@
iterator name for0;
@@
         for0()
-       {
                 0;
-       }

@@
iterator name for0;
@@
         for0()
-               { 1; }
+               1;

@@
iterator name for0;
@@
-       for0() { 2; }
+       for0() 2;
-----------
On file:
int f() {
         for0() {
                 0;
         }

         for0() {
                 1;
         }

         for0() {
                 2;
         }
}
Produces output:
int f() {
         for0()

                 0;

         for0() 1;

         for0 ()
                 2;
}
---
Ie. in cases:
0 - it adds extra line,
1 - removes existing line,
2 - produces correct output, but modifies iterator header (I would like 
to avoid, extra space between for0 and '('.

I would expect 0 and 1 produce correct indentation in 0 and 1, is it 
possible to fix it?

Regards
Andrzej
