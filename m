Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0C8E8FDC3
	for <cocci@archiver.kernel.org>; Thu,  5 Oct 2023 09:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:from:
   content-transfer-encoding:subject:reply-to:sender:list-id:
   list-help:list-subscribe:list-unsubscribe:list-post:
   list-owner:list-archive;
  bh=gQcYZU2OYER3miQEx8L2DLFexcP3U+gXKPUY7VMFQaA=;
  b=DnPHL+b5A+Qm7p7lSqWY/qZRUkz0xFdGDeCu7MzhoIT3IvBisPJXnOB2
   declHJYn/ETgzrWcOuUUszAgPqC71Mn28qZE27vZs9FqR72g5+4kQfRNd
   1zvDojCTomT2QX/ByXc2YdDUQm+7lZFmkLLaWSANaUcM1G9ayQGLmtIBa
   g=;
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
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="129624577"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2023 11:52:05 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id CADE8E0CD6; Thu,  5 Oct 2023 11:52:04 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F1103E00B7
	for <cocci@sympa.inria.fr>; Thu,  5 Oct 2023 11:52:01 +0200 (CEST)
IronPort-SDR: 651e8741_f0ii7eoa5YIET3yj3KGYzNi9ua8J5i1xkXcFlfpfim56R4d
 cDm5W4v7XStgYwu+KSxnITfFA2bjhd3ZqO4odig==
X-IPAS-Result: =?us-ascii?q?A0FAQwChhR5lh07ASNlaHAEBATwBAQQEAQECAQEHAQEVg?=
 =?us-ascii?q?VGBTQIBAQFjegNTMAQLSAiBRQKDBI88gXYthD6BVY0niG6DFj4PAQMBDRQBA?=
 =?us-ascii?q?QYhBAECBAEBAwMBDYF/igICHgcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBA?=
 =?us-ascii?q?QECAQECBAUBAhABAQEjFwcOECeFaA2CNyQZgQyBHgEBAQEBAQEBAQEBAQEBA?=
 =?us-ascii?q?QEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAg06ax0BAREnNAImAnQBAYJ6A?=
 =?us-ascii?q?YIpAQMxBw0GsH+BMoEBggkBAQaCZqxuHywiVYFfAwaBGiwCAQEBAQGHaxoBB?=
 =?us-ascii?q?WOJRQ+BVUSBPIYjAQECgiuDDoJGIoQFhT0HglaDWIEviQlyEwVCcBsDBwOBA?=
 =?us-ascii?q?xArBwQvIgYJFi0lBlEELSQJExI+BIM4CoEGPw8OEYJDYTYZS4JbCRUMNTkUd?=
 =?us-ascii?q?hArBBQXgRRuHxUeNxESFw0DCHYdAhEjPAMFAwQ0ChUNCyEFVwNHBksLAwIcB?=
 =?us-ascii?q?QMDBIE4BQ8eAhAuKQMDGU0CEBQDOwMDBgMLMQMwV0sMWQRoBA4DGSsdQAIBC?=
 =?us-ascii?q?209NQkLGwY+ApwkbYIwAYFEASsilS+QSaB1NAeCMYFeBYFaDIhzgSOVDAYTL?=
 =?us-ascii?q?5caDgaSN5g3jWKVIoVHgXojgVwzGiSDNk8DGQ+OOYNfM4ELjj0/NQswAgcLA?=
 =?us-ascii?q?QEDCYVGAQGDWoFKXgEB?=
IronPort-PHdr: A9a23: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
 ybY6NJj8QjOegyn1TdtFhZD+G4juQ==
