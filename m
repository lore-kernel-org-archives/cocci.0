Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A20AC77B61
	for <cocci@archiver.kernel.org>; Sun,  9 Apr 2023 18:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=1xQxkL/JhqMMkOxoJkjHqMEnyLWcm0jtLzhXM6SmKVo=;
  b=uS63sycqRk6LHzhdNwpNEq/qtVrhM8NF5coonO0LYLdYiSX6wJUibo5k
   ONKraKXe4LhbHBEjtoFRAT1+ZTXOfnb3OKj7M56NFzaCDSs7EQi6E7Ocf
   uHg6jS8mhvrCMT7DFRuXmcGKMJZJsPHQZpYSaCBOihQALKgF+96rcLNym
   k=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=markus.elfring@web.de
X-IronPort-AV: E=Sophos;i="5.98,331,1673910000"; 
   d="scan'208";a="102222477"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 09 Apr 2023 20:31:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 09F38E7312; Sun,  9 Apr 2023 20:31:02 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FE4CE72F8
	for <cocci@sympa.inria.fr>; Sun,  9 Apr 2023 20:30:58 +0200 (CEST)
IronPort-SDR: 64330461_L0Ec+bS0eal20vaLJCz41XADaSzx7D4qji+sybmu7JdavpT
 pXOyecB0wmyeeooeb0Gi41wDIdqe++J8d3O09NA==
X-IPAS-Result: =?us-ascii?q?A0H7AgDqAjNkh07ASNlagQmBT4IudVYvBAtGhFOVYI5si?=
 =?us-ascii?q?GuBVoFAPg8BAwENOwYBAgQBAQMEij4CHQcBBDAJDgECBAEBAQEDAgMBAQEBA?=
 =?us-ascii?q?QEDAQEFAQEBAgEBAgQFAQIQAQEBGAsXBw4QBSKFaA2CNyIZZIEIAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQESAhQzHkkdAQERJzQCJgJsCAEBgnoBgicBAzEHD?=
 =?us-ascii?q?Kp1gTKBAYIIAQEGgmOZKB8sIlSBXgMGgRQth0seWIkgD4FVRIE8iFKDDoJnj?=
 =?us-ascii?q?maKW2qBNHSBIA6BPYEEAgkCEWuBEAhrgXlAAg1kCw5vgUmDKgQCFC0lBA4DG?=
 =?us-ascii?q?SsdQAIBC3U/NQkLHwZYawIsERMFAwsVKkcECDgGTxECCA8SDyxEDkI3MxMGg?=
 =?us-ascii?q?QYLDhEDUIFGBIEIgQFRoBiVQZAQoC80B4IqgVYFgVQMiGuBIpUABhMvg2oBk?=
 =?us-ascii?q?x4OBpIll3ONU5UKhUKBYzqBXDMaJIM2TwMZD445hAw3jxE/NAI7AgcLAQEDC?=
 =?us-ascii?q?YVGAQGFfQEB?=
