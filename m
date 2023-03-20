Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E42DC7618A
	for <cocci@archiver.kernel.org>; Mon, 20 Mar 2023 08:20:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=1DO+Yojk7NLLCPbfm6bGn6fV4je4FHa3iuzaFhWpkbA=;
  b=XveZ0hprKYTkSULzksvyE+Xyob7b+95eH5o3nyaridPyWukjxAXcaJ6p
   d3skGmj4Ma+SCioNovYir77bFVeAbvySXSl8SgdQWcD/0cM7Ye3lLmSWT
   uq5v18ykjK3BbxsUnsjI3NW1eOFk2FELoRUVUg98QKIOWplfEG3Gwf8jA
   4=;
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
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="98004714"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 20 Mar 2023 09:20:25 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 29553E0C9A; Mon, 20 Mar 2023 09:20:26 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5D336E0AEF
	for <cocci@sympa.inria.fr>; Mon, 20 Mar 2023 09:20:24 +0100 (CET)
IronPort-SDR: 64181747_PmkJ00Q0S8WCcIxNiGPUeFHb2dJ74LdDJuIr1EY3ZZnGkxN
 PRnLsxjF67Egwv34/Y4pxau4lvle2CbOgZ9hi8Q==
X-IPAS-Result: =?us-ascii?q?A0FTBABPFhhkhw4P49RagQmDfXVWLwQLRgSET48KgXcxa?=
 =?us-ascii?q?YNGjmaEZ4cYPg8BAwENOwYBAgQBAQMDATiERgKFNQIdBwEENBMBAgQBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwEBBQEBAQIBAQIEBAEBAhABAQEaCRcHDhAFIoVoDYI3KQERZ?=
 =?us-ascii?q?IEIAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBAQECD?=
 =?us-ascii?q?ToYOz0BAgIBIx0BAREmAQQLCxoCJgICVwYNBgIBAYJ6AYInAQMOIwcMBrMNg?=
 =?us-ascii?q?TKBAYIIAQEGgUABAwIMAkOZcx8sIlOBXgMGgRQskDp6Jw+BVUSBFScMgnc+g?=
 =?us-ascii?q?ksXA4Ffg1iCZ41tixwKgTR1gSAOgT2BBAIJAhFrgRIIa4F9QQINZQsOcoFLA?=
 =?us-ascii?q?oFZJQQOAxkrHUACAQs7Oj81CQshBlhrAiwREwUDCxUqRwQIOQYbNBECCA8SD?=
 =?us-ascii?q?wYmRA5CNzQTBlwBKQsOEQNPgUcEL158CgYBJiSeLBYCdLEEk3g0B4IogVWBW?=
 =?us-ascii?q?QyKDJUABhMug2oTjGaGJQ4GkiMuhy2KUoU9i2OBb5UmA4UfgXkjgVwzGiSDN?=
 =?us-ascii?q?h8wAxkPjjmEDIELg1aKZkA0AgE4AgcBCgEBAwmFRgEBhXsBAQ?=
IronPort-PHdr: A9a23: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
 fDQmai1JDoQqro8HOMZANXIbt2KOjwtPEixcAM=
IronPort-Data: A9a23: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
 D3QFrAc/vR8/32xedsu2w==
IronPort-HdrOrdr: A9a23:63xUfKBd4IdptszlHel455DYdb4zR+YMi2TDGXoBKyC9Afbo8/
 xG+85rrSMc6QxhIU3I/OrqBEDuexzhHPJOkO4s1PKZLW/bUQiTQr2Kj7GP/9SIIUSXm9K1l5
 0QFpSWY+eRMbEVt7eY3CCFM5IH3MSN9ryuiNzT1nF3UGhRGtxdBktCazpyCSdNNXJ77HcCZe
 ChDkErnVCdRUg=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,274,1673910000"; 
   d="scan'208";a="50649356"
X-MGA-submission: =?us-ascii?q?MDH+qF/2urqbmnWwV/L0h8nuXdZ02bdR9TS/yF?=
 =?us-ascii?q?91UTIwbA+Cvdzm95Xp3HlIMNqV6KolNhr4wC0xHNAfs+nm7Fq3LGrYmU?=
 =?us-ascii?q?Cwx4nj4hSkkZ3K3nYAyxTdxmHzn7JmHHUkDvj7kniBsimqGSnqfCUmWl?=
 =?us-ascii?q?3PL9C4zhn8VKfNQo4rqJ9loQ=3D=3D?=
Received: from mout.web.de ([212.227.15.14])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2023 09:20:23 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
	t=1679300416; i=markus.elfring@web.de;
	bh=1DO+Yojk7NLLCPbfm6bGn6fV4je4FHa3iuzaFhWpkbA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=SjY+sRI4fYwRUGep9zWBEesyDWnaZYrIwNnGO08bWerss7/riPY72DVyAvph3mUTO
	 9/9FPMfMlAY4u1ARzselajEb8yJ5bqtXGh6LshBAHa9DwTtDja5vm2AvUfCMvE8Rh7
	 daVVz5alnpMEk6qYppKHo+lFFLmLZbLf+ckV5Vvv5ldFuGQHM3kgF4bn5pNUtSjsnU
	 Hc4k3/iIkmbQIpuCzZZpIvlwh0KOvSSiFleBBpzl3+KeRxYWDBM8S9Gs5KoTx6mzp7
	 +hdxqSZU5D2Aj9eC0t/a4jgj6A6Np3rUDb49uO9ERKfow+lUFtmGTMwkVQVUndPs4/
	 cf1ubxlo+QvtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.83]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTvrq-1q5DnO0kuQ-00RHZB; Mon, 20
 Mar 2023 09:20:16 +0100