IronPort-Data: A9a23:3a9/n62elAgiUgQsDPbD5YV1kn2cJEfYwER7XKvMYLTBsI5bpzwGm
 GAfXGCBbPmMZzHwf9lzO4jg9U0Ev5KBzYRgQQdp3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3Zhn9gFaYDkpOs/jY8Us34ayr0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJW1XugOtRUkgOBKtG+715XDxQt
 qY0IS9YO3hvh8ruqF66Yuxrm9hlM8Theo8S0p1i5WuAUrB5G9aaEv+Muo8wMDQY3qiiGd77b
 tAadCEpQRDOeRxJNX8IBZh4kOrAanzXLWII9AnN//NfD277nR11gafrIf/uVeOpXO9Etx3Cg
 0WB8DGsav0dHIXClWTcqyzEavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutG8jVOiHc1SI
 QoY90LCsJTe6mSFTJrjYEOxmEei4B9HVYcNDa5gxAiSn/+8DxmiOkAISTtIadoDvcAwRCA32
 lLho+4FFQCDo5XIECjMp+z8QSeaaHREdDdqiTosF1Ndi+QPtr3fmTrjY75e/EOdi9roBXfvz
 jrMoCVWa1QvYSwjh/TTEbPv2WrESn31ougdu1u/soWNs1MRWWJdT9b0gWU3FN4ZRGpjcnGPv
 WIfh++V5/0UAJeGmUSlGbtcQu31u6zebmGC2zaD+qXNERzyqxZPmqgPsFlDyLtBaZZslcLBP
 RGJ51MOjHOtFCH2NPIqC25ONyja5fG9SYq8D668gitmO9YoPA6B4Cx0Y0OMl2ni+HXAYolvU
 ap3hf2EVC5AYYw+lGTeb75EjdcDmHtkrUuNHs+T8vhS+eHDDJJjYexZawTmgyFQxP/snTg5B
 P4EaZrVlUUCD7SlCsQVmKZKRW03wbEALcieg6RqmiSre2KKwUlxVKeD8qBrYIF/gaVem8HB+
 3z3CAcSy0PyiTeDYU+GY2xqIuGnF5tuj2MJDQp1N3aR2l8nfdmO6oUbfMAJZrUJzrFo4sN1a
 PgnQP++JMpzZA7JwQlAUqmlnrdeLEyqoSmsIxuaZCMOes88Zg7Rpf7hUAjd1AgPKSuV7vkBg
 qCS+T7aZbEhRA1SKtncR9zy7lG2vFkbwPlTWWmRKPZtWUzcyqpYAA2vse0SPOc3NgTl+juW8
 y20ECUoj7DBjKFt+eaYmJ3eiZmiFtVPO3ZzHk7Z3O6QDjbb9G/y+r1wer+EUh6FXVyl5Zj4Q
 /teysz9F/g1nFxqlY5YOJQzxIIc4+rfnZNr/j5GLl7qMWvyUqhBJ0OY1/ZhrqdOn79VmTWnU
 3K1p+V1B++7B9PHInUweiwVNv+OxNMFqAn0tP4VGnj31AVz3biAUHhRASWytTxgHON1Hr8Ik
 eYFk+wK2jO7kSsvY4qnjDgL1mGiLU4gcqQAt7MGCtTV0i4txlVzYMHfOBTX+7CKUc1HaWMxE
 w+XhY3DprVS/VXDeHwNDkrw3fJRqJANmRJSxnoQDg6ttv/aoMQozTtt8TgTZSZE/CVtiu5cF
 DBiCBxoGP+o4TxtuvlmY0mtPANwXDui5U37zgoypl3zFkWHeDTEEzwgBLyr4ksczmN7ewpb9
 pG+zELOc27jXOP17xsIdX9Vkd7RZv0vyVSag+GiJdqPILciazm8gqOOW3sBmyG6PewP3n/4t
 ctY18cuT52jLiMBgbwJO6/D35QqdR20DmhjQ/ZgwaA3IV/haAyCgTijFkTgVf5Odtrr8FC5A
 fNAPshgdQqz/wfQoyE5BZwjGa5Vnvko6IA8e5fuH2onsqSenBVtopn/5ijzv051YtRMwOIWC
 JLdSCKGKUOU3UBrom7qqNJWH0aFevwGWVHM5/+0++A3CJ4ziuFgXkUs2L+SvX/OEg9Y0z+Ln
 QHEPYn68vdDzNlyoo7SDalzPQW4BtftXuCu8grokdBvb8vKAPjepTEutVjrEARHD4Q/A+0tu
 +y2j+f2+0fZsJIdcWPTwcCBHpYUw/SCZrNcN8avIURKmSeHZtTX3CIC3GKGeKx5yIYXooHtQ
 gajc8K/eOIEQ9oXljUfdyFaFA1bEKjtKLvpoSSmtfmXFxwBykr9Ici68WPyJ3RuHsPS10YS1
 iev0xpv2jxZkGiILBoDGu0gHJJyZlPuMUfjmxsdqhHAZlREQHvb0lchqfbkwS7GAD+IHa4WJ
 LrbEwPmek3aVL7glblkXk8bgvHTJGlwi688cyrxPjKwZy+SVAY7EAjWDXnK5ly4XMA/OFEUq
 QwhtFcfNBg=
