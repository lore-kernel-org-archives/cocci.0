Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DA6DC02182
	for <cocci@archiver.kernel.org>; Thu, 23 Jan 2025 12:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:cc:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=UTqiET7WvIyNmxkB9HztfBX6a1pIICycyDq3ehfiDBg=;
  b=q8wgBja1eqEb5VzyiTD0mmnvHoKsQd0oDVEm/3JGPWp1aWHepLepFzPs
   Z6EiFBrkZsoT++lW++40WIh7JPdTh6ouGuXR/8rW1vVHCmlxfcanRn/t6
   LI/n6BhuS0qU9GDoWUYeNaHKzcZo2hnTJfNOTCDUWIZCmihZ/nFUQ9aH8
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
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204639077"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 23 Jan 2025 13:06:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id AD565E0137; Thu, 23 Jan 2025 13:06:29 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 13B16E0077
	for <cocci@sympa.inria.fr>; Thu, 23 Jan 2025 13:06:25 +0100 (CET)
IronPort-SDR: 679230c0_T7842v/C7MNO/N1yJgIN7NsEwe1SgosX3hhO6v7ROpdpEAe
 qNiWk7VThwEQ3qlfS+iPsdTiZ825WagrNiUCKbw==
X-IPAS-Result: =?us-ascii?q?A0HEDACGL5JngwsR49RagQmBU4JEYhtaMwQLSIRWj06Bd?=
 =?us-ascii?q?C0DhDuPEYh2gVaBfg8BAwENPQQBAgQBAQMEhQACinQCHgcBBDAJDgECBAEBA?=
 =?us-ascii?q?QEDAgMBAQEBAQEQAQEFAQEBAgEBAgQGAQIQAQEBOgcOCjGFew2CYgGBJIEmA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBHQINOkQBAQECASMdAQERJgEECwsaAiYCAlYGARQBAYJ9A?=
 =?us-ascii?q?YIvAQMOIwcNtRN6gTKBAYIMAQEG2lsfLCJXgWQDBoEaLoVrgmMBhiaEPCcPg?=
 =?us-ascii?q?VVEgRUngwM+aYFhFwQYgUaDW4JpgjOEKCVnjE2EQYRnihRSexwDWSwBVRMXC?=
 =?us-ascii?q?wcFgSkQOAMtNhQdI4EmBTVBOoINaUk6Ag0CNYIeJFiCK2sEBYEtgj2ERYRRg?=
 =?us-ascii?q?kNUgkSCFHpuAwMWEAGDJ3kfgQIdQAIBC209NwYDCxsGPZ0MPYRBMRMsCYIWH?=
 =?us-ascii?q?o1FhVKTZJ8bNAeCOIFmgWMMiimOLYcGBhMvl0QOBpJ7mHwijWKbKYFnOoFcM?=
 =?us-ascii?q?xokgzZPAxkPjjqEFIRhu2FCNQIBATgCBwsBAQMJhUYBAYpOamEBAQ?=
IronPort-PHdr: A9a23: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
 ICnfEfbNzpItd7Zr5N07yf8N8+NdnYsY0OBJQ==
IronPort-Data: A9a23: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
 IT7qa2ogK12dKIpLftdRg==
IronPort-HdrOrdr: A9a23:MQ/uXaAxOv2EFaXlHem755DYdb4zR+YMi2TDtnoBKyC9Hfb2qy
 nDppgmPHzP+VUssRMb+OxoUZPoKRiwyXcf2+ks1NmZMjXOiS+NFqkn16vaqgeLJ8WTm9QtsJ
 tdTw==
X-Talos-CUID: 9a23:7ViTo2FCsyYlNl0/qmJ15B5KFv4/TETUxWjbe2/lO0p0F7S8HAo=
X-Talos-MUID: =?us-ascii?q?9a23=3AL587gAwrvLJd6IsXyPB01OZi8OqaqIOwMn4wybQ?=
 =?us-ascii?q?aguKjLQJ0Cw20rCSNaJByfw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,228,1732575600"; 
   d="scan'208";a="204639002"
