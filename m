Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B251C0218D
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 05:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=Wht2thRDahYYxR+tegBEk8fX7Ubl7UHYL3NLzUC8OjY=;
  b=EMWLxUA+4PS9Wt1GyszhoWbKqmTYkvybwNA/vZRvWzHfrb9cJBGNQMO+
   tPPwfa0D6kCFjtBuIjhT6fFofAntLPlw323H31kuIkMg0AozoS4BUZ+fy
   d/svd9y8tyKic6+oblaaf2oX975NG1HvIBFpmADMjxW7X7gVNz8fIAq65
   Y=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205483923"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 06:06:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 8C5DEE0264; Wed, 29 Jan 2025 06:06:05 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 2A413E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 06:06:03 +0100 (CET)
IronPort-SDR: 6799b73a_l05U5DdhvmtmlZmSRl4w/rRG39V8HSwy9LyjA0Q6LVSyL7Q
 XogEDC0ZeDXiikTKPfmIEL9EFhuQ4j19GBuBVWQ==
X-IPAS-Result: =?us-ascii?q?A0EaAAAYtplnhbaaTQ1aHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?UAGAQELAYJDfVozBwhIhFaRcAOLc5IlFIEsPg8BAwFIBgECBAEBAwSFAAKKd?=
 =?us-ascii?q?QIfBgEEMQgOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQ?=
 =?us-ascii?q?EmFew2CYgGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR0BA?=
 =?us-ascii?q?QEBAgEREg8BDQEBNwEECwsYAgIRFQICVgYTAgEBgn4BgkEjBgIMohABh2ABA?=
 =?us-ascii?q?QKKKXqBMoEBggwBAQbcH4FkAwaBGi4BiE0BhWsbKYQzJxuBSUSBPAsDgQaBb?=
 =?us-ascii?q?z6DfFwqgxyCaYIzSkVkgSqCFoc1hXeCFiV7hVUEEVpsiShSexwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSlIA4ERI4EmBTUKNzqCDWlJOgINAjWCHnyBHYEOawQFgS2CO4RFYC8DA?=
 =?us-ascii?q?wMDgzaFW4IUgWUDAxYQAYMneByCLB1AAgELbT03CQsbQ51nPYMRgS9ZJIIfk?=
 =?us-ascii?q?yyDOwGOfaEDhCWMGJUzBg8EL5dYknsuh2SQaowLgXmVW4UdghoBN4FcRgcjF?=
 =?us-ascii?q?YMiTwMZD44hGYNhhRPFJiI1AjoCBwEKAQEDCYVGAQGKXYFLAQE?=