Message-ID: <fb858bd1-7475-7007-a440-b30bd6b7b76b@web.de>
Date: Mon, 20 Mar 2023 09:19:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
To: Leon Romanovsky <leon@kernel.org>
Cc: kernel-janitors@vger.kernel.org, linux-rdma@vger.kernel.org,
 Bernard Metzler <bmt@zurich.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>,
 Cheng Xu <chengyou@linux.alibaba.com>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <afe30fc6-04c9-528c-f84a-67902b5a6ed8@web.de> <20230319114048.GB36557@unreal>
 <1c06e86d-1468-c11a-8344-9563ad6047b5@web.de> <20230319141145.GE36557@unreal>
 <a03c1d04-a41e-7722-c36a-bd6f61094702@web.de> <20230319173716.GF36557@unreal>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20230319173716.GF36557@unreal>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lwkwUU+zi2syiqoWxxd0Am2yAZ6nd6lc6oZOqMaPFRXQVf1QAK1
 lfh+qOy81uuHq1it08TkwD4xVWJVtsAdMBGNM9Cq8PuE4S0BcLK64BBSBWSOUrg8xSLUMgb
 4J1N1Fel0tv/CAmxFSBq/3rsscWIXABs2rZk+P2AakwY1iX9T/WagR4DhVsv2BJa9zm8X9n
 X/4bpEgWfcMxuT/Gie9Yg==
UI-OutboundReport: notjunk:1;M01:P0:mWQCJeh0O2g=;sTV4mjVw+BdTsZ32gGEgcifPL9y
 /wKeSrj2OLsTZ7hGHy/ZOblbLbwDFwRlT3/JgpstjACNY33gy/xADfljv/PFakLVSMYvZsu1Y
 IpEzEw+i2qnaX6ktOJWK/AR+I1eDQx9xWspEaGLnUiBYgzcXroOovxWX+t8DlEfaB1tWs7L+1
 DLUSWrCl0cfAEW0QOsVxh5snBnsl4m3nph5iNsVtfopirs/LNBRlpGZHy+4ZuZu24BaUODOHH
 dRUUfHFa8ljmNNvSQOl4LhgjZjKyDTTGa7qt5y7LTF04t09JDdWFxb6RJJ5LZYfGnTpzXqC9Y
 aftYHnugRNngtzzLRlPk0MG+1lxKa63zGkHNhQP9CBVUUr30MvCa2t/wGELMyppHAjJAUzISM
 M0ZcmHY8+UI+OReKp4pamSiKa58SYb3weA34dOmrabnObtNo3BTM54Vu6YUq9Hi5LiKLHEzZL
 mSxenDb8uVS1plTsxG3MMSuKi4lLLbnzgpkEuBYMOMfR5Qbez/oMXBScnCr5WrktiqN+PQtSk
 I0CXICxtOTXrMMAPazWKNxam5dj/9J6gPZe2rlLJTDagaoBzRxp2ssvMxpfwew/lhKIqojeah
 A/npXnWNHR1WSsDWhhObtlUq48x5CpB18NqghH/QRLkzkoeI9qo9UbsGxshfeY1b6fDJdxUfN
 NYB5vyK6EoVlp3YxXB04gkaK4982wnX+sj6yJJNDPS2Ca+4nbK1Z/eb1i7mMm/SpzpK9fi94t
 yFjMVoy5EAA/JMxP1dr25ty6fw7UCSFdxsa3fqOkQ3cOVQ0spKEgFC9a5/3fo2WVEt+oIkPvK
 bxsTyeS59QqQXqNVsm7CUQX4RxNDIwnQgJjARl7Nb4ToC8EQzAmMgbAIdTTlveR96cCyW9Hnm
 Olj5FI7vkpkiBioxyKWkIHXhCLnGdyjMSglFcGOZWnafO9FNyPUqmTScvNLzt+aJJl7jWvCJH
 5RaARg==
Subject: Re: [cocci] RDMA/siw: Fix exception handling in
 siw_accept_newconn()
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 902
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/fb858bd1-7475-7007-a440-b30bd6b7b76b%40web.de>

> ok, I'm taking my request to resubmit back.


Interesting =E2=80=A6



> Please retain from posting to RDMA ML. I'm not going to apply any of
> your patches.


This is a pity.

It seems that I need to convince other contributors somehow
to care more for remaining programming mistakes.


Example:
Use after free (or erdma_cep_put)?

https://lore.kernel.org/linux-rdma/167179d0-e1ea-39a8-4143-949ad57294c2@li=
nux.alibaba.com/
https://lkml.org/lkml/2023/3/19/191
https://sympa.inria.fr/sympa/arc/cocci/2023-03/msg00026.html


Regards,
Markus