IronPort-HdrOrdr: A9a23:7Ffj76l7eTFf9K9S+nUHOJD2dpPpDfI73DAbv31ZSRFFG/FwWf
 re/8jztCWZtN9/YhAdcLy7UpVoBEm9yXcK2+Qs1MaZMzUO0VHAROpfBMnZsljd8kbFmNK1u5
 0QEZSWcOeAaWRHsQ==
X-Talos-CUID: 9a23:RAvWUm8dqa1qs1xh4e+Vv2AWWd4aLHTl9VGOIhS2VDt3C+e5QEDFrQ==
X-Talos-MUID: 9a23:HB3AWApM5ORdLFJ0rmMez2BzMJZ35bWLM28ysowsquDfbwlXfDjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.03,202,1694728800"; 
   d="scan'208";a="67843021"
X-MGA-submission: =?us-ascii?q?MDHdBcExg0+phAHlgDOv3Qx5ectYJnh8H75G7P?=
 =?us-ascii?q?srxmBOfx2l7QvLSzjsYkblVGh2ym5t6f+hFnWPjZQgMMl9/7hAHkqB0/?=
 =?us-ascii?q?VO5ylSJARrSDUUh+h4r9ZvbY6EX/C+enWmlRsAk3J+sLAI7osxtDWpo9?=
 =?us-ascii?q?Ld0HcjrPftOKZKumYlDeF5mQ=3D=3D?=
Received: from mout.web.de ([217.72.192.78])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:52:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696499520; x=1697104320; i=markus.elfring@web.de;
 bh=DVROA0JFgqa9Iquf26tf9aCxBz6jn9q9nkFaJhqtkk0=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=GXtkIIr9AbVYUKe1rGEgglqrQrCKPVxEZd8vPCLG5vkHCAgXPZwwjauzPA1eqCpCmaCzqEMXygr
 StMhmxa2unXQEGtYTFkpu9EDOEFhYD8D7N63jQcc9D+/fe6OkMis8lnDxTM2UpYP/dqCBZ5woVKPn
 +1OsNxaBlHbOqu12g1nfA/KpoiGbVAlJznZSOxagEGPm+McPC+dEYdYGA5y6X7c1fSoYOoKMjF4Qk
 c8hWfq5UGUytx2fg9+NctHvDhT+pXTY17e/Hsy3zaZt6GsGfosAgJDDXDm/cIH+IlxH7yGOc/gNKv
 8t+enPFwPfuBE9dqjS94Ga4ukyesx4/b5/LA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.80.95]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N6bCu-1rffby18OM-018KGx for
 <cocci@inria.fr>; Thu, 05 Oct 2023 11:52:00 +0200
