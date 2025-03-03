Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667DFC282CD
	for <cocci@archiver.kernel.org>; Mon,  3 Mar 2025 17:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=W7ZlCwZ1+R+xVlIL5I/gw+m7bAv/kknFtFmT1LHwQjk=;
  b=dTQhvH17vZP2xuHFw7JqaT5XdrwEzmXJAGDD9tgFVtGctxT7bqq59PJc
   skBGb6MhDoEL65478Ua3Ke/5JUfqpcTpjZYCX1xnqPSxwO2Qze4ofRzpx
   dCACl8gEdMr1kL2BYK20R/Cfgl4p7aFQjhWJqMOSKfYaeuNQicb9EKIur
   k=;
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
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210956575"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 03 Mar 2025 18:55:51 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 43DC2E0264; Mon,  3 Mar 2025 18:55:51 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id E33B0E0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 18:55:46 +0100 (CET)
IronPort-SDR: 67c5ed22_LEkCZt3hvO/+ewxdm1W+hDufXRkoFnHQvq7MCKJkzVD5WuV
 qZzXl9Crk6y5Bod+S4hCpqzo9WUvkJSy2BcItPw==
X-IPAS-Result: =?us-ascii?q?A0EIHwCM7MVnfg4P49RaHQEBAQEJARIBBQUBQIFTAoJCg?=
 =?us-ascii?q?VczBAtIhFaPT4F0MIQ7hzuHU4h1g1QPAQMBDUEBAgQBAQMEggyCagEJAosVA?=
 =?us-ascii?q?h4HAQQ1BQ0BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBOwcOC?=
 =?us-ascii?q?QExhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CR0QBAQECASMdAQERJgEECwsaA?=
 =?us-ascii?q?iYCAlYGARQBAYJ+gjABAw4jB69ZgTKBAYIMAQEG2lwfLCJXgWUJgRouAYVrg?=
 =?us-ascii?q?mMBhVJUg0J6Jw+BVUSBPAuCRzE+iB6CaYIzhEBnmgWOU1J7HANZLAFVExcLB?=
 =?us-ascii?q?wWBKRA4Ayo0FB0jD4EUBTRBOoILaUk6Ag0CNYIeJFiCK2oEBYEkgjeEPYRAg?=
 =?us-ascii?q?j9RgkKCEXFsAwMWDwGDH3ccg0+BLYRqHUACAQttPTcGAwsbBj2iKIRCmkOOF?=
 =?us-ascii?q?aE9NAeCOIFmgWMMn14GEy+DcAGTVA4Gkn2YfSKpD4F/IoFcMxokgzZPAxkPj?=
 =?us-ascii?q?iE4g3XIIEI1PAIHCwEBAwmFRgEBilSBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:NrlLHqDzUZ1lPhVW/+3nw5YqxClBgxIJ4kV8jS/XYbTApGki3jZUz
 WQeXDvVb/6CZjb9fN5ybY+28kIFvJHSyIRgOVdlrnsFo1Bi+ZOUX4zBRqvTF3rPdZObFBoPA
 +E2MISowBUcFyeEzvuVGuG96yM6j8lkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/YuGYzdJ5xYuajhJs/nb80s11BjPkGpwUmIWNagjUGD2zCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iGtY+DiDS4pZiYJVOtzAZzsAEPgnXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0usyxVEFL0OavHJSxjSCc53HvKlj+z9FkN3ovBq4F8OhtWmtE2
 vNNfVjhbjjb7w636Le8V/UqmckpasXmVG8dkis5l3eDV6lgGM2FGvmiCdxwhF/cguhrFOzde
 tFfRD5hdhXGbDVQN11RBJ9WcOKA3CCnImAG9Q3PzUYxy2mJ6FE23LrRDN+PW5+Ea/RYxUu6r
 FuTqgwVBTlBaIzHkmramp62vcfEmijwWaoJBbig/7hrhkeSzyodEnUruUCTpP6klgihVtgZJ
 0F8FjcSQbYayGXybcvxexeDm2e/nQMWVcALGecV51TYokbL2DqxCm8BRz9HTdUpss4qWDAnv
 mNlefu2XVSDV5XKExqgGqeokN+kBcQCBUMvDRLooCMA5MT/5p4+hFTDQ76P8ZJZbPWkQFkcI
 BjT8kDSYon/a+ZVjs1XGniZ2FqRSmDhFFJd2+kudjvNAvlFTICkfZe0zlPQ8OxNKo2UJnHY4
 yRcypTGt75SVsjR/MBofAnrNO73jxpiGGKM6WOD47F/q2X9k5JeVdsBuWAlei+FzO5fKWKyM
 Sc/Rj+9FLcIYCvyNv8oC25AI8Uty6/7Xc/oPs04nfIeCqWdgDSvpXk0DWbJhz6FuBF1zckXZ
 83HGe7yVytyIfo9klKeGbxHuZd1nX9W+I8mbcqlp/hR+eDBPCbNIVrEWXPSBt0EAFSs+1uJo
 44Ob5fTk32ykoTWO0HqzGLaFnhSRVBTOHw8g5U/mjerc1o8SlIyQeTc260gcIFDlqFY3LWAt
 HKkV0MSjBK1iXTbIE/YIjpueZH+b6ZZ9HgbBC0LOUr3+n4BZY300rwTWaFqdpYa9cti78VOc
 d87R+u6DM9idBH76hUGTJykrIVdZBWh3g2PGCy+YQkARZ1rRi2X29q9YAffzTQCVBS2kc4Ep
 5yhyQLpbp4RTCtyDMvtSayOznHgmVM/ie5NT0/zDd0LQ3rV8a9uMD7Uos4sBcMHOTHv4yS87
 BmHJysYqc3mgZ4HwPOQiY+q946WQvZDRGxEFGzl3JOKHCj9/Fv757RfUeyNLAvvZEmt9IqMP
 exqnuzBatsZl1N3sq15IbZh7YQ6w/DN/7Z67ABVLE/nXmSRKIFLAye5hJFUl6h32LVmlxO8W
 RuP9vlkKLy5Ap7ZP2BLFjU1TNao9K8yoSbT38QXMU+hxS5Q/Zi7a2twESSIqhRgKOpSDNt47
 8Yn4NUb+i6uuCoMa9ymtB1Zx06ID34HUpgkiK0kPZ/WulIV7W9GMLPhCX7QwZCQat9zHFEgD
 R2KiYHj2blN5ErwXEAiNHrK3OYHu5UqvSpO7V4dJmamnsjOqe830SZwrxU2bFVx5TdW391jP
 lNEMxVOGpyP2DNz3u5RcnuJCSgYIDG4o2vfk0Aokk/dRGmWDl39FnU3Y7uxzRpI4lBicSh+1
 5DG7mTcCBLBXtz7hwk2Um5b883Td8R7rFD+qZr2Dva+PscIZBT+ifWTfksOkRzsBP0xiGDhp
 eVH+OVRa7XxBRUPop8UWpWr6rANdC+qfGByY+lt3KcsL1HufDuf3TuvKUfoXuhvI/fM01GzC
 u0wB8Zpeim96h2zrWEgNfZRG4N3of8n38pdW7XJIWVdjaCTgAA0u73t9w//plQRffNQregHJ
 Lj8TQmySl6ruSMMmkvmjtV1BW6jUNxVOCz+xL+U9csKJbIiscZtUxoA7ZqpjVqoMS9M3RGdj
 CXcbYD4ks1gzoVNmdP3M6NhXg+bF/L6ZN6qwiuS7etcXIjqCtjcki8osXzlAlhmBqQQUNFJi
 ri9it7780fbtrIQUWqCuZ2+O4RWxMe1Bsx7D9nWKSREoC68R8Pc2RsP1GSmI5hvktkGxM2GR
 RO9WfSgZ+wuRNZR631EWRdwSy9HJfzMUZ7hgieho9CnKBsXi1XHJez6007ZVzhQcytQNqDuD
 gPxhe2V2elZi4ZxHz4BOeBtBs5pAV3kWJZ+TebLixujMjCKjG+B65zYrjhx2QGTXzPAWIz/7
 IneTxfzSAWqteuahJtFuoh1pVsMAGw7neA0eVkH9sVrjyyhSlQLNvkZLY5MH6Q8fvYeD30kT
 GqlgKoe5STBsfBsdBLh/JL8Uw3ZCuFm1hIV4NA21xv8Vst0LNro7HhdGuNI/Hp8PDfupA1iA
 c9L4WX+Z3Bd3bkwLdv+JZWHbSNP2f7QgH4Fkaw4fwoeHD5GaYg3OLdd8MahmMAJ/wwhVKkGG
 ITteV15fQ==
