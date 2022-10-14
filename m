Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89039C433FE
	for <cocci@archiver.kernel.org>; Fri, 14 Oct 2022 12:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:from:to:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=gG8BBmiLn8ud7aXbqdvqN6ZxqlcMfmlWgUjoTO5t4Eo=;
  b=tAqAQWRE8No2cfq0QXK/RmMcN3tiI3A4Gqm9FaFtaetF4hKcxrBvhQqN
   wAMd2S+bMW1KHZ51NJiDg0O0FPO3XhHnjtwWLfOIgedsJoHkRo6VvkQ4F
   Ac5GENnsopjkKMyOkMIiQLtzY9bKU6yQs9rdrbUg+cvIxZPOxh90Ouicb
   Y=;
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
X-IronPort-AV: E=Sophos;i="5.95,184,1661810400"; 
   d="scan'208";a="65186458"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 14 Oct 2022 14:03:49 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 59037E0038; Fri, 14 Oct 2022 14:03:49 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 99B12E0038
	for <cocci@sympa.inria.fr>; Fri, 14 Oct 2022 14:03:45 +0200 (CEST)
IronPort-SDR: 63495021_NKoTrwCzS2tCVtXljo56+Hs5nc6Ky32o7VZNTbw9zxpzoDH
 qLzmYblsHzESsUBW9J4XSVynsbc2jwZazDM/Mrg==
X-IPAS-Result: =?us-ascii?q?A0BDAQC4T0ljmB+IhoZagQmBT4IlgVYsAwQLRYROiH6Ha?=
 =?us-ascii?q?oRZmHKBfAsBAwENQgQBAYR7CoRwHgcBBDAJDgECBAEBAQEDAgMBAQEBAQEDA?=
 =?us-ascii?q?QEFAQEBAgEBAgQEARMBAQEBAQEBARQJGQUQDgUihWgNgjUihBUVCAEBODQCJ?=
 =?us-ascii?q?gJTGQgBAYJ5gyEDqi6BMoEBgggBAQaGDoFcCYERLJBqgVVEgTwMgQmHBTiDC?=
 =?us-ascii?q?oJmkh6ISyYEDgMZKx1AAgELbxgDFAMFIQcDGQ8jDQ0EHQwDAwUlAwICGwcCA?=
 =?us-ascii?q?gMCBhMFAgJNNAgECAQrJA8FAgcvBQQvAh4EBQYRCAIWAgYEBAQEFQIQCAIIJ?=
 =?us-ascii?q?hcHExgbGQEFWQ4JIRwKHg0FBhMDIG8FCjgPKC9pKx0bB4EMKigVAwQEAwIGE?=
 =?us-ascii?q?wMiAg0pMRQEKRMPLQcpcQkCAyJqAwMEKCwDCSEfByUkPAdYOgUDAhAiPAYDC?=
 =?us-ascii?q?QMCIllzAi8RFQUDDRcnCAU3GwQIPAIFBlISAgoRAxIPLUgPSj45FwYnny+lQ?=
 =?us-ascii?q?J8mNAeDYoFEBgyeVgYPBC6DZKUrh2WPLZkxjhIwgWI6gVszGiODN04DGQ+OO?=
 =?us-ascii?q?YNZimBCMTsCBgsBAQMJjG4BAQ?=
IronPort-PHdr: A9a23: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
 Dw6eERI/OT40A==
IronPort-Data: A9a23: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
 RwjFqXMAyWM
IronPort-HdrOrdr: A9a23:BAVqmK9JyiEWQTdZSCxuk+DdI+orL9Y04lQ7vn2ZKCYlC/Bw+P
 re+cjzuSWE6gr5HUtQ+uxoW5PgfZq/z+8Q3WB5B97LNzUO+lHJEGgI1/qE/9SPIVyZygef78
 pdmmpFYuEYwWIUsS8y2mXXL+od
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.95,184,1661810400"; 
   d="scan'208";a="65186449"
X-MGA-submission: =?us-ascii?q?MDHvql6F6x57z/Ey+14Ts2Nqf3nufiNcKpAaY8?=
 =?us-ascii?q?wn4sl+I3hk5OxX8E3aDZrzWQMfp6t7LX83rSjS/RioGjHCWJP7qPcxAW?=
 =?us-ascii?q?2X8kIRKVt6vHIG7uWLWMBpBCajyIVy3iJgqQ0ik1g3PVGuHG+DXjE6W8?=
 =?us-ascii?q?3BlV/YjqKA3IwRxhy4/Oi6IA=3D=3D?=
Received: from mga06b.intel.com (HELO mga06.intel.com) ([134.134.136.31])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 14:03:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665749024; x=1697285024;
  h=message-id:date:mime-version:from:subject:to:
   content-transfer-encoding;
  bh=Or0lW4HHVQ6nrz7CrfGnE4TPgEjeaH4lFUzVDWR1YcM=;
  b=a8xhvuuKi8NLD1D0Na3C2ystJ60Qvv/AL37onpSdDBli4uGcVDhdAHDa
   uEUV6cld3ft16abdneqtRuiyrYvWB5O1QKEuDdhtK5CCVylm6rCn04NPb
   hBlklNmwRH3QTldDcKk/rX7OSa6OFTskQBzuE5uvGy+DMD7rYyDZze+a9
   f2XMNAxTWf0g7Z72GEpgNsBVIm9KO84kXT2hkRBvSCx0JI7J/0MI3HhdX
   qbA7icsxn/GgoIZvh6ASTs5TKxayJMDKhVb9ISSZCX29An9sWF0He5ZKY
   c0cmwAgpkHBBrAU0weZnIxrtTYM+yK1xhHGcSpq3CL9TUyVcP58kYRuxg
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="367378957"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="367378957"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 05:03:42 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10499"; a="578609022"
X-IronPort-AV: E=Sophos;i="5.95,184,1661842800"; 
   d="scan'208";a="578609022"
Received: from ahajda-mobl.ger.corp.intel.com (HELO [10.213.15.251]) ([10.213.15.251])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2022 05:03:41 -0700
Message-ID: <7bda3ec2-1335-4451-dc59-b70faa216750@intel.com>
Date: Fri, 14 Oct 2022 14:03:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.3.2
From: Andrzej Hajda <andrzej.hajda@intel.com>
To: cocci@inria.fr
X-Mozilla-News-Host: news://news://nntp.lore.kernel.org:119
Content-Language: en-US
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298
 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [cocci] spatch adds zero or two lines after if statement
Reply-To: Andrzej Hajda <andrzej.hajda@intel.com>
X-Loop: cocci@inria.fr
X-Sequence: 646
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-10/7bda3ec2-1335-4451-dc59-b70faa216750%40intel.com>

Adding 'if' statement to the code does not add empty line after it, as 
expected, but if I explicitly add empty line spatch adds two lines, and 
this is unexpected. How can I convince spatch to add exactly one line?

Following script:
@@
@@
+ if (1)
+ printf("a\n");
return 0;

@@
@@
+ if (1)
+ printf("b\n");
+
return 1;

##### EOF
used on file:
int a()
{
return 0;
}

int b()
{
return 1;
}
##### EOF
produces:
@@ -1,9 +1,15 @@
int a()
{
+ if (1)
+ printf("a\n");
return 0;
}

int b()
{
+ if (1)
+ printf("b\n");
+
+
return 0;
}
##### EOF

Regards
Andrzej