Message-ID: <d71be555-d569-4ccd-9f06-4b33d8095e6f@web.de>
Date: Thu, 5 Oct 2023 11:51:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:0UEZNnuHcA8DMOFtJ57PBJefk1JXMHNbGCMTxudTWlzbw+cKNG/
 oZ9ZNBA1sK3WoBvn3F0r7FsspE5YHKmaC/lJLAa6Xk+pmrbZG+kaDq0n7WVd0XVm4erhJRx
 5Nts67qNMxeCYAIpRpt9hkFhQ5tqGvGLwKeR2/h/E/phJfJPqSXtDU/WjsjyuTZj1Qu+qdG
 soS04d0v3537pkftRY8Jw==
UI-OutboundReport: notjunk:1;M01:P0:Fe+cVbf1C40=;ZfbEoSnVrRdbDsTIQSXJQotekRb
 T8dMrjdBlArmx92vHyGMPNxDXp1mqP1AXQf3U065vhseeUt+D6bOj6jwisBDNV1snfwB7jMTe
 zfr60MYG1ikTWOwweH15eGE6YLNauewiE6gHwiHjTb88dSnA7crgcDPY57xEo5y+gzbS0UoVd
 uqilXOyayTftb+WlH7I0hruw2mdfr7gKxNx04a1wEJHOk/ggUQQEWdxYtKAh4eELyFsnlobQe
 eZgfrLc2INyzPkgkzQEGXObNMKW+fCVzURVkpuTTbZ3LlrkNkQo+k+kmfp/jAcb8ek6DEzV34
 /9Szbq9mbbB1Q4ViQohn4PD/1ZOG5i9I9W4emwJ2gWIs34SzF0dclDjofR/Snzeyr9J86dXSK
 9jQMjUv8wrmaV0LlnVOl+MvFWM5eNTNqLMpxe72ES5CsvI/9s07wWAjA8ZkUg12u0mTUUQUMd
 kyBgREQ9zLfmvmoqa46UuEt4JHqVrzPJjmI+lz2GdoBKgEDYoDRDeL7aAAmas8Qgerg5ZpM5J
 7aWs3ka/R8QvnhZkm3B9wB/lqZKHxOA2TCuSnEoenOuZ2WuwmVvusnHqKLDrTJ+Lt02S6V5Yy
 QMWzxhmuZhBt7TGMwfUfplvW9lGVrF/dRpZSUEIKezv4aEVpRzwBNFFMXTwjEkvVyF5GqVGaM
 ZR9yH8vyYhLucg6FapUawzzMJF8y28AGLaqsV/+QU2OyKOvQ+71XGdxk1QIEF1Fx3FeBbdL6u
 OycQh0R2YaymvlzSGC2XK4YduCCnWrBFNx5uppzSVaLzgYX9GYwkN0ZmJp9iWEGRZ423Nmi+g
 KJlEMUe4fh3PdZRRFyD5Lfb2AxJmexFB4YNccMbkJGgoPOGAZYjr7S3gBBn02/PUmuWuhvrvG
 Fv+2HTYK+NxYQglzvX7/JUIbR60R6DueBxhwZwjlgl9LgqxN6TKopD8jMlhOQiKUmRPZU6tmP
 psK/PA==
Subject: [cocci] Searching for variable definitions in C++ source files
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 1244
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-10/d71be555-d569-4ccd-9f06-4b33d8095e6f%40web.de>

Hello,

Will the Coccinelle software become able to find variable definitions
also within C++ source code by the following script variant for
the semantic patch language?
https://gitlab.inria.fr/coccinelle/coccinelle/-/issues/22

SmPL script:
@display@
identifier x;
@@
*RPC x(...);


C++ source file excerpt:
// deleted part
// See also:
// https://github.com/BOINC/boinc/blob/44295c1a50d84e44992d97b9e949700d3b9af2d1/lib/gui_rpc_client.cpp#L262
int RPC_CLIENT::authorize(const char* passwd) {
    bool found=false, authorized;
    int retval, n;
    char nonce[256], nonce_hash[256], buf[1024];
    RPC rpc(this);
    XML_PARSER xp(&rpc.fin);
// deleted part
    return ERR_AUTHENTICATOR;
}
// deleted part


Regards,
Markus