IronPort-HdrOrdr: A9a23:l+NpCanMQvAty1YYPDNfh29QXEPpDfL43DAbv31ZSRFFG/FwWf
 re/sjzpiWE7Ar5P0tQ4exoWZPwOE80kKQf3WB/B9iftWXdyQyVxcRZnO3fKl7bdREWlNQw6U
 4IScEXZeEYT2IK6PoSizPZLz9P+qjlzImVpaP502pnSx1sZppt9gFjF2+gYzBLrUV9ZKbQD/
 Cnl7F6TtebCA4qhk/XPBM4Y9Q=
X-Talos-CUID: 9a23:2lJ1kmNa51OoEu5DZAA+11wYPsoeSWTm72raLVXjA2xGR+jA
X-Talos-MUID: 9a23:h8ofUQi7btfB8yyDjmpYIMMpNZ1MvuOiCnwxlM8n+MeqBCErNhWXtWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,330,1732575600"; 
   d="scan'208";a="210956572"
X-MGA-submission: =?us-ascii?q?MDFyc0XCNCZRdd5Y19KROegdaYsr8HHsQRfRoh?=
 =?us-ascii?q?T+51LWy4XfFaYy4dPRHgns9VJsis87zyFW3zAVX1KPjIYF64vJ6q9S0k?=
 =?us-ascii?q?Gs88JMQN4EoO6Wagh2yIonKE/YwVR0D1ds/M4ccnqdLJRVnT0sh4741y?=
 =?us-ascii?q?EpXHUHLY8ym1kvm0Cz0gL7pw=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 18:55:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1741024522; x=1741629322; i=markus.elfring@web.de;
	bh=W7ZlCwZ1+R+xVlIL5I/gw+m7bAv/kknFtFmT1LHwQjk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=VCjExzwXxHw1/2HeQkqv28mPWPiBgd1Gncc9aqN7Xwky7OF2aldFP6mMEUTnZHqo
	 J/wIYFbcGQc/uYpDHmKDhDE13bStN7Cui5BkeKcNK8ZxsHBivyELjsm8j9iXwA375
	 NAnQBtYlLI+cwAPq+TAX8I2aPcUdPsS0jmz7DOZ5bLchzOOLi2yTVZU3c1bjK6zqL
	 bNb2yEvt3YoHrAtuMpMJj6fhCPicRrmVEuEsKQdXB1KLavCUoK6/aGpXAQe4rRZvg
	 wtF7/AChsyBsLKzfWoh/K9x2nPRESrpFTyuswRGzR0XbWnx+fX16hhMq2BL0gXgoC
	 oSgi7EPR+SU6IJxG7Q==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.93.19]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MUl9B-1tfyxc3XGL-00LaLm; Mon, 03
 Mar 2025 18:55:21 +0100
