Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3881C19F32
	for <cocci@archiver.kernel.org>; Fri,  7 Mar 2025 09:24:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Da5GvoMYHK+n2EpSfkWr3DP2DBfqQWCYmifpDQl2QNg=;
  b=ebP8iRzMTd6V6Qf0fobAxNJj+PJtu89dKvcFwnhWXna8ogxO3y8rQB2z
   8cG16IS4mvZ0rflHWajqW7dUtb5AWl4/FJoDEk+J9pTlx4spml38MwLpv
   O6O2oo92S7ZH3p188d0qJ0vDmcFhZblSGJDLN5U4ICa1OFs9H6geYbYT0
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.alibaba.com
X-IronPort-AV: E=Sophos;i="6.14,228,1736809200"; 
   d="scan'208";a="211724825"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Mar 2025 10:24:41 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1F557E0264; Fri,  7 Mar 2025 10:24:41 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 3D26EE0260
	for <cocci@sympa.inria.fr>; Thu,  6 Mar 2025 13:06:48 +0100 (CET)
IronPort-SDR: 67c98fd7_ST8V/r7yNaa75a16S1Sl6MHUTPonDaA8+bH5Vx7YFqhA4eM
 Rqupd7ygMhGT9Z/7Q9GIlk5bMA9e9zDCf5FnrOQ==