IronPort-PHdr: A9a23:FvgV8RHr+u2yP97QruNbT51Gfy9FhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k21hmRBc6Bs6MMy7KP9fy7ACpYudfJmUtBWaIPfidGs/lepxYnDs+BBB+zB9/RRAt+I
 v5/UkR49WqwK0lfFZW2TVTTpnqv8WxaQU2nZkJ6KevvB4Hdkdm82fys9J3PeQVIgye2ba9vI
 BmsogjcuNcajZF+JqotxRfFvGdEduBLzm9sOV6fggzw68i+8ZJ+6Shcp+4t+8tdWqjmYqo0S
 qBVAzshP20p/sPnsgXNQxWS7XUGSGUWlRRIAwnB7B7kW5r6rzX3uOlg1iSEJMP6Vb87Vyis4
 KdtUx/olTwINyUl/2HNi8x/l7xUrRS8rBFi2YHUYYWVNP1jfqPBeN4RWGRMUtpNWyFHH4ixd
 JUEAfYfMulEron9v1oOogW4BQmwH+Pk1ztEimbr0aEmz+gtFAfL1xEiEd0TqnTZtNb7OqkdX
 u+70qTG0CvNb/1W1zj/9IfGfQssoe2PUL9qbcbd1VcjGgHDg16NqYLlJTSV1uEVvmaU9eVgT
 uyuhHQ9qwpsoDag3N0siojJho0P0FDL7yN5y5syKNKmUkF7YcSrEIFRtyGaLYR7WcciQ2Buu
 CYnxbwKo5u7fCkWx5Q9wB7fcPuHc4aU4h75SOmRJjJ4iWtjdbmiiBm87VKuxffgVsmozllKt
 CxFn8HSu30PyRHe5caJR/t/80qu2juDyg7e5+JGLE02lafVJZAsz6M+m5QdvkrPAyD7lFj2g
 aKKaEgp+uql5ubnb7n6oJKXKoF6igb7Mqs0m8y/B/w1MgsQUGiB/+Szyrnj8Vf+QLVQgf07l
 LTSvpPCJckDu6K0DRVZ34Qh5hqlEjur0NsVkWMaIF9GZh6Ll5blN03ULPzmA/qygk6gnCp2y
 /zcI7HtHovBI37em7r/ebZ99lVcyBYtwtBF+pxUC7AAL+zrV0PtstHTEwU3PBauw+n9DdVwz
 oMeVnyLAq+eKK7StV6I5uQyI+iDfoMVvTf9JOQ/5/7pln85nlEdfbWz0ZQLb3C4G+xqI0SfY
 XXyntcMCXoGswQkQOHoilCOSyNfana9Uq4m+z02C5yqAZ/GRo+3gbyB2Cm7HodRZmBDEl2DD
 23nd4WeVPcWaSKSItVunycAVbigTY8hyB6vuBX/y7pmMuXU4CoYtYnk1Nh7++3fjw099TtxD
 8iF1WGCVHl7nnkUSD8uwKB/vUt9x0+N3KRgmfxXCcRT5+9VUgc9LZPcy/Z1Ct7oVQLFeteEU
 1enQtSjAT4qVNI+2cUCY0d7G9W4jxDMxTCmA7EPl7CTHpw77rrc32TtJ8Z603vJyK4hgEU6T
 ctOLmCmna5+9w3LB4HTiUmZlqCqdb4d3CHX7muDw3COsFlCUAFsSaXFQWwfZkzOoNTn6UPNV
 bquBq8mMgRf086PMapLatzsjVpdXvfsIs7SY2O3m2eqBBaH3KmAbITwezZV4CKILUEekB0It
 VuCOxI/ACjp90fXFj9zDhTCZ0328O9xgGy2RAk4wlfZQVdm0u+Y8wUKjObUa/oJ37INoi4n4
 2F5FVa0xdPWAvKEpgx8bONZYNgn50xA236fvAt4aM/zZ5t+j0ITJlwk93jl0A96X8AZyZBCR
 BICyQNzLfjdy1Zdb3aC2pu2PLTLK2709RTpaqjM21iY3szFsrwX5qEerFPu9BqsClJk629uh
 tRc03KG55XDJA4TV4/hFEM2/AJ9vLbUfm824IaHnWZ0P/yMuyTZk8ksGPNjzx+he9lFN6bRG
 QbyGtcbB8GGLO0shkjvaxMPJudJ86AoecihcqjOw7alad5phynulmFb+MZ930aLojJ7UfLN1
 o0Zzuuw2gqBSie6iVaqqMfsno5YIzoVGwJT0ADCA4hcLu13dIcPUyK1JtGvg895jNjrUmJZ8
 1iqAxUH3tWocFycdQ612woYzkkRrXG9/EnwhzVpjzEkqLae1y3S0qzjchQAIGtCWGhlix/lP
 4G1i9kQWEXgYRIukVOp4kPzxq4To6oaTSGbTE5IdjL3L2hKVqq2q6rEZs9E8pQztitLFu+7Z
 BHSS7LwpQcbzzK2B3FXl1VZP3mhvpT0mQA/iXrIdS018yWfIJwsg06Pvo+5J7YZxDcNSShmh
 COCA1G9O4Ps5tCIj9LZtev4UWu9V5pVeC2tzIWatSL963c5ZH/31/21hNDjFhA3lCHh0Nw/H
 yjBrB/mY4ni/6C7N/93OExpD0X78M10Bsd1lY561/RykTAKw46Y+3YKizK5PNxb0Lj/bHMlQ
 T8N3s6T5Qnuwkp4KXyVgYn+Uz/Op6kpL8n/aWQQ1CUn6slMA6rB971Ikxx+pV+gpB7Qa/xw9
 tsE4cMn82VSw+QAuQ53iz6YHqhXB05TeyrlixWP6dm66qRRfmemN7aqhgJymtWoDbfKpQ85O
 j6xd54iFDVx7sxXNFPKzW2174DvYt7LatwP8BaTll/MgvNUJ5Q4ivcRzXM8fz2i+yR4l6hi3
 UYm1Irf3sDPM2h3+aOlHhNUfib4Yc8e4HCljKpTmNqXw5H6G5xgHjsRW567BfmsET8UqbHmL
 1PXS3tj9THCROaZRF/FuyIE5zrVHpumNm+aPiwcxNRmHlyGIVBHxRoTV3M8l4I4EQajwIrgd
 l1473Yf/A2dyFMEx+R2Oh34Smqaqh2vb2J+RZGfJQBX7ghq40bTLNzY6+N4BSZD+ZO96geKL
 ybIAmYARXFMQUGCC135a/Oj7NnJ6emYD8K6Lv3TcfOLqOdEUOyPy47p2YxjtWXpVI3HLjxpC
 Ps13VBGVHZyFpHCmjkBfCcQkjrEc8+RoBrvsj0ytM209+7nHR7+/YbaQaUHKs1holrl5MXLf
 /7VnityLixUk48B1WOdgqZKx0Yc0mlvb2X/SO9G6nGLFf+M3PYHVVZeYid3fqOk9ooE1xJWc
 Y7eg9LxjPtji+ItTk1CXhrnk92oYsoDJye8MknGDQCFLubOKTrOysDxKaSyLN8YxP1TrAG1s
 C2HHlXLOjWFiimvUhGkK+ZXiy+HehdZvcmxfw1sBm7qUN/9IkTgdoAoy2Rrnftt1imCPHV5U
 3A0a05Xq7yM8S5Uyu5yHWBM9DstLOWJnTqY8/iNKpsStqgjCSB1muRGpXUinuIOqn4bAqUox
 G2L/oQ9xjPu2vOCwTdmThdU/zNChYbR+F5nJb2c7J5LH3DN4BMK62yUTRUMvdpsTNP16MUyg
 pDCkrz+LDBa/pfa58wZUoLZIcKOKnshODLtGTjJHE0ATDWxMnrYiVAbm/aXvC7wzNByut33l
 ZwCR6UOHkQyDe8fA195EcYqJJZxQyNilL+QlskT4nSi6hLWQY8J2/KPHuLXCvLpJjGDiLBCb
 BZd2rL0I7MYMYjj0lBjYF13z8zaXlDdVtdXrmh9fxc59Q9TpWNmQDR5iCeHIku9pWUeHvmuk
 lsqhxtiNK4zoSz07Q5/J0KW9nJr1hZu34y43XbIIGS5aa60Wcs+48Xcs0k3L4O9Rgd+dwqpm
 kJ4cjzDQuAI51OBXWRqjhLM/55OEuRbVqpKfFkbwvTFPp3ANHxYqyO61QlC5ODfDoBlmhdse
 pmp/Soo5g==
