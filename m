Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B710D68BDA
	for <cocci@archiver.kernel.org>; Fri, 15 Nov 2024 22:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=mFhCA+NOYuk8bYXlsYuRwz8vDo6+kwMYACTSSoIzGGw=;
  b=Woy7yDws827NtDAOfUqTHH+730rmTQSLRY2PS/zhYAEE+RZxl/xguqQ+
   RqEw547sV7c4x37PQvAdwuxYr5jGvUiIAyWK9RsNfITDjxMkeqzcJDS6w
   WybiR9lFIPkJrmotz3vqzSqrCJcJJSQcCPc0WpitkgRy2Ac+KJrUf0woB
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@quicinc.com
X-IronPort-AV: E=Sophos;i="6.12,158,1728943200"; 
   d="scan'208";a="194170288"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 15 Nov 2024 23:36:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A25E5E0D89; Fri, 15 Nov 2024 23:36:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id D5EA4E00B7
	for <cocci@sympa.inria.fr>; Fri, 15 Nov 2024 22:41:46 +0100 (CET)
IronPort-SDR: 6737c01a_UWR5hh4LZqhTmD2JXruqqt5T1wy3ddEyV14kai2tAqK81eZ
 HvcC13JPHWDI6dp6scxx7yZtccz6lbImUiu23Kg==
X-IPAS-Result: =?us-ascii?q?A0ERAADTvjdng4Oo3M1AGhwBAQEBAQEHAQESAQEEBAEBQ?=
 =?us-ascii?q?IE/BwEBCwGCQ32BDQQLSAQZhDmIHV+GUYIhA4Q7mAWBVoF+DwEDAQsBATsJB?=
 =?us-ascii?q?AEBAwSFAAKKSwIeBwEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECB?=
 =?us-ascii?q?AYBAhABAQEBOQdJhXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CCAVeAQEeAQEBA?=
 =?us-ascii?q?xIRHQEBNwEPCw4KAgImAgJWBgENBQIBAR6CXwGCZAMFDAakK0NngQMBgSBCi?=
 =?us-ascii?q?RIBAQF4gTKBAYIMAQEG3gMDBoEaLgGBYYZqAYFsg30bIIQ8J4IogTwLgng+g?=
 =?us-ascii?q?VKGTIJpgkUthGYlTYgyjBeNbglJexwDWTIBVRMXCwcFgSkRECwDIm9qTn+BN?=
 =?us-ascii?q?oFRAUGCTi8bIQtcgSl9HRQGFQSBDgU3Cj+CSmlLNwINAjaCJCRZgk+BJQQFg?=
 =?us-ascii?q?2yBC4NhZy8DAwMDgzyCTmQ8HUACAQttPTUGAwsbBqA7AUaCQoIsUCMSDIECN?=
 =?us-ascii?q?5Y8jFWBNmuhAA2EF4wWlTIGEy+XVJJ6LodkkGUii2WBeJVzhQsCBAIEBQIXg?=
 =?us-ascii?q?Wc6gVwzGiODN08DFwIPjiEZg2GFFIoqAbZJIjUCATgCBwsBAQMJj1cugR0BA?=
 =?us-ascii?q?Q?=
IronPort-PHdr: A9a23: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
 mqw09NhXUr3ntwj