IronPort-PHdr: A9a23:POYp6xCRyE+SilEJdqB9UyQUH0kY04WdBeb1wqQuh78GSKm/5ZOqZ
 BWZua8wygWZBc6Csa8MotGVmp6jcFRI2YyGvnEGfc4EfD4+ouJSoTYdBtWYA1bwNv/gYn9yN
 s1DUFh44yPzahANS47xaFLIv3K98yMZFAnhOgppPOT1HZPZg9iq2+yo9JDffQVFiCCjbb5xM
 Bm6ohjdutcWjIB/Nqs/1xzFr2dHdOhR2W5mP0+YkQzm5se38p5j8iBQtOwk+sVdT6j0fLk2Q
 KJBAjg+PG87+MPktR/YTQuS/XQcSXkZkgBJAwfe8h73WIr6vzbguep83CmaOtD2TawxVD+/4
 apnVAPkhSEaPDM/7WrZiNF/jLhDrRyiqRJwzIDbbp+VOvRjYqzTcsgXRXZDU8tLSyBNHo2xY
 okJAuEcPehYtY79p14WoBW5HwasHuDvyiJThnTr0qM61+ohERvH3AwmENIFrXPZotLvO6cIU
 uC10bLIwS/MYfNS1zf98onIchYuofyXU7N/b9HexVMyGAzbl1idr5HuMDyJ2OoXqWeb8/ZgW
 vy1i24hswx8vzuiy9owh4TXgo8bxVDK+TtnzIsrO9G0VkF1bcK6HZdMqyyUN497Tt4tTWx2p
 Ss31L8LtIC0ciUJyJkqyALSZvqaeIaG5RLjUfyeITZ+hH99ZL2/gguy/VK+xeLhS8m51ktBo
 CldktTUqHwByh7e5tKFR/dj5EutxDKC2x7J5uxGIk04ja7WJpE7zrM+i5Yfq0fOEyHslEj1g
 qKbcFgv9PKy5OT9eLrmo4eRN49qhQH6NaQjgsm/AeMlMggSRWSa9/qz26b58ULkXrpGlvw2k
 q/Hv5DGPckXuLO1Dg1P3osh9RqzFSqq3dAGkXUdLl9IewqLj43zNFHPJPD4A+2/g1OpkDpzw
 P7JJKfhApbQLnjYirvvcrJ960BGyAoyy9Bf6IlZC78fL/3oQEP+qcLXAgc/MwOv2+nnEsly1
 psCWWKTBa+UKL7evUeS5u0zO+mMeJMVuDHlJvc54P7hkWM2mV4GcKmy3ZoXbWi4Ee58L0WYZ
 3rsmNYBHn0QsgowVuy5wGGFBDVUbH2zd6M6/DAyToy8XqnZQYX4pbWb3zqgVrBSaHpHDF/ER
 VLhbYaZQLEhbCyII8luuiMJX/6tRtlyhlmVqAbmxu8/faLv8SoCuMe7vDAUz+jalBVpsCdxE
 9zYyGaVCWd9gmIPQTYymqF5u010jFmZguBjm/INM9tV6rtSVxsic4bGxrlfAsrxRxmHU9OHU
 legTf25DDt3Qt9ii8QWbRNFEs65xgvGwzLsBrYUk7KRA5lh16vG3GXqYet5xWzH0qYJkFQsB
 MdCZiW9nqAq0Q/VCsbSllmB0aancaNJxCnW6GKK1naDpmldVxNsF7rIVzYTayM6tPzf4UXPB
 /+rALUjaU5azNKab7BNcpvvhElHQ/HqPJLfZXiwkiG+H0TAwLTEd4fsd2gHuUeVQEEZjwAe+
 2qHPgkiF2+gpWzZFjlnCVPoZQvl7+B/rHqxSkJ8wRuNagVt0L+8+xhdgvL5Kbtb+7seuzo67
 RhwEky82d3+FNeK4QZsPe1dbd47/FZbxDfBrQUudpekLq1kmhsfa1Et5hyoiE8xU9Qa15d6/
 xZIhEJoJKmV0U1MbWad1JH0YfjML3XquQuoc+jQ003f19Cf/uEO7u45ohPtplLMdAJq/nN53
 t1Sy3bZ6I/NCV9YdJvrUVsssTV+qavbZCYV+I7ek3Fhe/rR0HeKy5cyCe0pxwz1NfJWKqCZD
 0nfF8MABs6hAPMnkR6lY1hXWYIavL5xNMSgefyc3aetN+s1hzOqg1NM54Vl216N/S5xIgLR9
 64M2OrQng6OVjOnyUykrtiygodcIzcbAmu4zyHgQo9XfKx7O4gRWy+iJMi+x9M2gJCIOTYQ0
 Ve5BE4dnuKtdwCTaVPVwgBak0ga6XCqgiq3yTVoniph9PPAmnOUhb2zLlxYaiZCXyF6gE3pI
 JSogtx/PgDgdAUvmBa/pA77y6VduKVjPjzWSEZMcTLxKjIqWa+xu7yeJs9Xvclx7mMICqLlM
 ArcFe6uxnlSmznuFGZf2j0hIjSju5Gi2gd/lHrYN3Fr6nzQZcB3wx7bot3aX/9YmDQcF0waw
 XHaAEaxO96x8JCajZDG56qbXniiS4YVXC3l14KGuwOk6GcsDRD1zJXR0pX3VBM31yP2zYwgc
 CzSrwvnJKTv2b67N+1PYURiQlPxoZkfeMk2gs47g5ce3mIfj5Oe8C8ckGv9Bt5c3Lr3cHsHQ
 TNYi86Q+gXu31dva26Y34+sHGvI2dNvPpPpBwFekjJ49c1BD72YqaBJjTcg6ETtthrfOLB8h
 mtPk6J0riRA3KdQ4lRrl3/NRepPeCsQdS30y0bStor49v8IIj/yN+D3jhc2nMj9Xuvb+EcGA
 im/I8hkRWgqsY1+KA6eiiSsrN6+PoCBN5RJ6k3TyUal7aAdKYptxKpQw3M5ZCSk4Cxjk6lh0
 1Rvxc3o5tHYbTo3uvjhXVgAcWeqL8ILpmO31PkYwZzQhtH1WMs9XW9VOfmgBfOwTGBC77K+a
 VvISmdt7C7AQfLeBVPNuB0g9iySVcrwbzfNfjFcxNFmDnFxPWR5hwYZFHU/l589TUWxwdD5N
 Vx+/nYX70L5rR1FzqRpMQP+WyHRvlXgbDB8U5WZIBdMi2MKr07ILcyT6P5yFCBE79WgqgKKM
 GmSewVPCykAREWFA1npOrTm68PH9qCUAe+3Lv2GZrvry6QWT/CT2ZemyZdr5R6JMdiTeGZvB
 bs31wsLXHx0HdjYhyRaSyETkHGoDYbTrxO99ytr68Gnpa6yB0Swv83WWuEUboU8nnL+yb2OP
 OORmitjfDNR15dXgGTN1KBax1kKzSdnaziqF70E8y/LVqPZ3KFNXHt5I2t+MtVF66Uk00xDI
 8ne35nQ36R7k+VzJlNLT13nlem2aMZML2z3ZzalTA6bca+LIzHG2ZS9eaSnVbhZl/lZrTW1v
 iuHVVDuNHKPmnO6MnLnefEJhyadMhtEvYi7eRs4EmnvQuXtbRijOcN2hzk7qVXbrmzHPygQP
 GolG6ushriX8D8enfh1XWBMvCINxQyshCuTqeXVeM5+jA==