X-IPAS-Result: =?us-ascii?q?A0FkAwBXj8lnj2UefHNagQmBU4JEfVk0BAtIhFaRQy0Dm?=
 =?us-ascii?q?DiEBoFqgREHFD4PAQMBDTkLBAEBAwSFAAKLGAIeBwEEMwYOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBARABAQUBAQECAQECBAYBAhABAQEBAQE5BUmFew2CYgGBJGUJOAEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEWAg02RwEBAQECASMECwENAQE3AQQLCxQBAwICJ?=
 =?us-ascii?q?gICVgYBDAYCAQGCfgGCQSMCEgauQ3p/M4EBggwBAQbcIIFlAwaBGi6FbIJjA?=
 =?us-ascii?q?YYGIIQ8QoINgRUnDoJ1PoQqLoNGgmmCM0WBJAGDPZBXmB5SexwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSlDAyo0MSOBIwU0QTqCC2lJOgINAjWCHnyCK2oEBYEkgjeEPYRChVKCE?=
 =?us-ascii?q?YFdAwMWEIMfdxyERjuEaRcdQAIBC209NwkLG0OhdQE6g0eCHhgigSFQN5ZAj?=
 =?us-ascii?q?n6hCRWEEIFjijWVNQYPBC+EA40JhjqTES6HZY9yeSKLaoF5my6BfSSBXHAVg?=
 =?us-ascii?q?yJPAxkPjjqDYYUTwlk5MgI6AgcBCgEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:56YNjairRGb9/1rEtLsKLajFX161GhsKZh0ujC45NGQN5FlHY01je
 htvWz3Xaf7fMWT3Kogjat/np0IGvcfVzoUxGgVl+yEyEn5jpJueD7x1DG+gZnLIdpWroGFPt
 phFNIGYdKjYaleG+39B55C49SEUOZmgH+a6UqieUsxIbVcMYD87jh5+kPIOjIdtgNyoayuAo
 tqaT/f3YTdJ4BYqdDtIg06/gEk35qmq42tG5gdWic1j5TcyqVFFVPrzGonqdxMUcqEMdsamS
 uDKyq2O/2+x13/B3fv4+lpTWhRiro/6ZWBiuFIOM0SRqkQqShgJ70oOHKF0hXG7JNm+t4sZJ
 N1l7fRcQOqyV0HGsLx1vxJwS0mSMUDakVNuzLfWXcG7liX7n3XQL/pGJXMqeqw3/uFOHWx31
 e0KAhQGTi6+vrfjqF67YrEEasULK9T3Z9ta4yk5iz/DAPsjSJHHBaDD5Nse1TMxl91IW/3ZY
 qL1axI2NUmGOkcTfAxPTstmxY9EhVGnG9FcgFmVqKw48m/O5Ahw1qX9dtPRe9aDT8wTlUGdz
 o7D1z2gWkFGboXHlVJp9FqIgLHVpQn/BblOL7uK+95uuUGh1DcqXUh+uVyT+qTh1BHhAbqzM
 Xc88S0lpqka712uVtC7XhuioXfCsAR0ZjZLO+on9FrVj/OMukCXHGUJSzdAbJojvc4yAzUu1
 06UmZXiAjkHXKCppWy134WI6hKdPS8sMWI7RT4WZy8Ow+femdRm5v7QdepLHKmwh9zzPDj/x
 TGWsSQz74n/a+ZUis1XGniY31qRSoj1c+Ij2unAdkmDhj6ViaaiepDzsR2Cta8GIpyUQ1yIv
 XxCnsGf6KYHCZCciSrLS+IIdF1I2xpnGGOC6bKMN8N5n9hIx5JFVdsBiN2ZDBw2WvvogRezP
 CfuVfp5vfe/xkeCY65teJ6WAM8316XmHtmNfqmLMoMXM8ktJF/ZrHoGiausM4bFzxBEfUYXZ
 s/zTCpQJSty5VlPlWvqGrlFuVPV7nlknTmKLXwE8/hX+eHDPCDKFu1t3KqmfOA07qKNpgqd7
 99YPcKNgxNSTPL5eCqf+olVZVQWIRAG6WPe9KRqmhq4ClM+QgkJUqaJqZt4ItwNt/oOzI/go
 CriMnK0PXKj3hUr3y3WMSg7MNsCnP9X8RoGAMDbFQ3zgCBzMN/wsvZ3mlleVeBPydGPBMVcF
 5EtE/hsyNwWItge021FMcevn58obxmxmwOFMgysZTV1LdYqRBXE9pWgNkHj/TUHRHj//8Yvg
 ayS5iWCS7o6RiNmEJn3btCrxAiPpnQzor95cHbJBdhxQ3/S1rZWBRb/tdIJBv0dCA7iw2Ka3
 jmGAB1DqujqpZQ0webzhquFjtmIFronEmZ/AE3nwKmTDnTf9W+dxYV/fv6CVm3BZVzw44GnS
 /5c//WlOvxanlwQ64tYOJRoxJIY+NHAieJ7zANlPXOTdHWtKOpqDUen1Pl1lJ9m5+Fmqyrvf
 WmQ6Px2BK6vBPr1NHIgfy8ecfWl198YvhLw/MYFChz2ywEv9YXWTHgIGQeHjRJsCYdcMaQn8
 L8Hg9EX4QnusSgaGI+KoQ4M/lvdM0Fadbsss6wbJ4rZigAL7FVmSr6EAw/U5KC/Ufl9AnMIE
 BS12pWb3699w3DceUUdDXLOhOpRpaofsSBwkWMtGQ67pcrntNQWgjtq7jUFfiZExE5m0sVyG
 FRRGW9bGKGsxwps1e9/Bz2COgcZHxCI2F3D+31Qnk3jckSYfGjsLmo8BOWzwH4k419sJgZ8w
 rXJ51vmABDLfd7w1BQcQURKieLuZv0v+xzgmPKIJdWkHZ47axXhn6Oeanc5lAv/MMYfhXz8+
 Otgpr5xTYbZNicghbIxJKfH9LYXSTGCfHdjR9M49ow3PGjsQhOA8hnQFFKUZeV2OKbs42KjL
 s5TevJ0SBW10RiRogAhBaIjJ6F+mNgr7oEgfozHCHEnsbzFiBZUq7PVqzbDgVE0T+VUkcoSL
 p3bcxSAGDeygVpWg2r8k9lWCFGnYNUrZBzO487tyb8nT6k8ieBLdV0+9pCWvH/PaQtuwE+yj
 TP5PqTTy7Rv9JRok47SCZ58PgSTK+7odeG24Qu24sVvb9TODJ/0jDkriGLbZiZYAbhAfO5Mt
 +WpkMX210b7rroJQzjnu52eJZJou+S2fsRqa/zSElcLvBGsesHW5zk7x1uZMr1MydNU2dmmT
 VC3aey2bt8kZO1ez3x0NQlbAw4XDZqrSqLOviqCjfS9DzUA4FaWMPKm6n7bQmVJfQAYO5DFK
 1HVutT/wvt6vYhzFBs/KPU+OKBBIXjnQrkDW+DqkzuTHk2EowqllOP5tBwC7TrrNCG1IPzi6
 8iYeimkJQWAhq7Y6fp47apwh0QzJ1Rgi7ASekk9xYZHuwqiBjRbEdVHYIQ0MbAKoCncz5qiW
 SrsalElAiDDXThpVxXwzdDgfwWHDNw1JdbLCW01znyQdhuJKtuMMJl5+gdkxkVGSD/p4eWkC
 NMZo1nbHBy6xLN3TucyuN2/p8paxc3h+3FZwnClzvTOACsfD4tThTYlVEBIWDfcGs7AqFTTK
 CJnDSpYSUW8UgjqHdwmZ3dRHwoDsSjyyykzKx2C28vbp57R2dgoJCcT4A0v+uZrgAU2yL8yq
 bffQHaRuDjTgyRK/6Uztt8siK5wT/eCH8z8JaviVBAU2aq37wzL+i/EcTUnFKkfFMx3SjsxV
 QVAJ1A6BUKYOAZY3LycwA8AvZl2VxrgyhnX2RXnq2aufQMRlrDkltvD8O4/AZXxrbXz+UxcQ
 T0bZk/XqFqT3NchSf+SqdxDzmG67Qot+bUon8zmol4eUvthdYOFKI1c7g==