IronPort-Data: A9a23:vGg0Fa1nITdgQznNKfbD5U91kn2cJEfYwER7XKvMYLTBsI5bp2EBz
 jMWXm+DP/2JYDT2f4x/YI7i9kJXv8SDm9A2GwA53Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn8gVaYDkpOs/jf8Uo24ayo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW0bPmc9pDHsNBqsB5clTEF1ey
 807GAlYO3hvh8ruqF66Yux83s1mdJGwZY8R4igm1SnZCu06TJyFSKLPjTNa9G1o24YUR66YP
 pRJL2M0NXwsYDUXUrsTIIsjneyfhHv4cztDr1S9vLc26GnVx0p6172F3N/9I4TTGpoMwR/Ez
 o7A13jFCBxZF4GS9THf20qjuMCIxhzdH6tHQdVU8dYx2gHLmjNOYPEMbnOwpvKyi2alStdHI
 goV/DAvpO487iSWosLVWg3gqTvc5kVFV9QISqsi8AGK0bbZ70CSAW1soiN9hMIOiexsfzsq7
 GSyucr2Khh+jK2reFGtz+LBxd+tAhQ9IWgHbC4CaAIK5dj/vY0+5i4jqP4zScZZafWlQFnNL
 yC2kcQou1kEYSc2O0iT+ECfinf0/sOQQgBtv0PPRmKi9R90aMiuYInABbnnARRoc93xorqp5
 Slsdy2iAAYmUc/leMulHLplIV1Rz6zZWAAweHY2d3Xbyxyj+mS4Yadb6yxkKUFiP64sIGCyO
 RGL6FsBuMYKZBNGiJObharhUqzGKoCwTLzYugz8N4QmjmVZL1LXoHkGibC4hTm0yBBEfV4D1
 WezKpzwVSpFVMyLPRKuXeAa36csxyYijWLVTtaT8vhU+er2WZJhcp9caAHmRrlhssus+VyFm
 /4BbJHi40sED4XDjtz/qtd7waYidiFjXcieRg0+XrLrHzeK70l6Uq+Onuh7JNQ490mX/8+Rl
 kyAtoZj4AKXrRX6xc+iMxiPsZu2Bc4h/0EodzchJ0ip0HUFaIOipvVXPZgucLVtsKQpwfdoR
 rNXM4+NE9ZeeAThoj49VJjaqJA9VRKJgQnVATGpTgJidLFdRivI2OTeQC3RyAc0ABCK6PQO+
 4+b6luDQL4oZRhTM8LNWff+k3KzpSc8ncxxbWvpI/5SWlXgz4xoIhOsjNsyBd8GEjTY5z6gz
 w3NKwwplerMhI4U8dfymqGPqbmyIdZ+BkZ3G2r67668EyvR7k6P4NZnfr6TXDb/UGjUxv2TV
 d9NxauhDMxdzUd4jYVsNp1Kk4Q83oLLjJ1HxF1GGH7rUQyaOol4KCPb4fgV57x//Z4Hiw6YQ
 UnVx8J7P4+OM8bbEFI8AgopQ+CA9PMMkAnp8vUHDxTm1RBz4Ya4fx1eDzuUhAxZCYlFAocv7
 OMimcwRsiiUqB4hNPSYhSF1qUWICFE9UJsci5JLO7+z1zIXyWxDb6fMVQ7wwpWEMOtXPmcQf
 zS7uavlhpZn/HTkTUYdL3b28NR4uYUvozFPlV8LGESIkIHKh9gxxxxgzg40RQV0kDRCir5WF
 UV3EmFcN4CxxTJNqOVeVECGHAsaIkWrxXXs+gFYiEzYUEiaeWjfJ0ItOeu23R448kANWhN57
 b2n2GLefjKyR/7I3ww2QhRDudH4aN56qynuuZmANNuUOLUcbR7OoL6cVUBRpzTJWcoO1VD6/
 8909+NOWIjHHC83oYhgLqKF1L4VGSu2FEYbTd5PpKo2THzhIhes0j2zKme0SMNHB9rO1WSaU
 8VOBMZ+Zy6S5Ra0jAIwJPAzeudvvfsT+tA9VKvhJjcGv5uhvzNZis/s2RaktlA7YedFsJgbE
 ZzQRQKgA2bLpHpzmk3xludmFFe8Q+E5YFzb4Ljo3sQPT4kOocN9Q3EUi7GUhUiYACFj3hCTv
 T7AWZPo8vxf+dxssrboQ4p+BFSSCNLsVe633hi5nPZQYPjub8rflQMnhWP2HgZRPLAhZcxGz
 7CQgc+q3kmf5LcSeELakqmnCKNmy5iTXu1WE8SvN1hcv3KId/HN6is52VKTCMJ2guIGw/K4V
 i2EaMeUXvwEaed3nXF6RXBXLEcANv7RcKzlmxKYk92NLRosiSr8M9Kt8C7SX1FxLyMnFcX3N
 V7phqyI+NtdkYVrAS0EDdFAB7tTAgfqeYkiRu3LmQioNEuaqXLcheK6jjsl0y/BNVecGsWj4
 Z7leAn3RC7vhI72luNmo65AlTxJKk1igNsAXFMXoP93rDGYMFQoD8ogNbc+N5UFtRCqib/ZY
 mjBYlJ3XG+5FX5BfA7n6dvuYhaHC6Zccp3lLzgu5AWPZz3wGIqEB6B7+zx952ttPAHu1/yjN
 cpU70iY0sJdGX21bb17Cj2HbeZbKjfyw2JQ8AWly5erDxhGWPMSzHxmBxZAWWrMFMSleIAn4
 4QqbTgsfa15YReZ/QVcl7p9AQwYtzLpxHMjaiLnLBP3pdCA1OMZoBHgE7ib71DABfjm4JYXW
 HL8Rm2GpWuR3xT/fEfvV80B2cdJNB5AIiR2wGIPi+Hfc2FcJ1nL5/8/oBc=