IronPort-Data: A9a23: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
 RH0i0UD6I+5xIy9FVFYJcjlO368b57UMwz0sQ==
IronPort-HdrOrdr: A9a23:n2YPPKmyG/st0M446j1/IaOGUBrpDfIc3DAbv31ZSRFFG/FwWf
 rPoB1p726StN93YgBZpTngAtj4fZu/naQe3WB1B9qftWbd11dAQLsSibcKhgeQfREWldQy6U
 4DScRD4bTLZDAQsS+52njcLz9K+qjlzEnHv5a9854gd2BXV50=
X-Talos-CUID: 9a23:efE1hGMws4T75+5DYxBm+WUZGYMcdVL85WrLBEWxJUEyR+jA
X-Talos-MUID: =?us-ascii?q?9a23=3AWdVqLgyLi3iVLMZarXy1MTWnRLaaqJ2ELlBd0qk?=
 =?us-ascii?q?fgZiJJHdhYC+dlSyaQYByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,242,1732575600"; 
   d="scan'208";a="205483917"
X-MGA-submission: =?us-ascii?q?MDEBOMZ7fukyIObI/tlkYjxvzILEdV5kzvfEWz?=
 =?us-ascii?q?LY8ICt4tFadbsgD2Y0if55bVA88XrkqM8ibraQh+I4UfOyzgY7pgVLWw?=
 =?us-ascii?q?HnQh669cBeh3fn7JsSSipzp83LZz5LvC25foUu+LNxzGYs1zkhONDpol?=
 =?us-ascii?q?45yJjp57awM/4IedCIcUW/Lw=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 29 Jan 2025 06:06:01 +0100
Received: from [100.65.200.247] (unknown [20.236.11.102])
	by linux.microsoft.com (Postfix) with ESMTPSA id BF2B7203719A;
	Tue, 28 Jan 2025 21:05:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BF2B7203719A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1738127158;
	bh=Wht2thRDahYYxR+tegBEk8fX7Ubl7UHYL3NLzUC8OjY=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=AFX9oF9pTu72L24VZYqKx9K3J6cjX75OWwM6bx5F//N6XwqpIMkYxe0t1yv/1uANn
	 K7CYPXdux4/ltP2jazP0+UvJCsUaSdS3dhpnc4wskhaa9xzVe+3duJMghpWbik88tx
	 7xoRplm16e8Caydkk6cw2Nsk6naPDQhd3Kt6qY7Y=