X-MGA-submission: =?us-ascii?q?MDEb0yxe0wgF4Fbwzc3q4WASN0pt5XG65lP9Cf?=
 =?us-ascii?q?/owVMmAMHrHK7Gso66Y0Loxgw2w38e5/FlBoYUHUp2W2IySjXDpJkGu+?=
 =?us-ascii?q?xAy6R/lCS54pnSvn8YxOtk+oq44HRx+DYjLX374zIcDUb8b9zxGTa2Gj?=
 =?us-ascii?q?YkSdCCHkXTes6nvum/577pcQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2025 13:06:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1737633969; x=1738238769; i=markus.elfring@web.de;
	bh=UTqiET7WvIyNmxkB9HztfBX6a1pIICycyDq3ehfiDBg=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
	 References:Cc:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=J0/5sZUrC3lKWzqNKO4jFDxE1IqTSEZq1Jw9k0moBbt99Ke6hwlOJ9/wQuDVTPD3
	 BIIW6PEz0OAQ+/OuJK4XX2qtgJjn3p224Zu0N4lDFq+qDtKp0bfL6tanrHdsZb50d
	 4C3F4CFmFhE2g2SKbCQv+zmbMRa2myKi2/k3uTvLPHWraJnc+JM9E8zEmXnVXBiaG
	 XJQa4UYk9xjE+q9z0FrXzo/o7IZepmZaDcmIK4clVh7XdaZYnVWUurhhHQrhTDveE
	 hTxLvGuMZmfHp63fsglJ/gauLkyqt5VIPZBCxa4lN04ZiMlay7GjwCN6giB9h88kt
	 O/Rzt1J3jVlFGO1tpA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.70.29]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MYcll-1twg6c2iFn-00Sq37; Thu, 23
 Jan 2025 13:06:09 +0100
Message-ID: <07da64ca-e645-4a29-bc21-c3065ad5a3c4@web.de>
Date: Thu, 23 Jan 2025 13:05:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Ricardo Ribalda <ribalda@google.com>, cocci@inria.fr,
 Easwar Hariharan <eahariha@linux.microsoft.com>
References: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
Content-Language: en-GB
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <CANiDSCvLCaMdJVSMahNgg1UQMh3naoTrWGh=9+4p8pePWyLStg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ETKQyoQm+2wisY4zMXlznKj4rTVYFgMBgmfgxnKx8kRLbgjOYZ5
 sKpHCL0Frerjxr6hiLBdhqHfZ8encQXBH2d9lFELMtfZiIJ0v8HjdYE9lfWpM9dG9jKqfgs
 v/Fri3PLZYiEw3+8bAFq1ErlEpheQAarn66/PaZ6WoJ7ebhZhiSWk17IFd4G1TrYEO9vpOQ
 4ODEVFwC1eEFjqWMfesog==