IronPort-HdrOrdr: A9a23:MR7snK170evzGRSkX4wfDAqjBCMkLtp133Aq2lEZdPRUGvbo8/
 xG785rrCMc7wxhIk3I+OrwQ5VoJEm3yXcb2+gs1NuZLW/bUS6TXflfBOjZowEIeReRygc178
 4JGMUTZ+EYT2IK6voSizPIcerIruP3lZxAyd2urEuEGmpRGt1dBlBCe3umO3wzfRJBA5UhEp
 qa+45omxqMEE5nH/iTNz09RO7EqMTMlJX6JTg8JzBixjWvoFqTmc7H+z7x5GZtb9qK+8ZdgB
 v4uj283o+CtOy20RjV0gbonutrpOc=
X-Talos-CUID: 9a23:w1GQvG/S6FjTphj72iWVv3M3QPoickfm91HJPGCcGFp5doy2eWbFrQ==
X-Talos-MUID: 9a23:8dC/TwZhNFrksuBTqwPmiXJBacpU6P6HME8zvtJdhO/DHHkl
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,157,1728943200"; 
   d="scan'208";a="101771714"
X-MGA-submission: =?us-ascii?q?MDGNUhNc/u+SWxZNnx57u6JxXBfaHh2fiq69a4?=
 =?us-ascii?q?skJV4goND71gOHpLImPaeGeiMrHwkIM3zW57S0DEwZBeSq8Qjnrp0jK2?=
 =?us-ascii?q?GxIC/bEBBGxIyK4EHabkJf/Iy99CiPjKHlVlzZvP3vvOw1f5aEkFivXm?=
 =?us-ascii?q?SNMdQ7UmCirxJv9FS/ChTeLQ=3D=3D?=
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2024 22:41:45 +0100
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9ZiSk002915;
	Fri, 15 Nov 2024 21:41:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mFhCA+NOYuk8bYXlsYuRwz8vDo6+kwMYACTSSoIzGGw=; b=W4A/Q+ovpyTMIbbC
	w26T8oqCxB9r85d4RPZa3xoW41U9P08tasWS2HjZmNxLpaZMCdFv4De8U/XKX5Ii
	IYkJQKbRx4TJT1R6RWAIOAzblwPFrJTsVeQxbxKt5riUTGA0w8UBwMCVbKDwIQ7g
	ISsGkWeC4L59nJ8h778Lvk5M5KO69ajgOUlmV45tFrqZ9KACxjzP5FKJrF5phUNk
	aUYstcB8qCqhT4tXQvyeXJH2o0NfIC4Lj+vL5uwKkItKv88Dh24rsZEt/oRxzZ85
	xxLIYdyHoTcBgqiu7oL6S1NEplQ2R7qnhAkPstvLz+c3IgBTmuIVftLZa5BkbSxD
	OJNvxw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3t9hss4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:41:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFLfNwS024141
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 21:41:23 GMT
Received: from [10.111.176.23] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Fri, 15 Nov
 2024 13:41:20 -0800
Message-ID: <3ac480f5-549b-4449-baa9-f766e074c409@quicinc.com>
Date: Fri, 15 Nov 2024 13:41:19 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Easwar Hariharan <eahariha@linux.microsoft.com>,
        Pablo Neira Ayuso
	<pablo@netfilter.org>,
        Jozsef Kadlecsik <kadlec@netfilter.org>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Julia Lawall <Julia.Lawall@inria.fr>,
        Nicolas Palix
	<nicolas.palix@imag.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang
	<haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Russell
 King <linux@armlinux.org.uk>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle
	<svens@linux.ibm.com>, Ofir Bitton <obitton@habana.ai>,
        Oded Gabbay
	<ogabbay@kernel.org>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
        Rodrigo
 Vivi <rodrigo.vivi@intel.com>,
        Maarten Lankhorst
	<maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand
	<shailend@google.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        James Smart
	<james.smart@broadcom.com>,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James
 E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        "Martin K. Petersen"
	<martin.petersen@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=C3=A9?=
	<roger.pau@citrix.com>,
        Jens Axboe <axboe@kernel.dk>, Kalle Valo
	<kvalo@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        Catalin Marinas
	<catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jack
 Wang <jinpu.wang@cloud.ionos.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz
	<luiz.dentz@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Ray Jui
	<rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
        Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Xiubo Li
	<xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>,
        Josh Poimboeuf
	<jpoimboe@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Miroslav Benes
	<mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>,
        Joe Lawrence
	<joe.lawrence@redhat.com>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
	<tiwai@suse.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Russell King
	<linux+etnaviv@armlinux.org.uk>,
        Christian Gmeiner
	<christian.gmeiner@gmail.com>,
        Louis Peens <louis.peens@corigine.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Naveen N Rao
	<naveen@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>