IronPort-HdrOrdr: A9a23:LOK2MqxUDDQkbSQAXyLLKrPwFb1zdoMgy1knxilNoNJuA66lfr
 OV/MjzsiWE8Qr5OUtQ/+xoXZPqfZqyz/JICOUqTNOftUzdyQyVxeJZgrcKoQeMJ8SWzIc0v5
 uIMZIObeEYZmIasS+V2njaLz9t+re6zJw=
X-Talos-CUID: 9a23:4QmEcmOwPXfD4e5DcRt7s287HsccbnDk7GbCCWuzKVhUcejA
X-Talos-MUID: 9a23:vREyIApJyKLfoGOTTH8ezxVkat1QyaDzMxw2l6cLm829KR5iYA7I2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.14,226,1736809200"; 
   d="scan'208";a="110842104"
X-MGA-submission: =?us-ascii?q?MDF/ecKocdB8cDE3FvecYlI2bWMs+y4siHmgxG?=
 =?us-ascii?q?uHpdZqu3eyCzUquo4Q8K4+DGQotYW7b5Zh7PEGPMsmA7jpE1hzqzNxns?=
 =?us-ascii?q?VM/12xGacrNJKwv8H3SaYzPQjXFyZNYM134s7L9i2COcpteppvfXT9wM?=
 =?us-ascii?q?K7NwycnlLETz1TKDlJGwSL0A=3D=3D?=
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 13:06:46 +0100
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1741262801; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=Da5GvoMYHK+n2EpSfkWr3DP2DBfqQWCYmifpDQl2QNg=;
	b=sXqI1Ds7VKzwm1TStoK2afb0wjIYg2V+ncgmvlUZvrOVmgxCG33vR0sc3ZUgQnfuVHVQM4YGmOUOPc+FDgkl8X4KAVF7bJohj3rh4AxLtbhlRaInXBQEukcgxhUHxKGEgcxlsgNsD02c4EbRUG6xr5/w+3fhqlpvPd6sNZtTV0k=
Received: from 30.221.97.194(mailfrom:chengyou@linux.alibaba.com fp:SMTPD_---0WQomNor_1741262800 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 06 Mar 2025 20:06:40 +0800
Message-ID: <edd17fe8-5a27-4ae3-cec6-b2ecd01b1b76@linux.alibaba.com>
Date: Thu, 6 Mar 2025 20:06:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Content-Language: en-US
To: Leon Romanovsky <leon@kernel.org>, Markus Elfring <Markus.Elfring@web.de>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, Kai Shen <kaishen@linux.alibaba.com>,
 Yang Li <yang.lee@linux.alibaba.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>,
 Christophe Leroy <christophe.leroy@csgroup.eu>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <f0f96f74-21d1-f5bf-1086-1c3ce0ea18f5@web.de>
 <167179d0-e1ea-39a8-4143-949ad57294c2@linux.alibaba.com>
 <20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de>
 <20250306084754.GR1955273@unreal>
From: Cheng Xu <chengyou@linux.alibaba.com>
In-Reply-To: <20250306084754.GR1955273@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH] RDMA/erdma: Prevent use-after-free in
 erdma_accept_newconn()
Reply-To: Cheng Xu <chengyou@linux.alibaba.com>
X-Loop: cocci@inria.fr
X-Sequence: 2570
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/edd17fe8-5a27-4ae3-cec6-b2ecd01b1b76%40linux.alibaba.com>



On 3/6/25 4:47 PM, Leon Romanovsky wrote:
> On Wed, Mar 05, 2025 at 03:20:41PM +0100, Markus Elfring wrote:
>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 5 Mar 2025 15:07:51 +0100
>>
>> The implementation of the function “erdma_accept_newconn” contained
>> still the statement “new_cep->sock = NULL” after
>> the function call “erdma_cep_put(new_cep)”.
>> Thus delete an inappropriate reset action.
>>
>> Reported-by: Cheng Xu <chengyou@linux.alibaba.com>
> 
> Cheng, please resubmit this patch, I'm experiencing the same issues as
> Christophe has here https://lore.kernel.org/all/20a1a47c-8906-44e8-92e6-9b3e698b1491@web.de
> and it looks like Markus continues do not listen to the feedback.
> 

Hi Leon,

Sure, I just resubmitted the patch, please review and apply.

Thanks,
Cheng Xu

> Thanks