UI-OutboundReport: notjunk:1;M01:P0:qnxH8L+R42U=;JcHHDYgJ+ZKhG7SlbXIjDav3hR5
 dBZ0q0qG15YwJ0kEsR95KGfVJMMLaN+lxnLX3hp7cf0R+JWHQSqwQjqgrx8YArb1YXUy32tRp
 zL//Ndq0QzTq7jTh6MD4Hcbdl8NvIFsuFsqaGLok8EtX4eN9r73ndqovoV7UVwXLKS0agm3RR
 33SwOaBD/F7yx5JxvgdDLQ+6nQvTUqZlSC5zapaRJBWLsrOjyC92/+IV3Ihl0O2RLthNoMqjq
 V5c868qdHxGE9ZQt9U4gDnTi7zyz5kNKMoWly46rLbbr+uLx2NqIDOaY5qyncLZtZDOyLJLTK
 b+NgEiAyoYpW9qQjRTJbYOqWvbEEhuVR+F/BEhe+zzOoD12E17954jzyXNx8IFhDUc2ho/OQN
 tV1SQOoM3nUwW3N19OyfOaGTY+KWoP50Twc5ddv/Xu6IOqyGKhEa/7IKk7sKOumzFmBqLlpd5
 Hymn5dHdi1bE1NVrzz9GT5QxeisSygkourf24m3tsvHkpOv6pcVcEg4iBIkJbFOd8ncRaqiar
 mF7bDVOyVXn9quOaeqqSrsc3OUF3EKnyI5h+cuztrHtuRzeM61kJxtTTBBEinLNh2VUo4HIas
 hMMy2Ec11Ol20EE3UFUKujDNZC0IzMyBdHjV+L1a5Tce76OtZWke/txaVZh2JE3adK7aRVtYV
 /L9VUWnl0Jh11I1TC1xJY5TzRNq95tVoX8ib0NZN9vZKH3oos4I0Ep5KfED2lxqeo7UO2fC6P
 Pefw7c+G4nV/dXrbjNZC47YTRpR9FFwU4jSzhp/bRPG1ffUF1qUEA48OQdW8t2Oor0otQ7CsD
 TwYIXEIK3vC6wz2nq55frC7mJTZrmNmKOUbR39EAQOolrYPWGNOPOoo31GUCWPQNfs3dvdKrW
 WsieonCAVhJnfP66bVVbCNiVU46zBdFJ31gN2h/sxaPA/QjvipUaDuc4VW/FJdsl0qxscZ8Z/
 bvGZmf0/tphuyZHOXM1FFfgUUH9hQ+1XGwrYvMnvt0Xwj6l+Aew1ah4X/3zNkKRosqM5J8IqU
 tfX7usXuTgbHF+Eu7lONcEyy1I2mMMb8JXMBJ6FFfBnQ3HXCu329h5q5AVBNffsDmXsoze1Jm
 rgoV/Kxj7l42IJVM4bHw86abgNBZ26rMc9/vzE9p3nDz4jxXHKiOV/beW7vVl7kdrThYNbbg4
 ZCmOxF2nzteO2VsPCNVMpaMHy7xaiFzw7HdacbGvq6CiWzmj2VcM8Hv/2f1iFownjHDbmSWFE
 elbw+Oif5GaYcTvzeARDJEzF2IAAIkVeiQUyv6rZPNuVPlnChU6Gioir9muH4xW4c6Jz4BpA3
 T9Ce0T9zRV3G/IokZWJvS5zqngjQrAY109mVv4xfVpvu/bF5fGs8PVUFdWDFzXXtzbm
Subject: Re: [cocci] linux-next: virtual rule report not supported
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2220
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/07da64ca-e645-4a29-bc21-c3065ad5a3c4%40web.de>

> While trying out linux-next I have hit an error in cocci:
>
> $make coccicheck M=3D"$dir" MODE=3Dreport
> ...
> /usr/bin/spatch -D report --no-show-diff --very-quiet --cocci-file
> /workdir/scripts/coccinelle/misc/secs_to_jiffies.cocci --patch
> /workdir --dir . -I /workdir/arch/x86/include -I
> /workdir/arch/x86/include/generated -I /workdir/include -I
> /workdir/include -I /workdir/arch/x86/include/uapi -I
> /workdir/arch/x86/include/generated/uapi -I /workdir/include/uapi -I
> /workdir/include/generated/uapi --include
> /workdir/include/linux/compiler-version.h --include
> /workdir/include/linux/kconfig.h --jobs 64 --chunksize 1
> virtual rule report not supported
> coccicheck failed
> make[1]: Leaving directory '/workdir/drivers/media'
> make[2]: *** [/workdir/Makefile:2094: coccicheck] Error 255
> make[1]: *** [/workdir/Makefile:251: __sub-make] Error 2
> make: *** [Makefile:251: __sub-make] Error 2
>
> Deleting scripts/coccinelle/misc/secs_to_jiffies.cocci "works"

Would you like to increase the development attention for better support
of involved operation modes?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/dev-tools/coccinelle.rst?h=3Dv6.13#n71

Regards,
Markus