CC: <netfilter-devel@vger.kernel.org>, <coreteam@netfilter.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <cocci@inria.fr>, <linux-arm-kernel@lists.infradead.org>,
        <linux-s390@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <intel-xe@lists.freedesktop.org>, <linux-scsi@vger.kernel.org>,
        <xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
        <linux-wireless@vger.kernel.org>, <ath11k@lists.infradead.org>,
        <linux-mm@kvack.org>, <linux-bluetooth@vger.kernel.org>,
        <linux-staging@lists.linux.dev>,
        <linux-rpi-kernel@lists.infradead.org>, <ceph-devel@vger.kernel.org>,
        <live-patching@vger.kernel.org>, <linux-sound@vger.kernel.org>,
        <etnaviv@lists.freedesktop.org>, <oss-drivers@corigine.com>,
        <linuxppc-dev@lists.ozlabs.org>,
        Anna-Maria Behnsen
	<anna-maria@linutronix.de>
References: <20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com>
 <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Content-Language: en-US
In-Reply-To: <10ee4e8f-d8b4-4502-a5e2-0657802aeb11@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: S_kpc-fxOeYei4jGvmu7Zy3HQH9VEGzh
X-Proofpoint-ORIG-GUID: S_kpc-fxOeYei4jGvmu7Zy3HQH9VEGzh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 malwarescore=0 impostorscore=0 priorityscore=1501 clxscore=1015 mlxscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411150183
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH v2 00/21] Converge on using secs_to_jiffies()
Reply-To: Jeff Johnson <quic_jjohnson@quicinc.com>
X-Loop: cocci@inria.fr
X-Sequence: 2052
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2024-11/3ac480f5-549b-4449-baa9-f766e074c409%40quicinc.com>

On 11/15/2024 1:29 PM, Easwar Hariharan wrote:
> On 11/15/2024 1:26 PM, Easwar Hariharan wrote:
>> This is a series that follows up on my previous series to introduce
>> secs_to_jiffies() and convert a few initial users.[1] In the review for
>> that series, Anna-Maria requested converting other users with
>> Coccinelle. This is part 1 that converts users of msecs_to_jiffies()
>> that use the multiply pattern of either of:
>> - msecs_to_jiffies(N*1000), or
>> - msecs_to_jiffies(N*MSEC_PER_SEC)
>>
>> The entire conversion is made with Coccinelle in the script added in
>> patch 2. Some changes suggested by Coccinelle have been deferred to
>> later parts that will address other possible variant patterns.
>>
>> CC: Anna-Maria Behnsen <anna-maria@linutronix.de>
>> Signed-off-by: Easwar Hariharan <eahariha@linux.microsoft.com>
>>
>> [1] https://lore.kernel.org/all/20241030-open-coded-timeouts-v3-0-9ba123facf88@linux.microsoft.com/
>> [2] https://lore.kernel.org/all/8734kngfni.fsf@somnus/
>>
>> ---
>> Changes in v2:
>> - EDITME: describe what is new in this series revision.
>> - EDITME: use bulletpoints and terse descriptions.
>> - Link to v1: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v1-0-19aadc34941b@linux.microsoft.com
>>
> 
> Apologies, I missed out on editing the changelog here. v1 included a
> patch that's already been accepted, there are no other changes in v2.
> 
> Thanks,
> Easwar

How do you expect this series to land since it overlaps a large number of
maintainer trees? Do you have a maintainer who has volunteered to take the
series and the maintainers should just ack? Or do you want the maintainers to
take the individual patches that are applicable to them?

/jeff