IronPort-Data: A9a23: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
 Qwhp1fOxckwsfqovPk8DBnest+jO9Ez
IronPort-HdrOrdr: A9a23:0ZR29K8sRqTqEDPDDGluk+D6I+orL9Y04lQ7vn2ZOiYlEfBw8P
 re+8jztCWE7Ar5PUtKpTnuAsa9qB/nhPxICOoqU4tKPjOLhILAFugLgLcKqAeQfhEWmNQ86Y
 5dU+xZFMD6C0R8gP33+Q+iDr8bsaG6GeyT5Ns31B1WPGdXgkxbnn5E4o33KCdLeDU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,331,1673910000"; 
   d="scan'208";a="52959065"
X-MGA-submission: =?us-ascii?q?MDF8HGmVyaWiL94HCIsD3cA81cHsOyr3x4TVAY?=
 =?us-ascii?q?B4HFnsZa+Oj8i0o1PwowRugAoNNr4BK30RF5shBp1Qp97mu/ottaWb1h?=
 =?us-ascii?q?9sCa2z5e47aoyiVzetFq31XbuQ7GOrop6VCGalQzqqoaDXDKbjOV6jFo?=
 =?us-ascii?q?nklRCaE3q7j5zYx1oZCFxfrg=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2023 20:30:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1681065056; i=markus.elfring@web.de;
	bh=1xQxkL/JhqMMkOxoJkjHqMEnyLWcm0jtLzhXM6SmKVo=;
	h=X-UI-Sender-Class:Date:To:From:Subject;
	b=IQ70Vf7iP8VewxijYQxuePf2vgak2KoaVHnp+G++j6CyO7yAMEWRhpLEfhV1PQkv8
	 gjTFW+D+n9Za3qxhdp7Iz0KYHf6Buyl0g0yY+j2up1LERxJVFXcdAQchlx0uGvUQ0H
	 VzSGmkUTPWXoURC+3fK3B0xshllkh4YX54kzdbeTXaeklsREpeL4+tu1fmjbqFcRTa
	 DtbZGgR3M4yXADIT5J1oQf19m2TDp8/xi2T1Hg/oKfhD3/ttkmE1wvZsY7ISH0VM/z
	 01J5olcYXwEHXzF0rmu8oYyFi7+qOR6x0lzTLpR/ldpNennX9LYi1KIqNYzBRXB52R
	 A+l/O0A8w5gbQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.83.83]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mq184-1q7DVq1TcI-00nTYL for
 <cocci@inria.fr>; Sun, 09 Apr 2023 20:30:56 +0200