Message-ID: <2402812d-b818-4d1b-9653-767c9cd89dda@linux.microsoft.com>
Date: Tue, 28 Jan 2025 21:05:58 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: cocci@inria.fr, eahariha@linux.microsoft.com,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 linux-block@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ide@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 ceph-devel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
 dri-devel@lists.freedesktop.org, ibm-acpi-devel@lists.sourceforge.net,
 imx@lists.linux.dev, kernel@pengutronix.de,
 linux-arm-kernel@lists.infradead.org,
 Andrew Morton <akpm@linux-foundation.org>, Carlos Maiolino <cem@kernel.org>,
 Chris Mason <clm@fb.com>, Christoph Hellwig <hch@lst.de>,
 Damien Le Moal <dlemoal@kernel.org>, "Darrick J. Wong" <djwong@kernel.org>,
 David Sterba <dsterba@suse.com>, Dick Kennedy <dick.kennedy@broadcom.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>,
 Fabio Estevam <festevam@gmail.com>, Frank Li <Frank.Li@nxp.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Henrique de Moraes Holschuh <hmh@hmh.eng.br>,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 James Smart <james.smart@broadcom.com>, Jaroslav Kysela <perex@perex.cz>,
 Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
 Josef Bacik <josef@toxicpanda.com>, Julia Lawall <Julia.Lawall@inria.fr>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Ilya Dryomov <idryomov@gmail.com>,
 Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Leon Romanovsky <leon@kernel.org>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Nicolas Palix <nicolas.palix@imag.fr>, Niklas Cassel <cassel@kernel.org>,
 Oded Gabbay <ogabbay@kernel.org>, Ricardo Ribalda <ribalda@google.com>,
 Sagi Grimberg <sagi@grimberg.me>, Sascha Hauer <s.hauer@pengutronix.de>,
 Sebastian Reichel <sre@kernel.org>,
 Selvin Xavier <selvin.xavier@broadcom.com>, Shawn Guo <shawnguo@kernel.org>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, Takashi Iwai <tiwai@suse.com>,
 Victor Gambier <victor.gambier@inria.fr>, Xiubo Li <xiubli@redhat.com>,
 Yaron Avizrat <yaron.avizrat@intel.com>
To: Markus Elfring <Markus.Elfring@web.de>
References: <20250128-converge-secs-to-jiffies-part-two-v1-1-9a6ecf0b2308@linux.microsoft.com>
 <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <565fb1db-3618-4636-8820-1ca77dad07a2@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH 01/16] coccinelle: misc: secs_to_jiffies: Patch
 expressions too
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2296
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/2402812d-b818-4d1b-9653-767c9cd89dda%40linux.microsoft.com>

On 1/28/2025 1:02 PM, Markus Elfring wrote:
>> Teach the script to suggest conversions for timeout patterns where the
>> arguments to msecs_to_jiffies() are expressions as well.
> 
> I propose to take another look at implementation details for such a script variant
> according to the semantic patch language.
> 
> 
> …
>> +++ b/scripts/coccinelle/misc/secs_to_jiffies.cocci
>> @@ -11,12 +11,22 @@
>>
>>  virtual patch
> …
>> -@depends on patch@ constant C; @@
>> +@depends on patch@
>> +expression E;
>> +@@
>>
>> -- msecs_to_jiffies(C * MSEC_PER_SEC)
>> -+ secs_to_jiffies(C)
>> +-msecs_to_jiffies
>> ++secs_to_jiffies
>> + (E
>> +- * \( 1000 \| MSEC_PER_SEC \)
>> + )
> 
> 1. I do not see a need to keep an SmPL rule for the handling of constants
>    (or literals) after the suggested extension for expressions.

Can you explain why? Would the expression rule also address the cases
where it's a constant or literal?

> 2. I find it nice that you indicate an attempt to make the shown SmPL code
>    a bit more succinct.
>    Unfortunately, further constraints should be taken better into account
>    for the current handling of isomorphisms (and corresponding SmPL disjunctions).
>    Thus I would find an SmPL rule (like the following) more appropriate.
> 

Sorry, I couldn't follow your sentence construction or reasoning here. I
don't see how my patch is deficient, or different from your suggestion
below, especially given that it follows your feedback from part 1:
https://lore.kernel.org/all/9088f9a2-c4ab-4098-a255-25120df5c497@web.de/

Can you point out specifically what SmPL isomorphisms or disjunctions
are broken with the patch in its current state?

Thanks,
Easwar