Message-ID: <30ea63cd-4389-4b07-879f-011e1b1af421@web.de>
Date: Mon, 3 Mar 2025 18:55:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kory Maincent <kory.maincent@bootlin.com>, netdev@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Ariel Elior <aelior@marvell.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Manish Chopra <manishc@marvell.com>,
 Paolo Abeni <pabeni@redhat.com>, Ram Amrani <Ram.Amrani@caviumnetworks.com>,
 Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
 LKML <linux-kernel@vger.kernel.org>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
 <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
 <64725552-d915-429d-b8f8-1350c3cc17ae@web.de>
 <a191bd33-6c59-45c2-9890-265ec182b39a@stanley.mountain>
 <20250303183532.580eb301@kmaincent-XPS-13-7390>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250303183532.580eb301@kmaincent-XPS-13-7390>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:PrKHLpQ0y3itZPb+HSXogN+l+7pWtXNc95tU8bv3IEFkVAePhKS
 IkZI6Izg/xnX6ByP/uCgX0TzjSuXHJtZ7QsId1shUQoONR30dOKSJrO5V/x30bufh3qnSOU
 1/XQ4EW1hsF+9qv8wZ6K6dzONC8bkSZGeySx0UVyVS2G4oIdWDuUPlI/7yD3/HRnmV0b3xi
 IoidclaePdKo7lfDxWsAQ==