Message-ID: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
Date: Sun, 9 Apr 2023 20:30:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:lW7T79K9URZQK23E8ffyhLJt7YwTUGlvIYAWcARplRX7bRZSwBy
 HrbWOkNKl+OXb0lppjTXuSEtTFEGXMCcWiPlYEpOEXP4+a5lNmaBQz8krOLBAPGnujZuTYn
 jDV7D5Nk3aHFr86+5xy76u9rtxkowfVhnQha/DlPa0t/T4c5lwBSQw/+ucten49kFILzqIr
 jU0/a/lIP6/Qj2FEris+Q==
UI-OutboundReport: notjunk:1;M01:P0:QRcDjj35EGA=;S1PW2JH3ON+/psb/rv9dlSmiaJb
 y71bucR85A5wvSpkjU2+nSWTY5vj3bK0aFesKSdOveIjOIl/ALPSUvBIrJTUpA69TV+S1QatZ
 SHQKtodCvMJ4PNZmIIH4rgjxUkVMHJkfNlTiC/R+43stvPN02VppILmVKK5ZkAo7kBvoKQVog
 1axgpivB7qeszAnIMhs+cMCCnp13uofcwl9ZwEHaERx3zE4FjlVy4J/vnvGVVcmv/kR/4hXj2
 9LF/Yqaqok0v0qCL1YbQC/OIfcrPs/79gJA9oWdcQS2Tlx9buXt5RrR19o6RrZ7+7LqWKXYsX
 Y6e487YECWCihr44ROOX1wayhM/+priTroHil4t6ipoYPqdOUCHJk+Un89hnIv6CySnn4He2v
 jsgxRARM1a+R5kF4S5qyzXtwOcRFYdeuteX6das/+KpEiwtJHOFv/Ip8ZA7jefSDkTChSOTQe
 BxCly4rDlOaWJ6OCnnZvQtB8wZwnTni8oGfQxOWlwRbWD11AT0LWLAuDKQOUJgBHA7pXUw6Q5
 5+SwRb9PjrI5cC4Hro0eThOvTP7eYWp/KGGZuFQ18bC6bLmq4b3ODlLnu6lEAyAzubwKVEdXz
 ZMsTkn+grVNHcWU5GtcQAulAcHOs1CwXdvkoVR1PzE7h09ONme95QYFK5lJ6pN38iaxWFhCHH
 KOIlvmx41eq/C4lC9w3848qGJdAfpWRyIT8KmKGj8wRoDqeBbw33G5MOBikxtJiEZ1H300n4K
 QCzHFywqwE1pu4PBdVT5orRNwOjKSGX7zpyU5U7eRrXf9vZPidSTM6AHhx3rmt02CS+Fz8+rt
 hJ61980QWUDbZcybw5IkOWg7pcmUXa5dW3iae2BkmPKx/6nGKjw7wSlZrqgVo3uJ+UtpPbBge
 OKTsfZeeTs1UZKYG9rzqtoAxPZ+qbRKCzE3Lflwk+T2CSPDfUtcbITkHu
Subject: [cocci] Checking pointer dereferences with SmPL
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1014
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-04/40c60719-4bfe-b1a4-ead7-724b84637f55%40web.de>

Hello,

Script variants for the semantic patch language can help also to take another
look at the usage of various pointers.

Will development interests grow for the avoidance of undefined behaviour?
https://wiki.sei.cmu.edu/confluence/display/c/EXP34-C.+Do+not+dereference+null+pointers

Regards,
Markus