UI-OutboundReport: notjunk:1;M01:P0:ivk4gQMFeBc=;em3m2FPQLtScHCPjq7yxppgF0lG
 RRQCcX1FzRUUPmF9fUbMlgQqiFCq1qNyXpXArSbZV8ul7SuOaRu5EtsM6UMY1gM1uJETvWB/0
 ipMhirwYsMYTfBOtltbwDpcHu0hWPUG6dEYCdDn/d59G7JvMH33G/AVrsrUtUd0D3i21JiXkS
 kAPyqULu1Vi7FAae5JIPUpzc807P7VSyRTVCWJdopli6BGiCiHZ6kIQ9B+DO6o6m47E3h5DqZ
 wuqHQoIEltuMg59vY8MpjZ6rVoBkYJ3BGd/6jiZhjgxNjUMkOCsc/5Q7lMYV/W9ZGfSoVrjFP
 iuDzc8BNY9GyZqxL5xVtqc8p+Q+ikhZ5kQ0TrFAgGLrpRPt0oVuXtpgPPp+dM8rg+JHFtlv3T
 Fh8StOR02wclCqzRBHuoh9bR5dwpLi4wBNipT9xtzVzkflym9k96Izh/uboAdddKZLVnYKtmI
 B8moxI1J2UjTOdrX0N9I/8vUB/V4Dt35Ewn89ATXUTImhGghvvOkMBwVSQh8KmJsewFd3zZIr
 tVb2tpc813pRqJuY5Pm77GmYFz2JcVmJvhcujBdno4iCmDCmTUKq2V9TkLlqN5dAeGvTACEoT
 QGXJICbHkVhytwvIWY67LaGbMPNYlE8mMVyAZ9u0l4dEf05ojgEKTpI215PISr7xSB7vOXnwT
 Qivz/GWwg+qWTaf5y+nh0WGhzIU0FVs+7FHx3FfHfiM46ypJgGWudH7N0W/Ingp7UfXyLn3Wi
 9jzDOONxP0/Mxgfk/YO4zxR6Wp4LC5PjXLuRkF2AY9v4I53kgddAVb7u64+Nduhj+XMpF+hxE
 LkXzf1iqIqUowxUBuN1OhevuhACykrXSuofo895L6LCNvhBt2GTrqslgEHlsAiE9FJ0b6vGLE
 qXLf1IGMqGWWRnjGLDmdBxvaVlzI+INry3YsPdT40BsfasPj3Gf8PvHx2OLapZssf9mPXbwdb
 XoKXn58f71Pk3W7GQpUkdm/wcyExU/3DlyvCkwGGNwQvVssGan2MzSj6U1boEITPKDhck3zVX
 7lZ9LaYCr8+x7z3inVrHQAWs5BcrQIVnmAV3u6sy8gcUODlwQU+3ZTIl8TeitthG2yu6ypYcL
 tpmkNr7uJ2w4VrUkiWSRTDhOMKO+Oayh8Fs6g0dpTLPLyn400KLqQFmTP/pXhhMvH9sA52DlH
 otcM4uqG0NlHgv2vYAkh1+KRK3VNAIyAUWQ+XQPXAaWLrsV/Po8O3guajaBmBdG/Sfev6dvI0
 vgRQtSzivCrqo5Q+NaRzEnQLoDRIZbDky50mTVZnMG46yUAuvNjxXU1jV7SEdJpQps83aYV8U
 xIEZUMPKQjAcohGrtNUWnfoec07FD511kffWb2kEozw54vEH5cjDKVGu3mVN8Hu1hP4N98na7
 qkxqJ80JhrP7nJnY+GTuB0H5IM2qmU2eHJUQPiIQ1HHWLkMEuxclsWaRcRtGlSq3iLvcQ6+MM
 ki0T0Lg==
Subject: Re: [cocci] qed: Move a variable assignment behind a null pointer
 check in two functions
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 2484
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/30ea63cd-4389-4b07-879f-011e1b1af421%40web.de>

> There is a lot of chance that he is a bot.
I hope that corresponding software development discussions can become
more constructive again.

Regards,
Markus
